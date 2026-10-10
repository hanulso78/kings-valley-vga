# B_UNP.BIN 의 데이터 세그먼트(DS=1161) typed const 에서 data.c 를 만든다.
#   python tools/mkdata.py > data.c
import struct, sys

D = open('B_UNP.BIN', 'rb').read()
DS = 0x11610


def ds(off, n):
    return D[DS + off: DS + off + n]


def bytes_c(buf, indent='    ', per=16):
    out = []
    for i in range(0, len(buf), per):
        out.append(indent + ','.join('0x%02X' % b for b in buf[i:i + per]) + ',')
    return '\n'.join(out)


def notes_c(off, count):
    lines = []
    row = []
    for i in range(count):
        f, n = struct.unpack_from('<HH', ds(off + i * 4, 4))
        row.append('{%4d,%2d}' % (f, n & 0xFF))
        if len(row) == 8:
            lines.append('    ' + ','.join(row) + ',')
            row = []
    if row:
        lines.append('    ' + ','.join(row) + ',')
    return '\n'.join(lines)


sys.stdout.reconfigure(encoding='utf-8', newline='\n')
w = sys.stdout.write
w('''/* ============================================================================
 *  data.c  -  원본 데이터 세그먼트(DS)의 typed const 초기값
 * ----------------------------------------------------------------------------
 *  tools/mkdata.py 가 B_UNP.EXE 에서 뽑아 만든 파일이다.  고치지 말 것.
 *  괄호 안은 원본 DS 오프셋.
 * ========================================================================== */
#include "kv.h"

''')

w('/* 배경음악 악보 (DS:0000)  {주파수 Hz, 틱 수} x 136 = 711 틱 */\n')
w('const struct note music_score[MUSIC_NOTES] = {\n%s\n};\n\n' % notes_c(0x0000, 0x88))

w('/* 음악을 끈 뒤의 똑딱 박자 (DS:0220)  {주파수, 틱 수} x 18 = 32 틱 */\n')
w('const struct note beat_score[BEAT_NOTES] = {\n%s\n};\n\n' % notes_c(0x0220, 0x12))

w('/* 편집기 타일 목록 (DS:0268, 원래 [1..21]) */\n')
w('const unsigned char editor_tiles[EDITOR_TILES + 1] = {\n    0,\n%s\n};\n\n'
  % bytes_c(ds(0x0268, 21)))

w('/* 스프라이트 비트맵 (DS:027E, 8436 바이트)\n'
  ' *  sprite 0x00..0x32 32x16, 0x33..0x40 32x8, 0x41..0x48 40x16,\n'
  ' *         0x49..0x6E 32x16, 0x6F..0x8A 32x8,  0x8B..0xAE 19x7 (글꼴) */\n')
w('const unsigned char sprite_bits[SPRITE_BITS_SIZE] = {\n%s\n};\n\n'
  % bytes_c(ds(0x027E, 8436)))

w('/* 1비트 PCM - 곡괭이로 옆 벽 파는 소리 (DS:2372, 원래 [1..90]) */\n')
w('const unsigned char pcm_dig[PCM_DIG_SIZE] = {\n%s\n};\n\n' % bytes_c(ds(0x2372, 90)))

w('/* 1비트 PCM - 죽을 때 소리 (DS:2426, 원래 [1..304]) */\n')
w('const unsigned char pcm_die[PCM_DIE_SIZE] = {\n%s\n};\n\n' % bytes_c(ds(0x2426, 304)))

w('/* 1비트 PCM - 단검에 맞은 미라 비명 (DS:2556, 원래 [1..391]) */\n')
w('const unsigned char pcm_scream[PCM_SCREAM_SIZE] = {\n%s\n};\n' % bytes_c(ds(0x2556, 391)))
