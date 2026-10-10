/* ============================================================================
 *  system.c  -  터보 파스칼 Crt / Dos / System 유닛 흉내 + 인터럽트 처리기
 * ----------------------------------------------------------------------------
 *  원본이 쓴 것
 *      Crt     Delay, Sound, NoSound, KeyPressed, ReadKey
 *      Dos     GetIntVec / SetIntVec 로 INT 9(키보드), INT 8(타이머) 가로채기
 *      System  Random (Randomize 는 부르지 않아서 늘 같은 순서)
 *  게임 유닛(08E2)의 인터럽트 처리기
 *      keyboard_isr (08E2:0016)  포트 60h 바이트를 scan_code 에 넣고 BIOS 로 넘긴다
 *      timer_isr    (08E2:0045)  틱마다 tune[] 의 다음 음을 f-10, f, f+10, f 로 울린다
 *
 *  djgpp 에서는 보호 모드 인터럽트 처리기를 처음에 한 번만 걸어 두고,
 *  원본이 벡터를 걸고 푸는 곳에서는 "지금 벡터가 누구를 가리키나"만 바꾼다.
 *  원본은 걸 때 GetIntVec 으로 현재 벡터를 저장(DS:B03C, B040)하고 SetIntVec 으로
 *  자기 처리기를 걸고, 풀 때 저장값을 되돌린다.  이미 걸린 상태에서 다시 걸면
 *  저장값이 자기 처리기가 되어 그 뒤로는 풀어도 풀리지 않는다 - 그것까지 흉내 낸다.
 *  (곡괭이로 옆을 파는 동안 단검이 미라를 맞히면 이렇게 되어, 그 뒤로는
 *   일시정지/지도/출구 장면에서도 음악이 멈추지 않는다)
 * ========================================================================== */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <bios.h>                /* bioskey */
#include <crt0.h>                /* _crt0_startup_flags */
#include <dpmi.h>
#include <go32.h>
#include <pc.h>                  /* inportb, outportb */
#include <time.h>                /* uclock */
#include <sys/exceptn.h>         /* __djgpp_set_ctrl_c */
#include <sys/farptr.h>

#include "kv.h"

/* 인터럽트 처리기가 건드리는 메모리를 스왑되지 않게 전부 잠근다 */
int _crt0_startup_flags = _CRT0_FLAG_LOCK_MEMORY;

#define PCM_RATE    8000        /* 1비트 PCM 재생 속도 (원본은 CPU 속도에 따라 달랐다) */

static _go32_dpmi_seginfo old_int8, new_int8, old_int9, new_int9;
static volatile int keyboard_hooked, timer_hooked;      /* 지금 벡터가 게임 처리기인가 */
static int saved_int9_is_game, saved_int8_is_game;      /* 원래 DS:B040, DS:B03C 에 저장한 벡터 */
static int installed;
static int pending_scan = -1;   /* ReadKey 가 확장키의 스캔 코드를 남겨 둔 것 (원래 Crt 의 DS:CE0F) */

/* ---------------------------------------------------------------------------
 *  Crt.Sound (0FDD:02C6)
 *  18Hz 이하는 무시한다 (이전 소리가 계속 난다).  스피커가 꺼져 있을 때만
 *  타이머 2 모드를 다시 설정하고, 켜져 있으면 분주비만 바꾼다.
 * ------------------------------------------------------------------------- */
void crt_sound(uint16_t hz)
{
    unsigned div;
    unsigned char v;

    if (hz <= 18)
        return;
    div = (unsigned)(0x1234DDUL / hz);
    v = inportb(0x61);
    if ((v & 3) == 0) {
        outportb(0x61, v | 3);
        outportb(0x43, 0xB6);
    }
    outportb(0x42, (unsigned char)div);
    outportb(0x42, (unsigned char)(div >> 8));
}

/* Crt.NoSound (0FDD:02F3) */
void crt_nosound(void)
{
    outportb(0x61, inportb(0x61) & 0xFC);
}

/* ---------------------------------------------------------------------------
 *  keyboard_isr  (08E2:0016)
 * ------------------------------------------------------------------------- */
