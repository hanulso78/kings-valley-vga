/* ============================================================================
 *  kv.h  -  KING'S VALLEY (왕의 계곡, 1989 APROMAN / POSTECH) 공용 선언
 * ----------------------------------------------------------------------------
 *  B.EXE 는 터보 파스칼로 만든 16비트 DOS 게임이다 (PKLITE 로 압축).
 *  디버그 정보가 없어서 원래 이름은 알 수 없다.  이 C 소스의 이름은 모두
 *  하는 일을 보고 새로 붙인 것이고, 선언마다 원본 주소를 적어 두었다.
 *      함수      원본 세그먼트:오프셋  (0000 = 메인 프로그램, 0777 = 편집기 유닛,
 *                                       08E2 = 게임 유닛)
 *      전역 변수  원본 DS 오프셋 (DS = 1161)
 *
 *  게임 개요
 *      피라미드(스테이지) 마다 방이 1..9 개 있고, 방들은 3x3 격자로 이어져 있다.
 *      방 = 가로 20칸(32픽셀) x 세로 24줄(8픽셀), CGA 640x200 흑백.
 *      방 곳곳의 영혼석(soul stone)을 모두 모은 뒤 출구 문에 들어가면 다음 스테이지.
 *      미라(최대 3마리)에게 닿으면 죽는다.  단검을 던져 미라를 잡을 수 있고,
 *      곡괭이로 벽돌을 파고, 돌을 밀고, 회전문을 지나고, 사다리를 오르내린다.
 *      61 스테이지를 넘기면 끝.
 *
 *  방 지도의 칸 값 = 그 칸에 그릴 스프라이트 번호 (100 = 빈칸).
 *      값 + 50*n 은 같은 칸에 단검이 n 개 떨어져 있다는 뜻 (예: 102 = 사다리52 + 단검 1개).
 * ========================================================================== */
#ifndef KV_H
#define KV_H

#include <stdint.h>

/* ---- 화면 (CGA 640x200 흑백) -------------------------------------------------- */
#define SCREEN_W        640
#define SCREEN_H        200
#define SCREEN_BPL      80              /* 한 줄 바이트 수 (1bpp) */
#define CGA_MEM_SIZE    0x4000          /* B800:0000 화면 메모리 (짝수 줄 뱅크 + 홀수 줄 뱅크) */

#define PUT_COPY        0               /* PutImage op */
#define PUT_XOR         1
#define PUT_OR          2

/* ---- 방 지도 -------------------------------------------------------------------- */
#define ROOM_SIZE       0x226           /* 방 하나 = kings-v.dat 레코드 하나 = 22열 x 25줄 */
#define ROOM_ROWS_ALL   25
#define MAX_ROOMS       9               /* 방 레코드 1..9 (레코드 0 은 스테이지 목록) */
#define ROOM_COLS       20              /* 화면에 보이는 칸 */
#define ROOM_ROWS       24
#define CELL_W          32
#define CELL_H          8

/* 16비트로 감싸서 계산하는 원본 그대로의 지도 인덱스 (지도 메모리는 64K 로 잡아 넘쳐도 안전) */
#define MAP_INDEX(room, col, row) \
        ((uint16_t)((uint16_t)(room) * ROOM_SIZE + (uint16_t)(col) * ROOM_ROWS_ALL + (uint16_t)(row)))
#define MAP(room, col, row)     rooms[MAP_INDEX(room, col, row)]
#define ROOM_CELL(col, row)     MAP(cur_room, col, row)

/* 레코드 0 = 스테이지별 방 개수 목록: 스테이지 s 의 방 수 = rooms[(s/20)*25 + s%20] */
#define STAGE_ROOMS(s)  rooms[(uint16_t)(((int16_t)(s) / 20) * ROOM_ROWS_ALL + (int16_t)(s) % 20)]

/* 3x3 방 배치표 room_grid[1..9] (원래 DS:B9C3) 는 방 1 레코드의 21번 열에 들어 있다 */
#define ROOM_GRID_OFS   (0xB9C3 - 0xB590)
#define room_grid       (rooms + ROOM_GRID_OFS)

