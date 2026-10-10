/* ============================================================================
 *  KING'S VALLEY (왕의 계곡)  -  (C) 1989 APROMAN, POSTECH - PPUC
 *      art design and main programmer  Oh Jeon Seok
 *      technical assistant             Kim Hea Jin
 *      game designer                   Kyeong yeol
 * ----------------------------------------------------------------------------
 *  B.EXE (38,817 바이트) 를 역어셈블해서 C 로 옮긴 것.
 *
 *  원본은 터보 파스칼 프로그램을 PKLITE 로 압축한 것이다.
 *  tools/unpklite.py 로 압축을 풀면(B_UNP.EXE) 세그먼트가 이렇게 나뉜다.
 *      0000  메인 프로그램        ->  main.c (본체), title.c, player.c
 *            (0000:5EF6.. 은 링크된 BGI CGA 드라이버)
 *      0777  편집기 유닛          ->  editor.c
 *      08E2  게임 유닛            ->  gamelib.c, mummy.c, system.c (인터럽트 처리기)
 *      0C93  Graph 유닛 (볼랜드)  ->  graph.c 로 흉내
 *      0FD3  Dos,  0FDD  Crt,  103F  System (볼랜드)  ->  system.c 로 흉내
 *      1161  데이터 세그먼트      ->  전역 변수(main.c), 초기값(data.c)
 *  역어셈블 목록은 tools/mklist.py 로 만든다 (listing.asm).
 *
 *  djgpp(32비트 보호 모드)로 옮기면서 바뀐 것
 *      - 화면: 원본은 BGI CGA 드라이버로 그렸다.  DetectGraph 가 돌려준 모드를
 *        그대로 써서 진짜 CGA 에서만 640x200 흑백(CGAHi)이 되고, EGA/VGA 에서는
 *        320x200 4색 모드가 되어 화면이 깨졌다.  이 판은 늘 640x200 흑백으로
 *        그리고 VGA 640x480 가운데에 한 줄을 두 줄로 늘려 보여 준다.
 *      - 인터럽트: INT 8/9 처리기를 한 번만 걸고 SetIntVec 은 켜짐/꺼짐으로 바꿨다.
 *      - 1비트 PCM 효과음: 원본은 CPU 속도(기계 ID)에 맞춘 빈 루프로 재생 속도를
 *        정했다.  여기서는 시계로 8kHz 에 맞춘다.
 *      - 파일: 원본은 {$I-} 로 오류를 무시한 곳이 많다 - 그대로 무시한다.
 *
 *  조작 (원본 그대로)
 *      메뉴     1 게임 시작, 2 스테이지 편집, 3 시작 스테이지 고르기, 4 끝
 *      게임     왼쪽/오른쪽 걷기, 위/아래 사다리, Space 점프 또는 들고 있는 것 쓰기
 *               F1 잠깐 멈춤, F2 방 지도, F3 음악 켜기/끄기, F4 스스로 죽기, F10 끝
 * ========================================================================== */
/*  KVVGA.EXE (-DKVVGA) 는 화면을 graph256.c (256색), 음악을 musvgm.c (애드립) 로
 *  바꾼 개선판이다.  게임 코드에서 다른 곳은 #ifdef KVVGA 와 music_play 호출뿐이다. */
#include <stdio.h>
#include <stdlib.h>              /* exit */
#include <string.h>
#include <conio.h>               /* clrscr */

#include "kv.h"

/* ============================ 전역 변수 =====================================
   원래 DS 오프셋은 kv.h 의 선언 옆에 적어 두었다. */

