/* ============================================================================
 *  graph256.c  -  256색 화면  ->  KVVGA.EXE   (graph.c 대신 링크한다)
 * ----------------------------------------------------------------------------
 *  원판은 흑백 화면에 그림을 XOR 로 그렸다가 같은 자리에 한 번 더 XOR 해서
 *  지웠다.  색칠한 그림은 XOR 할 수 없으므로, 여기서는 화면에 "무엇을 어디에
 *  그렸는지" 목록(scene)을 들고 있다가 그 목록으로 화면을 다시 만든다.
 *      COPY      그 사각형을 덮는 그림 (가려진 그림은 목록에서 뺀다)
 *      XOR       같은 그림이 같은 자리에 있으면 지우기, 없으면 위에 겹쳐 그리기
 *      OR        위에 겹쳐 그리기 (글자)
 *      Line      색칠한 사각형 (한 줄씩 그리면 이어 붙인다)
 *      ClearViewPort / 빈 그림 COPY   배경으로 덮기
 *  게임 규칙은 화면을 읽지 않으므로 이렇게 바꿔도 동작은 같다.
 *
 *  색 그림은 KV256.SPR (tools/mkspr256.py).  그림은 흑백 비트맵 내용으로 찾는다
 *  - 원판은 실행 중에 스프라이트 비트맵을 바꿔 쓰기(벽 무늬, AND, 지우기) 때문.
 *  화면은 640x200 을 세로로 두 배 한 640x400 (그림도 세로 두 배로 그려 두었다).
 *      VESA 0x100  640x400 256색  /  VESA 0x101  640x480 가운데  /  모드 13h 320x200
 *  바뀐 곳(16x16 칸 단위)만 다시 합성해서 내보낸다.
 * ========================================================================== */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dpmi.h>
#include <go32.h>
#include <pc.h>
#include <sys/movedata.h>

#include "kv.h"

#define OUT_W       640
#define OUT_H       400
#define CELL        16                  /* 바뀐 곳 표시 칸 (화면 16x16) */
#define CELLS_X     (OUT_W / CELL)
#define CELLS_Y     (OUT_H / CELL)
#define LINE_COLOR  16                  /* mkspr256.py 가 16번에 금색을 넣어 둔다 - 선/사각형 색 */

unsigned char screen[SCREEN_H * SCREEN_BPL];    /* graph.c 와 이름을 맞춘 것 (쓰지 않음) */

/* ---- 색칠한 스프라이트 ------------------------------------------------------ */
typedef struct cspr {
    int            w, h;                /* 흑백 크기 (색 그림은 w x 2h) */
    unsigned char *mono, *color;
    unsigned long  hash;
    struct cspr   *next;
} cspr;

#define HASH_SIZE   1024
static cspr         *bucket[HASH_SIZE];
static unsigned char palette[768];
static unsigned char backdrop[OUT_W * OUT_H];
static unsigned char title_mono[CGA_MEM_SIZE];
static unsigned char title_color[OUT_W * OUT_H];

/* ---- 화면 목록 -------------------------------------------------------------- */
enum { IT_IMAGE, IT_RECT, IT_TITLE };

typedef struct {
    unsigned char type, opaque, color;
    unsigned char moving;               /* XOR 로 그린 것 - 가려져도 목록에 남긴다 */
    short         sprno;                /* 스프라이트 번호 (-1 = 표 밖의 그림) - 시험판 기록용 */
    short         x, y, w, h;           /* 원판 좌표 (640x200) */
    const cspr   *spr;
} item;

typedef struct {
    item *v;
    int   n, cap;
} item_list;

static item_list scene;
static struct { const unsigned char *key; item_list list; } snaps[4];

static unsigned char dirty[CELLS_Y][CELLS_X];
static int any_dirty;

/* ---- Graph 유닛 상태 ---------------------------------------------------------- */
static int vp_x1, vp_y1, vp_x2, vp_y2, vp_clip;
static int draw_color;

/* ============================================================================
 *  VESA 출력 (korea/vid256.c 와 같은 방식)
 * ========================================================================== */
typedef struct {
    unsigned short attributes;
    unsigned char  win_a_attr, win_b_attr;
    unsigned short granularity, win_size, seg_a, seg_b;
    unsigned long  func_ptr;
    unsigned short bytes_per_line, width, height;
    unsigned char  char_w, char_h, planes, bpp, banks, memory_model;
    unsigned char  bank_size, pages, reserved0;
    unsigned char  red_mask, red_pos, green_mask, green_pos;
    unsigned char  blue_mask, blue_pos, rsvd_mask, rsvd_pos, direct_color;
    unsigned long  phys_base;
    unsigned char  reserved[212];
} __attribute__((packed)) vbe_mode_info;

