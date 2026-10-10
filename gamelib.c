/* ============================================================================
 *  gamelib.c  -  게임 유닛 (원본 세그먼트 08E2)
 * ----------------------------------------------------------------------------
 *  점수판, 방 사이 이동, 던진 단검, 방 다시 그리기, 물건 줍기, 출구에 들어가기,
 *  큰 글씨.  미라는 mummy.c, 인터럽트 처리기는 system.c.
 * ========================================================================== */
#include <stdio.h>
#include <string.h>

#include "kv.h"

/* ---------------------------------------------------------------------------
 *  원래 08E2:0118  (안에 중첩 프로시저 08E2:00CD - 앞에 '0' 채우기)
 *  상태줄 숫자: 1 스테이지(2자리), 2 점수(8자리, 최고 점수도 고친다), 3 목숨.
 *  숫자 그림 = SPR(0x8B + 숫자).  점수를 쓰는 동안 scratch 를 for 변수로 쓴다.
 * ------------------------------------------------------------------------- */
void draw_status_number(int which)
{
    char num[16];
    int len;

    switch (which) {
    case 1:
        graph_put_image(0x78, 0xC1, SPR(stage / 10 + 0x8B), PUT_COPY);
        graph_put_image(0x8C, 0xC1, SPR(stage % 10 + 0x8B), PUT_COPY);
        break;

    case 2:
        sprintf(num, "%ld", (long)score);
        len = (int)strlen(num);
        text_buf[0] = 0;
        if (8 - len > 0)                        /* Copy('0000000', 1, 8 - Length(s)) + s */
            sprintf(text_buf, "%.*s", 8 - len > 7 ? 7 : 8 - len, "0000000");
        strcat(text_buf, num);
        if (score > hi_score)
            hi_score = score;
        FOR_TO(scratch, 1, 8)
            graph_put_image(scratch * 20 + 300, 0xC1, SPR((uint8_t)text_buf[scratch - 1] + 0x5B), PUT_COPY);
        break;

    case 3:
        graph_put_image(0x258, 0xC1, SPR(lives / 10 + 0x8B), PUT_COPY);
        graph_put_image(0x26C, 0xC1, SPR(lives % 10 + 0x8B), PUT_COPY);
        break;
    }
}

/* ---------------------------------------------------------------------------
 *  원래 08E2:029B
 *  무엇이든(플레이어, 단검, 돌, 미라) 화면 가장자리를 넘으면 3x3 방 배치표에서
 *  그쪽으로 이웃한 방을 찾고(없으면 줄/열을 한 바퀴 돌아서), 좌표를 반대편
 *  가장자리로 옮긴다.  배치표 칸 k(1..9): 줄 = (k-1)/3, 칸 = (k-1)%3.
 * ------------------------------------------------------------------------- */