/* ---- 칸 값 ---------------------------------------------------------------------- */
#define T_PLAYER_START  0x00            /* 지도에서 읽을 때만 */
#define T_PICK_DOWN     0x1E            /* 곡괭이 (아래로 파기)    -> held_item 4 */
#define T_SOUL_STONE    0x21
#define T_PICK_SIDE     0x22            /* 곡괭이 (옆으로 파기)    -> held_item 6 */
#define T_PICK_SHORT    0x23            /* 곡괭이 (아래로 한 칸만) -> held_item 8 */
#define T_DOOR_L        0x2A            /* 왼쪽으로만 도는 회전문 */
#define T_DOOR_R        0x2B            /* 오른쪽으로만 도는 회전문 */
#define T_DOOR2_L       0x2E
#define T_DOOR2_R       0x2F
#define T_STONE         0x32            /* 밀 수 있는 돌 */
#define T_LADDER        0x34
#define T_BRICK         0x35            /* 곡괭이로 팔 수 있는 벽돌 */
#define T_DAGGER        0x38            /* 바닥에 떨어진 단검 */
#define T_MUMMY_HOME    0x49            /* 미라가 나오는 자리 (지도에서는 0x4C) */
#define T_MUMMY_START   0x4C
#define T_EXIT          0x58
#define T_EMPTY         0x64
#define T_USED_LADDER   0x6F            /* 한 번 오른 사다리 (0x34 + 59) - 내려오면 사라진다 */
#define T_BRIDGE        0xAF            /* 무너지는 다리 */
#define T_BRIDGE_USED   0xDE            /* 밟은 다리 - 떠나면 무너진다 */

/* ---- 들고 있는 것 (held_item) ------------------------------------------------------ */
#define HOLD_NOTHING    0
#define HOLD_DAGGER     2
#define HOLD_PICK_DOWN  4
#define HOLD_PICK_SIDE  6
#define HOLD_PICK_SHORT 8

/* ---- 스캔 코드 (keyboard_isr 가 받은 그대로) -------------------------------------------- */
#define SC_ESC          0x01
#define SC_SPACE        0x39
#define SC_SPACE_UP     0xB9            /* Space 뗌 */
#define SC_F1           0x3B
#define SC_F2           0x3C
#define SC_F3           0x3D
#define SC_F4           0x3E
#define SC_F10          0x44
#define SC_UP           0x48
#define SC_LEFT         0x4B
#define SC_RIGHT        0x4D
#define SC_DOWN         0x50

/* ---- 스프라이트 ------------------------------------------------------------------ */
#define SPRITE_COUNT    0xB0            /* 0..0xAF */
#define SPRITE_REC      0x54            /* BGI 이미지 레코드: word 폭-1, word 높이-1, 비트맵 80 */
#define SPR(n)          (sprites + (uint16_t)((uint16_t)(n) * SPRITE_REC))
#define SPRITE_BITS_SIZE 8436

#define SPR_FONT        0x8A            /* 글꼴: SPR_FONT + 1..10 = '0'..'9', +11..36 = 'a'..'z' */
#define SPR_BLANK_CELL  0x33            /* 죽을 때 화면을 지우는 빈 칸 (비트맵을 0 으로 만든다) */
#define SPR_BRIDGE      0xAF            /* 게임 시작 때 0x33 을 복사해 둔 다리 그림 */

/* ---- 효과음 데이터 / 악보 ----------------------------------------------------------- */
struct note { uint16_t freq; uint8_t ticks; };
#define MUSIC_NOTES     0x88
#define MUSIC_TICKS     0x2C7
#define BEAT_NOTES      0x12
#define BEAT_TICKS      0x20
#define EDITOR_TILES    21
#define PCM_DIG_SIZE    90
#define PCM_DIE_SIZE    304
#define PCM_SCREAM_SIZE 391