static int            video_mode;
static int            top_margin;
static int            line_bytes;
static int            lfb_sel;
static __dpmi_meminfo lfb_map;
static int            bank_window;
static unsigned long  bank_addr, bank_size, bank_step;
static long           bank_now = -1;
static int            flashed;

static void bios_set_mode(int mode)
{
    __dpmi_regs r;

    memset(&r, 0, sizeof r);
    r.x.ax = mode;
    __dpmi_int(0x10, &r);
}

static int vbe_get_mode_info(int mode, vbe_mode_info *mi)
{
    __dpmi_regs r;

    memset(&r, 0, sizeof r);
    r.x.ax = 0x4F01;
    r.x.cx = mode;
    r.x.es = (__tb >> 4) & 0xFFFF;
    r.x.di = __tb & 0x0F;
    __dpmi_int(0x10, &r);
    if (r.x.ax != 0x004F)
        return 0;
    dosmemget(__tb, sizeof *mi, mi);
    return (mi->attributes & 0x01) && mi->bpp == 8 && mi->width >= OUT_W && mi->height >= OUT_H;
}

static void lfb_release(void)
{
    if (lfb_sel) {
        __dpmi_free_ldt_descriptor(lfb_sel);
        __dpmi_free_physical_address_mapping(&lfb_map);
        lfb_sel = 0;
    }
}

static int lfb_setup(const vbe_mode_info *mi)
{
    int sel;

    if (!(mi->attributes & 0x80) || mi->phys_base == 0)
        return 0;
    lfb_map.address = mi->phys_base;
    lfb_map.size    = (unsigned long)mi->bytes_per_line * mi->height;
    if (__dpmi_physical_address_mapping(&lfb_map) != 0)
        return 0;
    sel = __dpmi_allocate_ldt_descriptors(1);
    if (sel <= 0) {
        __dpmi_free_physical_address_mapping(&lfb_map);
        return 0;
    }
    __dpmi_set_segment_base_address(sel, lfb_map.address);
    __dpmi_set_segment_limit(sel, (lfb_map.size - 1) | 0xFFF);
    lfb_sel = sel;
    return 1;
}

static int try_vesa(int mode)
{
    vbe_mode_info mi;
    __dpmi_regs r;

    if (!vbe_get_mode_info(mode, &mi))
        return 0;
    if (!lfb_setup(&mi)) {
        if ((mi.win_a_attr & 0x05) == 0x05) {
            bank_window = 0;
            bank_addr = (unsigned long)mi.seg_a << 4;
        } else if ((mi.win_b_attr & 0x05) == 0x05) {
            bank_window = 1;
            bank_addr = (unsigned long)mi.seg_b << 4;
        } else
            return 0;
        bank_size = (unsigned long)mi.win_size * 1024;
        bank_step = (unsigned long)mi.granularity * 1024;
        if (bank_size == 0 || bank_step == 0)
            return 0;
    }
    memset(&r, 0, sizeof r);
    r.x.ax = 0x4F02;
    r.x.bx = mode | (lfb_sel ? 0x4000 : 0);
    __dpmi_int(0x10, &r);
    if (r.x.ax != 0x004F) {
        lfb_release();
        return 0;
    }
    video_mode = mode;
    line_bytes = mi.bytes_per_line;
    top_margin = (mi.height - OUT_H) / 2;
    bank_now = -1;
    return 1;
}

static void vram_write(unsigned long offset, const unsigned char *src, unsigned long len)
{
    __dpmi_regs r;
    unsigned long bank, off, n;

    if (lfb_sel) {
        movedata(_my_ds(), (unsigned)src, lfb_sel, offset, len);
        return;
    }
    while (len > 0) {
        bank = offset / bank_step;
        off = offset - bank * bank_step;
        n = bank_size - off;
        if (n > len)
            n = len;
        if ((long)bank != bank_now) {
            memset(&r, 0, sizeof r);
            r.x.ax = 0x4F05;
            r.x.bx = bank_window;
            r.x.dx = bank;
            __dpmi_int(0x10, &r);
            bank_now = bank;
        }
        movedata(_my_ds(), (unsigned)src, _dos_ds, bank_addr + off, n);
        src += n;
        offset += n;
        len -= n;
    }
}

