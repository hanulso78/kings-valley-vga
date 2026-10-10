/* ============================================================================
 *  graph.c  -  볼랜드 Graph 유닛 + BGI CGA 드라이버 흉내  (CGA 640x200 흑백)
 * ----------------------------------------------------------------------------
 *  원본은 터보 파스칼 Graph 유닛에 CGA.BGI 를 링크해서 CGAHi 모드(640x200,
 *  2색)로 그렸다.  게임이 쓰는 것은
 *      PutImage, Line, Rectangle, SetColor, SetViewPort, ClearViewPort,
 *      ClearDevice  와  화면 메모리(B800:0000) 직접 쓰기(타이틀 그림),
 *      BIOS int 10h AH=06 스크롤(제작진 화면)
 *  뿐이다.
 *
 *  이 판은 640x200 1bpp 버퍼(한 줄 80바이트)에 원본과 똑같이 그리고,
 *  graph_present 가 VGA 모드 12h(640x480 16색) 가운데에 한 줄을 두 줄로 늘려
 *  (640x400) 옮긴다.  모드 12h 기본 상태(쓰기 모드 0, 맵 마스크 0Fh)에서는
 *  바이트를 그대로 쓰면 1 비트가 흰색(15), 0 비트가 검정이 된다.
 *  바뀐 것이 있을 때만 옮긴다(dirty).
 * ========================================================================== */
#ifdef KV_SHADOW
/* 시험판 KVTESTV.EXE 에서는 이 파일을 shadow_* 이름으로 한 번 더 컴파일해 링크한다.
   graph256.c 가 원판 흑백 화면을 나란히 그려 두고 색 화면 목록과 맞는지 본다 (화면에는 내보내지 않는다). */
#define screen                  shadow_screen
#define graph_init              shadow_init
#define graph_close             shadow_close
#define graph_present           shadow_present
#define graph_touch             shadow_touch
#define graph_to_cga            shadow_to_cga
#define graph_from_cga          shadow_from_cga
#define graph_bios_scroll_up    shadow_bios_scroll_up
#define graph_put_image         shadow_put_image
#define graph_set_color         shadow_set_color
#define graph_line              shadow_line
#define graph_rectangle         shadow_rectangle
#define graph_set_viewport      shadow_set_viewport
#define graph_clear_viewport    shadow_clear_viewport
#define graph_clear_device      shadow_clear_device
#define graph_dump              shadow_dump
#endif
#include <stdio.h>
#include <string.h>
#include <dpmi.h>                /* __dpmi_int */
#include <go32.h>                /* _dos_ds, _my_ds */
#include <sys/movedata.h>        /* movedata */

#include "kv.h"

#define VGA_ADDR    0xA0000
#define VGA_TOP     40              /* 480 줄 가운데에 400 줄 */

unsigned char screen[SCREEN_H * SCREEN_BPL];     /* 원래 B800:0000 (인터레이스를 풀어 놓은 것) */

static int dirty;

/* Graph 유닛 상태 (원래 DS:CDAA.. 뷰포트, DS:CD96 색) */
static int vp_x1, vp_y1, vp_x2, vp_y2, vp_clip;
static int draw_color;

#ifndef KV_SHADOW
static void bios_set_mode(int mode)
{
    __dpmi_regs r;

    memset(&r, 0, sizeof r);
    r.x.ax = mode;
    __dpmi_int(0x10, &r);
}
#endif

static void put_pixel(int x, int y, int c)
{
    unsigned char *p = screen + y * SCREEN_BPL + (x >> 3);
    unsigned char bit = 0x80 >> (x & 7);

    if (c) *p |= bit; else *p &= ~bit;
}

/* ---------------------------------------------------------------------------
 *  InitGraph(CGA, CGAHi)  -  원본 0000:35A7
 *  BGI 가 모드를 바꾸면 화면이 지워지고 뷰포트는 전체 화면, 색은 최대색(1).
 * ------------------------------------------------------------------------- */
void graph_init(void)
{
#ifndef KV_SHADOW
    bios_set_mode(0x12);
#endif
    memset(screen, 0, sizeof screen);
    vp_x1 = 0; vp_y1 = 0; vp_x2 = SCREEN_W - 1; vp_y2 = SCREEN_H - 1; vp_clip = 1;
    draw_color = 1;
    dirty = 1;
}

/* CloseGraph - 텍스트 모드로 돌아간다 */
void graph_close(void)
{
#ifndef KV_SHADOW
    bios_set_mode(0x03);
#endif
}

/* ---------------------------------------------------------------------------
 *  원본에 없던 것.  원본은 화면 메모리에 바로 그렸다.
 *  기다리는 곳(Delay, 키 읽기)에서 부른다.
 * ------------------------------------------------------------------------- */