/* ---- 파스칼 for 문 ------------------------------------------------------------------
 *  for v := a to b  - 끝나면 v 는 b 로 남는다 (C 의 for 처럼 b+1 이 아니다).
 *  원본은 전역 변수를 for 변수로 쓰고 끝난 뒤 값을 다시 쓰기도 하므로 그대로 흉내 낸다.
 *  b 는 들어갈 때 한 번만 계산한다.
 * ---------------------------------------------------------------------------------- */
#define FOR_TO(v, a, b) \
    for (int _end = (b), _run = ((v) = (a)) <= _end; _run; _run = ((v) != _end) ? ((v)++, 1) : 0)
#define FOR_DOWNTO(v, a, b) \
    for (int _end = (b), _run = ((v) = (a)) >= _end; _run; _run = ((v) != _end) ? ((v)--, 1) : 0)

/* ---- 파스칼 집합  c in [a, b, ...] ---------------------------------------------------- */
static inline int tile_in(uint8_t c, const uint8_t *list, int n)
{
    while (n--)
        if (*list++ == c)
            return 1;
    return 0;
}
#define IN(c, ...)  tile_in((uint8_t)(c), (const uint8_t[]){ __VA_ARGS__ }, \
                            sizeof((const uint8_t[]){ __VA_ARGS__ }))

/* ---- 미라 레코드 (원래 DS:AFB8 + n*0x1E, n = 1..3) -------------------------------------- */
struct mummy {
    int16_t  x, y;              /* +00 +02  가운데 좌표 (그림은 x-16, y-8) */
    int16_t  timer;             /* +04  매 틱 +1.  1..0x42 나타남, ..0x2710 살아 있음,
                                        0x2711.. 죽음, 0x27D9 다시 나타남 */
    int16_t  home_x, home_y;    /* +06 +08  나타나는 자리 */
    int16_t  dir;               /* +0A  -1 / 0 / +1 */
    int16_t  unused_0c;         /* +0C  늘 -1 로 쓰기만 한다 */
    uint8_t  room;              /* +0E */
    uint8_t  home_room;         /* +0F */
    uint8_t  sprite;            /* +10  화면에 XOR 로 그려 둔 그림 */
    uint8_t  bump;              /* +11  벽에 부딪힌 횟수, 100..119 = 멈춰서 두리번 */
    uint8_t  turns_right;       /* +12 */
    uint8_t  turns_left;        /* +13 */
    uint8_t  unused_14, unused_15;
    uint8_t  stuck_right;       /* +16 */
    uint8_t  stuck_left;        /* +17 */
    uint8_t  want_down;         /* +18  사다리를 내려가려 함 */
    uint8_t  stuck_down;        /* +19 */
    uint8_t  climbing_up;       /* +1A */
    uint8_t  climbing_down;     /* +1B */
    uint8_t  ladder_end;        /* +1C  사다리 끝 - 멈추고 방향을 새로 고른다 */
    uint8_t  active;            /* +1D */
} __attribute__((packed));