uint8_t   loop_i, loop_j, loop_k;
uint8_t   probe_col, probe_row;
volatile uint8_t scan_code;
uint8_t   mummy_i;
uint8_t   lives;
uint8_t   stage;
uint8_t   stones_left;
uint8_t   held_item;
uint8_t   facing_left;
uint8_t   player_sprite;
uint8_t   scratch;
uint8_t   ladder_col;
uint8_t   bridge_row;
uint8_t   standing;
uint8_t   cur_room;
uint8_t   dagger_room;
uint8_t   stone_room;
uint8_t   start_room;
uint8_t   push_left, push_right;
uint16_t  tune[MUSIC_TICKS];
struct mummy mummies[4];
int32_t   score, hi_score;
int16_t   player_x, player_y;
int16_t   dagger_x, dagger_y;
int16_t   dagger_dx, dagger_dy;
int16_t   dagger_spin;
volatile uint16_t tune_len;
int16_t   walk_count;
int16_t   dagger_stopped;
int16_t   dagger_hit_step;
int16_t   frame_count;
int16_t   probe_x, probe_y;
int16_t   exit_x, exit_y;
uint16_t  exit_room;
volatile uint16_t tune_pos;
int16_t   work;
int16_t   cell_x, cell_y;
int16_t   old_x;
int16_t   tmp_y;
int16_t   stone_col, stone_row;
uint8_t   last_key;
char      text_buf[256];
uint8_t   rooms[0x10000];
uint8_t   dagger_flying;
uint8_t   dagger_hit;
uint8_t   player_caught;
uint8_t   stone_falling;
uint8_t   show_stage_intro;
uint8_t   bridge_left, bridge_right;
uint8_t   ladder_marked;
uint8_t   ladder_leave;
uint8_t   bridge_latch;
uint8_t   on_bridge;
uint8_t   ladder_marked_up, ladder_marked_down;
uint8_t   machine_speed;
uint8_t   sprites[SPRITE_COUNT * SPRITE_REC];

static uint8_t screen_save[CGA_MEM_SIZE];       /* 원래 DS:2968 (타이틀 그림 읽기에도 썼다) */

enum { NEXT_ROUND, GAME_OVER };

/* ---------------------------------------------------------------------------
 *  스프라이트 first..last 의 크기를 정하고 sprite_bits 에서 비트맵을 채운다.
 *  tune_pos 를 읽는 자리로 쓴다 (원본 그대로 - 이때는 타이머 처리기가 꺼져 있다).
 * ------------------------------------------------------------------------- */
void load_sprites(int first, int last, int w1, int h1, int nbytes)
{
    FOR_TO(loop_i, first, last) {
        uint8_t *s = SPR(loop_i);
        s[0] = (uint8_t)w1; s[1] = 0;
        s[2] = (uint8_t)h1; s[3] = 0;
        FOR_TO(loop_j, 1, nbytes) {
            tune_pos++;
            s[3 + loop_j] = sprite_bits[tune_pos];
        }
    }
}

/* ---------------------------------------------------------------------------
 *  열 스테이지마다 바뀌는 벽 무늬 (7가지).  0000:3F37, 5B4A
 *  SPR(0x6F + 4k .. 0x72 + 4k) 를 벽돌/사다리/벽 칸 SPR(0x33..0x37) 에 복사하고,
 *  미라가 나오는 그림 SPR(0x67..0x6E) 에 새 벽돌 무늬를 AND 한다
 *  (스테이지를 다시 할 때마다 거듭 AND 된다 - 원본 그대로).
 * ------------------------------------------------------------------------- */
void select_wall_set(void)
{
    scratch = (uint8_t)((((int16_t)stage - 1) / 10) % 7);
    memmove(SPR(0x33), SPR(scratch * 4 + 0x6F), SPRITE_REC);
    FOR_TO(loop_i, 1, 3)
        memmove(SPR(loop_i + 0x34), SPR(scratch * 4 + 0x6F + loop_i), SPRITE_REC);

    FOR_TO(loop_i, 1, 8)
        FOR_TO(loop_j, 0, 0x3F)
            SPR(loop_i + 0x66)[4 + loop_j] &= SPR(T_BRICK)[4 + (int16_t)loop_j % 0x20];
}

/* ---------------------------------------------------------------------------
 *  악보를 틱 단위로 펼친다.  같은 음의 짝수 번째 틱은 5Hz 낮게.  0000:3E44, 4FE9
 * ------------------------------------------------------------------------- */
void fill_music_tune(void)
{
    uint8_t n;

    tune_len = MUSIC_TICKS;
    old_x = 0;
    FOR_TO(loop_i, 1, MUSIC_NOTES) {
        n = music_score[loop_i - 1].ticks;
        FOR_TO(loop_k, 1, n) {
            if (loop_k & 1)
                tune[old_x] = music_score[loop_i - 1].freq;
            else
                tune[old_x] = (uint16_t)(music_score[loop_i - 1].freq - 5);
            old_x++;
        }
    }
}

/* 원본 곳곳에 펼쳐져 있던 "눌린 키 하나 버리기" */
void flush_key(void)
{
    if (crt_keypressed())
        last_key = crt_readkey();
}

/* 파스칼 Str(n) 을 두 자리로 ('0' 을 앞에) */
static void two_digits(char *dst, unsigned n)
{
    sprintf(dst, n < 10 ? "0%u" : "%u", n);
}

