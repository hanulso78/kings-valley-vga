# -*- coding: utf-8 -*-
"""KVVGA.EXE 배경음악 - 애드립(OPL2) VGM 곡을 새로 만들어 SOUND.DAT 하나로 묶는다.

   쓰는 법 :  python tools/mkmusic.py [만들 폴더] [--vgm]   (기본: kv 폴더)
              --vgm 을 주면 묶기 전의 VGM 파일도 따로 남긴다 (들어 보기용)

   SOUND.DAT 구조 (korea 판과 같은 틀, 표시만 다르다)
       0..7    "KVSND10" + 0
       8..9    곡 수
       10..    곡마다 20바이트  이름 12 / 시작 위치 4 / 길이 4
       그 뒤   VGM 자료

       KVTITLE.VGM  타이틀/메뉴   느리고 장엄한 피라미드 주제 (되풀이)
       KVGAME.VGM   게임 중       마크숨 리듬 + 가락 + 우드풍 분산화음 (되풀이)
       KVBEAT.VGM   게임 중 F3    타악기와 베이스만 (되풀이) - 원판의 "똑딱" 자리
       KVCLEAR.VGM  스테이지 깸   히자즈 음계로 오르는 팡파르
       KVDIE.VGM    죽음          내려앉는 가락
       KVOVER.VGM   게임 끝       느린 마침

   모두 여기서 새로 지은 곡이다.  음계는 D 히자즈 (D Eb F# G A Bb C) -
   중동/이집트 느낌을 내는 프리지안 도미넌트.
   OPL2 리듬 모드: 가락 채널 0..5 + 베이스드럼/스네어/하이햇/탐/심벌.
       0 가락(피리)   1 가락 겹침   2 베이스   3..5 코드/우드풍 뜯기
"""
import os, struct, sys

SR = 44100

# ---------------------------------------------------------------- 음색 ------
# (모듈레이터 20 40 60 80 E0), (캐리어 20 40 60 80 E0), C0
P_LEAD   = ((0x21, 0x15, 0xF4, 0x35, 0x00), (0x21, 0x02, 0xF2, 0x15, 0x00), 0x0C)
P_LEAD2  = ((0x21, 0x18, 0xF4, 0x35, 0x00), (0x21, 0x0A, 0xF2, 0x15, 0x00), 0x0C)
P_BASS   = ((0x20, 0x1D, 0xB4, 0x0F, 0x00), (0x21, 0x00, 0xC3, 0x0F, 0x00), 0x3E)
P_STAB   = ((0x22, 0x1E, 0xF3, 0x16, 0x00), (0x21, 0x10, 0xF3, 0x16, 0x00), 0x01)
P_PLUCK  = ((0x01, 0x1B, 0xF6, 0x56, 0x00), (0x01, 0x06, 0xF4, 0x57, 0x00), 0x0A)
P_PAD    = ((0x21, 0x22, 0x74, 0x24, 0x00), (0x21, 0x0C, 0x63, 0x25, 0x00), 0x0C)
# 리듬부
P_BD     = ((0x00, 0x07, 0xD8, 0x0F, 0x00), (0x00, 0x00, 0xF5, 0x0F, 0x00), 0x38)
P_HH_SD  = ((0x01, 0x0C, 0xF8, 0x0F, 0x00), (0x01, 0x04, 0xF7, 0x0F, 0x00), 0x39)
P_TOM_CY = ((0x04, 0x05, 0xF7, 0x0F, 0x00), (0x0E, 0x0C, 0xC9, 0x0F, 0x00), 0x3D)

BD, SD, TOM, CYM, HH = 0x10, 0x08, 0x04, 0x02, 0x01

OP1 = [0x00, 0x01, 0x02, 0x08, 0x09, 0x0A, 0x10, 0x11, 0x12]
OP2 = [0x03, 0x04, 0x05, 0x0B, 0x0C, 0x0D, 0x13, 0x14, 0x15]

