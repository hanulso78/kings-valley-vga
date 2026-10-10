# -*- coding: utf-8 -*-
"""KVVGA.EXE 256색 그림 - KV256.SPR 을 만든다.

   쓰는 법 :  python tools/mkspr256.py [--preview 폴더]      (kv 폴더에서)
              B_UNP.BIN (원본 데이터 세그먼트), KINGS-V.IFM, KINGS-V.DAT,
              둥근모꼴(DungGeunMo.ttf, 윈도우에 설치) 을 쓴다.  PIL 필요.

   스프라이트는 원판의 윤곽을 그대로 두고 색만 입체감 있게 칠한다 (세로 두 배).
       1. 원판 1bpp 그림의 점을 나눈다
            켜진 점          - 도드라진 면/선
            디더(바둑판)     - 원판이 그늘을 나타낸 곳 -> 그 재질의 그늘색
            선에 둘러싸인 안 - 선으로만 그린 곳(관, 문) -> 면으로 채운다
            바깥            - 투명 (벽돌 칸은 줄눈 색)
       2. 바깥까지의 거리로 볼록한 높이를 만들고, 그 기울기로 왼쪽 위 빛의
          음영과 반사광을 준다.  바깥 둘레에는 어두운 윤곽선.
       3. 재질 색은 스프라이트 종류와 부위로 정한다 (탐험가: 모자/얼굴/윗옷/바지/장화/도구).
   타이틀도 원판 KINGS-V.IFM 그림 그대로 부분마다 칠한다 (바둑판 바탕 -> 노을빛, 제목 KING'S VALLEY 만
   둥근모꼴(DungGeunMo) 픽셀 글꼴로 새로 그린 금 블록 글자,
   게임 장면 칸 -> 그 자리에 찍힌 스프라이트를 찾아 게임과 같은 색).  원판의 검은 바탕(방, 메뉴)은
   모양 없는 어두운 그러데이션.  모든 그림에서 256색 팔레트를 뽑는다.

   KV256.SPR 구조
       0..7      "KV256S1" + 0
       8..775    팔레트 256색 x (R,G,B)  VGA DAC 값 0..63
                 0 = 투명,  1 = 검정,  2..15 회색,  16 = 선/사각형 금색,  17.. 그림에서 뽑은 색
       776..777  스프라이트 수 N
       스프라이트마다  폭 w (1), 높이 h (1), 흑백 비트맵 ((w+7)/8*h), 색 그림 (w * 2h)
                 게임은 흑백 비트맵 "내용"으로 색 그림을 찾는다 (원판이 실행 중에
                 벽 무늬를 바꾸고 AND 로 섞으므로 그 결과마다 그림을 만들어 둔다)
       배경      640 x 400
       타이틀    흑백 CGA 덤프 16384 + 색 그림 640 x 400
"""
import os, struct, sys, math

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, '..')

from PIL import Image, ImageDraw, ImageFont


# ============================================================ 색 =============
def clamp(v):
    return max(0, min(255, int(round(v))))


def mix(a, b, t):
    return tuple(clamp(a[i] + (b[i] - a[i]) * t) for i in range(3))


def mul(c, k):
    return tuple(clamp(v * k) for v in c)


KHAKI  = (234, 214, 158)
BAND   = (120, 78, 42)
SKIN   = (240, 184, 134)
SHIRT  = (206, 58, 46)
PANTS  = (66, 92, 160)
BOOT   = (104, 66, 40)
STEEL  = (184, 200, 220)
WOOD   = (160, 104, 56)
WRAP   = (226, 212, 172)
GOLD   = (240, 186, 56)
LAPIS  = (46, 88, 200)
BRONZE = (176, 112, 52)
STONE  = (178, 166, 146)
GEM    = (80, 210, 250)
GEM_D  = (120, 60, 200)
FIRE   = (255, 150, 40)
GHOST  = (176, 208, 255)

# 벽 무늬 7가지 (10 스테이지마다): 사암, 청금석, 비취, 붉은 화강암, 자수정, 금, 흑요석
WORLDS = [(218, 170, 106), (86, 126, 216), (80, 180, 126), (204, 100, 78),
          (166, 114, 216), (230, 188, 86), (100, 144, 156)]

# ============================================================ 원본 스프라이트 ==
BIN = open(os.path.join(ROOT, 'B_UNP.BIN'), 'rb').read()
DS = 0x11610
GROUPS = [(0x00, 0x32, 32, 16), (0x33, 0x40, 32, 8), (0x41, 0x48, 40, 16),
          (0x49, 0x6E, 32, 16), (0x6F, 0x8A, 32, 8), (0x8B, 0xAE, 19, 7)]