static void set_palette(int inverted)
{
    int i;

    outportb(0x3C8, 0);
    for (i = 0; i < 768; i++)
        outportb(0x3C9, inverted ? 63 - palette[i] : palette[i]);
}

/* ============================================================================
 *  KV256.SPR
 * ========================================================================== */
static unsigned long hash_bytes(int w, int h, const unsigned char *p, int n)
{
    unsigned long x = 2166136261UL ^ (unsigned long)(w * 131 + h);
    int i;

    for (i = 0; i < n; i++)
        x = (x ^ p[i]) * 16777619UL;
    return x;
}

static void add_sprite(cspr *s)
{
    int n = (s->w + 7) / 8 * s->h;

    s->hash = hash_bytes(s->w, s->h, s->mono, n);
    s->next = bucket[s->hash % HASH_SIZE];
    bucket[s->hash % HASH_SIZE] = s;
}

static void load_spr(void)
{
    FILE *f = fopen("kv256.spr", "rb");
    char magic[8];
    unsigned char hdr[2];
    int count, i;

    if (!f || fread(magic, 1, 8, f) != 8 || memcmp(magic, "KV256S1", 8) != 0) {
        printf("Not found \"KV256.SPR\" sprite data file.\n");
        exit(1);
    }
    fread(palette, 1, sizeof palette, f);
    fread(hdr, 1, 2, f);
    count = hdr[0] | hdr[1] << 8;
    for (i = 0; i < count; i++) {
        cspr *s = calloc(1, sizeof *s);
        unsigned char wh[2];
        int n;

        fread(wh, 1, 2, f);
        s->w = wh[0];
        s->h = wh[1];
        n = (s->w + 7) / 8 * s->h;
        s->mono = malloc(n);
        s->color = malloc(s->w * s->h * 2);
        fread(s->mono, 1, n, f);
        fread(s->color, 1, s->w * s->h * 2, f);
        add_sprite(s);
    }
    fread(backdrop, 1, sizeof backdrop, f);
    fread(title_mono, 1, sizeof title_mono, f);
    fread(title_color, 1, sizeof title_color, f);
    fclose(f);
}

/* 흑백 비트맵으로 색 그림 찾기.  없으면 흑백 그대로 밝은 회색으로 만들어 둔다 */
static const cspr *find_sprite(int w, int h, const unsigned char *mono)
{
    int n = (w + 7) / 8 * h;
    unsigned long hv = hash_bytes(w, h, mono, n);
    cspr *s;
    int x, y;

    for (s = bucket[hv % HASH_SIZE]; s; s = s->next)
        if (s->hash == hv && s->w == w && s->h == h && memcmp(s->mono, mono, n) == 0)
            return s;

    s = calloc(1, sizeof *s);
    s->w = w;
    s->h = h;
    s->mono = malloc(n);
    s->color = calloc(w * h * 2, 1);
    memcpy(s->mono, mono, n);
    for (y = 0; y < h; y++)
        for (x = 0; x < w; x++)
            if ((mono[y * ((w + 7) / 8) + (x >> 3)] >> (7 - (x & 7))) & 1)
                s->color[y * 2 * w + x] = s->color[(y * 2 + 1) * w + x] = 13;
    add_sprite(s);
    return s;
}

/* ============================================================================
 *  화면 목록
 * ========================================================================== */
static void mark(int x, int y, int w, int h)         /* 원판 좌표 */
{
    int cx0, cy0, cx1, cy1, cx, cy;

    if (w <= 0 || h <= 0)
        return;
    cx0 = x < 0 ? 0 : x / CELL;
    cy0 = y < 0 ? 0 : (y * 2) / CELL;
    cx1 = (x + w - 1) / CELL;
    cy1 = ((y + h) * 2 - 1) / CELL;
    if (cx1 >= CELLS_X) cx1 = CELLS_X - 1;
    if (cy1 >= CELLS_Y) cy1 = CELLS_Y - 1;
    for (cy = cy0; cy <= cy1; cy++)
        for (cx = cx0; cx <= cx1; cx++)
            dirty[cy][cx] = 1;
    any_dirty = 1;
}

static void mark_all(void)
{
    memset(dirty, 1, sizeof dirty);
    any_dirty = 1;
}

static void reserve(item_list *l, int n)
{
    if (l->cap < n) {
        l->cap = n > 1024 ? n * 2 : 1024;
        l->v = realloc(l->v, l->cap * sizeof(item));
    }
}

static item *push(void)
{
    reserve(&scene, scene.n + 1);
    return &scene.v[scene.n++];
}