def fnum_block(midi):
    f = 440.0 * 2.0 ** ((midi - 69) / 12.0)
    for blk in range(8):
        fn = int(round(f * (1 << (20 - blk)) / 49716.0))
        if fn < 1024 and (fn >= 300 or blk == 7):
            return fn, blk
    return 1023, 7

NAMES = {'C': 0, 'D': 2, 'E': 4, 'F': 5, 'G': 7, 'A': 9, 'B': 11}

def midi(name):
    k = NAMES[name[0]]
    i = 1
    while i < len(name) and name[i] in '#b':
        k += 1 if name[i] == '#' else -1
        i += 1
    return (int(name[i:]) + 1) * 12 + k

def seq(text):
    """'E5/4 B4/2 r/2 ...' -> [(시작, 길이, midi 또는 None)]  단위 16분음표"""
    out, t = [], 0
    for tok in text.split():
        name, ln = tok.split('/')
        ln = int(ln)
        out.append((t, ln, None if name == 'r' else midi(name)))
        t += ln
    return out, t

# ---------------------------------------------------------------- 악보 틀 ---
class Song:
    def __init__(self, bpm):
        self.tick_samples = SR * 60.0 / bpm / 4          # 16분음표 한 칸
        self.ev = []                                     # (칸, 순서, 종류, 값...)
        self.loop_tick = None
        self.end_tick = 0

    def patch(self, t, ch, p):
        self.ev.append((t, 0, 'patch', ch, p))

    def note(self, t, ln, ch, m, gap=0.12, shift=0):
        if m is None:
            return
        self.ev.append((t, 2, 'on', ch, m + shift))
        self.ev.append((t + ln - min(gap, ln * 0.5), 1, 'off', ch, 0))
        self.end_tick = max(self.end_tick, t + ln)

    def melody(self, t, text, ch, shift=0, gap=0.12):
        notes, total = seq(text)
        for st, ln, m in notes:
            self.note(t + st, ln, ch, m, gap, shift)
        return total

    def drum(self, t, mask):
        self.ev.append((t, 3, 'drum', mask, 0))
        self.end_tick = max(self.end_tick, t + 1)

    def tom_pitch(self, t, m):
        self.ev.append((t, 0, 'tompitch', 8, m))

    def level(self, t, ch, tl):
        self.ev.append((t, 0, 'level', ch, tl))

class Writer:
    def __init__(self):
        self.d = bytearray()
        self.samples = 0

    def w(self, reg, val):
        self.d += bytes((0x5A, reg & 0xFF, val & 0xFF))

    def wait_until(self, s):
        n = int(round(s)) - self.samples
        if n <= 0:
            return
        self.samples += n
        while n > 65535:
            self.d += bytes((0x61, 0xFF, 0xFF))
            n -= 65535
        self.d += bytes((0x61, n & 0xFF, n >> 8))

    def patch(self, ch, p):
        mod, car, c0 = p
        for r, v in zip((0x20, 0x40, 0x60, 0x80, 0xE0), mod):
            self.w(r + OP1[ch], v)
        if car:
            for r, v in zip((0x20, 0x40, 0x60, 0x80, 0xE0), car):
                self.w(r + OP2[ch], v)
        self.w(0xC0 + ch, c0)