def load_sprites():
    d = BIN[DS + 0x27E: DS + 0x27E + 8436]
    spr, p = {}, 0
    for a, b, w, h in GROUPS:
        bpr = (w + 7) // 8
        for n in range(a, b + 1):
            spr[n] = (w, h, bytes(d[p:p + bpr * h]))
            p += bpr * h
    return spr


def bits_of(w, h, raw):
    bpr = (w + 7) // 8
    return [[(raw[y * bpr + (x >> 3)] >> (7 - (x & 7))) & 1 for x in range(w)] for y in range(h)]


def raw_of(w, h, m):
    bpr = (w + 7) // 8
    out = bytearray(bpr * h)
    for y in range(h):
        for x in range(w):
            if m[y][x]:
                out[y * bpr + (x >> 3)] |= 0x80 >> (x & 7)
    return bytes(out)


# ============================================================ 점 나누기 ======
ON, TEX, INSIDE, OUT = 1, 2, 3, 0


def classify(m, fill_inside=True, tidy=False):
    h, w = len(m), len(m[0])

    def at(x, y):
        return 0 <= x < w and 0 <= y < h and m[y][x]

    cls = [[OUT] * w for _ in range(h)]
    for y in range(h):
        for x in range(w):
            p = m[y][x]
            hx = 0 < x < w - 1 and m[y][x - 1] != p and m[y][x + 1] != p
            vy = 0 < y < h - 1 and m[y - 1][x] != p and m[y + 1][x] != p
            if p:
                cls[y][x] = TEX if (hx and vy) else ON
            elif hx and vy:
                cls[y][x] = TEX                          # 바둑판 사이의 꺼진 점
    if tidy:                                             # 벽돌: 가장자리 빗살 틈을 메우고 네모 덩어리로
        def on(xx, yy):
            return 0 <= xx < w and 0 <= yy < h and cls[yy][xx] != OUT
        row_used = [any(cls[y][x] != OUT for x in range(w)) for y in range(h)]      # 통째로 빈 줄/칸은 줄눈
        col_used = [any(cls[y][x] != OUT for y in range(h)) for x in range(w)]
        for x, y in [(x, y) for y in range(h) for x in range(w) if cls[y][x] == OUT and
                     ((col_used[x] and on(x - 1, y) and on(x + 1, y)) or
                      (row_used[y] and on(x, y - 1) and on(x, y + 1)))]:
            cls[y][x] = INSIDE
        label = [[0] * w for _ in range(h)]
        n = 0
        for sy in range(h):
            for sx in range(w):
                if cls[sy][sx] == OUT or label[sy][sx]:
                    continue
                n += 1
                stack, pts = [(sx, sy)], []
                label[sy][sx] = n
                while stack:
                    x, y = stack.pop()
                    pts.append((x, y))
                    for xx, yy in ((x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)):
                        if on(xx, yy) and not label[yy][xx]:
                            label[yy][xx] = n
                            stack.append((xx, yy))
                x0, x1 = min(p[0] for p in pts), max(p[0] for p in pts)
                y0, y1 = min(p[1] for p in pts), max(p[1] for p in pts)
                if len(pts) >= 0.7 * (x1 - x0 + 1) * (y1 - y0 + 1):
                    for y in range(y0, y1 + 1):
                        for x in range(x0, x1 + 1):
                            if cls[y][x] == OUT:
                                cls[y][x] = INSIDE
    if fill_inside:
        seen = [[False] * w for _ in range(h)]
        stack = [(x, y) for x in range(w) for y in (0, h - 1)] + [(x, y) for y in range(h) for x in (0, w - 1)]
        while stack:
            x, y = stack.pop()
            if not (0 <= x < w and 0 <= y < h) or seen[y][x] or cls[y][x] != OUT:
                continue
            seen[y][x] = True
            stack.extend(((x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)))
        for y in range(h):
            for x in range(w):
                if cls[y][x] == OUT and not seen[y][x]:
                    cls[y][x] = INSIDE
    return cls


# ============================================================ 칠하기 ========
LIGHT = (-0.55, -0.65, 0.53)