void move_to_next_room(uint8_t *room, int16_t *x, int16_t *y)
{
    static uint8_t cell;        /* 원래 [bp-1].  배치표에서 못 찾으면 쓰레기 값 그대로 쓴다 */
    uint8_t line[7];            /* [1..6] = 같은 줄(또는 열)의 방 셋을 두 번 */
    uint8_t k;

    FOR_TO(k, 1, 9)
        if (room_grid[k] == *room)
            cell = k;

    if (*x < 0x14) {                            /* 왼쪽으로 나감 */
        FOR_TO(k, 1, 3) {
            uint8_t g = (uint8_t)(((cell - 1) / 3) * 3 + k);
            line[k] = room_grid[g];
            line[k + 3] = room_grid[g];
        }
        *x = 0x26C;
        FOR_DOWNTO(k, (uint8_t)((cell - 1) % 3 + 3), 1)
            if (line[k] >= 1 && line[k] <= 9) {
                cell = (uint8_t)(((cell - 1) / 3) * 3 + (k - 1) % 3 + 1);
                goto found;
            }
    }
    if (*x > 0x26C) {                           /* 오른쪽으로 나감 */
        FOR_TO(k, 1, 3) {
            uint8_t g = (uint8_t)(((cell - 1) / 3) * 3 + k);
            line[k] = room_grid[g];
            line[k + 3] = room_grid[g];
        }
        *x = 0x14;
        FOR_TO(k, (uint8_t)((cell - 1) % 3 + 2), 6)
            if (line[k] >= 1 && line[k] <= 9) {
                cell = (uint8_t)(((cell - 1) / 3) * 3 + (k - 1) % 3 + 1);
                goto found;
            }
    }
    if (*y < 0x0A) {                            /* 위로 나감 */
        FOR_TO(k, 1, 3) {
            uint8_t g = (uint8_t)((k - 1) * 3 + (cell - 1) % 3 + 1);
            line[k] = room_grid[g];
            line[k + 3] = room_grid[g];
        }
        *y = 0xB4;
        FOR_DOWNTO(k, (uint8_t)((cell - 1) / 3 + 3), 1)
            if (line[k] >= 1 && line[k] <= 9) {
                cell = (uint8_t)((cell - 1) % 3 + ((k - 1) % 3) * 3 + 1);
                goto found;
            }
    }
    if (*y > 0xB4) {                            /* 아래로 나감 */
        FOR_TO(k, 1, 3) {
            uint8_t g = (uint8_t)((k - 1) * 3 + (cell - 1) % 3 + 1);
            line[k] = room_grid[g];
            line[k + 3] = room_grid[g];
        }
        *y = 0x0A;
        FOR_TO(k, (uint8_t)((cell - 1) / 3 + 2), 6)
            if (line[k] >= 1 && line[k] <= 9) {
                cell = (uint8_t)((cell - 1) % 3 + ((k - 1) % 3) * 3 + 1);
                goto found;
            }
    }
found:
    *room = room_grid[cell];
}

/* ---------------------------------------------------------------------------
 *  원래 08E2:06C3   던진 단검 한 걸음
 *  벽에 닿으면 가로로 멈추고, 20 프레임 넘게 멈춰 있으면 떨어진다.
 *  빈손인 플레이어가 닿으면 다시 줍는다.  미라를 맞힌 뒤(dagger_hit)에는
 *  비명을 지르고 점수를 주고 튕겨 오른다.  바닥에 닿으면 그 칸에 단검을 남긴다.
 * ------------------------------------------------------------------------- */
static int16_t abs16(int16_t v)
{
    return v < 0 ? (int16_t)-v : v;
}

#define DAGGER_CELL(col, row)   MAP(dagger_room, col, row)