#ifdef KVVGA
/* (KVVGA) 방향키를 겹쳐 누른 채 앞 키를 떼면 원판은 scan_code 에 뗌 코드가 남아,
   새 키의 반복 입력이 시작될 때까지(약 0.5초) 제자리에 서 있었다.
   아직 누르고 있는 방향키가 있으면 뗌 대신 그 키를 넣는다.  확장키 머리 E0 은 버린다. */
static volatile uint8_t arrows_held[4];         /* 누른 순서대로 */
static volatile int arrows_n;

static int translate_key(int b)
{
    int make = b & 0x7F, i, j;

    if (b == 0xE0)
        return -1;
    if (make != SC_UP && make != SC_DOWN && make != SC_LEFT && make != SC_RIGHT)
        return b;
    for (i = j = 0; i < arrows_n; i++)
        if (arrows_held[i] != make)
            arrows_held[j++] = arrows_held[i];
    arrows_n = j;
    if (!(b & 0x80))
        arrows_held[arrows_n++] = (uint8_t)make;
    else if (arrows_n)
        return arrows_held[arrows_n - 1];
    return b;
}
#else
#define translate_key(b) (b)
#endif

static void keyboard_handler(void)
{
    int b = translate_key(inportb(0x60));

    if (keyboard_hooked && b >= 0)
        scan_code = (uint8_t)b;
}

/* ---------------------------------------------------------------------------
 *  timer_isr  (08E2:0045)
 *  tune_pos 가 tune_len 에 닿으면 처음으로.  한 틱에 Sound 를 네 번 불러
 *  음이 살짝 떨리게 한다.
 * ------------------------------------------------------------------------- */
static void timer_handler(void)
{
    uint16_t f;

    if (!timer_hooked)
        return;
    tune_pos++;
    if (tune_pos == tune_len)
        tune_pos = 0;
#ifdef KVVGA
    /* 음악은 애드립이 맡는다.  원판은 틱마다 음악이 효과음을 덮어썼으므로
       여기서는 스피커를 꺼서 효과음이 같은 길이로 끊기게 한다 */
    (void)f;
    crt_nosound();
#else
    f = tune[tune_pos];
    crt_sound((uint16_t)(f - 10));
    crt_sound(f);
    crt_sound((uint16_t)(f + 10));
    crt_sound(f);
#endif
}

int timer_is_hooked(void)
{
    return timer_hooked;
}

#ifndef KVVGA
void music_play(int song) { (void)song; }
void music_poll(void)     { }
#endif

/* ---------------------------------------------------------------------------
 *  on  : GetIntVec(9, B040); SetIntVec(9, keyboard_isr)
 *  off : SetIntVec(9, B040)
 * ------------------------------------------------------------------------- */
void hook_keyboard(int on)
{
    if (on) {
        saved_int9_is_game = keyboard_hooked;
        keyboard_hooked = 1;
    } else {
        keyboard_hooked = saved_int9_is_game;
    }
}

/* on : GetIntVec(8, B03C); SetIntVec(8, timer_isr)     off : SetIntVec(8, B03C) */
void hook_timer(int on)
{
    if (on) {
        saved_int8_is_game = timer_hooked;
        timer_hooked = 1;
    } else {
        timer_hooked = saved_int8_is_game;
    }
}

static void uninstall(void)
{
    if (!installed)
        return;
    installed = 0;
    keyboard_hooked = timer_hooked = 0;
    _go32_dpmi_set_protected_mode_interrupt_vector(8, &old_int8);
    _go32_dpmi_set_protected_mode_interrupt_vector(9, &old_int9);
    crt_nosound();
}

void system_init(void)
{
    __djgpp_set_ctrl_c(0);                      /* Ctrl-C 로 벡터를 남긴 채 끝나지 않게 */
    signal(SIGINT, SIG_IGN);

    _go32_dpmi_get_protected_mode_interrupt_vector(8, &old_int8);
    _go32_dpmi_get_protected_mode_interrupt_vector(9, &old_int9);
    new_int8.pm_offset = (unsigned long)timer_handler;
    new_int8.pm_selector = _go32_my_cs();
    new_int9.pm_offset = (unsigned long)keyboard_handler;
    new_int9.pm_selector = _go32_my_cs();
    _go32_dpmi_chain_protected_mode_interrupt_vector(8, &new_int8);
    _go32_dpmi_chain_protected_mode_interrupt_vector(9, &new_int9);
    installed = 1;
    atexit(uninstall);
}