def render(song, name, effect=False):
    """effect=True 면 효과음: 리듬부/전체 설정을 건드리지 않고 쓴 채널만 끈다
       (곡이 울리는 중에 겹쳐 틀기 때문)"""
    v = Writer()
    rhythm = 0x20
    if not effect:
        v.w(0x01, 0x20)
        v.w(0x08, 0x00)
        v.patch(6, P_BD)
        v.patch(7, P_HH_SD)
        v.patch(8, P_TOM_CY)
        for ch, m in ((6, 36), (7, 60), (8, 50)):
            fn, blk = fnum_block(m)
            v.w(0xA0 + ch, fn & 0xFF)
            v.w(0xB0 + ch, blk << 2 | fn >> 8)
        v.w(0xBD, rhythm)

    events = sorted(song.ev, key=lambda e: (e[0], e[1]))
    loop_offset = None
    carrier_patch = {}
    i = 0
    while i < len(events):
        t = events[i][0]
        if song.loop_tick is not None and loop_offset is None and t >= song.loop_tick:
            v.wait_until(song.loop_tick * song.tick_samples)
            loop_offset = len(v.d)
        v.wait_until(t * song.tick_samples)
        mask = 0
        while i < len(events) and events[i][0] == t:
            e = events[i]
            kind = e[2]
            if kind == 'patch':
                v.patch(e[3], e[4])
                carrier_patch[e[3]] = e[4]
            elif kind == 'on':
                fn, blk = fnum_block(e[4])
                v.w(0xB0 + e[3], blk << 2 | fn >> 8)          # 먼저 키 오프
                v.w(0xA0 + e[3], fn & 0xFF)
                v.w(0xB0 + e[3], 0x20 | blk << 2 | fn >> 8)
            elif kind == 'off':
                v.w(0xB0 + e[3], 0x00)
            elif kind == 'drum':
                mask |= e[3]
            elif kind == 'tompitch':
                fn, blk = fnum_block(e[4])
                v.w(0xA8, fn & 0xFF)
                v.w(0xB8, blk << 2 | fn >> 8)
            elif kind == 'level':
                ch, tl = e[3], e[4]
                v.w(0x40 + OP2[ch], tl)
            i += 1
        if mask:
            v.w(0xBD, rhythm & ~mask)
            v.w(0xBD, rhythm | mask)

    v.wait_until(song.end_tick * song.tick_samples)
    used = sorted({e[3] for e in song.ev if e[2] == 'on'}) if effect else range(9)
    for ch in used:
        v.w(0xB0 + ch, 0x00)
    v.d += b'\x66'

    DATA = 0x100
    hdr = bytearray(DATA)
    hdr[0:4] = b'Vgm '
    struct.pack_into('<I', hdr, 0x04, DATA + len(v.d) - 4)
    struct.pack_into('<I', hdr, 0x08, 0x151)
    struct.pack_into('<I', hdr, 0x18, v.samples)
    if loop_offset is not None:
        struct.pack_into('<I', hdr, 0x1C, DATA + loop_offset - 0x1C)
        struct.pack_into('<I', hdr, 0x20, v.samples - int(round(song.loop_tick * song.tick_samples)))
    struct.pack_into('<I', hdr, 0x34, DATA - 0x34)
    struct.pack_into('<I', hdr, 0x50, 3579545)                 # YM3812 클럭
    print('%-11s %6d 바이트  %5.1f초%s' % (name, DATA + len(v.d),
          v.samples / SR, '  (되풀이)' if loop_offset is not None else ''))
    return name, bytes(hdr) + bytes(v.d)

def bundle(path, songs):
    """(이름, VGM 자료) 목록 -> SOUND.DAT"""
    head = bytearray(b'KVSND10\0')
    head += struct.pack('<H', len(songs))
    off = len(head) + 20 * len(songs)
    body = bytearray()
    for name, data in songs:
        head += name.encode('ascii').ljust(12, b'\0')[:12]
        head += struct.pack('<II', off + len(body), len(data))
        body += data
    with open(path, 'wb') as f:
        f.write(bytes(head) + bytes(body))
    print('%s  %d 바이트, %d 곡' % (os.path.basename(path), len(head) + len(body), len(songs)))

# ---------------------------------------------------------------- 음색 더하기 --
# 갈대 피리(네이) 느낌: 숨소리 섞인 부드러운 가락
P_NEY    = ((0x61, 0x22, 0x74, 0x16, 0x00), (0x21, 0x00, 0x63, 0x16, 0x00), 0x08)
# 우드(oud) 뜯기: 줄을 튕기는 빠른 감쇠
P_OUD    = ((0x03, 0x19, 0xF5, 0x46, 0x00), (0x01, 0x04, 0xF3, 0x47, 0x00), 0x0A)
# 금관 팡파르
P_BRASS  = ((0x21, 0x16, 0x86, 0x16, 0x00), (0x21, 0x00, 0x74, 0x17, 0x00), 0x0E)