void move_dagger(void)
{
    uint8_t c;

    if (IN(DAGGER_CELL((dagger_x + 16 - dagger_dx * 21) / 32, (dagger_y - 2) / 8),
           42, 43, 46, 47, 50, 53, 54, 175, 222))
        dagger_dx = 0;
    if (dagger_dx == 0) {
        dagger_stopped++;
        if (dagger_stopped > 20)
            dagger_dy = 1;
    }

    if (cur_room == dagger_room) {
        graph_put_image(dagger_x, dagger_y, SPR(dagger_spin % 8 + 0x39), PUT_XOR);
        if (abs16(dagger_x + 16 - player_x) < 6 && abs16(dagger_y + 2 - player_y) < 8 &&
            held_item == HOLD_NOTHING) {
            dagger_flying = 0;
            dagger_hit = 0;
            held_item = HOLD_DAGGER;
            dagger_dy = 0;
            dagger_hit_step = 0;
            dagger_stopped = 0;
            return;
        }
    }

    dagger_spin++;
    if (IN(DAGGER_CELL((dagger_x + 16) / 32, (dagger_y - 2) / 8), 42, 43, 46, 47, 50, 53, 54, 175, 222))
        dagger_dy = 1;
    dagger_x -= dagger_dx * 4;
    dagger_y += dagger_dy;
    if (dagger_hit)
        dagger_x += dagger_dx * 3;

    if (dagger_x < -1 || dagger_y > 0xB4)
        move_to_next_room(&dagger_room, &dagger_x, &dagger_y);
    if (dagger_x > 0x270) {
        dagger_x = 0x281;
        move_to_next_room(&dagger_room, &dagger_x, &dagger_y);
        dagger_x = 1;
    }

    if (cur_room == dagger_room)
        graph_put_image(dagger_x, dagger_y, SPR(dagger_spin % 8 + 0x39), PUT_XOR);
    if (cur_room == dagger_room)
        crt_sound((uint16_t)((dagger_spin % 8) * 100 + 5000));

    if (dagger_hit) {
        dagger_hit_step++;
        switch (dagger_hit_step) {
        case 2:                                 /* 비명 - 인터럽트를 잠깐 풀고 */
            hook_keyboard(0);
            hook_timer(0);
            pcm_play(pcm_scream, PCM_SCREAM_SIZE, 0);
            hook_keyboard(1);
            hook_timer(1);
            if (player_caught) {
                hook_keyboard(0);
                hook_timer(0);
            }
            break;
        case 3:
            score += 100;
            draw_status_number(3);              /* 점수가 아니라 목숨을 다시 쓴다 (원본 그대로) */
            break;
        case 4:  dagger_dx = -dagger_dx;  break;
        case 5:  dagger_dy = -1;          break;
        case 15: dagger_dy = 0;           break;
        case 20: dagger_dy = 1;           break;
        case 27: dagger_dx = 0;           break;
        case 28:
            dagger_hit_step = 0;
            dagger_hit = 0;
            break;
        }
    }

    /* 0A48: 바닥에 떨어졌다 */
    if (IN(DAGGER_CELL((dagger_x + 16) / 32, (dagger_y + 8) / 8),
           42, 43, 46, 47, 50, 51, 52, 53, 54, 101, 102, 111, 151, 152, 161, 175, 201, 202, 222, 251, 252) &&
        dagger_dx == 0 && dagger_dy == 1) {
        int16_t col = (dagger_x + 16) / 32;
        int16_t row = dagger_y / 8;

        if (cur_room == dagger_room)
            graph_put_image(dagger_x, dagger_y, SPR(dagger_spin % 8 + 0x39), PUT_XOR);
        dagger_flying = 0;
        if (dagger_hit_step > 0) {
            dagger_hit = 0;
            dagger_hit_step = 0;
        }

        if (IN(DAGGER_CELL(col, row), 51, 52, 56, 101, 102, 106, 111, 151, 152, 156, 161, 201, 202))
            DAGGER_CELL(col, row) += 50;        /* 단검이 한 개 더 */
        else
            DAGGER_CELL(col, row) = T_DAGGER;
        crt_sound(30);
        crt_delay(20);

        if (cur_room == dagger_room) {
            c = DAGGER_CELL(col, row);
            if (IN(c, 56, 106, 156, 206))
                graph_put_image((col << 5) + c / 50 - 1, row << 3, SPR(T_DAGGER), PUT_XOR);
            else if (IN(c, 161, 211))
                graph_put_image((col << 5) + c / 50 - 3, row << 3, SPR(T_DAGGER), PUT_XOR);
            else
                graph_put_image((col << 5) + c / 50 - 2, row << 3, SPR(T_DAGGER), PUT_XOR);
        }
    }

    if (cur_room != dagger_room)
        crt_delay(2);
    flush_key();
}

/* ---------------------------------------------------------------------------
 *  원래 08E2:28F1
 *  플레이어가 가장자리를 넘었으면 옆 방으로 옮기고 화면을 모두 다시 그린다.
 *  칸 값 100 이상: 밟은 사다리(111 계열), 단검이 쌓인 칸(+50*n), 다리.
 * ------------------------------------------------------------------------- */