void system_shutdown(void)
{
    uninstall();
}


#ifdef KV_TEST
/* ---------------------------------------------------------------------------
 *  시험용 (-DKV_TEST 로만 컴파일).  kvtest.txt 의 줄을 시간 순서대로 실행한다.
 *      <ms> down <scan> <ascii>   키 누름: scan_code 를 바꾸고 BIOS 키 버퍼에 넣는다
 *      <ms> up <scan>             키 뗌
 *      <ms> shot <name>           화면을 <name>.pbm (KVVGA 는 .ppm) 으로 저장
 *      <ms> set player <x> <y>     플레이어를 옮긴다
 *      <ms> set exit               영혼석을 다 모은 것으로 하고 출구 앞으로 (스테이지 깨기 시험)
 *      <ms> log                    시각, 프레임 수를 kvtest.log 에 적는다
 *      <ms> quit                  끝
 * ------------------------------------------------------------------------- */
#include <sys/farptr.h>
static FILE *test_file;
static uclock_t test_start;
static char test_line[128];
static long test_next_ms = -1;

static void test_poll(void)
{
    long now;

    if (!test_file) {
        if (test_start)
            return;
        test_start = uclock();
        test_file = fopen("kvtest.txt", "r");
        if (!test_file)
            return;
    }
    now = (long)((uclock() - test_start) * 1000 / UCLOCKS_PER_SEC);
    for (;;) {
        char cmd[16], arg[64];
        int a1, a2, n;

        if (test_next_ms < 0) {
            if (!fgets(test_line, sizeof test_line, test_file)) {
                fclose(test_file);
                test_file = NULL;
                return;
            }
            if (sscanf(test_line, "%ld", &test_next_ms) != 1) {
                test_next_ms = -1;
                continue;
            }
        }
        if (now < test_next_ms)
            return;
        test_next_ms = -1;
        cmd[0] = arg[0] = 0;
        n = sscanf(test_line, "%*s %15s %63s %x", cmd, arg, &a2);
        if (n >= 2 && !strcmp(cmd, "down")) {
            unsigned tail = _farpeekw(_dos_ds, 0x41C);
            unsigned next = tail + 2 >= 0x3E ? 0x1E : tail + 2;

            a1 = (int)strtol(arg, NULL, 16);
            if (n < 3) a2 = 0;
            scan_code = (uint8_t)translate_key(a1);
            if (next != _farpeekw(_dos_ds, 0x41A)) {
                _farpokew(_dos_ds, 0x400 + tail, (unsigned short)(a1 << 8 | (a2 & 0xFF)));
                _farpokew(_dos_ds, 0x41C, next);
            }
        } else if (n >= 2 && !strcmp(cmd, "up")) {
            scan_code = (uint8_t)translate_key((int)(strtol(arg, NULL, 16) | 0x80));
        } else if (n >= 2 && !strcmp(cmd, "shot")) {
            graph_dump(arg);
        } else if (n >= 2 && !strcmp(cmd, "set") && !strcmp(arg, "player")) {
            int px, py;                         /* 플레이어를 옮긴다 (그림도 옮겨 그린다) */

            if (sscanf(test_line, "%*s %*s %*s %d %d", &px, &py) == 2) {
                graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
                player_x = (int16_t)px;
                player_y = (int16_t)py;
                graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
            }
        } else if (n >= 2 && !strcmp(cmd, "set") && !strcmp(arg, "exit")) {
            /* 영혼석을 다 모은 것으로 하고 출구 앞으로 옮긴다 (출구가 지금 방에 있을 때) */
            stones_left = 0;
            if (exit_room == cur_room) {
                graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
                player_x = exit_x;
                player_y = exit_y;
                graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
            }
        } else if (!strcmp(cmd, "log")) {
            FILE *lg = fopen("kvtest.log", "a");    /* 시각과 프레임 수 */
            if (lg) {
                fprintf(lg, "%ld ms  frame %d  walk %d  x %d\n", now, frame_count, walk_count, player_x);
                fclose(lg);
            }
        } else if (!strcmp(cmd, "quit")) {
            system_shutdown();
            graph_close();
            exit(0);
        }
    }
}
#else
#define test_poll()
#endif

