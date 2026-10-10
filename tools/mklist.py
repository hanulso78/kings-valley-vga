# B_UNP.EXE (B.EXE 를 unpklite.py 로 푼 것) 역어셈블 목록 만들기
#   python tools/mklist.py > listing.asm
# 터보 파스칼 프로그램: 세그먼트 = 유닛 하나.  call 대상에서 시작해 흐름을 따라가며
# 코드를 찾고, 나머지는 데이터(문자열 상수 등)로 찍는다.
import struct, sys, re, collections
from capstone import *
from capstone.x86 import *

E = open('B_UNP.EXE', 'rb').read()
H = struct.unpack('<14H', E[:28])
IMG = E[H[4] * 16:]
RELOC = set()
for i in range(H[3]):
    o, s = struct.unpack_from('<HH', E, 28 + 4 * i)
    RELOC.add(s * 16 + o)

SEGS = [(0x0000, 'MAIN'), (0x0777, 'EDITOR'), (0x08e2, 'GAMELIB'), (0x0c93, 'GRAPH'),
        (0x0fd3, 'DOS'), (0x0fdd, 'CRT'), (0x103f, 'SYSTEM'), (0x1161, 'DATA')]
SEGBASE = [s for s, _ in SEGS]
DS = 0x1161

NAMES = {}
def load_names():
    try:
        for ln in open('tools/names.txt', encoding='utf-8'):
            ln = ln.split('#')[0].strip()
            if not ln: continue
            a, n = ln.split(None, 1)
            if ':' in a:
                s, o = a.split(':'); NAMES[(int(s, 16), int(o, 16))] = n.strip()
            else:
                NAMES[('ds', int(a, 16))] = n.strip()
    except FileNotFoundError:
        pass
load_names()

def segend(seg):
    i = SEGBASE.index(seg)
    return SEGBASE[i + 1] * 16 if i + 1 < len(SEGBASE) else len(IMG)

md = Cs(CS_ARCH_X86, CS_MODE_16)
md.detail = True

def seg_name(seg): return dict(SEGS)[seg]
def lab(seg, off):
    n = NAMES.get((seg, off))
    return n if n else 'sub_%04x_%04x' % (seg, off)

# ---- 코드 찾기 ---------------------------------------------------------------
entries = collections.defaultdict(set)    # seg -> 함수 시작
entries[0].add(H[10])
for p in RELOC:
    if p >= 3 and IMG[p - 3] == 0x9A:
        s = struct.unpack_from('<H', IMG, p)[0]; o = struct.unpack_from('<H', IMG, p - 2)[0]
        entries[s].add(o)
for (s, o) in list(NAMES):
    if s != 'ds' and s != 0x1161: entries[s].add(o)

code = {}          # 선형주소 -> insn
labels = set()     # 선형주소 (분기 대상)
funcs = {}         # 선형주소 -> (seg, off)
todo = []
for s in entries:
    for o in entries[s]:
        todo.append((s, o, True))
extra_refs = []
while todo:
    s, o, isfunc = todo.pop()
    lin = s * 16 + o
    if isfunc: funcs[lin] = (s, o)
    else: labels.add(lin)
    work = [o]
    while work:
        off = work.pop()
        while True:
            a = s * 16 + off
            if a in code or a >= segend(s): break
            ins = next(md.disasm(IMG[a:a + 16], off), None)
            if ins is None: break
            code[a] = ins
            m = ins.mnemonic
            nxt = off + ins.size
            if m == 'call' and ins.bytes[0] == 0xE8:
                t = ins.operands[0].imm & 0xFFFF
                if s * 16 + t not in funcs: todo.append((s, t, True))
            elif m == 'lcall' and ins.bytes[0] == 0x9A:
                pass
            elif m == 'jmp' and ins.bytes[0] in (0xE9, 0xEB):
                t = ins.operands[0].imm & 0xFFFF
                labels.add(s * 16 + t); work.append(t); break
            elif m.startswith('j') or m in ('loop', 'loope', 'loopne', 'jcxz'):
                if ins.operands and ins.operands[0].type == X86_OP_IMM:
                    t = ins.operands[0].imm & 0xFFFF
                    labels.add(s * 16 + t); work.append(t)
                if m in ('jmp', 'ljmp'): break
            elif m in ('ret', 'retf', 'iret', 'hlt'):
                break
            off = nxt

# ---- 이름/주석 -----------------------------------------------------------------
def ds_name(v):
    n = NAMES.get(('ds', v))
    return n

def pstring_at(lin, maxlen=255):
    L = IMG[lin]
    if L == 0 or L > maxlen or lin + 1 + L > len(IMG): return None
    t = IMG[lin + 1: lin + 1 + L]
    if all(32 <= c < 127 for c in t): return t.decode()
    return None