void check_room_change(void)
{
    uint8_t before = cur_room, n;

    move_to_next_room(&cur_room, &player_x, &player_y);
    if (cur_room == before)
        return;

    graph_clear_device();
    strcpy(text_buf, "stage     score           rest");
    n = (uint8_t)strlen(text_buf);
    FOR_TO(loop_i, 1, n)
        if (text_buf[loop_i - 1] != ' ')
            graph_put_image(loop_i * 20 - 20, 0xC1, SPR((uint8_t)text_buf[loop_i - 1] + 0x34), PUT_COPY);
    draw_status_number(1);
    draw_status_number(2);
    draw_status_number(3);

    FOR_TO(loop_i, 0, ROOM_COLS - 1)
        FOR_TO(loop_j, 0, ROOM_ROWS - 1) {
            int16_t x = loop_i << 5, y = loop_j << 3;

            loop_k = ROOM_CELL(loop_i, loop_j);
            flush_key();
            if (loop_k < T_EMPTY) {
                graph_put_image(x, y, SPR(loop_k), PUT_XOR);
                continue;
            }
            switch (loop_k) {
            case 111:
                graph_put_image(x, y, SPR(T_LADDER), PUT_XOR);
                break;
            case 161:
                graph_put_image(x, y, SPR(T_LADDER), PUT_XOR);
                graph_put_image(x, y, SPR(T_DAGGER), PUT_XOR);
                break;
            case 211:
                graph_put_image(x, y, SPR(T_LADDER), PUT_XOR);
                graph_put_image(x, y, SPR(T_DAGGER), PUT_XOR);
                graph_put_image(x + 1, y, SPR(T_DAGGER), PUT_XOR);
                break;
            case 101: case 102: case 151: case 152:
            case 201: case 202: case 251: case 252:
                graph_put_image(x, y, SPR(loop_k % 50 + 50), PUT_XOR);
                n = (uint8_t)(loop_k / 50);
                FOR_TO(scratch, 2, n)
                    graph_put_image(x + scratch - 2, y, SPR(T_DAGGER), PUT_XOR);
                break;
            case 106: case 156: case 206:
                n = (uint8_t)(loop_k / 50);
                FOR_TO(scratch, 1, n)
                    graph_put_image(x + scratch - 1, y, SPR(T_DAGGER), PUT_XOR);
                break;
            case T_BRIDGE: case T_BRIDGE_USED:
                graph_put_image(x, y, SPR(SPR_BRIDGE), PUT_XOR);
                break;
            }
        }

    if (dagger_flying && cur_room == dagger_room)
        graph_put_image(dagger_x, dagger_y, SPR(dagger_spin % 8 + 0x39), PUT_XOR);

    FOR_TO(loop_i, 1, 3) {
        struct mummy *m = &mummies[loop_i];

        if (m->active && m->room == cur_room) {
            if (m->timer > 0x2711 && m->timer < 0x2727)
                graph_put_image(m->x - 16, m->y - 8, SPR(0x52), PUT_XOR);
            if (m->timer > 0x41 && m->timer < 0x2711)
                graph_put_image(m->x - 16, m->y - 8, SPR(m->sprite), PUT_XOR);
        }
    }
}

/* ---------------------------------------------------------------------------
 *  원래 08E2:2DEB (08E2:34E0 안의 중첩 프로시저)
 *  (col, row) 칸의 물건을 줍는다.
 *      곡괭이 셋  - 빈손일 때만
 *      영혼석    - 점수 200.  마지막 것이면 화면을 20번 뒤집어 번쩍인다
 *      단검      - 빈손일 때만, 쌓인 것 중 하나
 *  소리를 내는 사이사이에도 단검과 미라를 움직인다.
 * ------------------------------------------------------------------------- */
static void chime(uint8_t from, uint8_t to, int mul, int ms)
{
    FOR_TO(loop_k, from, to) {
        crt_sound((uint16_t)(loop_k * mul));
        crt_delay(ms);
        crt_nosound();
    }
}