/* ---------------------------------------------------------------------------
 *  스테이지 시작 (0000:3EF1 .. 489A)
 *  kings-v.dat 에서 방들을 읽고, 영혼석/시작 방/출구/미라를 찾고,
 *  (처음이면) "NN stage / soul stones NN" 을 보여 준 뒤 방을 그린다.
 * ------------------------------------------------------------------------- */
static void start_round(void)
{
    uint8_t n;
    char num[8], line[40];

    tune_pos = 0;
    dagger_hit_step = 0;
    push_left = push_right = 0;
    ladder_marked = 0;
    ladder_leave = 0;
    bridge_latch = 0;
    on_bridge = 0;
    ladder_marked_up = ladder_marked_down = 0;
    bridge_left = bridge_right = 0;
    player_caught = 0;
    dagger_hit = 0;

    select_wall_set();

    /* 403D: 앞 스테이지들의 방 수를 더해 이 스테이지의 첫 레코드를 찾는다 */
    scratch = 0;
    if (STAGE_ROOMS(stage) >= 1 && STAGE_ROOMS(stage) <= 9) {
        FILE *f;

        if (stage > 1) {
            n = stage - 1;
            FOR_TO(loop_i, 1, n)
                scratch += STAGE_ROOMS(loop_i);
        }
        f = fopen("kings-v.dat", "rb");         /* {$I-} Reset(f, 550) */
        if (f) {
            fseek(f, (long)(scratch + 1) * ROOM_SIZE, SEEK_SET);
            n = STAGE_ROOMS(stage);
            FOR_TO(loop_i, 1, n)
                fread(rooms + loop_i * ROOM_SIZE, 1, ROOM_SIZE, f);
            fclose(f);
        }
    }

    /* 4155: 방 훑기 */
    stones_left = 0;
    work = 0;
    mummies[2].active = 0;                      /* 1번 레코드는 지우지 않는다 (원본 그대로) */
    mummies[3].active = 0;
    n = STAGE_ROOMS(stage);
    FOR_TO(loop_i, 1, n)
        FOR_TO(loop_j, 0, ROOM_COLS - 1)
            FOR_TO(loop_k, 0, ROOM_ROWS - 1) {
                if (loop_k == ROOM_ROWS - 1)
                    MAP(loop_i, loop_j, ROOM_ROWS) = MAP(loop_i, loop_j, ROOM_ROWS - 1);
                if (MAP(loop_i, loop_j, loop_k) == T_SOUL_STONE)
                    stones_left++;
                if (MAP(loop_i, loop_j, loop_k) == T_PLAYER_START)
                    start_room = loop_i;
                if (MAP(loop_i, loop_j, loop_k) == T_EXIT) {
                    exit_x = loop_j << 5;
                    exit_y = (loop_k << 3) + 8;
                    exit_room = loop_i;
                }
                if (MAP(loop_i, loop_j, loop_k) == T_MUMMY_START && work < 3) {
                    struct mummy *m;

                    work++;
                    m = &mummies[work];
                    m->active = 1;
                    m->timer = 1;
                    m->home_x = (loop_j << 5) + 16;
                    m->home_y = (loop_k << 3) + 8;
                    m->x = (loop_j << 5) + 16;
                    m->y = (loop_k << 3) + 8;
                    m->stuck_right = m->stuck_left = m->want_down = m->stuck_down = 0;
                    m->turns_right = m->turns_left = m->unused_14 = m->unused_15 = 0;
                    m->room = loop_i;
                    m->home_room = loop_i;
                    m->dir = (int16_t)(pascal_random(2) * 2 - 1);
                    /* 4431: 아직 앞 판의 cur_room 값으로 비교한다 (원본 그대로) */
                    if (m->room == cur_room && (int16_t)((player_x - m->x) * m->dir) < 0)
                        m->dir = -m->dir;
                    m->unused_0c = -1;
                    m->sprite = 0x4D;
                    MAP(loop_i, loop_j, loop_k) = T_MUMMY_HOME;
                    m->bump = 0;
                }
            }

    cur_room = start_room;

    if (show_stage_intro) {
        two_digits(num, stage);
        sprintf(line, " stage  %s", num);
        draw_text(10, 9, line);
        two_digits(num, stones_left);
        sprintf(line, "soul stones  %s", num);
        draw_text(8, 13, line);
        show_stage_intro = 0;
        last_key = crt_readkey();
        graph_clear_viewport();
    }

#ifdef KVVGA
    /* 앞 판의 플레이어/미라/단검 그림은 죽을 때 빈 칸으로 덮였고 다시 지워지지 않는다.
       목록에 남겨 두면 새 판에서 같은 자리에 그릴 때 그것과 짝이 맞아 사라지고(깜박임),
       다음 걸음에 도로 나타난다(잔상) */
    graph_forget_moving();
#endif

    /* 4603: 방 그리기 */
    FOR_TO(loop_j, 0, ROOM_COLS - 1)
        FOR_TO(loop_k, 0, ROOM_ROWS - 1) {
            uint8_t c;

            cell_x = loop_j << 5;
            cell_y = loop_k << 3;
            if (ROOM_CELL(loop_j, loop_k) == T_PLAYER_START) {
                player_x = (loop_j << 5) + 16;
                player_y = (loop_k << 3) + 8;
                ROOM_CELL(loop_j, loop_k) = T_EMPTY;
            }
            c = ROOM_CELL(loop_j, loop_k);
            if (c < T_EMPTY)
                graph_put_image(cell_x, cell_y, SPR(c), PUT_COPY);
            else if (c == T_USED_LADDER)
                graph_put_image(cell_x, cell_y, SPR(T_LADDER), PUT_COPY);
            else if (c == T_BRIDGE || c == T_BRIDGE_USED)
                graph_put_image(cell_x, cell_y, SPR(SPR_BRIDGE), PUT_COPY);
        }

    /* 478F: 상태줄 */
    strcpy(text_buf, "stage     score           rest");
    n = (uint8_t)strlen(text_buf);
    FOR_TO(loop_i, 1, n)
        if (text_buf[loop_i - 1] != ' ')
            graph_put_image(loop_i * 20 - 20, 0xC1, SPR((uint8_t)text_buf[loop_i - 1] + 0x34), PUT_COPY);
    draw_status_number(1);
    draw_status_number(2);
    draw_status_number(3);

    held_item = HOLD_NOTHING;
    facing_left = 0;
    standing = 1;
    work = 0;
    dagger_flying = 0;
    graph_put_image(player_x - 16, player_y - 8, SPR(facing_left + held_item), PUT_COPY);
    player_sprite = facing_left + held_item;
    walk_count = 0;
    hook_timer(1);
    music_play(SONG_GAME);                      /* (KVVGA) 타이머가 걸린 동안 울린다 */
}