static void remove_at(int i)
{
    item *it = &scene.v[i];

    mark(it->x, it->y, it->w, it->h);
    memmove(it, it + 1, (scene.n - i - 1) * sizeof(item));
    scene.n--;
}

/* ---------------------------------------------------------------------------
 *  사각형에 완전히 가려지는 그림은 뺀다.
 *  단, XOR 로 그린 움직이는 그림(플레이어, 미라, 단검)은 남긴다.  원판에서는
 *  가려진 뒤에도 게임이 같은 자리에 XOR 해서 "지우므로", 목록에서 빼 버리면
 *  그 지우기가 새로 그리기가 되어 잔상이 남는다.  남겨 두면 가려진 채로 있다가
 *  그 XOR 에서 조용히 빠진다.
 * ------------------------------------------------------------------------- */
static void remove_covered(int x, int y, int w, int h, int upto)
{
    int i;

    for (i = upto - 1; i >= 0; i--) {
        item *it = &scene.v[i];
        if (!it->moving &&
            it->x >= x && it->y >= y && it->x + it->w <= x + w && it->y + it->h <= y + h)
            remove_at(i);
    }
}

static void add_rect(int x, int y, int w, int h, int color, int opaque)
{
    item *it;

    if (scene.n > 0) {                       /* 바로 앞 사각형에 이어 붙인다 */
        it = &scene.v[scene.n - 1];
        if (it->type == IT_RECT && it->color == color) {
            if (it->x == x && it->w == w && it->y + it->h == y) {
                it->h += h;
                mark(x, y, w, h);
                if (opaque)
                    remove_covered(it->x, it->y, it->w, it->h, scene.n - 1);
                return;
            }
            if (it->y == y && it->h == h && it->x + it->w == x) {
                it->w += w;
                mark(x, y, w, h);
                if (opaque)
                    remove_covered(it->x, it->y, it->w, it->h, scene.n - 1);
                return;
            }
        }
    }
    if (opaque)
        remove_covered(x, y, w, h, scene.n);
    it = push();
    it->type = IT_RECT;
    it->moving = 0;
    it->opaque = (unsigned char)opaque;
    it->color = (unsigned char)color;
    it->x = x; it->y = y; it->w = w; it->h = h;
    it->spr = NULL;
    mark(x, y, w, h);
}

#ifdef KV_TEST
/* ============================================================================
 *  시험판: 원판 흑백 화면(graph.c 를 shadow_* 로 컴파일)을 나란히 그리고,
 *  화면을 내보낼 때마다 목록에 남은 움직이는 그림이 흑백 화면에도 있는지 본다.
 *  흑백 화면에서는 이미 지워졌는데 목록에 남아 있으면 = 잔상.  kvcheck.log 에 적는다.
 * ========================================================================== */
extern unsigned char shadow_screen[SCREEN_H * SCREEN_BPL];
void shadow_init(void);
void shadow_to_cga(unsigned char *dst, int n);
void shadow_from_cga(const unsigned char *src, int n);
void shadow_bios_scroll_up(int lines, int top, int left, int bottom, int right, int attr);
void shadow_put_image(int x, int y, const unsigned char *img, int op);
void shadow_set_color(int c);
void shadow_line(int x1, int y1, int x2, int y2);
void shadow_set_viewport(int x1, int y1, int x2, int y2, int clip);
void shadow_clear_viewport(void);
void shadow_clear_device(void);

static struct { long frame; short sprno, x, y; unsigned char op, result; } ops[48];
static int ops_pos;
static short reported[64][3];
static int reported_n;

static void note_op(int sprno, int x, int y, int op, int result)     /* result: 0 추가, 1 지움, 2 덮음 */
{
    ops[ops_pos].frame = frame_count;
    ops[ops_pos].sprno = (short)sprno;
    ops[ops_pos].x = (short)x;
    ops[ops_pos].y = (short)y;
    ops[ops_pos].op = (unsigned char)op;
    ops[ops_pos].result = (unsigned char)result;
    ops_pos = (ops_pos + 1) % 48;
}

static int overlaps(const item *a, const item *b)
{
    return a->x < b->x + b->w && b->x < a->x + a->w && a->y < b->y + b->h && b->y < a->y + a->h;
}

