# PKLITE 로 압축된 B.EXE 를 에뮬레이터(unicorn)로 풀어서 B_UNP.EXE 로 저장한다.
# 서로 다른 두 세그먼트에 올려 풀고 결과를 비교해서 재배치 위치를 찾는다.
import struct, sys
from unicorn import *
from unicorn.x86_const import *

src = open(sys.argv[1] if len(sys.argv) > 1 else 'B.EXE', 'rb').read()
hdr = struct.unpack('<14H', src[:28])
cblp, cp, crlc, cparhdr, minalloc, maxalloc, ss, sp, csum, ip, cs, lfarlc, ovno = hdr[1:]
size = (cp - 1) * 512 + (cblp or 512)
img = src[cparhdr * 16:size]

def run(psp):
    mu = Uc(UC_ARCH_X86, UC_MODE_16)
    mu.mem_map(0, 0x110000)
    base = psp + 0x10
    psp_b = bytearray(256); psp_b[0] = 0xCD; psp_b[1] = 0x20
    struct.pack_into('<H', psp_b, 2, 0x9FFF)
    mu.mem_write(psp * 16, bytes(psp_b))
    mu.mem_write(base * 16, img)
    for i in range(crlc):
        o, s = struct.unpack_from('<HH', src, lfarlc + i * 4)
        a = ((s + base) * 16 + o)
        v = struct.unpack('<H', mu.mem_read(a, 2))[0]
        mu.mem_write(a, struct.pack('<H', (v + base) & 0xFFFF))
    mu.reg_write(UC_X86_REG_CS, (cs + base) & 0xFFFF); mu.reg_write(UC_X86_REG_IP, ip)
    mu.reg_write(UC_X86_REG_SS, (ss + base) & 0xFFFF); mu.reg_write(UC_X86_REG_SP, sp)
    mu.reg_write(UC_X86_REG_DS, psp); mu.reg_write(UC_X86_REG_ES, psp)
    # 압축 풀기 코드는 CS 를 두 번 바꾼다 (PSP 기준 -> 위로 복사한 곳).
    # 세 번째로 CS 가 바뀌는 곳이 원래 프로그램의 시작점이다.
    state = {'cs': None, 'n': 0, 'done': None}
    def hook(uc, addr, sz, _):
        c = uc.reg_read(UC_X86_REG_CS)
        if c != state['cs']:
            state['cs'] = c; state['n'] += 1
            if state['n'] == 2: state['stub'] = c
            if state['n'] == 3:
                state['done'] = (c, uc.reg_read(UC_X86_REG_IP),
                                 uc.reg_read(UC_X86_REG_SS), uc.reg_read(UC_X86_REG_SP))
                uc.emu_stop()
    def intr(uc, no, _):
        print('int', hex(no), hex(uc.reg_read(UC_X86_REG_AX))); uc.emu_stop()
    mu.hook_add(UC_HOOK_CODE, hook)
    mu.hook_add(UC_HOOK_INTR, intr)
    mu.emu_start((cs + base) * 16 + ip, 0x200000, count=200000000)
    return mu, state['done'] + (state['stub'],), base

A, da, ba = run(0x1000)
B, db, bb = run(0x2345)
print('entry A', [hex(x) for x in da])
cs0, ip0, ss0, sp0, stub_cs = da
# 풀린 이미지 크기: 로드 영역에서 끝까지 비교
N = 0x60000
ma = bytes(A.mem_read(ba * 16, N)); mb = bytes(B.mem_read(bb * 16, N))
delta = bb - ba
relocs = []
diffs = [i for i in range(N) if ma[i] != mb[i]]
i = 0; ds = set(diffs)
k = 0
while k < len(diffs):
    p = diffs[k]
    va = struct.unpack_from('<H', ma, p)[0]; vb = struct.unpack_from('<H', mb, p)[0]
    if (vb - va) & 0xFFFF == delta:
        relocs.append(p); k += 1
        if k < len(diffs) and diffs[k] == p + 1: k += 1
    else:
        print('unexplained diff at', hex(p)); k += 1
# 이미지 끝: 마지막 0 아닌 바이트 (decompressor가 남긴 것 제외 어렵다 -> 원래 minalloc 으로)
# 압축 풀기 코드가 옮겨 간 곳(두 번째 CS) 앞까지가 프로그램 이미지다
end = N
while end > 0 and ma[end - 1] == 0: end -= 1
end = min(end, (stub_cs - ba) * 16)
while end > 0 and ma[end - 1] == 0: end -= 1
relocs = [p for p in relocs if p + 2 <= end]
minalloc = ((((ss0 - ba) & 0xFFFF) * 16 + 0x10000) - end + 15) // 16
print('image end', hex(end), 'relocs', len(relocs))
imgout = bytearray(ma[:end])
for p in relocs:
    v = struct.unpack_from('<H', imgout, p)[0]
    struct.pack_into('<H', imgout, p, (v - ba) & 0xFFFF)
rel = b''.join(struct.pack('<HH', p - ((p >> 4) << 4) , p >> 4) for p in relocs)
hsize = 28 + len(rel); hsize = (hsize + 511) // 512 * 512
total = hsize + len(imgout)
out = bytearray(hsize)
struct.pack_into('<14H', out, 0, 0x5A4D, total % 512, (total + 511) // 512, len(relocs), hsize // 16,
                 minalloc, maxalloc, (ss0 - ba) & 0xFFFF, sp0, 0, ip0, (cs0 - ba) & 0xFFFF, 28, 0)
out[28:28 + len(rel)] = rel
open('B_UNP.EXE', 'wb').write(bytes(out) + bytes(imgout))
open('B_UNP.BIN', 'wb').write(bytes(imgout))
print('cs:ip %04x:%04x ss:sp %04x:%04x' % ((cs0 - ba) & 0xFFFF, ip0, (ss0 - ba) & 0xFFFF, sp0))