# ---------------------------------------------------------------- 도움 함수 --
CHORDS = {
    'D':  ('D4', 'F#4', 'A4'),
    'Gm': ('G3', 'Bb3', 'D4'),
    'Cm': ('C4', 'Eb4', 'G4'),
    'Eb': ('Eb4', 'G4', 'Bb4'),
    'Bb': ('Bb3', 'D4', 'F4'),
}
ROOT = {'D': 'D2', 'Gm': 'G2', 'Cm': 'C2', 'Eb': 'Eb2', 'Bb': 'Bb1'}


def put_lines(s, t, lines, ch, shift=0, gap=0.12):
    for b, line in enumerate(lines):
        s.melody(t + b * 16, line, ch, shift, gap)


def maqsum(s, t, bars, fill=True, light=False):
    """이집트 마크숨 리듬: 둠 - 텍 - - 텍 - 둠 - - - 텍 - - 텍(16분 칸)"""
    for b in range(bars):
        o = t + b * 16
        s.drum(o, BD | (CYM if b == 0 and not light else 0))
        s.drum(o + 2, SD)
        s.drum(o + 6, SD)
        s.drum(o + 8, BD)
        s.drum(o + 12, SD)
        if not light:
            s.drum(o + 14, SD)
            for k in (4, 10):
                s.drum(o + k, HH)
        last = fill and b % 4 == 3
        if last:
            for k, m in zip((9, 11, 13, 15), (50, 47, 45, 43)):
                s.tom_pitch(o + k, m)
                s.drum(o + k, TOM)


def bass_groove(s, t, chords, ch=2):
    """근음 - 근음 - 5도 - 근음 - 반음 위 - 근음 (히자즈 베이스)"""
    for b, name in enumerate(chords):
        r = midi(ROOT[name])
        for st, ln, off in ((0, 3, 0), (3, 3, 0), (6, 2, 7), (8, 2, 0), (10, 2, 1), (12, 4, 0)):
            s.note(t + b * 16 + st, ln, ch, r + off, gap=0.3)


def oud_arp(s, t, chords, up=0):
    order = [0, 1, 2, 1, 0, 2, 1, 2, 0, 1, 2, 3, 2, 1, 2, 1]
    for b, name in enumerate(chords):
        tones = [midi(n) + up for n in CHORDS[name]]
        tones.append(tones[0] + 12)
        for k in range(16):
            if k % 2 == 0 or k in (11, 13, 15):
                s.note(t + b * 16 + k, 1, 3 + (k % 3), tones[order[k]], gap=0.0)


def pads(s, t, chords, ln=16):
    for b, name in enumerate(chords):
        for v, n in enumerate(CHORDS[name]):
            s.note(t + b * ln, ln, 3 + v, midi(n), gap=0.4)


# ---------------------------------------------------------------- 가락 ------
THEME_A = [
    "D5/2 Eb5/2 F#5/4 G5/2 F#5/2 Eb5/4",
    "D5/4 C5/2 Bb4/2 A4/8",
    "Bb4/2 C5/2 D5/4 Eb5/2 D5/2 C5/4",
    "Bb4/4 A4/2 G4/2 A4/8",
    "D5/2 Eb5/2 F#5/4 A5/4 G5/2 F#5/2",
    "G5/4 F#5/2 Eb5/2 D5/8",
    "C5/2 Bb4/2 A4/2 Bb4/2 C5/4 Eb5/4",
    "D5/12 r/4",
]
CHORDS_A = ['D', 'D', 'Gm', 'D', 'D', 'Gm', 'Cm', 'D']