/* 목록을 흑백으로 그렸을 때 (x, y) 점.  idx = 그 근처에 걸친 항목 번호들 (순서대로) */
static int scene_bit(int x, int y, const int *idx, int n)
{
    int i, v = 0;

    for (i = 0; i < n; i++) {
        const item *it = &scene.v[idx[i]];
        int b = 0;

        if (x < it->x || y < it->y || x >= it->x + it->w || y >= it->y + it->h)
            continue;
        if (it->type == IT_RECT)
            b = it->color != 0;
        else if (it->type == IT_TITLE)
            b = (title_mono[(y & 1 ? 0x2000 : 0) + (y / 2) * 80 + (x >> 3)] >> (7 - (x & 7))) & 1;
        else {
            const cspr *s = it->spr;
            int xx = x - it->x, yy = y - it->y;
            if (xx < s->w)
                b = (s->mono[yy * ((s->w + 7) / 8) + (xx >> 3)] >> (7 - (xx & 7))) & 1;
        }
        if (it->type == IT_IMAGE && it->moving)
            v ^= b;
        else if (it->type == IT_IMAGE && !it->opaque)
            v |= b;
        else
            v = b;
    }
    return v;
}

static void check_scene(void)
{
    int i, j, k, x, y;

    for (i = 0; i < scene.n; i++) {
        const item *it = &scene.v[i];
        const cspr *s = it->spr;
        int bpr, on = 0, hit = 0, seen = 0, mixed = 0, near_n = 0;
        static int near[4096];
        FILE *f;

        if (it->type != IT_IMAGE || !it->moving)
            continue;
        for (j = i + 1; j < scene.n; j++)           /* 위에 덮인 것은 보이지 않으니 따지지 않는다 */
            if (overlaps(it, &scene.v[j]) && scene.v[j].opaque)
                mixed = 1;
        if (mixed)
            continue;
        for (j = 0; j < scene.n && near_n < 4096; j++)
            if (overlaps(it, &scene.v[j]))
                near[near_n++] = j;
        /* 이 그림 자리에서 목록(흑백)은 켜졌는데 원판 흑백 화면은 꺼진 점 = 원판에는 없는 그림 */
        bpr = (s->w + 7) / 8;
        for (y = 0; y < it->h && it->y + y < SCREEN_H; y++)
            for (x = 0; x < s->w && it->x + x < SCREEN_W; x++)
                if ((s->mono[y * bpr + (x >> 3)] >> (7 - (x & 7))) & 1) {
                    int X = it->x + x, Y = it->y + y;
                    int want = scene_bit(X, Y, near, near_n);
                    int have = (shadow_screen[Y * SCREEN_BPL + (X >> 3)] >> (7 - (X & 7))) & 1;
                    on++;
                    hit += want == have;
                }
        if (on < 8 || hit * 4 >= on * 3)
            continue;
        for (k = 0; k < reported_n; k++)
            if (reported[k][0] == it->sprno && reported[k][1] == it->x && reported[k][2] == it->y)
                seen = 1;
        if (seen)
            continue;
        if (reported_n < 64) {
            reported[reported_n][0] = it->sprno;
            reported[reported_n][1] = it->x;
            reported[reported_n][2] = it->y;
            reported_n++;
        }
        f = fopen("kvcheck.log", "a");
        if (!f)
            return;
        fprintf(f, "frame %ld stage %d room %d: sprite %02X at %d,%d  %d/%d bits on mono\n",
                (long)frame_count, stage, cur_room, it->sprno & 0xFF, it->x, it->y, hit, on);
        for (k = 0; k < 48; k++) {
            int p = (ops_pos + k) % 48;
            if (ops[p].frame || ops[p].sprno)
                fprintf(f, "    f%ld op%d spr %02X %d,%d %s\n", ops[p].frame, ops[p].op, ops[p].sprno & 0xFF,
                        ops[p].x, ops[p].y, ops[p].result == 1 ? "erase" : ops[p].result == 2 ? "cover" : "add");
        }
        fclose(f);
    }
}
#else
#define note_op(s, x, y, op, r)
#endif

/* ============================================================================
 *  Graph 유닛
 * ========================================================================== */
void graph_init(void)
{
    static int loaded;

    if (!loaded) {
        load_spr();
        loaded = 1;
        if (!try_vesa(0x100) && !try_vesa(0x101)) {
            bios_set_mode(0x13);
            video_mode = 0x13;
        }
        set_palette(0);
    }
    scene.n = 0;
    vp_x1 = 0; vp_y1 = 0; vp_x2 = SCREEN_W - 1; vp_y2 = SCREEN_H - 1; vp_clip = 1;
    draw_color = 1;
    mark_all();
#ifdef KV_TEST
    shadow_init();
#endif
}

void graph_close(void)
{
    lfb_release();
    bios_set_mode(0x03);
}