def shade(m, material, opaque_bg=None, fill_inside=True, relief=0.35, radius=3.0, spec=0.55, tidy=False):
    """material(x, y, cls) -> RGB (원판 좌표).  돌려주는 것: [[RGB 또는 None]] (w x 2h)"""
    h, w = len(m), len(m[0])
    cls = classify(m, fill_inside, tidy)
    H2 = h * 2
    body = [[cls[y // 2][x] != OUT for x in range(w)] for y in range(H2)]
    # 바깥까지의 거리 (8방향, 대각 1.4) -> 높이
    INF = 99.0
    dist = [[0.0 if not body[y][x] else INF for x in range(w)] for y in range(H2)]
    for y in range(H2):
        for x in range(w):
            if dist[y][x]:
                best = dist[y][x]
                for dx, dy, c in ((-1, 0, 1), (0, -1, 1), (-1, -1, 1.4), (1, -1, 1.4)):
                    xx, yy = x + dx, y + dy
                    v = dist[yy][xx] + c if 0 <= xx < w and 0 <= yy < H2 else c
                    best = min(best, v)
                dist[y][x] = best
    for y in range(H2 - 1, -1, -1):
        for x in range(w - 1, -1, -1):
            if dist[y][x]:
                best = dist[y][x]
                for dx, dy, c in ((1, 0, 1), (0, 1, 1), (1, 1, 1.4), (-1, 1, 1.4)):
                    xx, yy = x + dx, y + dy
                    v = dist[yy][xx] + c if 0 <= xx < w and 0 <= yy < H2 else c
                    best = min(best, v)
                dist[y][x] = best
    hgt = [[0.0] * w for _ in range(H2)]
    for y in range(H2):
        for x in range(w):
            if body[y][x]:
                t = min(dist[y][x], radius) / radius
                v = t * t * (3 - 2 * t)
                c = cls[y // 2][x]
                if c == ON and fill_inside:
                    v += relief * (1.0 if any(cls[y // 2][x2] == INSIDE for x2 in range(max(0, x - 2), min(w, x + 3))) else 0.3)
                elif c == TEX:
                    v -= relief * 0.3
                hgt[y][x] = v
    L = LIGHT
    Hv = (L[0], L[1], L[2] + 1.0)
    hn = math.sqrt(sum(v * v for v in Hv))
    Hv = tuple(v / hn for v in Hv)

    def H(x, y):
        return hgt[y][x] if 0 <= x < w and 0 <= y < H2 else 0.0

    out = [[None] * w for _ in range(H2)]
    for y in range(H2):
        for x in range(w):
            c = cls[y // 2][x]
            if not body[y][x]:
                if opaque_bg is not None:
                    out[y][x] = opaque_bg(x, y // 2) if callable(opaque_bg) else opaque_bg
                continue
            nx = -(H(x + 1, y) - H(x - 1, y)) * 1.6
            ny = -(H(x, y + 1) - H(x, y - 1)) * 1.6
            nz = 1.0
            nl = math.sqrt(nx * nx + ny * ny + nz * nz)
            nx, ny, nz = nx / nl, ny / nl, nz / nl
            diff = max(0.0, nx * L[0] + ny * L[1] + nz * L[2]) / 0.53
            sp = max(0.0, nx * Hv[0] + ny * Hv[1] + nz * Hv[2]) ** 18 * spec
            base = material(x, y // 2, c)
            if c == TEX:
                base = mul(base, 0.64)
            elif c == INSIDE:
                base = mul(base, 0.82)
            k = 0.42 + 0.62 * diff
            col = tuple(clamp(base[i] * k + 255 * sp) for i in range(3))
            out[y][x] = col
    if opaque_bg is None:                                  # 어두운 윤곽선
        o2 = [row[:] for row in out]
        for y in range(H2):
            for x in range(w):
                if out[y][x] is None:
                    nb = [out[yy][xx] for xx, yy in ((x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1))
                          if 0 <= xx < w and 0 <= yy < H2 and out[yy][xx] is not None]
                    if nb:
                        avg = tuple(sum(q[i] for q in nb) / len(nb) for i in range(3))
                        o2[y][x] = mul(avg, 0.22)
        out = o2
    return out


# ============================================================ 재질 ==========
def first_row(m):
    return next((y for y in range(len(m)) if any(m[y])), 0)


def mat_explorer(m, item=None, core=(7, 25)):
    """탐험가: 모자 / 얼굴 / 윗옷 / 바지 / 장화, 몸 밖으로 나온 것은 도구"""
    y0 = first_row(m)
    w = len(m[0])

    def f(x, y, c):
        r = y - y0
        if item and r >= 6 and not (core[0] <= x <= core[1]):
            if item in ('dagger', 'drill'):
                return STEEL
            return STEEL if r <= 8 else WOOD
        if r <= 2:
            return KHAKI
        if r <= 6:
            return BAND if (r == 4 and c == ON) else KHAKI
        if r <= 8:
            return SKIN if 9 <= x <= w - 8 else KHAKI
        if r <= 12:
            if c == ON and (x < 10 or x > w - 10):
                return SKIN
            return SHIRT
        if r == 13:
            return PANTS
        return BOOT
    return f


def mat_const(col):
    return lambda x, y, c: col


def mat_mummy(x, y, c):
    return mix(WRAP, (178, 160, 118), y / 16.0)                    # 아래로 갈수록 때 묻은 붕대


def mat_burst(w, h):
    def f(x, y, c):
        d = math.hypot(x - w / 2, (y - h / 2) * 2) / (w / 2)
        return mix((255, 250, 180), FIRE, min(1, d * 1.4))
    return f


def mat_sarcophagus(x, y, c):
    if c == TEX or (c == INSIDE and y <= 8):
        return LAPIS
    return GOLD


def mat_door(x, y, c):
    if c == ON:
        return GOLD
    if c == TEX:
        return BRONZE
    return WOOD


def mat_gate(state):
    def f(x, y, c):
        if c == ON:
            return GOLD
        if c == TEX:
            return (206, 170, 110)
        return (110, 66, 32) if state < 2 else (40, 24, 14)
    return f


def mat_gem(w, h):
    def f(x, y, c):
        if c == TEX:
            return GEM_D
        d = math.hypot(x - w * 0.45, (y - h * 0.45) * 2) / (w / 2)
        return mix((230, 255, 255), GEM, min(1, d * 1.6))
    return f


def mat_tool(kind):
    def f(x, y, c):
        if kind == 'pick':
            return STEEL if (y <= 6 or x >= 15) else WOOD
        if kind == 'shovel':
            return STEEL if (y >= 9 and x <= 12) else WOOD
        return STEEL if (x <= 16 and y >= 6) else GOLD         # 드릴
    return f


def mat_font(h):
    def f(x, y, c):
        t = y / max(1, h - 1)
        return mix((255, 246, 170), GOLD, t / 0.5) if t < 0.5 else mix(GOLD, (206, 100, 20), (t - 0.5) / 0.5)
    return f


# ============================================================ 만들기 ========
ITEM_OF = {}
for f in (0, 1):
    for i, item in enumerate([None, 'dagger', 'pick', 'drill', 'shovel']):
        ITEM_OF[2 * i + f] = item
        ITEM_OF[10 + 4 * i + f] = item
        ITEM_OF[12 + 4 * i + f] = item
PLAYER = set(range(0x00, 0x1E)) | {0x1F, 0x20, 0x24, 0x26, 0x27, 0x28, 0x29} | set(range(0x61, 0x67))


def paint_sprite(n, w, h, m):
    if n in PLAYER:
        return shade(m, mat_explorer(m, ITEM_OF.get(n)), fill_inside=False)
    if 0x41 <= n <= 0x48:                                   # 아래 파기 (40 폭)
        right = n in (0x41, 0x42, 0x45, 0x46)
        item = 'pick' if n <= 0x44 else 'shovel'
        return shade(m, mat_explorer(m, item, (4, 24) if right else (15, 35)), fill_inside=False)
    if n == 0x1E:
        return shade(m, mat_tool('pick'), fill_inside=False)
    if n == 0x21:
        return shade(m, mat_gem(w, h), fill_inside=False, radius=5)
    if n == 0x22:
        return shade(m, mat_tool('drill'), fill_inside=False)
    if n == 0x23:
        return shade(m, mat_tool('shovel'), fill_inside=False)
    if n == 0x25:
        return shade(m, mat_const(GHOST), fill_inside=False)
    if 0x2A <= n <= 0x31:
        return shade(m, mat_door)
    if n == 0x32:
        return shade(m, mat_const(STONE), radius=4)
    if n in (0x33,) or 0x6F <= n <= 0x8A and (n - 0x6F) % 4 == 0:
        k = 0 if n == 0x33 else (n - 0x6F) // 4
        return shade(m, mat_const(mix(WORLDS[k], (255, 255, 255), 0.1)), fill_inside=False)
    if n == 0x34:
        return shade(m, mat_const(WOOD), fill_inside=False)
    if 0x38 <= n <= 0x40:
        return shade(m, mat_const(STEEL), fill_inside=False, radius=1.5)
    if 0x49 <= n <= 0x4B:
        return shade(m, mat_sarcophagus)
    if 0x4C <= n <= 0x51 or n in (0x53, 0x54):
        return shade(m, mat_mummy, fill_inside=False)
    if n == 0x52:
        return shade(m, mat_burst(w, h), fill_inside=False)
    if 0x55 <= n <= 0x60:
        return shade(m, mat_gate(0 if n < 0x59 else 1 if n < 0x5D else 2))
    if 0x67 <= n <= 0x6E:
        return None                                          # 벽 무늬를 AND 한 뒤에 따로 만든다
    if 0x6F <= n <= 0x8A:
        k = (n - 0x6F) // 4
        base = WORLDS[k] if (n - 0x6F) % 4 != 2 else mul(WORLDS[k], 0.82)
        return shade(m, mat_const(base), opaque_bg=mul(WORLDS[k], 0.28), fill_inside=False, radius=2.5, tidy=True)
    if n >= 0x8B:
        return shade(m, mat_font(h), fill_inside=False, radius=1.5, spec=0.3)
    return shade(m, mat_const(STEEL), fill_inside=False)


def crumble_px(k, orig, anded):
    """옆 파기: 원판의 흰 곳은 벽 (벽돌/줄눈), 검은 곳은 구멍"""
    h, w = len(orig), len(orig[0])
    img = shade(anded, mat_const(WORLDS[k]), opaque_bg=mul(WORLDS[k], 0.28), fill_inside=False, radius=2.5, tidy=True)
    for y in range(h * 2):
        for x in range(w):
            if not orig[y // 2][x]:
                img[y][x] = None
    return img


# ============================================================ 배경 ==========
def make_backdrop():
    """방/메뉴 뒤 바탕 - 원판의 검은 바탕 자리.  모양 없이 어두운 색 그러데이션만"""
    W, H = 640, 400
    im = Image.new('RGB', (W, H))
    px = im.load()
    for y in range(H):
        t = y / (H - 1)
        row = mix((16, 14, 36), (40, 22, 30), t)
        for x in range(W):
            g = max(0.0, 1 - math.hypot((x - W / 2) / (W * 0.62), (y - H * 0.55) / (H * 0.7)))
            px[x, y] = mix(row, (70, 40, 44), g * g * 0.6)
    return im


# ============================================================ 타이틀 ========
def load_ifm():
    """KINGS-V.IFM (CGA 640x200 덤프) -> [[0/1]]"""
    d = open(os.path.join(ROOT, 'KINGS-V.IFM'), 'rb').read()
    rows = []
    for y in range(200):
        base = (0 if y % 2 == 0 else 0x2000) + (y // 2) * 80
        rows.append([(d[base + (x >> 3)] >> (7 - (x & 7))) & 1 for x in range(640)])
    return rows


def find_sprites(A, spr, names, box):
    """box 안에서 원판 스프라이트가 그대로 찍힌 자리를 모두 찾는다"""
    x0, y0, x1, y1 = box
    ints = [int(''.join(map(str, r)), 2) for r in A]
    hits = []
    for n in names:
        w, h, raw = spr[n]
        m = bits_of(w, h, raw)
        rows = [int(''.join(map(str, r)), 2) for r in m]
        mask = (1 << w) - 1
        for y in range(y0, y1 - h + 2):
            for x in range(x0, x1 - w + 2):
                sh = 640 - x - w
                if all((ints[y + i] >> sh) & mask == rows[i] for i in range(h)):
                    hits.append((n, x, y))
    return hits


def make_title(sprite_px, spr):
    """원판 타이틀 그림 그대로, 부분마다 색과 음영만 입힌다.
       sprite_px(n) -> 게임 스프라이트 색 그림 (w x 2h, None = 투명)"""
    A = load_ifm()
    W, H = 640, 400
    im = Image.new('RGB', (W, H))
    px = im.load()

    def crop(x0, y0, x1, y1, keep=None):
        return [[A[y][x] if (keep is None or keep(x, y)) else 0 for x in range(x0, x1 + 1)] for y in range(y0, y1 + 1)]

    def put(x0, y0, img, bg=None):
        for yy, row in enumerate(img):
            for xx, c in enumerate(row):
                X, Y = x0 + xx, y0 * 2 + yy
                if c is None:
                    c = bg(X, Y) if callable(bg) else bg
                if c is not None and 0 <= X < W and 0 <= Y < H:
                    px[X, Y] = c

    def fill(x0, y0, x1, y1, col):
        for Y in range(y0 * 2, (y1 + 1) * 2):
            for X in range(x0, x1 + 1):
                px[X, Y] = col(X, Y) if callable(col) else col

    # 바탕: 원판의 사선 바둑판 - 노을 하늘색으로, 무늬는 살짝 남긴다
    stops = [(0, (30, 24, 96)), (140, (104, 40, 134)), (260, (214, 70, 92)), (400, (255, 150, 62))]

    def sky(Y):
        for (y0, c0), (y1, c1) in zip(stops, stops[1:]):
            if Y <= y1:
                return mix(c0, c1, (Y - y0) / (y1 - y0))
        return stops[-1][1]
    LY0, LY1 = 4, 58                                           # 원판 제목 KING'S VALLEY 자리
    for Y in range(H):
        c = sky(Y)
        hi, lo = mix(c, (255, 255, 255), 0.12), mul(c, 0.86)
        for X in range(W):
            if LY0 <= Y // 2 <= LY1 and 10 <= X < 630:          # 원판 글자는 지우고 바둑판만
                on = (X + Y // 2) % 2 == 0
            else:
                on = A[Y // 2][X]
            px[X, Y] = hi if on else lo

    # 위아래 흰 띠 -> 금 테
    for y0, y1 in ((0, 3), (195, 199)):
        put(0, y0, shade(crop(0, y0, 639, y1), mat_const(GOLD), fill_inside=False, radius=2.5, spec=0.4))

    # KING'S VALLEY: 둥근모꼴(DungGeunMo, 16 점 픽셀 글꼴)의 점을 가로 5, 세로 9 배 금 블록으로 - 테두리, 그림자
    text = "KING'S VALLEY"
    fpath = next(q for q in (os.path.join(os.environ.get('LOCALAPPDATA', ''), r'Microsoft\Windows\Fonts\DungGeunMo.ttf'),
                             r'C:\Windows\Fonts\DungGeunMo.ttf') if os.path.exists(q))
    raster = Image.new('L', (400, 30))
    ImageDraw.Draw(raster).text((2, 4), text, font=ImageFont.truetype(fpath, 16), fill=255)
    bx0, by0, bx1, by1 = raster.getbbox()
    rows = [[1 if raster.getpixel((x, y)) >= 128 else 0 for x in range(bx0, bx1)] for y in range(by0, by1)]
    mh, mw = len(rows), len(rows[0])
    SX, SY = 5, 9
    ox, top = (W - mw * SX) // 2, (118 - mh * SY) // 2 + 2

    def lit(x, y):
        return 0 <= y < mh and 0 <= x < mw and rows[y][x]
    for y in range(mh):                                        # 그림자
        for x in range(mw):
            if lit(x, y):
                for yy in range(SY):
                    for xx in range(SX):
                        X, Y = ox + x * SX + xx + SX // 2 + 3, top + y * SY + yy + SY // 2 + 4
                        px[X, Y] = mix(px[X, Y], (20, 6, 30), 0.75)
    for y in range(mh):                                        # 테두리 2점
        for x in range(mw):
            if lit(x, y):
                for yy in range(-2, SY + 2):
                    for xx in range(-2, SX + 2):
                        px[ox + x * SX + xx, top + y * SY + yy] = (60, 22, 6)
    for y in range(mh):                                        # 금빛 몸통 - 글꼴 점 하나하나를 금 블록처럼
        for x in range(mw):
            if lit(x, y):
                for yy in range(SY):
                    for xx in range(SX):
                        Y = top + y * SY + yy
                        t = (Y - top) / (mh * SY)
                        c = (mix((255, 250, 205), (255, 204, 52), t / 0.5) if t < 0.5 else
                             mix((255, 204, 52), (206, 100, 20), (t - 0.5) / 0.5))
                        if (yy == 0 and not lit(x, y - 1)) or (xx == 0 and not lit(x - 1, y)):
                            c = mix(c, (255, 255, 240), 0.6)            # 윗면/왼쪽 빛
                        elif (yy == SY - 1 and not lit(x, y + 1)) or (xx == SX - 1 and not lit(x + 1, y)):
                            c = mul(c, 0.62)                            # 아랫면/오른쪽 그늘
                        px[ox + x * SX + xx, Y] = c

    # 왕의 계곡 명판: 흰 판 -> 금판, 글자 구멍 -> 새긴 글씨
    def plaque(x0, y0, x1, y1, col, text_col):
        put(x0, y0, shade(crop(x0, y0, x1, y1), mat_const(col), fill_inside=False, radius=3, spec=0.35), text_col)
    plaque(43, 60, 270, 74, (246, 214, 140), (110, 30, 24))

    # 게임 장면 두 칸: 검은 바탕 -> 어두운 방,  찍힌 스프라이트는 게임과 같은 색
    room_bg = lambda X, Y: mix((22, 16, 40), (50, 28, 34), Y / H)
    names = [0x21, 0x38, 0x4C, 0x55, 0x56, 0x57, 0x58, 0x71, 0x7B, 0x7C, 0x7D]
    for box in ((44, 83, 312, 122), (397, 60, 608, 173)):      # 테두리 바둑판 점은 하늘로 둔다
        x0, y0, x1, y1 = box
        fill(x0, y0, x1, y1, room_bg)
        hits = find_sprites(A, spr, names, box)
        if box[0] == 44:
            hits.insert(0, (0x00, 108, 99))              # 탐험가 (바닥과 한 점 겹쳐 그대로 찾아지지 않는다)
        covered = set()
        for n, x, y in hits:
            w, h, raw = spr[n]
            put(x, y, sprite_px(n))
            covered.update((xx, yy) for xx in range(x, x + w) for yy in range(y, y + h))
        rest = crop(x0, y0, x1, y1, lambda x, y: (x, y) not in covered and
                    (A[y][x - 1] or A[y][x + 1] or A[y - 1][x] or A[y + 1][x]))
        img = shade(rest, mat_const(STONE), fill_inside=False)
        for yy, row in enumerate(img):                   # 남은 점만 (스프라이트 위에 윤곽선을 덮지 않게)
            for xx, c in enumerate(row):
                if c is not None and (x0 + xx, y0 + yy // 2) not in covered:
                    px[x0 + xx, y0 * 2 + yy] = c

    # 아프로만 상표: 검은 칸의 흰 피라미드, 오른쪽은 디더 그러데이션과 흰 판의 글자
    fill(43, 131, 150, 171, lambda X, Y: mix((20, 18, 60), (60, 24, 70), (Y - 262) / 82))

    def mat_pyramid(x, y, c):
        return (255, 222, 130) if x < 53 else (232, 146, 60)     # 왼쪽 면은 햇빛, 오른쪽 면은 그늘
    put(43, 131, shade(crop(43, 131, 150, 171), mat_pyramid, fill_inside=False, radius=4, spec=0.45))
    dens = [sum(A[y][151:297]) / 146.0 for y in range(131, 157)]
    for i, y in enumerate(range(131, 157)):
        dd = sum(dens[max(0, i - 2):i + 3]) / len(dens[max(0, i - 2):i + 3])
        col = mix((40, 16, 60), (236, 110, 60), dd / 0.5) if dd < 0.5 else mix((236, 110, 60), (255, 236, 180), (dd - 0.5) / 0.5)
        fill(151, y, 295, y, col)
    plaque(151, 157, 295, 171, (255, 236, 180), (70, 20, 64))

    # 저작권 띠: 검은 띠 -> 짙은 자주, 흰 글자 -> 금
    fill(23, 179, 615, 189, lambda X, Y: mix((36, 8, 30), (70, 16, 40), abs(X - 320) / 320))
    put(23, 179, shade(crop(23, 179, 615, 189), mat_font(11), fill_inside=False, radius=1.5, spec=0.3))
    return im


# ============================================================ 팔레트 ========
FIXED = [(255, 0, 255), (0, 0, 0)] + [((i - 1) * 18,) * 3 for i in range(2, 16)] + [(240, 196, 80)]


def build_palette(sprite_px, title, backdrop):
    samples = []
    for px in sprite_px:
        for row in px:
            for c in row:
                if c is not None:
                    samples.extend([c] * 3)                     # 스프라이트 색을 더 무겁게
    for im, step, weight in ((title, 1, 2), (backdrop, 2, 1)):   # 타이틀 하늘은 색이 많이 필요하다
        p = im.load()
        for y in range(0, im.height, step):
            for x in range(0, im.width, step):
                samples.extend([p[x, y]] * weight)
    n = len(samples)
    sw = 1024
    sh = (n + sw - 1) // sw
    sim = Image.new('RGB', (sw, sh))
    sim.putdata(samples + [samples[-1]] * (sw * sh - n))
    q = sim.quantize(colors=256 - len(FIXED), method=Image.Quantize.MEDIANCUT)
    pal = q.getpalette()[:3 * (256 - len(FIXED))]
    colors = FIXED + [tuple(pal[i:i + 3]) for i in range(0, len(pal), 3)]
    while len(colors) < 256:
        colors.append((255, 0, 255))
    pimg = Image.new('P', (1, 1))
    flat = []
    for c in colors:
        flat += list(c)
    pimg.putpalette(flat)
    return colors, pimg


def map_image(im, pimg, dither):
    return im.convert('RGB').quantize(palette=pimg, dither=dither)


def flat_data(im):
    return list(im.get_flattened_data()) if hasattr(im, 'get_flattened_data') else list(im.getdata())


def map_sprite(px, pimg, w, h):
    im = Image.new('RGB', (w, h))
    im.putdata([c if c is not None else (0, 0, 0) for row in px for c in row])
    q = flat_data(map_image(im, pimg, Image.Dither.NONE))
    return [[0 if px[y][x] is None else (q[y * w + x] or 1) for x in range(w)] for y in range(h)]


# ============================================================ 묶기 ==========
def main():
    spr = load_sprites()
    entries = []                                  # (w, h, raw, px 또는 None=투명)
    for w, h in ((32, 8), (32, 16), (40, 16), (19, 7)):
        entries.append((w, h, bytes((w + 7) // 8 * h), None))
    rgb_of = {}
    for n in range(0x00, 0xAF):
        w, h, raw = spr[n]
        px = paint_sprite(n, w, h, bits_of(w, h, raw))
        if px is not None:
            entries.append((w, h, raw, px))
            rgb_of[n] = px
    for k in range(7):                            # 벽 무늬 k 를 AND 한 옆 파기 그림
        bw, bh, braw = spr[0x70 + 4 * k]
        brick = bits_of(bw, bh, braw)
        for n in range(0x67, 0x6F):
            w, h, raw = spr[n]
            orig = bits_of(w, h, raw)
            anded = [[orig[y][x] & brick[y % 8][x] for x in range(w)] for y in range(h)]
            px = crumble_px(k, orig, anded)
            entries.append((w, h, raw_of(w, h, anded), px))
            if k == 0:
                rgb_of[n] = px

    title = make_title(lambda n: rgb_of[n], spr)
    backdrop = make_backdrop()
    colors, pimg = build_palette([e[3] for e in entries if e[3] is not None], title, backdrop)

    seen, uniq = set(), []
    for w, h, raw, px in entries:
        if (w, h, raw) in seen:
            continue
        seen.add((w, h, raw))
        idx = [[0] * w for _ in range(h * 2)] if px is None else map_sprite(px, pimg, w, h * 2)
        uniq.append((w, h, raw, idx))

    out = bytearray(b'KV256S1\0')
    for i, c in enumerate(colors):
        c = (0, 0, 0) if i == 0 else c
        out += bytes(v * 63 // 255 for v in c)
    out += struct.pack('<H', len(uniq))
    for w, h, raw, idx in uniq:
        out += bytes((w, h)) + raw
        for row in idx:
            out += bytes(row)
    bd = map_image(backdrop, pimg, Image.Dither.FLOYDSTEINBERG)
    tt = map_image(title, pimg, Image.Dither.FLOYDSTEINBERG)
    out += bytes(flat_data(bd))
    out += open(os.path.join(ROOT, 'KINGS-V.IFM'), 'rb').read()
    out += bytes(flat_data(tt))
    open(os.path.join(ROOT, 'KV256.SPR'), 'wb').write(out)
    print('KV256.SPR  %d bytes, %d sprites' % (len(out), len(uniq)))

    if '--preview' in sys.argv:
        preview(sys.argv[sys.argv.index('--preview') + 1], uniq, colors, bd, tt, spr)


# ============================================================ 미리보기 =====
def preview(folder, uniq, colors, bd, tt, spr):
    flat = []
    for c in colors:
        flat += list(c)

    def rgb(idx_img):
        idx_img = idx_img.copy()
        idx_img.putpalette(flat)
        return idx_img.convert('RGB')

    key = {(w, h, raw): idx for w, h, raw, idx in uniq}
    cols = 16
    sheet = Image.new('P', (cols * 44, ((len(uniq) + cols - 1) // cols) * 36), 3)
    sp = sheet.load()
    for i, (w, h, raw, idx) in enumerate(uniq):
        ox, oy = (i % cols) * 44 + 2, (i // cols) * 36 + 2
        for y in range(h * 2):
            for x in range(w):
                sp[ox + x, oy + y] = idx[y][x] or 5
    s = rgb(sheet)
    s.resize((s.width * 2, s.height * 2), Image.NEAREST).save(os.path.join(folder, 'kv256_sheet.png'))
    rgb(tt).save(os.path.join(folder, 'kv256_title.png'))

    dat = open(os.path.join(ROOT, 'KINGS-V.DAT'), 'rb').read()

    def room_image(rec, world, stage_text):
        scr = bd.copy()
        p = scr.load()
        room = dat[rec * 550:(rec + 1) * 550]
        walls = {0x33: 0x6F + 4 * world, 0x35: 0x70 + 4 * world, 0x36: 0x71 + 4 * world, 0x37: 0x72 + 4 * world}

        def blit(n, x, y, opaque):
            w, h, raw = spr[n]
            idx = key.get((w, h, raw))
            if idx is None:
                return
            for yy in range(h * 2):
                for xx in range(w):
                    c = idx[yy][xx]
                    X, Y = x + xx, y * 2 + yy
                    if 0 <= X < 640 and 0 <= Y < 400:
                        if c:
                            p[X, Y] = c
                        elif opaque:
                            p[X, Y] = bd.getpixel((X, Y))
        start = None
        for col in range(20):
            for row in range(24):
                c = room[col * 25 + row]
                if c == 0:
                    start = (col, row)
                    continue
                n = walls.get(c, c)
                if c == 0x4C:
                    n = 0x49
                if c < 100:
                    blit(n, col * 32, row * 8, True)
        if start:
            blit(0, start[0] * 32, start[1] * 8, False)
        for i, ch in enumerate(stage_text):
            if ch != ' ':
                n = 0x8B + (ord(ch) - 0x30 if ch.isdigit() else ord(ch) - 0x61 + 10)
                blit(n, i * 20, 193, False)
        return rgb(scr)

    room_image(1, 0, 'stage 01  score 00001200  rest02').save(os.path.join(folder, 'kv256_room.png'))
    d = dat[:550]
    rec = 1
    for s_ in range(1, 11):
        rec += d[(s_ // 20) * 25 + s_ % 20]
    room_image(rec, 1, 'stage 11  score 00031200  rest03').save(os.path.join(folder, 'kv256_room11.png'))
    print('preview:', folder)


if __name__ == '__main__':
    main()