/* ---------------------------------------------------------------------------
 *  발밑이 비었으면 떨어진다 (0000:48C2 .. 4C45)
 * ------------------------------------------------------------------------- */
static int falls_through(uint8_t c)       /* 원래 집합 CS:39AA */
{
    switch (c) {
    case 30: case 33: case 34: case 35: case 56: case 73:
    case 85: case 86: case 87: case 88: case 100: case 156:
        return 1;
    }
    return 0;
}

static int lands_on(uint8_t c)            /* 원래 집합 CS:39CA */
{
    switch (c) {
    case 42: case 43: case 46: case 47: case 50: case 51: case 52:
    case 53: case 54: case 111: case 175: case 222:
        return 1;
    }
    return 0;
}

/* 한 줄 떨어진 돌을 그리고 다음 줄로 (떨어지는 루프와 메인 루프가 같은 모양이다) */
static void fall_player(void)
{
    if (!(falls_through(ROOM_CELL((player_x + 11) / 32, (player_y + 8) / 8)) &&
          falls_through(ROOM_CELL((player_x + 11) / 32, player_y / 8)) &&
          falls_through(ROOM_CELL((player_x - 11) / 32, (player_y + 8) / 8)) &&
          falls_through(ROOM_CELL((player_x - 11) / 32, player_y / 8))))
        return;

    work = 3000;
    do {
        work -= 50;
        if (dagger_flying)
            move_dagger();
        crt_sound((uint16_t)work);
        crt_delay(2);
        check_pickup();
        frame_count++;
        if (frame_count % 3 == 0)
            move_mummies();

        graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
        player_y += 4;
        if (player_y > 0xB4)
            check_room_change();
        player_sprite = facing_left + held_item;
        graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
        flush_key();

        /* 4A9B: 돌도 같이 떨어뜨린다 */
        if (stone_falling) {
            if (MAP(stone_room, stone_col, stone_row + 2) == T_EMPTY) {
                if (stone_room == cur_room)
                    graph_put_image(stone_col << 5, stone_row << 3, SPR(T_STONE), PUT_XOR);
                stone_row++;
                crt_sound(1000);
                crt_delay(2);
                if (stone_row > 0x16) {
                    /* old_x, tmp_y 를 그대로 넘긴다 (원본 그대로 - 5D9F 와 달리 tmp_y 를 정하지 않음) */
                    move_to_next_room(&stone_room, &old_x, &tmp_y);
                    stone_row = 0;
                }
                if (stone_room == cur_room)
                    graph_put_image(stone_col << 5, stone_row << 3, SPR(T_STONE), PUT_XOR);
            } else {
                MAP(stone_room, stone_col, stone_row) = T_STONE;
                stone_falling = 0;
                crt_sound(30);
                crt_delay(20);
            }
        }
    } while (!lands_on(ROOM_CELL(player_x / 32, (player_y + 8) / 8)));

    crt_nosound();
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    player_y = (player_y / 8) * 8;
    work = 0;
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
}