/* ---------------------------------------------------------------------------
 *  원본에 없던 것.  기다리는 동안 화면을 내보내고 DPMI 에 시간을 돌려준다.
 * ------------------------------------------------------------------------- */
void idle(void)
{
    test_poll();
    music_poll();
    graph_present();
    __dpmi_yield();
}

/* ---------------------------------------------------------------------------
 *  Crt.Delay (0FDD:029E)  -  원본은 시작할 때 잰 빈 루프로 기다렸다.
 * ------------------------------------------------------------------------- */
void crt_delay(unsigned ms)
{
    uclock_t end;

    if (ms == 0)
        return;
    graph_present();
    end = uclock() + (uclock_t)ms * UCLOCKS_PER_SEC / 1000;
    while (uclock() < end) {
        test_poll();
        music_poll();
    }
}

/* Crt.KeyPressed (0FDD:02FA) */
int crt_keypressed(void)
{
    test_poll();
    if (pending_scan >= 0)
        return 1;
    return bioskey(1) != 0;
}

/* ---------------------------------------------------------------------------
 *  Crt.ReadKey (0FDD:030C)
 *  확장키면 먼저 0 을 돌려주고 다음 번에 스캔 코드를 돌려준다.
 * ------------------------------------------------------------------------- */
uint8_t crt_readkey(void)
{
    int key;
    uint8_t al;

    if (pending_scan >= 0) {
        al = (uint8_t)pending_scan;
        pending_scan = -1;
        return al;
    }
    graph_present();
    while (!bioskey(1))
        idle();
    key = bioskey(0);
    al = (uint8_t)key;
    if (al == 0) {
        if ((key >> 8) != 0)
            pending_scan = (key >> 8) & 0xFF;
        else
            al = 3;                             /* Ctrl-Break */
    }
    return al;
}

/* ---------------------------------------------------------------------------
 *  1비트 PCM 을 PC 스피커로 (원본 2F7A, 56D3, 06C3 에 펼쳐져 있던 루프)
 *      for i := 1 to n do for b := 0 to 7 do
 *          Port[$61] := Port[$61] and $FC or ((data[i] shr (7-b)) shl 1 and 2);
 *  원본은 PC/XT 에서 2번, AT 에서 10번 도는 빈 루프(machine_speed)로 속도를
 *  맞췄다(06C3 은 빈 루프도 없다).  여기서는 시계로 PCM_RATE 에 맞춘다.
 * ------------------------------------------------------------------------- */
void pcm_play(const unsigned char *bits, int nbytes, int paced)
{
    uclock_t t = uclock();
    uclock_t step = UCLOCKS_PER_SEC / PCM_RATE;
    int i, b;

    (void)paced;
    graph_present();
    for (i = 0; i < nbytes; i++)
        for (b = 0; b <= 7; b++) {
            unsigned char bit = (unsigned char)(((bits[i] >> (7 - b)) << 1) & 2);
            outportb(0x61, (inportb(0x61) & 0xFC) | bit);
            t += step;
            while (uclock() < t)
                ;
        }
}

/* ---------------------------------------------------------------------------
 *  System.Random (103F:0980)
 *      RandSeed := RandSeed * $08088405 + 1;  Random(n) = (RandSeed shr 16) mod n
 *  원본은 Randomize 를 부르지 않으므로 RandSeed 는 늘 0 에서 시작한다.
 * ------------------------------------------------------------------------- */
static uint32_t rand_seed = 0;

uint16_t pascal_random(uint16_t n)
{
    rand_seed = rand_seed * 0x08088405UL + 1;
    if (n == 0)
        return 0;
    return (uint16_t)((rand_seed >> 16) % n);
}

/* ROM BIOS 기계 ID (FFFF:000E) */
uint8_t machine_id(void)
{
    return _farpeekb(_dos_ds, 0xFFFFE);
}

/* 터보 파스칼 런타임 오류 (IOCheck 실패 등) */
void runtime_error(int code)
{
    system_shutdown();
    graph_close();
    printf("Runtime error %03d.\n", code);
    exit(code);
}
