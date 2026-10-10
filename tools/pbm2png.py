# 시험 빌드가 저장한 640x200 PBM 들을 한 장의 PNG 로 (줄 두 배)
import sys
from PIL import Image
names = sys.argv[2:]
ims = [Image.open(n).convert('L').resize((640, 400), Image.NEAREST) for n in names]
cols = 2
rows = (len(ims) + 1) // 2
out = Image.new('L', (cols * 650, rows * 410), 128)
for i, im in enumerate(ims):
    out.paste(im, ((i % cols) * 650, (i // cols) * 410))
out.save(sys.argv[1])