void graph_present(void)
{
    unsigned char doubled[SCREEN_H * 2 * SCREEN_BPL];
    int y;

    if (!dirty)
        return;
    dirty = 0;
#ifdef KV_SHADOW
    (void)doubled; (void)y;
    return;
#endif
    for (y = 0; y < SCREEN_H; y++) {
        memcpy(doubled + (y * 2) * SCREEN_BPL, screen + y * SCREEN_BPL, SCREEN_BPL);
        memcpy(doubled + (y * 2 + 1) * SCREEN_BPL, screen + y * SCREEN_BPL, SCREEN_BPL);
    }
    movedata(_my_ds(), (unsigned)doubled, _dos_ds, VGA_ADDR + VGA_TOP * SCREEN_BPL, sizeof doubled);
}

void graph_touch(void)
{
    dirty = 1;
}

/* ---------------------------------------------------------------------------
 *  원본이 CGA 화면 메모리(B800:0000)를 Move 로 통째로 읽고 쓴 곳 흉내.
 *  화면 메모리 배치: 0000..1F3F 짝수 줄(100줄 x 80), 2000..3F3F 홀수 줄.
 *  n 바이트만 옮긴다 (원본은 $3F48, $3EE4 처럼 끝을 조금 덜 옮기기도 했다).
 * ------------------------------------------------------------------------- */
static int cga_to_line(int ofs, int *x)
{
    int bank = ofs & 0x2000 ? 1 : 0;
    int rel = ofs & 0x1FFF;

    if (rel >= (SCREEN_H / 2) * SCREEN_BPL)
        return -1;                              /* 뱅크 끝의 빈 곳 */
    *x = rel % SCREEN_BPL;
    return (rel / SCREEN_BPL) * 2 + bank;
}

/* Move(Mem[$B800:0], dst, n) */
void graph_to_cga(unsigned char *dst, int n)
{
    int i, x, y;

    for (i = 0; i < n; i++) {
        y = cga_to_line(i, &x);
        dst[i] = y < 0 ? 0 : screen[y * SCREEN_BPL + x];
    }
}

/* Move(src, Mem[$B800:0], n) */
void graph_from_cga(const unsigned char *src, int n)
{
    int i, x, y;

    for (i = 0; i < n; i++) {
        y = cga_to_line(i, &x);
        if (y >= 0)
            screen[y * SCREEN_BPL + x] = src[i];
    }
    dirty = 1;
}

/* ---------------------------------------------------------------------------
 *  BIOS int 10h AH=06 (창 위로 스크롤) 를 그래픽 모드 6 에서 한 것과 같게.
 *  글자 칸은 8x8, lines=0 이면 창을 지운다.  빈 줄은 attr 의 0비트 색.
 * ------------------------------------------------------------------------- */
void graph_bios_scroll_up(int lines, int top, int left, int bottom, int right, int attr)
{
    int rows, y, x0, w, fill;

    if (right > 79) right = 79;
    if (bottom > 24) bottom = 24;
    if (left > right || top > bottom)
        return;
    rows = bottom - top + 1;
    if (lines == 0 || lines > rows)
        lines = rows;
    x0 = left;
    w = right - left + 1;
    fill = (attr & 1) ? 0xFF : 0x00;

    for (y = top * 8; y < (bottom + 1 - lines) * 8; y++)
        memcpy(screen + y * SCREEN_BPL + x0, screen + (y + lines * 8) * SCREEN_BPL + x0, w);
    for (; y < (bottom + 1) * 8; y++)
        memset(screen + y * SCREEN_BPL + x0, fill, w);
    dirty = 1;
}

/* ---------------------------------------------------------------------------
 *  PutImage(x, y, bitmap, op)   Graph 0C93:0E93 + CGA 드라이버 restorebitmap
 *  bitmap = word 폭-1, word 높이-1, 줄마다 (폭+7)/8 바이트.
 *  Graph 유닛은 화면 아래 끝에서만 높이를 자르고, 오른쪽 끝을 넘거나
 *  왼쪽/위가 음수이면 아예 그리지 않는다.
 *  op: 0 COPY, 1 XOR, 2 OR, 3 AND, 4 NOT(뒤집어서 COPY)
 * ------------------------------------------------------------------------- */