def comment(seg, ins):
    a = seg * 16 + ins.address
    out = []
    # far call
    if ins.bytes[0] == 0x9A:
        s = struct.unpack_from('<H', IMG, a + 3)[0]; o = struct.unpack_from('<H', IMG, a + 1)[0]
        return 'call   %s' % lab(s, o), None
    if ins.bytes[0] == 0xE8:
        t = ins.operands[0].imm & 0xFFFF
        return 'call   %s' % lab(seg, t), None
    txt = '%-6s %s' % (ins.mnemonic, ins.op_str)
    # DS 메모리 참조
    for op in ins.operands:
        if op.type == X86_OP_MEM and op.mem.base == 0 and op.mem.index == 0 and op.mem.segment in (0, X86_REG_DS):
            n = ds_name(op.mem.disp & 0xFFFF)
            if n: out.append(n)
        elif op.type == X86_OP_MEM and op.mem.segment in (0, X86_REG_DS) and op.mem.base in (X86_REG_BX, X86_REG_DI, X86_REG_SI) and op.mem.disp:
            d = op.mem.disp & 0xFFFF
            if d >= 0x100 or d < 0:
                d &= 0xFFFF
                n = ds_name(d)
                if n: out.append('+' + n)
        elif op.type == X86_OP_IMM:
            v = op.imm & 0xFFFF
            # mov di, imm ; push ds / push cs 형태 -> 주소
            nb = seg * 16 + ins.address + ins.size
            nxt = IMG[nb:nb + 2]
            if ins.mnemonic == 'mov' and len(nxt) and nxt[0] == 0x0E:
                st = pstring_at(seg * 16 + v)
                look = IMG[nb:nb + 12]
                if 0x9A in look and any(IMG[nb + k] == 0x9A and struct.unpack_from('<H', IMG, nb + k + 1)[0] == 0x08d4 for k in range(len(look) - 3)):
                    sb = IMG[seg * 16 + v: seg * 16 + v + 32]
                    mem = [i for i in range(256) if sb[i >> 3] >> (i & 7) & 1]
                    out.append('set cs:%04x = [%s]' % (v, ','.join('%d' % m for m in mem)))
                elif st is not None: out.append("cs:'%s'" % st)
            elif ins.mnemonic == 'mov' and len(nxt) and nxt[0] == 0x1E:
                n = ds_name(v)
                if n: out.append('&' + n)
                else:
                    st = pstring_at(DS * 16 + v)
            elif ins.mnemonic == 'mov' and nb in RELOC and False:
                pass
    # 재배치된 세그먼트 값 (mov dx, seg)
    for k in range(ins.size - 1):
        if a + k in RELOC:
            sv = struct.unpack_from('<H', IMG, a + k)[0]
            out.append('seg %s' % seg_name(sv) if sv in dict(SEGS) else 'seg %04x' % sv)
    return txt, '; ' + ', '.join(out) if out else None

def emit():
    w = sys.stdout.write
    for seg, name in SEGS:
        if name == 'DATA': continue
        start, end = seg * 16, segend(seg)
        w('\n;' + '=' * 78 + '\n; SEGMENT %04x  %s   (linear %05x..%05x)\n;' % (seg, name, start, end) + '=' * 78 + '\n')
        a = start
        while a < end:
            if a in funcs:
                s, o = funcs[a]
                w('\n; ' + '-' * 60 + '\n%s:\n' % lab(s, o))
            if a in code:
                ins = code[a]
                if a in labels and a not in funcs:
                    w('  loc_%04x:\n' % ins.address)
                t, c = comment(seg, ins)
                line = '%04x  %-40s' % (ins.address, t)
                if c: line += ' ' + c
                w(line.rstrip() + '\n')
                a += ins.size
            else:
                # 데이터: 다음 코드까지
                b = a
                while b < end and b not in code: b += 1
                chunk = IMG[a:b]
                if all(x == 0 for x in chunk) and len(chunk) > 16:
                    w('%04x  db %d dup(0)\n' % (a - start, len(chunk)))
                else:
                    i = 0
                    while i < len(chunk):
                        st = pstring_at(a + i)
                        if st is not None and len(st) >= 1 and (len(st) >= 3 or i == 0):
                            w("%04x  db %d,'%s'\n" % (a + i - start, len(st), st))
                            i += 1 + len(st)
                        else:
                            j = min(len(chunk), i + 16)
                            # 다음 문자열 시작 전까지 끊기
                            w('%04x  db %s\n' % (a + i - start, ','.join('%02x' % x for x in chunk[i:j])))
                            i = j
                a = b

if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8')
    emit()