THEME_B = [
    "A5/2 A5/2 Bb5/2 A5/2 G5/4 F#5/4",
    "G5/2 G5/2 A5/2 G5/2 F#5/4 Eb5/4",
    "F#5/2 G5/2 F#5/2 Eb5/2 D5/4 C5/4",
    "D5/8 A4/8",
    "Bb4/2 C5/2 D5/2 Eb5/2 F#5/4 G5/4",
    "A5/4 G5/2 F#5/2 Eb5/4 D5/4",
    "Eb5/2 D5/2 C5/2 Bb4/2 A4/4 Bb4/2 C5/2",
    "D5/12 r/4",
]
CHORDS_B = ['D', 'Cm', 'D', 'D', 'Gm', 'D', 'Cm', 'D']

TITLE = [
    "D5/8 Eb5/4 F#5/4",
    "G5/6 F#5/2 Eb5/8",
    "D5/4 C5/4 Bb4/4 C5/4",
    "D5/16",
    "A5/8 G5/4 F#5/4",
    "G5/6 A5/2 Bb5/8",
    "A5/4 G5/4 F#5/4 Eb5/4",
    "D5/16",
]
CHORDS_T = ['D', 'Cm', 'Gm', 'D', 'D', 'Gm', 'Cm', 'D']


# ---------------------------------------------------------------- 곡 --------
def song_game():
    s = Song(138)
    s.patch(0, 0, P_NEY)
    s.patch(0, 1, P_LEAD2)
    s.patch(0, 2, P_BASS)
    for ch in (3, 4, 5):
        s.patch(0, ch, P_OUD)
    # 들어가기 2마디: 베이스와 리듬만
    bass_groove(s, 0, ['D', 'D'])
    maqsum(s, 0, 2, fill=False, light=True)
    t = 32
    s.loop_tick = t
    # A: 피리 가락 + 우드 뜯기
    put_lines(s, t, THEME_A, 0)
    oud_arp(s, t, CHORDS_A)
    bass_groove(s, t, CHORDS_A)
    maqsum(s, t, 8)
    t += 8 * 16
    # B: 높은 가락, 겹침 한 옥타브 아래
    put_lines(s, t, THEME_B, 0)
    put_lines(s, t, THEME_B, 1, shift=-12)
    oud_arp(s, t, CHORDS_B)
    bass_groove(s, t, CHORDS_B)
    maqsum(s, t, 8)
    t += 8 * 16
    # A': 가락을 옥타브로 겹치고 우드도 한 옥타브 위
    put_lines(s, t, THEME_A, 0, shift=12)
    put_lines(s, t, THEME_A, 1)
    oud_arp(s, t, CHORDS_A, up=12)
    bass_groove(s, t, CHORDS_A)
    maqsum(s, t, 8)
    t += 8 * 16
    # B': 우드가 가락을 뜯고 피리는 쉰다 -> 마지막 마디에서 모인다
    put_lines(s, t, THEME_B, 3, shift=-12, gap=0.05)
    put_lines(s, t, THEME_B, 1)
    bass_groove(s, t, CHORDS_B)
    maqsum(s, t, 8)
    t += 8 * 16
    s.end_tick = t
    return s


def song_beat():
    s = Song(138)
    s.patch(0, 2, P_BASS)
    s.loop_tick = 0
    bass_groove(s, 0, CHORDS_A)
    maqsum(s, 0, 8)
    s.end_tick = 8 * 16
    return s