/* ============================ 전역 변수 (main.c) =========================== */
/*                                                              원래 DS 오프셋   */
extern uint8_t   loop_i, loop_j, loop_k;        /* A3B0 A3B1 A3B2  공용 for 변수     */
extern uint8_t   probe_col, probe_row;          /* A3B5 A3B6  검사할 칸              */
extern volatile uint8_t scan_code;              /* A3B7  keyboard_isr 가 받은 마지막 바이트 */
extern uint8_t   mummy_i;                       /* A3B8  미라 for 변수               */
extern uint8_t   lives;                         /* A3B9  남은 목숨 (REST)            */
extern uint8_t   stage;                         /* A3BC  스테이지 번호 1..           */
extern uint8_t   stones_left;                   /* A3BD  남은 영혼석                 */
extern uint8_t   held_item;                     /* A3BE  HOLD_*                      */
extern uint8_t   facing_left;                   /* A3BF  1 = 왼쪽을 봄               */
extern uint8_t   player_sprite;                 /* A3C0  화면에 XOR 로 그려 둔 그림  */
extern uint8_t   scratch;                       /* A3C1  여러 곳에서 임시로 쓰는 바이트 */
extern uint8_t   ladder_col;                    /* A3C2  없앨 사다리 열              */
extern uint8_t   bridge_row;                    /* A3C3  밟은 다리 줄                */
extern uint8_t   standing;                      /* A3C4  1 = 걷던 중이 아님          */
extern uint8_t   cur_room;                      /* A3C5  화면에 보이는 방            */
extern uint8_t   dagger_room;                   /* A3C6  날아가는 단검이 있는 방     */
extern uint8_t   stone_room;                    /* A3C8  떨어지는 돌이 있는 방       */
extern uint8_t   start_room;                    /* A3C9  플레이어가 시작하는 방      */
extern uint8_t   push_left, push_right;         /* A3CA A3CB  돌/문을 민 프레임 수   */
extern uint16_t  tune[MUSIC_TICKS];             /* A3CC  타이머가 틱마다 연주할 주파수 */
extern struct mummy mummies[4];                 /* AFB8  [1..3]                      */
extern int32_t   score, hi_score;               /* B034 B038                         */
extern int16_t   player_x, player_y;            /* B058 B05A  가운데 좌표            */
extern int16_t   dagger_x, dagger_y;            /* B05C B05E  단검 왼쪽 위           */
extern int16_t   dagger_dx, dagger_dy;          /* B060 B062                         */
extern int16_t   dagger_spin;                   /* B064                              */
extern volatile uint16_t tune_len;              /* B066                              */
extern int16_t   walk_count;                    /* B068  걷기 그림 카운터 1..1000    */
extern int16_t   dagger_stopped;                /* B06A  가로로 멈춘 프레임 수       */
extern int16_t   dagger_hit_step;               /* B06C  미라를 맞힌 뒤 단계         */
extern int16_t   frame_count;                   /* B06E                              */
extern int16_t   probe_x, probe_y;              /* B070 B072  미라가 검사할 칸       */
extern int16_t   exit_x, exit_y;                /* B074 B076  출구                   */
extern uint16_t  exit_room;                     /* B078                              */
extern volatile uint16_t tune_pos;              /* B07E  (시작 때는 스프라이트 데이터 읽는 자리) */
extern int16_t   work;                          /* B080  임시 (미라 수, 점프 방향, 파는 깊이, 소리 높이) */
extern int16_t   cell_x, cell_y;                /* B082 B084  임시 좌표              */
extern int16_t   old_x;                         /* B086  지우기용 이전 x (임시로도 씀) */
extern int16_t   tmp_y;                         /* B088                              */
extern int16_t   stone_col, stone_row;          /* B08A B08C  떨어지는 돌            */
extern uint8_t   last_key;                      /* B08E  버린 키                     */
extern char      text_buf[256];                 /* B090  파스칼 문자열               */
extern uint8_t   rooms[0x10000];                /* B590  [0] 스테이지 목록, [1..9] 방 */
extern uint8_t   dagger_flying;                 /* CB0C */
extern uint8_t   dagger_hit;                    /* CB0D  미라를 맞힘                 */
extern uint8_t   player_caught;                 /* CB0E  미라에게 잡힘               */
extern uint8_t   stone_falling;                 /* CB0F */
extern uint8_t   show_stage_intro;              /* CB10 */
extern uint8_t   bridge_left, bridge_right;     /* CB13 CB14  다리를 밟고 떠난 방향 표시 */
extern uint8_t   ladder_marked;                 /* CB15  이번 오르내리기에서 사다리를 표시함 */
extern uint8_t   ladder_leave;                  /* CB16  사다리를 없애야 함          */
extern uint8_t   bridge_latch;                  /* CB17 */
extern uint8_t   on_bridge;                     /* CB18 */
extern uint8_t   ladder_marked_up, ladder_marked_down;  /* 2964 2965 (typed const 0) */
extern uint8_t   machine_speed;                 /* 2966  PC/XT 2, AT 10              */
extern uint8_t   sprites[SPRITE_COUNT * SPRITE_REC];    /* 69EC */