void graph_touch(void)
{
    mark_all();
}

/* 새 판을 그리기 전에: 가려진 채 남아 있던 움직이는 그림을 모두 뺀다 (main.c start_round) */
void graph_forget_moving(void)
{
    int i;

    for (i = scene.n - 1; i >= 0; i--)
        if (scene.v[i].moving)
            remove_at(i);
}

/* 소울 스톤을 다 모았을 때 화면 반전 (원판은 화면 메모리를 뒤집어 썼다) */
void graph_flash(int inverted)
{
    flashed = inverted;
    set_palette(inverted);
}

/* i 번 항목 뒤에 그린 덮는 그림이 i 와 겹치나 */
static int covered_later(int i)
{
    const item *a = &scene.v[i];
    int j;

    for (j = i + 1; j < scene.n; j++) {
        const item *b = &scene.v[j];
        if (b->opaque && a->x < b->x + b->w && b->x < a->x + a->w && a->y < b->y + b->h && b->y < a->y + a->h)
            return 1;
    }
    return 0;
}

void graph_put_image(int x, int y, const unsigned char *img, int op)
{
    unsigned w1 = img[0] | img[1] << 8;
    unsigned h1 = img[2] | img[3] << 8;
    unsigned lim;
    const cspr *s;
    item *it;
    int i, w, h;
    int sprno = img >= sprites && img < sprites + sizeof sprites ? (int)(img - sprites) / SPRITE_REC : -1;

#ifdef KV_TEST
    shadow_put_image(x, y, img, op);
#endif
    x += vp_x1;
    y += vp_y1;
    lim = (unsigned)(SCREEN_H - 1 - y) & 0xFFFF;
    if (lim < h1)
        h1 = lim;
    if ((long)x + (long)w1 > SCREEN_W - 1 || x < 0 || y < 0)
        return;
    if (y + (int)h1 > SCREEN_H - 1)
        h1 = SCREEN_H - 1 - y;

    w = (int)w1 + 1;
    h = (img[2] | img[3] << 8) + 1;             /* 찾기는 자르기 전 크기로 */
    s = find_sprite(w, h, img + 4);
    h = (int)h1 + 1;

    if (op == 1) {                              /* XOR: 같은 그림이 있으면 지운다 */
        for (i = scene.n - 1; i >= 0; i--) {
            it = &scene.v[i];
            if (it->type == IT_IMAGE && it->spr == s && it->x == x && it->y == y) {
                if (it->opaque && covered_later(i)) {
                    /* COPY 로 찍은 뒤 다른 COPY 가 그 위를 덮었으면 원판 화면에서 그 점들은
                       이미 그 그림이 아니다 - 이 XOR 는 지우기가 아니라 위에 다시 그리기다
                       (출구: 탐험가를 찍고, 열린 문으로 덮고, 탐험가를 다시 XOR) */
                    break;
                }
                if (it->opaque) {
                    /* COPY 로 그린 것을 XOR 로 지움 = 그 사각형이 검게 된다.
                       그 자리(목록 순서)에서 배경 사각형으로 바꾼다 - 뒤에 그린
                       그림은 그대로 위에 보여야 한다 */
                    it->type = IT_RECT;
                    it->color = 0;
                    it->spr = NULL;
                    mark(it->x, it->y, it->w, it->h);
                } else {
                    remove_at(i);
                }
                note_op(sprno, x, y, op, 1);
                return;
            }
        }
    }
    if (op != 1 && op != 2)
        remove_covered(x, y, w, h, scene.n);
    it = push();
    it->type = IT_IMAGE;
    it->opaque = (op != 1 && op != 2);
    it->moving = (op == 1);
    it->sprno = (short)sprno;
    it->color = 0;
    it->x = x; it->y = y; it->w = w; it->h = h;
    it->spr = s;
    mark(x, y, w, h);
    note_op(sprno, x, y, op, op == 1 || op == 2 ? 0 : 2);
}

void graph_set_color(int c)
{
#ifdef KV_TEST
    shadow_set_color(c);
#endif
    draw_color = (c & 0xFF) != 0;
}