/* ---------------------------------------------------------------------------
 *  F1 / F2 가 끝나기를 기다린다: 확장키 k 를 다시 누르고 뗄 때까지 (4DA4, 4F05)
 * ------------------------------------------------------------------------- */
static void wait_function_key(uint8_t k)
{
    do {
        while (crt_readkey() != 0)
            ;
    } while (crt_readkey() != k);
    while (scan_code == k)
        idle();
}

/* ---------------------------------------------------------------------------
 *  Space - 들고 있는 것 쓰기 (0000:5081 .. 5A30)
 * ------------------------------------------------------------------------- */
static int can_dig_through(uint8_t c)     /* 원래 집합 CS:3A8A */
{
    switch (c) {
    case 30: case 33: case 34: case 35: case 56: case 87: case 88: case 100:
        return 1;
    }
    return 0;
}

static void throw_dagger(void)
{
    if (dagger_flying)
        return;
    flush_key();
    dagger_flying = 1;
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    graph_put_image(player_x - 16, player_y - 8, SPR(facing_left + 2), PUT_XOR);
    crt_delay(40);
    graph_put_image(player_x - 16, player_y - 8, SPR(facing_left + 2), PUT_XOR);
    graph_put_image(player_x - 16, player_y - 8, SPR(facing_left + 0x26), PUT_XOR);
    crt_delay(70);
    graph_put_image(player_x - 16, player_y - 8, SPR(facing_left + 0x26), PUT_XOR);
    graph_put_image(player_x - 16, player_y - 8, SPR(facing_left + 2), PUT_XOR);
    crt_delay(30);
    graph_put_image(player_x - 16, player_y - 8, SPR(facing_left + 2), PUT_XOR);
    graph_put_image(player_x - 16, player_y - 8, SPR(facing_left), PUT_XOR);

    player_sprite = facing_left;
    dagger_spin = 0;
    dagger_room = cur_room;
    dagger_dy = 0;
    dagger_y = player_y - 4;
    dagger_dx = facing_left * 2 - 1;
    dagger_x = player_x - 16 - dagger_dx * 10;
    held_item = HOLD_NOTHING;
    dagger_spin = 0;
    dagger_stopped = 0;
    graph_put_image(dagger_x, dagger_y, SPR(0x39), PUT_XOR);
}

/* 곡괭이로 앞의 바닥을 판다 (held_item 4: 두 칸까지, 8: 한 칸) */
static void dig_down(void)
{
    probe_col = (uint8_t)((player_x - (facing_left * 2 - 1) * 18) / 32);
    probe_row = (uint8_t)((player_y + 8) / 8);
    work = 1;
    crt_delay(7);
    move_mummies();

    while (ROOM_CELL(probe_col, probe_row) == T_BRICK && work < 3 &&
           can_dig_through(ROOM_CELL(probe_col, (player_y - 6) / 8)) &&
           can_dig_through(ROOM_CELL(probe_col, (player_y + 6) / 8))) {
        if (work == 1) {
            graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
            graph_put_image(player_x - 14 - facing_left * 10, player_y - 8, SPR(player_sprite), PUT_XOR);
        }
        if (work == 2 && held_item == HOLD_PICK_SHORT)
            break;
        FOR_TO(loop_j, 1, 12) {
            FOR_TO(loop_k, 1, 5) {
                crt_sound(loop_k * 5);
                crt_delay(2);
                crt_nosound();
                crt_delay(2);
                crt_sound(loop_k * 10);
                crt_delay(1);
                crt_nosound();
                if (dagger_flying && loop_k == 5)
                    move_dagger();
            }
            graph_put_image(player_x - 14 - facing_left * 10, player_y - 8, SPR(player_sprite), PUT_XOR);
            if (dagger_flying)
                move_dagger();
            else
                crt_delay(2);
            player_sprite = (uint8_t)(facing_left * 2 + 0x3D + (int16_t)loop_j % 2 + held_item);
            graph_put_image(player_x - 14 - facing_left * 10, player_y - 8, SPR(player_sprite), PUT_XOR);
            if ((int16_t)loop_j % 6 == 0)       /* 6 번째는 COPY, 12 번째는 XOR */
                graph_put_image(probe_col << 5, probe_row << 3, SPR(0x37), ((int16_t)loop_j - 1) / 6);
            ROOM_CELL(probe_col, probe_row) = T_EMPTY;
            move_mummies();
        }
        probe_row++;
        work++;
    }

    if (work > 1) {
        graph_put_image(player_x - 14 - facing_left * 10, player_y - 8, SPR(player_sprite), PUT_XOR);
        held_item = HOLD_NOTHING;
        standing = 1;
        player_sprite = facing_left + held_item;
        graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
        if (scan_code == SC_LEFT || scan_code == SC_RIGHT)
            standing = 0;
    }
}