/* ============================ data.c ======================================== */
extern const struct note   music_score[MUSIC_NOTES];
extern const struct note   beat_score[BEAT_NOTES];
extern const unsigned char editor_tiles[EDITOR_TILES + 1];
extern const unsigned char sprite_bits[SPRITE_BITS_SIZE];
extern const unsigned char pcm_dig[PCM_DIG_SIZE];
extern const unsigned char pcm_die[PCM_DIE_SIZE];
extern const unsigned char pcm_scream[PCM_SCREAM_SIZE];

/* ============================ main.c  (메인 프로그램 본체) ===================== */
void load_sprites(int first, int last, int w1, int h1, int nbytes);
void select_wall_set(void);
void fill_music_tune(void);
void flush_key(void);

/* ============================ title.c ======================================= */
void title_and_menu(void);                      /* 0000:34AB */

/* ============================ player.c ====================================== */
void remove_used_ladder(void);                  /* 0000:0020 */
void collapse_bridge(void);                     /* 0000:024D */
void climb_up(void);                            /* 0000:0480 */
void climb_down(void);                          /* 0000:085C */
void walk_left(void);                           /* 0000:0CB9 */
void walk_right(void);                          /* 0000:1A2C */
void jump(void);                                /* 0000:278F */
void player_die(void);                          /* 0000:2F7A */

/* ============================ gamelib.c (게임 유닛 08E2) ====================== */
void draw_status_number(int which);             /* 08E2:0118 */
void move_to_next_room(uint8_t *room, int16_t *x, int16_t *y);  /* 08E2:029B */
void move_dagger(void);                         /* 08E2:06C3 */
void check_room_change(void);                   /* 08E2:28F1 */
void check_pickup(void);                        /* 08E2:34E0 */
void enter_exit(void);                          /* 08E2:36D9 */
void draw_text(int col, int row, const char *s);/* 08E2:39BC */

/* ============================ mummy.c ======================================= */
void move_mummies(void);                        /* 08E2:0E48 */

/* ============================ editor.c (편집기 유닛 0777) ====================== */
void stage_editor(void);                        /* 0777:01A7 */

/* ============================ graph.c (Graph 유닛 + CGA.BGI 흉내) ============== */
extern unsigned char screen[SCREEN_H * SCREEN_BPL];
void graph_init(void);
void graph_close(void);
void graph_present(void);
void graph_touch(void);
void graph_to_cga(unsigned char *dst, int n);
void graph_from_cga(const unsigned char *src, int n);
void graph_bios_scroll_up(int lines, int top, int left, int bottom, int right, int attr);
void graph_put_image(int x, int y, const unsigned char *img, int op);
void graph_set_color(int c);
void graph_line(int x1, int y1, int x2, int y2);
void graph_rectangle(int x1, int y1, int x2, int y2);
void graph_set_viewport(int x1, int y1, int x2, int y2, int clip);
void graph_clear_viewport(void);
void graph_clear_device(void);
void graph_dump(const char *name);
void graph_flash(int inverted);                 /* KVVGA 만 */
void graph_forget_moving(void);                 /* KVVGA 만 */

/* ============================ 배경음악 ======================================= */
/* KV.EXE 는 원판처럼 타이머 인터럽트에서 PC 스피커로 연주하므로 아무것도 안 한다.
   KVVGA.EXE 는 musvgm.c 가 애드립으로 연주한다. */
enum { SONG_NONE, SONG_TITLE, SONG_GAME, SONG_CLEAR, SONG_DIE, SONG_OVER };
void music_play(int song);
void music_poll(void);

/* ============================ system.c (Crt/Dos/System 유닛 흉내) ============== */
void system_init(void);
void system_shutdown(void);
void crt_delay(unsigned ms);
void crt_sound(uint16_t hz);
void crt_nosound(void);
int  crt_keypressed(void);
uint8_t crt_readkey(void);
void idle(void);
void hook_keyboard(int on);
void hook_timer(int on);
int  timer_is_hooked(void);
void pcm_play(const unsigned char *bits, int nbytes, int paced);
uint16_t pascal_random(uint16_t n);
uint8_t machine_id(void);
void runtime_error(int code) __attribute__((noreturn));

#endif