void graph_line(int x1, int y1, int x2, int y2)
{
    int cx1, cy1, cx2, cy2, t;

#ifdef KV_TEST
    shadow_line(x1, y1, x2, y2);
#endif
    x1 += vp_x1; x2 += vp_x1;
    y1 += vp_y1; y2 += vp_y1;
    if (x1 > x2) { t = x1; x1 = x2; x2 = t; }
    if (y1 > y2) { t = y1; y1 = y2; y2 = t; }
    if (vp_clip) { cx1 = vp_x1; cy1 = vp_y1; cx2 = vp_x2; cy2 = vp_y2; }
    else         { cx1 = 0; cy1 = 0; cx2 = SCREEN_W - 1; cy2 = SCREEN_H - 1; }
    if (x1 < cx1) x1 = cx1;
    if (y1 < cy1) y1 = cy1;
    if (x2 > cx2) x2 = cx2;
    if (y2 > cy2) y2 = cy2;
    if (x1 > x2 || y1 > y2)
        return;
    /* 게임은 가로/세로 선만 긋는다 - 기울어진 선은 둘러싼 사각형으로 */
    add_rect(x1, y1, x2 - x1 + 1, y2 - y1 + 1, draw_color ? LINE_COLOR : 0, 1);
}

void graph_rectangle(int x1, int y1, int x2, int y2)
{
    graph_line(x1, y1, x2, y1);
    graph_line(x2, y1, x2, y2);
    graph_line(x2, y2, x1, y2);
    graph_line(x1, y2, x1, y1);
}

void graph_set_viewport(int x1, int y1, int x2, int y2, int clip)
{
#ifdef KV_TEST
    shadow_set_viewport(x1, y1, x2, y2, clip);
#endif
    if (x1 < 0 || y1 < 0 || x2 > SCREEN_W - 1 || y2 > SCREEN_H - 1 || x2 < x1 || y2 < y1)
        return;
    vp_x1 = x1; vp_y1 = y1; vp_x2 = x2; vp_y2 = y2;
    vp_clip = clip & 0xFF;
}

void graph_clear_viewport(void)
{
#ifdef KV_TEST
    shadow_clear_viewport();
#endif
    add_rect(vp_x1, vp_y1, vp_x2 - vp_x1 + 1, vp_y2 - vp_y1 + 1, 0, 1);
}

void graph_clear_device(void)
{
#ifdef KV_TEST
    shadow_clear_device();
#endif
    scene.n = 0;
    mark_all();
}

/* BIOS 스크롤 (제작진 화면) - 화면 전체를 lines*8 줄 올린다 */
void graph_bios_scroll_up(int lines, int top, int left, int bottom, int right, int attr)
{
    int i, dy;

#ifdef KV_TEST
    shadow_bios_scroll_up(lines, top, left, bottom, right, attr);
#endif
    (void)top; (void)left; (void)bottom; (void)right; (void)attr;
    if (lines <= 0)
        lines = 25;
    dy = lines * 8;
    for (i = scene.n - 1; i >= 0; i--) {
        scene.v[i].y -= dy;
        if (scene.v[i].y + scene.v[i].h <= 0) {
            memmove(&scene.v[i], &scene.v[i + 1], (scene.n - i - 1) * sizeof(item));
            scene.n--;
        }
    }
    mark_all();
}

/* Move(Mem[$B800:0], dst, n) - 지금 화면 목록을 dst 이름으로 기억해 둔다 */
void graph_to_cga(unsigned char *dst, int n)
{
    int i, slot = -1;

    memset(dst, 0, n);
#ifdef KV_TEST
    shadow_to_cga(dst, n);
#endif
    for (i = 0; i < 4; i++)
        if (snaps[i].key == dst || (slot < 0 && snaps[i].key == NULL))
            slot = i;
    if (slot < 0)
        slot = 0;
    snaps[slot].key = dst;
    reserve(&snaps[slot].list, scene.n);
    memcpy(snaps[slot].list.v, scene.v, scene.n * sizeof(item));
    snaps[slot].list.n = scene.n;
}

/* Move(src, Mem[$B800:0], n) - 기억해 둔 화면이면 되돌리고, 타이틀 그림이면 색 타이틀 */
void graph_from_cga(const unsigned char *src, int n)
{
    int i;

#ifdef KV_TEST
    shadow_from_cga(src, n);
#endif
    for (i = 0; i < 4; i++)
        if (snaps[i].key == src) {
            reserve(&scene, snaps[i].list.n);
            memcpy(scene.v, snaps[i].list.v, snaps[i].list.n * sizeof(item));
            scene.n = snaps[i].list.n;
            mark_all();
            return;
        }
    if (n == CGA_MEM_SIZE && memcmp(src, title_mono, CGA_MEM_SIZE) == 0) {
        item *it;

        scene.n = 0;
        it = push();
        it->type = IT_TITLE;
        it->moving = 0;
        it->opaque = 1;
        it->x = 0; it->y = 0; it->w = SCREEN_W; it->h = SCREEN_H;
        it->spr = NULL;
        mark_all();
    }
}