/* 곡괭이로 앞의 벽돌 두 줄을 옆으로 판다 */
static void dig_side(void)
{
    probe_col = (uint8_t)((player_x - (facing_left * 2 - 1) * 21) / 32);
    probe_row = (uint8_t)((player_y + 4) / 8);
    if (ROOM_CELL(probe_col, probe_row) != T_BRICK)
        return;
    if (ROOM_CELL(probe_col, (player_y - 4) / 8) != T_BRICK)
        return;

    hook_timer(0);
    FOR_TO(loop_j, 1, 14) {
        pcm_play(pcm_dig, PCM_DIG_SIZE, 1);
        loop_k = PCM_DIG_SIZE;                  /* 원본 PCM 루프가 남기는 for 변수 값 */
        scratch = 7;
        if (machine_speed >= 1)
            loop_i = machine_speed;
        if (dagger_flying) {
            move_dagger();
            crt_delay(1);
        } else {
            crt_delay(2);
        }
        graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
        player_sprite = (uint8_t)(((int16_t)loop_j % 2) * 18 + facing_left + 6);
        player_x -= facing_left * 2 - 1;
        graph_put_image(probe_col << 5, (probe_row << 3) - 8,
                        SPR((facing_left << 2) + (int16_t)loop_j / 4 + 0x67), PUT_COPY);
        graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
        move_mummies();
    }
    crt_delay(40);
    hook_timer(1);
    held_item = HOLD_NOTHING;
    standing = 1;
    graph_put_image(probe_col << 5, (probe_row << 3) - 8, SPR((facing_left << 2) + 0x6A), PUT_XOR);
    ROOM_CELL(probe_col, probe_row) = T_EMPTY;
    ROOM_CELL(probe_col, probe_row - 1) = T_EMPTY;
    if (scan_code == SC_LEFT || scan_code == SC_RIGHT)
        standing = 0;
    crt_delay(40);
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    player_sprite = facing_left + held_item;
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
}

/* ---------------------------------------------------------------------------
 *  키 처리 (0000:4C45 .. 5A30)   case scan_code of ...
 * ------------------------------------------------------------------------- */
