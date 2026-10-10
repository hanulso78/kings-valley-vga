# 간단 역어셈블러: python dis.py 선형주소(16진) [바이트수]
import sys, struct
from capstone import *
e=open('B_UNP.EXE','rb').read()
h=struct.unpack('<14H',e[:28]); hs=h[4]*16; img=e[hs:]
rel=set()
for i in range(h[3]):
    o,s=struct.unpack_from('<HH',e,28+4*i); rel.add(s*16+o)
SEGS=[0x0000,0x0777,0x08e2,0x0c93,0x0fd3,0x0fdd,0x103f,0x1161]
def segof(lin):
    s=[x for x in SEGS if x*16<=lin][-1]; return s
md=Cs(CS_ARCH_X86,CS_MODE_16)
start=int(sys.argv[1],16); n=int(sys.argv[2],16) if len(sys.argv)>2 else 0x100
seg=segof(start)
for ins in md.disasm(img[start:start+n], start-seg*16):
    lin=seg*16+ins.address
    b=ins.bytes.hex()
    print('%04x:%04x  %-14s %s %s'%(seg,ins.address,b[:14],ins.mnemonic,ins.op_str))