/* ============================================================================
 *  합성해서 내보내기
 * ========================================================================== */
static unsigned char band[CELL * OUT_W];

/* 화면 y0 (출력 좌표) 에서 CELL 줄, x0..x1 */
static void compose(int y0, int x0, int x1)
{
    int i, x, y;

    for (y = 0; y < CELL; y++)
        memcpy(band + y * OUT_W + x0, backdrop + (y0 + y) * OUT_W + x0, x1 - x0);

    for (i = 0; i < scene.n; i++) {
        const item *it = &scene.v[i];
        int ix0 = it->x, ix1 = it->x + it->w;
        int iy0 = it->y * 2, iy1 = (it->y + it->h) * 2;
        int ax0 = ix0 > x0 ? ix0 : x0, ax1 = ix1 < x1 ? ix1 : x1;
        int ay0 = iy0 > y0 ? iy0 : y0, ay1 = iy1 < y0 + CELL ? iy1 : y0 + CELL;

        if (ax0 >= ax1 || ay0 >= ay1)
            continue;
        for (y = ay0; y < ay1; y++) {
            unsigned char *d = band + (y - y0) * OUT_W;
            const unsigned char *bg = backdrop + y * OUT_W;

            switch (it->type) {
            case IT_RECT:
                if (it->color)
                    memset(d + ax0, it->color, ax1 - ax0);
                else
                    memcpy(d + ax0, bg + ax0, ax1 - ax0);
                break;
            case IT_TITLE:
                if (y - iy0 >= 0 && y - iy0 < OUT_H)
                    memcpy(d + ax0, title_color + (y - iy0) * OUT_W + ax0, ax1 - ax0);
                break;
            default: {
                const unsigned char *s = it->spr->color + (y - iy0) * it->spr->w - ix0;
                if (it->opaque) {
                    for (x = ax0; x < ax1; x++)
                        d[x] = s[x] ? s[x] : bg[x];
                } else {
                    for (x = ax0; x < ax1; x++)
                        if (s[x])
                            d[x] = s[x];
                }
                break;
            }
            }
        }
    }
}

static void output_band(int y0, int x0, int x1)
{
    int y, x;

    if (video_mode == 0x13) {
        unsigned char half[OUT_W / 2];
        for (y = 0; y < CELL; y += 2) {
            for (x = x0 / 2; x < x1 / 2; x++)
                half[x] = band[y * OUT_W + x * 2];
            movedata(_my_ds(), (unsigned)(half + x0 / 2), _dos_ds,
                     0xA0000 + ((y0 + y) / 2) * (OUT_W / 2) + x0 / 2, (x1 - x0) / 2);
        }
        return;
    }
    for (y = 0; y < CELL; y++)
        vram_write((unsigned long)(y0 + y + top_margin) * line_bytes + x0, band + y * OUT_W + x0, x1 - x0);
}

void graph_present(void)
{
    int cy, cx, start;

    if (!any_dirty)
        return;
    any_dirty = 0;
#ifdef KV_TEST
    check_scene();
#endif
    for (cy = 0; cy < CELLS_Y; cy++) {
        cx = 0;
        while (cx < CELLS_X) {
            if (!dirty[cy][cx]) {
                cx++;
                continue;
            }
            start = cx;
            while (cx < CELLS_X && dirty[cy][cx])
                dirty[cy][cx++] = 0;
            compose(cy * CELL, start * CELL, cx * CELL);
            output_band(cy * CELL, start * CELL, cx * CELL);
        }
    }
}

/* 시험판(KV_TEST): 지금 화면을 PPM 으로 */
void graph_dump(const char *name)
{
    static unsigned char full[OUT_W * OUT_H];
    char path[80];
    FILE *f;
    int cy, i;

    for (cy = 0; cy < CELLS_Y; cy++) {
        compose(cy * CELL, 0, OUT_W);
        memcpy(full + cy * CELL * OUT_W, band, CELL * OUT_W);
    }
    sprintf(path, "%s.ppm", name);
    f = fopen(path, "wb");
    if (!f)
        return;
    fprintf(f, "P6\n640 400\n255\n");
    for (i = 0; i < OUT_W * OUT_H; i++) {
        const unsigned char *p = palette + full[i] * 3;
        int k;
        for (k = 0; k < 3; k++) {
            int v = flashed ? 63 - p[k] : p[k];
            fputc(v * 255 / 63, f);
        }
    }
    fclose(f);
}