static void pick_up_item(uint8_t col, uint8_t row)
{
    static uint8_t saved[0x3EE5], inverted[0x3EE5];     /* 원래 34E0 의 지역 변수 (스택 32KB) */
    uint8_t c;
    int16_t i;

    if (dagger_flying)
        move_dagger();

    c = ROOM_CELL(col, row);
    switch (c) {
    case T_PICK_DOWN: case T_PICK_SIDE: case T_PICK_SHORT:
        if (held_item != HOLD_NOTHING)
            break;
        graph_put_image(col << 5, row << 3, SPR(ROOM_CELL(col, row)), PUT_XOR);
        if (dagger_flying)
            move_dagger();
        chime(20, 25, 50, 10);
        if (dagger_flying)
            move_dagger();
        chime(20, 30, 50, 10);
        if (dagger_flying)
            move_dagger();
        switch (ROOM_CELL(col, row)) {
        case T_PICK_DOWN:  held_item = HOLD_PICK_DOWN;  break;
        case T_PICK_SIDE:  held_item = HOLD_PICK_SIDE;  break;
        case T_PICK_SHORT: held_item = HOLD_PICK_SHORT; break;
        }
        ROOM_CELL(col, row) = T_EMPTY;
        break;

    case T_SOUL_STONE:
        graph_put_image(col << 5, row << 3, SPR(T_SOUL_STONE), PUT_XOR);
        stones_left--;
        score += 200;
        draw_status_number(2);
        draw_status_number(3);
        if (dagger_flying)
            move_dagger();
        chime(40, 45, 50, 7);
        if (dagger_flying)
            move_dagger();
        chime(40, 45, 60, 7);
        if (dagger_flying)
            move_dagger();
        chime(40, 50, 50, 7);
        if (dagger_flying)
            move_dagger();
        ROOM_CELL(col, row) = T_EMPTY;

        if (stones_left == 0) {
            graph_to_cga(saved, 0x3EE4);
            for (i = 0; i <= 0x3EE4; i++)
                inverted[i] = (uint8_t)~saved[i];
            for (i = 1; i <= 20; i++) {
#ifdef KVVGA
                graph_flash(i & 1);             /* 256색은 팔레트를 뒤집는다 */
                (void)inverted;
#else
                if (i & 1)
                    graph_from_cga(inverted, 0x3EE4);
                else
                    graph_from_cga(saved, 0x3EE4);
#endif
                crt_sound((uint16_t)(i * 30 + 100));
                crt_delay(5);
                crt_sound(50);
                crt_delay(3);
            }
        }
        break;

    case T_DAGGER:
    case 101: case 102: case 106: case 151: case 152: case 156:
    case 161: case 201: case 202: case 206: case 211: case 251: case 252:
        if (held_item != HOLD_NOTHING)
            break;
        if (c == 161 || c == 211)
            graph_put_image((col << 5) + ROOM_CELL(col, row) / 50 - 3, row << 3, SPR(T_DAGGER), PUT_XOR);
        else if (c == T_DAGGER || c == 106 || c == 156 || c == 206)
            graph_put_image((col << 5) + ROOM_CELL(col, row) / 50 - 1, row << 3, SPR(T_DAGGER), PUT_XOR);
        else
            graph_put_image((col << 5) + ROOM_CELL(col, row) / 50 - 2, row << 3, SPR(T_DAGGER), PUT_XOR);
        held_item = HOLD_DAGGER;
        if (dagger_flying)
            move_dagger();
        chime(20, 25, 50, 10);
        if (dagger_flying)
            move_dagger();
        chime(20, 30, 50, 10);
        if (ROOM_CELL(col, row) == T_DAGGER)
            ROOM_CELL(col, row) = T_EMPTY;
        else
            ROOM_CELL(col, row) -= 50;
        break;
    }

    move_mummies();
}

/* ---------------------------------------------------------------------------
 *  원래 08E2:34E0   플레이어 몸 위쪽 칸과 아래쪽 칸에 주울 것이 있나
 * ------------------------------------------------------------------------- */
static int pickable(uint8_t c)          /* 원래 집합 CS:34C0 */
{
    return IN(c, 30, 33, 34, 35, 56, 101, 102, 106, 151, 152, 156, 161, 201, 202, 206, 211, 251, 252);
}

void check_pickup(void)
{
    uint8_t col = (uint8_t)(player_x / 32);
    uint8_t row = (uint8_t)((player_y - 6) / 8);

    if (pickable(ROOM_CELL(col, row)))
        pick_up_item(col, row);
    row = (uint8_t)((player_y + 6) / 8);
    if (pickable(ROOM_CELL(col, row)))
        pick_up_item(col, row);
}

/* ---------------------------------------------------------------------------
 *  원래 08E2:3587, 08E2:3630 (36D9 안의 중첩 프로시저)  빰- 빰 빰 빰 빰
 * ------------------------------------------------------------------------- */
static void fanfare(uint16_t first, uint16_t rest)
{
    crt_sound(first); crt_delay(180); crt_nosound(); crt_delay(80);
    crt_sound(rest);  crt_delay(40);  crt_nosound(); crt_delay(100);
    crt_sound(rest);  crt_delay(40);  crt_nosound(); crt_delay(100);
    crt_sound(rest);  crt_delay(40);  crt_nosound(); crt_delay(200);
    crt_sound(rest);  crt_delay(40);  crt_nosound(); crt_delay(200);
}