static void handle_key(void)
{
    uint8_t c;

    if (scan_code == SC_LEFT || scan_code == SC_RIGHT || (scan_code == SC_SPACE_UP && standing == 0)) {
        if (scan_code == SC_LEFT || (scan_code == SC_SPACE_UP && facing_left == 1))
            walk_left();
        else
            walk_right();
        return;
    }

    switch (scan_code) {
    case SC_UP:                                 /* 4C92 */
        c = ROOM_CELL(player_x / 32, (player_y + 7) / 8);
        switch (c) {
        case 51: case 52: case 101: case 102: case 111: case 151: case 152:
        case 161: case 175: case 201: case 202: case 251: case 252:
            climb_up();
            return;
        }
        c = ROOM_CELL(player_x / 32, player_y / 8);
        switch (c) {
        case 51: case 52: case 101: case 102: case 111: case 151: case 152:
        case 161: case 175: case 201: case 202: case 251: case 252:
            climb_up();
            return;
        }
        crt_delay(7);
        if (ladder_leave)
            remove_used_ladder();
        return;

    case SC_DOWN:                               /* 4D2A */
        c = ROOM_CELL(player_x / 32, (player_y + 9) / 8);
        if (c != 50 && c != 53 && c != 54 && c != 175)
            climb_down();
        else if (ladder_leave)
            remove_used_ladder();
        return;

    case SC_F1:                                 /* 4D82: 잠깐 멈춤 */
        hook_timer(0);
        crt_nosound();
        last_key = crt_readkey();
        wait_function_key(SC_F1);
        hook_timer(1);
        return;

    case SC_F2:                                 /* 4DDD: 방 지도 */
        hook_timer(0);
        crt_nosound();
        last_key = crt_readkey();
        graph_to_cga(screen_save, 0x3F48);
        graph_clear_device();
        FOR_TO(loop_i, 1, 9)
            if (room_grid[loop_i] >= 1 && room_grid[loop_i] <= 9)
                graph_rectangle(((int16_t)(loop_i - 1) % 3) * 150 + 100, ((int16_t)(loop_i - 1) / 3) * 60 + 10,
                                ((int16_t)(loop_i - 1) % 3) * 150 + 250, ((int16_t)(loop_i - 1) / 3) * 60 + 70);
        FOR_TO(loop_i, 1, 9)
            if (room_grid[loop_i] == cur_room)
                scratch = loop_i;
        graph_put_image(((int16_t)(scratch - 1) % 3) * 150 + 160, ((int16_t)(scratch - 1) / 3) * 60 + 32,
                        SPR(0), PUT_XOR);
        wait_function_key(SC_F2);
        graph_from_cga(screen_save, 0x3F48);
        hook_timer(1);
        return;

    case SC_F3:                                 /* 4F55: 음악 <-> 박자 */
        if (tune_len == MUSIC_TICKS) {
            uint8_t n;

            loop_k = 0;
            tune_pos = 0;
            loop_j = 0;
            FOR_TO(loop_i, 1, BEAT_NOTES) {
                n = beat_score[loop_i - 1].ticks;
                FOR_TO(loop_j, 1, n) {
                    tune[loop_k] = beat_score[loop_i - 1].freq;
                    loop_k++;
                }
            }
            tune_len = BEAT_TICKS;
            scan_code = 0x0A;
        } else if (tune_len == BEAT_TICKS) {
            tune_pos = 0;
            fill_music_tune();
            scan_code = 0x0A;
        }
        return;

    case SC_SPACE:                              /* 5081 */
        switch (held_item) {
        case HOLD_NOTHING:
            c = ROOM_CELL(player_x / 32, (player_y - 9) / 8);
            if (c != 53 && c != 54) {
                jump();
                return;
            }
            c = ROOM_CELL(player_x / 32, (player_y + 9) / 8);
            if (c != 51 && c != 52)
                jump();
            return;
        case HOLD_DAGGER:
            throw_dagger();
            return;
        case HOLD_PICK_DOWN:
        case HOLD_PICK_SHORT:
            dig_down();
            return;
        case HOLD_PICK_SIDE:
            dig_side();
            return;
        }
        return;

    default:                                    /* 5A32 */
        standing = 1;
        check_pickup();
        return;
    }
}

/* ---------------------------------------------------------------------------
 *  스테이지를 깼다 (0000:5A92)
 * ------------------------------------------------------------------------- */
static int stage_clear(void)
{
    enter_exit();
    graph_set_viewport(0, 0xBE, 0x27F, 0xC7, 1);
    graph_clear_viewport();
    graph_set_viewport(0, 0, 0x27F, 0xC7, 1);
    stage++;
    if (stage == 61)
        return GAME_OVER;

    tune_pos = 0x10FF;                          /* 미라가 나오는 그림 0x49..0x6E 를 다시 읽는다 */
    load_sprites(0x49, 0x6E, 0x1F, 0x0F, 0x40);
    select_wall_set();

    lives++;
    score += 1000;
    draw_text(13, 3, "nice");
    draw_text(4, 5, "let s go to next stage");
    FOR_TO(loop_i, 0x32, 0x35)
        graph_line(0x90, loop_i, 0x94, loop_i);     /* let's 의 ' */
    crt_delay(1000);
    show_stage_intro = 1;
    hook_keyboard(1);
    do {
        flush_key();
    } while (crt_keypressed());
    return NEXT_ROUND;
}

/* ---------------------------------------------------------------------------
 *  한 판 (0000:489A .. 5E3B).  다시 시작하면 NEXT_ROUND, 끝나면 GAME_OVER.
 * ------------------------------------------------------------------------- */
