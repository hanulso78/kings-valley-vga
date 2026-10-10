# 데이터 세그먼트(DS=1161) 내용 보기:  python tools/ds.py 오프셋(16진) [길이(16진)] [b|w|s]
#   b = 바이트 hex (기본), w = 워드(16비트, 부호있는 10진도 같이), s = 파스칼 문자열
import sys, struct
d = open('B_UNP.BIN', 'rb').read()
base = 0x11610
off = int(sys.argv[1], 16); n = int(sys.argv[2], 16) if len(sys.argv) > 2 else 0x40
mode = sys.argv[3] if len(sys.argv) > 3 else 'b'
buf = d[base + off: base + off + n]
buf += bytes(n - len(buf))
if mode == 'w':
    for i in range(0, n - 1, 2):
        v = struct.unpack_from('<H', buf, i)[0]
        print('%04x: %04x %6d' % (off + i, v, v - 65536 if v >= 32768 else v))
elif mode == 's':
    L = buf[0]; print('%04x: len %d %r' % (off, L, buf[1:1 + L]))
else:
    for i in range(0, n, 16):
        print('%04x: %s' % (off + i, ' '.join('%02x' % c for c in buf[i:i + 16])))