/* ---------------------------------------------------------------------------
 *  원래 08E2:36D9   출구 문이 열리고 들어간 뒤 화면을 지운다 (스테이지 깸)
 * ------------------------------------------------------------------------- */
void enter_exit(void)
{
    hook_keyboard(0);
    hook_timer(0);
    crt_nosound();
    music_play(SONG_CLEAR);                     /* (KVVGA) */
    fanfare(50, 50);

    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    graph_put_image(player_x - 17, player_y - 8, SPR(97), PUT_COPY);
    fanfare(53, 54);

    graph_put_image(exit_x - 32, exit_y - 24, SPR(89), PUT_COPY);   /* 문 반쯤 열림 */
    graph_put_image(exit_x,      exit_y - 24, SPR(90), PUT_COPY);
    graph_put_image(exit_x - 32, exit_y - 8,  SPR(91), PUT_COPY);
    graph_put_image(exit_x,      exit_y - 8,  SPR(92), PUT_COPY);
    graph_put_image(player_x - 17, player_y - 8, SPR(97), PUT_COPY);
    fanfare(50, 50);

    graph_put_image(exit_x - 32, exit_y - 24, SPR(93), PUT_COPY);   /* 문 다 열림 */
    graph_put_image(exit_x,      exit_y - 24, SPR(94), PUT_COPY);
    graph_put_image(exit_x - 32, exit_y - 8,  SPR(95), PUT_COPY);
    graph_put_image(exit_x,      exit_y - 8,  SPR(96), PUT_COPY);
    graph_put_image(player_x - 17, player_y - 8, SPR(97), PUT_XOR);
    fanfare(53, 54);

    crt_sound(50);
    crt_delay(40);
    crt_delay(500);
    crt_nosound();

    FOR_TO(loop_i, 1, 5) {                      /* 문 안으로 걸어 들어간다 */
        crt_delay(500);
        graph_put_image(player_x - 17, player_y - 8, SPR(loop_i + 0x60), PUT_XOR);
        graph_put_image(player_x - 17, player_y - 8, SPR(loop_i + 0x61), PUT_XOR);
    }
    graph_put_image(player_x - 17, player_y - 8, SPR(102), PUT_XOR);
    crt_delay(1000);

    loop_j = 0;
    FOR_TO(loop_i, 1, 32)
        SPR(SPR_BLANK_CELL)[3 + loop_i] = 0;
    FOR_TO(loop_i, 0, 11)                       /* 위에서 아래로, 아래에서 위로 동시에 */
        FOR_TO(loop_j, 0, 19) {
            graph_put_image(loop_j << 5, loop_i << 3, SPR(SPR_BLANK_CELL), PUT_COPY);
            crt_delay(5);
            graph_put_image((19 - loop_j) << 5, (23 - loop_i) << 3, SPR(SPR_BLANK_CELL), PUT_COPY);
        }
}

/* ---------------------------------------------------------------------------
 *  원래 08E2:39BC   큰 글씨 (19x7 글꼴, OR 로 찍는다)
 *  x = (col + i - 1) * 20,  y = row * 10  (row 가 20 이면 y = 192)
 *  글꼴에 없는 글자는 바로 앞 글자의 그림을 다시 쓴다 (loop_j 가 남아 있어서).
 * ------------------------------------------------------------------------- */
void draw_text(int col, int row, const char *s)
{
    uint8_t len = (uint8_t)strlen(s);

    FOR_TO(loop_i, 1, len) {
        uint8_t c = (uint8_t)s[loop_i - 1];

        if (c >= '0' && c <= '9')
            loop_j = (uint8_t)(c - '0' + 1);
        else if (c >= 'a' && c <= 'z')
            loop_j = (uint8_t)(c - 'a' + 11);
        else if (c >= 'A' && c <= 'Z')
            loop_j = (uint8_t)(c - 'A' + 11);

        if (c != ' ') {
            if (row == 20)
                graph_put_image((loop_i + col - 1) * 20, 0xC0, SPR(loop_j + SPR_FONT), PUT_OR);
            else
                graph_put_image((loop_i + col - 1) * 20, row * 10, SPR(loop_j + SPR_FONT), PUT_OR);
        }
    }
}