static int play_round(void)
{
    for (;;) {
        flush_key();
        frame_count++;
        if (frame_count % 6 == 0)
            move_mummies();
        fall_player();

        handle_key();

        /* 5A3C */
        flush_key();
        if (dagger_flying)
            move_dagger();

        if (stones_left == 0 && cur_room == exit_room) {
            int16_t dx = player_x - exit_x;

            if (dx < 0)
                dx = -dx;
            if (dx < 5 && player_y == exit_y)
                return stage_clear();
        }

        if (player_caught || scan_code == SC_F4) {     /* 5CF6 */
            player_die();
            lives--;
            if (lives == 0xFF)
                return GAME_OVER;
            return NEXT_ROUND;
        }

        if (stone_falling) {                    /* 5D19 */
            uint8_t c = MAP(stone_room, stone_col, stone_row + 2);

            switch (c) {
            case 27: case 33: case 34: case 35: case 56: case 76: case 85:
            case 86: case 87: case 88: case 100: case 106: case 156: case 206:
                if (stone_room == cur_room)
                    graph_put_image(stone_col << 5, stone_row << 3, SPR(T_STONE), PUT_XOR);
                stone_row++;
                crt_sound(1000);
                crt_delay(2);
                if (stone_row > 0x16) {
                    tmp_y = 0xC3;
                    move_to_next_room(&stone_room, &old_x, &tmp_y);     /* x 로 old_x 를 넘긴다 (원본 그대로) */
                    stone_row = 0;
                }
                if (stone_room == cur_room)
                    graph_put_image(stone_col << 5, stone_row << 3, SPR(T_STONE), PUT_XOR);
                break;
            default:
                MAP(stone_room, stone_col, stone_row) = T_STONE;
                stone_falling = 0;
                crt_sound(30);
                crt_delay(20);
                break;
            }
        }

        if (machine_speed > 2)
            crt_delay(5);
        if (scan_code == SC_F10)
            return GAME_OVER;
#ifdef KVVGA
        if (scan_code == SC_ESC) {              /* (KVVGA) ESC: 바로 도스로 */
            crt_nosound();
            graph_close();
            system_shutdown();
            exit(0);
        }
#endif
    }
}

/* ---------------------------------------------------------------------------
 *  게임 끝 (0000:5E3E).  2 = 이어서, 1 = 끝.
 * ------------------------------------------------------------------------- */
static int game_over_menu(void)
{
    hook_keyboard(0);
    hook_timer(0);
    crt_nosound();
    music_play(SONG_OVER);                      /* (KVVGA) */
    graph_clear_viewport();
    draw_text(9, 10, "1  game over");
    draw_text(9, 12, "2  continue");
    do {
        last_key = crt_readkey();
    } while (last_key != '1' && last_key != '2');
    if (last_key == '2') {
        score = 0;
        lives = 2;
        show_stage_intro = 1;
        hook_keyboard(1);
        graph_clear_viewport();
        return 1;
    }
    return 0;
}

/* ---------------------------------------------------------------------------
 *  메인 프로그램 (0000:3B1F)
 * ------------------------------------------------------------------------- */
int main(void)
{
    uint8_t id;

    system_init();
    clrscr();

    /* 3B54: PC/XT 면 2, AT 면 10 (PCM 빈 루프 횟수 - 여기서는 한 판마다 Delay(5) 에만 쓰인다) */
    id = machine_id();
    if (id == 0xFF || id == 0xFE)
        machine_speed = 2;
    else if (id == 0xFC)
        machine_speed = 10;

    /* 3B7A: 스프라이트 */
    tune_pos = 0xFFFF;
    load_sprites(0x00, 0x32, 0x1F, 0x0F, 0x40);
    load_sprites(0x33, 0x40, 0x1F, 0x07, 0x20);
    load_sprites(0x41, 0x48, 0x27, 0x0F, 0x50);
    load_sprites(0x49, 0x6E, 0x1F, 0x0F, 0x40);
    load_sprites(0x6F, 0x8A, 0x1F, 0x07, 0x20);
    load_sprites(0x8B, 0xAE, 0x12, 0x06, 0x15);
    memmove(SPR(SPR_BRIDGE), SPR(0x33), SPRITE_REC);

    scan_code = 0;
    lives = 2;
    score = 0;
    hi_score = 0;
    title_and_menu();
    graph_clear_device();

    fill_music_tune();
    hook_keyboard(1);
    show_stage_intro = 1;

    for (;;) {
        start_round();
        if (play_round() == GAME_OVER && !game_over_menu())
            break;
    }

    graph_close();
    system_shutdown();
    return 0;
}