void graph_put_image(int x, int y, const unsigned char *img, int op)
{
    unsigned w1 = img[0] | img[1] << 8;
    unsigned h1 = img[2] | img[3] << 8;
    unsigned lim;
    const unsigned char *src = img + 4;
    int bpr = (w1 + 8) / 8;
    int row, i, nbits;

    x += vp_x1;
    y += vp_y1;
    lim = (unsigned)(SCREEN_H - 1 - y) & 0xFFFF;
    if (lim < h1)
        h1 = lim;
    if ((long)x + (long)w1 > SCREEN_W - 1 || x < 0 || y < 0)
        return;
    if (y + (int)h1 > SCREEN_H - 1)            /* 원본은 화면 밖을 썼다 - 여기서는 자른다 */
        h1 = SCREEN_H - 1 - y;

    /* 드라이버는 COPY/AND/NOT 만 폭 밖의 비트를 막고, XOR/OR 은 마지막 바이트를 통째로 쓴다 */
    nbits = (op == 1 || op == 2) ? bpr * 8 : (int)w1 + 1;

    for (row = 0; row <= (int)h1; row++, src += bpr) {
        unsigned char *dst = screen + (y + row) * SCREEN_BPL;
        for (i = 0; i < nbits; i++) {
            int s = (src[i >> 3] >> (7 - (i & 7))) & 1;
            int px = x + i;
            unsigned char bit = 0x80 >> (px & 7);
            unsigned char *d = dst + (px >> 3);
            int cur = (*d & bit) != 0;
            int v;

            if (px >= SCREEN_W)
                break;
            switch (op) {
            case 1:  v = cur ^ s; break;
            case 2:  v = cur | s; break;
            case 3:  v = cur & s; break;
            case 4:  v = !s;      break;
            default: v = s;       break;
            }
            if (v) *d |= bit; else *d &= ~bit;
        }
    }
    dirty = 1;
}

/* SetColor - CGAHi 에서 드라이버는 0 이 아니면 1 로 쓴다 */
void graph_set_color(int c)
{
    draw_color = (c & 0xFF) != 0;
}

/* ---------------------------------------------------------------------------
 *  Line(x1, y1, x2, y2)  - 뷰포트 기준 좌표, 뷰포트 밖은 잘린다.
 * ------------------------------------------------------------------------- */
void graph_line(int x1, int y1, int x2, int y2)
{
    int dx, dy, sx, sy, err, e2;
    int cx1, cy1, cx2, cy2;

    x1 += vp_x1; x2 += vp_x1;
    y1 += vp_y1; y2 += vp_y1;
    if (vp_clip) { cx1 = vp_x1; cy1 = vp_y1; cx2 = vp_x2; cy2 = vp_y2; }
    else         { cx1 = 0; cy1 = 0; cx2 = SCREEN_W - 1; cy2 = SCREEN_H - 1; }

    dx = x2 > x1 ? x2 - x1 : x1 - x2;
    dy = y2 > y1 ? y2 - y1 : y1 - y2;
    sx = x1 < x2 ? 1 : -1;
    sy = y1 < y2 ? 1 : -1;
    err = dx - dy;
    for (;;) {
        if (x1 >= cx1 && x1 <= cx2 && y1 >= cy1 && y1 <= cy2)
            put_pixel(x1, y1, draw_color);
        if (x1 == x2 && y1 == y2)
            break;
        e2 = 2 * err;
        if (e2 > -dy) { err -= dy; x1 += sx; }
        if (e2 < dx)  { err += dx; y1 += sy; }
    }
    dirty = 1;
}

/* Rectangle = 선 넷 (Graph 0C93:0CC2 와 같은 순서) */
void graph_rectangle(int x1, int y1, int x2, int y2)
{
    graph_line(x1, y1, x2, y1);
    graph_line(x2, y1, x2, y2);
    graph_line(x2, y2, x1, y2);
    graph_line(x1, y2, x1, y1);
}

/* SetViewPort - 잘못된 값이면 무시 (원본은 GraphResult = grError) */
void graph_set_viewport(int x1, int y1, int x2, int y2, int clip)
{
    if (x1 < 0 || y1 < 0 || x2 > SCREEN_W - 1 || y2 > SCREEN_H - 1 || x2 < x1 || y2 < y1)
        return;
    vp_x1 = x1; vp_y1 = y1; vp_x2 = x2; vp_y2 = y2;
    vp_clip = clip & 0xFF;
}

/* ClearViewPort - 뷰포트를 배경색(0)으로 */
void graph_clear_viewport(void)
{
    int y;

    for (y = vp_y1; y <= vp_y2; y++) {
        int x;
        for (x = vp_x1; x <= vp_x2; x++)
            put_pixel(x, y, 0);
    }
    dirty = 1;
}

/* ClearDevice - 드라이버가 BIOS 스크롤로 화면 전체를 지운다 */
void graph_clear_device(void)
{
    memset(screen, 0, sizeof screen);
    dirty = 1;
}

/* 시험판(KV_TEST): 지금 화면을 PBM 으로 */
void graph_dump(const char *name)
{
    char path[80];
    FILE *f;
    int i;

    sprintf(path, "%s.pbm", name);
    f = fopen(path, "wb");
    if (!f)
        return;
    fprintf(f, "P4\n640 200\n");
    for (i = 0; i < SCREEN_H * SCREEN_BPL; i++)
        fputc(~screen[i] & 0xFF, f);
    fclose(f);
}