def song_title():
    s = Song(76)
    s.patch(0, 0, P_NEY)
    s.patch(0, 1, P_LEAD2)
    s.patch(0, 2, P_BASS)
    for ch in (3, 4, 5):
        s.patch(0, ch, P_PAD)
    t = 0
    s.loop_tick = 0
    for rep in range(2):
        put_lines(s, t, TITLE, 0)
        if rep:
            put_lines(s, t, TITLE, 1, shift=-12)
        pads(s, t, CHORDS_T)
        for b, name in enumerate(CHORDS_T):
            s.note(t + b * 16, 8, 2, midi(ROOT[name]), gap=0.3)
            s.note(t + b * 16 + 8, 8, 2, midi(ROOT[name]) + 12 if b % 2 else midi(ROOT[name]), gap=0.3)
            s.tom_pitch(t + b * 16, 38)
            s.drum(t + b * 16, BD | TOM | (CYM if b % 4 == 0 else 0))
            s.drum(t + b * 16 + 8, TOM)
            if rep:
                s.drum(t + b * 16 + 12, SD)
                s.drum(t + b * 16 + 14, SD)
        t += 8 * 16
    s.end_tick = t
    return s


def song_clear():
    s = Song(150)
    s.patch(0, 0, P_BRASS)
    s.patch(0, 1, P_BRASS)
    s.patch(0, 2, P_BASS)
    for ch in (3, 4, 5):
        s.patch(0, ch, P_STAB)
    run = "D5/1 Eb5/1 F#5/1 G5/1 A5/1 Bb5/1 C6/1 D6/1 A5/2 F#5/2 D6/12"
    s.melody(0, run, 0, gap=0.05)
    s.melody(0, run, 1, shift=-12, gap=0.05)
    for v, n in enumerate(CHORDS['D']):
        s.note(12, 12, 3 + v, midi(n) + 12, gap=0.3)
    s.note(0, 8, 2, midi('D2'))
    s.note(8, 4, 2, midi('A2'))
    s.note(12, 12, 2, midi('D2'))
    for k in range(0, 8):
        s.drum(k, SD)
    s.drum(8, BD)
    s.drum(10, BD)
    s.drum(12, BD | CYM)
    s.end_tick = 24
    return s


def song_die():
    s = Song(96)
    s.patch(0, 0, P_NEY)
    s.patch(0, 2, P_BASS)
    for ch in (3, 4, 5):
        s.patch(0, ch, P_PAD)
    s.melody(0, "C5/2 Bb4/2 A4/2 G4/2 F#4/2 Eb4/2 D4/12", 0, gap=0.2)
    pads(s, 0, ['Gm'], ln=8)
    pads(s, 8, ['D'], ln=16)
    s.note(0, 8, 2, midi('G2'))
    s.note(8, 16, 2, midi('D2'))
    s.tom_pitch(0, 40)
    s.drum(0, TOM)
    s.drum(8, BD | TOM)
    s.end_tick = 24
    return s


def song_over():
    s = Song(60)
    s.patch(0, 0, P_NEY)
    s.patch(0, 2, P_BASS)
    for ch in (3, 4, 5):
        s.patch(0, ch, P_PAD)
    s.melody(0, "D5/4 C5/4 Bb4/4 A4/4 G4/6 A4/2 D4/12 r/4", 0, gap=0.25)
    pads(s, 0, ['Gm', 'Cm'], ln=8)
    pads(s, 16, ['D'], ln=20)
    for st, ln, r in ((0, 8, 'G2'), (8, 8, 'C2'), (16, 20, 'D2')):
        s.note(st, ln, 2, midi(r), gap=0.3)
    s.drum(0, BD | CYM)
    s.drum(16, BD | TOM)
    s.end_tick = 40
    return s


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    out = args[0] if args else os.path.join(here, '..')
    songs = [render(song_title(), 'KVTITLE.VGM'),
             render(song_game(),  'KVGAME.VGM'),
             render(song_beat(),  'KVBEAT.VGM'),
             render(song_clear(), 'KVCLEAR.VGM'),
             render(song_die(),   'KVDIE.VGM'),
             render(song_over(),  'KVOVER.VGM')]
    bundle(os.path.join(out, 'SOUND.DAT'), songs)
    if '--vgm' in sys.argv:
        for name, data in songs:
            with open(os.path.join(out, name), 'wb') as f:
                f.write(data)


if __name__ == '__main__':
    main()

