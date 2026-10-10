# ============================================================================
#  KING'S VALLEY (왕의 계곡)  -  djgpp 빌드
# ----------------------------------------------------------------------------
#  djgpp 창(dos-dev-system\djgpp.bat)에서 이 폴더로 와서
#
#      make -f kv.mak             둘 다 만든다
#      make -f kv.mak orig        KV.EXE     원판 그대로 (VGA 로 옮김)
#      make -f kv.mak vga         KVVGA.EXE  개선판
#      make -f kv.mak test        KVTEST.EXE, KVTESTV.EXE 자동 시험판 (아래)
#      make -f kv.mak clean
#
#  ---------------------------------------------------------------------------
#  KV.EXE    - 1989년 원판(B.EXE, 터보 파스칼, PKLITE 압축)을 역어셈블해 C 로
#       옮긴 것.  게임 규칙, 스테이지, 소리, 속도는 원판 그대로이고, 원판이
#       CGA 640x200 흑백으로 그리던 화면을 VGA 640x480(모드 12h) 가운데에
#       한 줄을 두 줄로 늘려 보여 준다.
#       필요한 파일 : CWSDPMI.EXE, KINGS-V.IFM (타이틀 그림), KINGS-V.DAT (스테이지)
#
#  KVVGA.EXE - 개선판.  같은 소스를 -DKVVGA 로 따로 컴파일하고 화면/음악만 바꾼다
#       (게임 규칙과 속도는 KV.EXE 와 같다).
#       - 256색: VESA 640x400 (없으면 640x480 가운데, 그것도 없으면 320x200).
#         원판의 흑백 스프라이트를 모두 색칠했고 세로 해상도가 두 배다.
#         벽 무늬 7가지는 색도 다르다 (사암, 청금석, 비취, 화강암, 자수정, 금, 흑요석).
#         색 그림은 KV256.SPR (tools/mkspr256.py 가 원본에서 만든다)
#       - 배경음악: 애드립(OPL2) VGM, 새로 지은 이집트풍 곡 6개를 SOUND.DAT 에 묶음
#           타이틀, 게임(F3: 타악기만), 스테이지 깸, 죽음, 게임 끝
#         (tools/mkmusic.py 가 만든다).  효과음은 원판대로 PC 스피커.
#       - 게임 중 ESC: 바로 도스로.  방향키를 겹쳐 누르다 앞 키를 떼도 멈추지 않는다.
#       필요한 파일 : CWSDPMI.EXE, KINGS-V.IFM, KINGS-V.DAT, KV256.SPR, SOUND.DAT
#
#  KVTEST.EXE, KVTESTV.EXE - KV.EXE / KVVGA.EXE 를 -DKV_TEST 로 컴파일한 것.  KVTEST.TXT 의 줄을 시간 순서로
#       실행한다 (키보드 없이 DOSBox 에서 돌려 볼 때).
#           <ms> down <스캔코드> <ASCII>    키 누름     예) 12000 down 02 31
#           <ms> up <스캔코드>              키 뗌
#           <ms> shot <이름>                화면을 <이름>.PBM 으로 저장 (KVTESTV 는 .PPM)
#           <ms> set player <x> <y>         플레이어를 옮긴다
#           <ms> set exit                   영혼석을 다 모은 것으로 하고 출구 앞으로 (스테이지 깨기 시험)
#           <ms> quit                       끝
#       KVTESTV 는 원판 흑백 화면(graph.c 를 shadow_* 로)도 나란히 그려서, 원판에서는 지워진
#       움직이는 그림이 색 화면에 남으면(잔상) KVCHECK.LOG 에 적는다.
#
#  소스 (괄호 안은 원본 세그먼트)
#       kv.h       공용 선언, 원래 주소 대조표
#       main.c     메인 프로그램 본체, 전역 변수      (0000:3B1F)
#       title.c    타이틀, 제작진, 첫 메뉴           (0000:34AB)
#       player.c   걷기, 사다리, 다리, 점프, 죽음    (0000:0020..3311)
#       gamelib.c  점수판, 방 이동, 단검, 줍기, 출구 (08E2)
#       mummy.c    미라                              (08E2:0E48)
#       editor.c   스테이지 편집기                   (0777)
#       data.c     데이터 세그먼트 초기값            (DS)  - tools/mkdata.py 가 만든다
#       system.c   Crt/Dos/System 유닛 흉내, 인터럽트 처리기
#     KV.EXE 만
#       graph.c    Graph 유닛 + CGA.BGI 흉내 -> VGA 640x480 흑백
#     KVVGA.EXE 만
#       graph256.c 화면 목록으로 다시 합성하는 256색 화면
#       musvgm.c   배경음악 - 애드립 VGM
#  도구 (파이썬, tools/)
#       unpklite.py  B.EXE 압축 풀기 -> B_UNP.EXE
#       mklist.py    역어셈블 목록 -> listing.asm   (names.txt = 런타임 이름표)
#       mkdata.py    데이터 세그먼트 -> data.c
#       mkspr256.py  흑백 스프라이트/타이틀 색칠 -> KV256.SPR   (--preview 폴더: PNG 미리보기)
#       mkmusic.py   애드립 곡 -> SOUND.DAT                     (--vgm: VGM 파일도)
#       pbm2png.py   KVTEST.EXE 가 저장한 화면들 -> PNG 한 장
# ============================================================================

CC      = gcc
CFLAGS  = -O2 -Wall -std=gnu99

SRCS    = main.c title.c player.c gamelib.c mummy.c editor.c data.c graph.c system.c
ORIG    = $(SRCS:.c=.o)
VGASRCS = $(filter-out graph.c,$(SRCS)) graph256.c musvgm.c
VGA     = $(VGASRCS:.c=.vo)

all: kv.exe kvvga.exe

orig: kv.exe
vga:  kvvga.exe
test: kvtest.exe kvtestv.exe

kv.exe: $(ORIG)
	$(CC) $(CFLAGS) -o kv.exe $(ORIG)
	strip kv.exe

kvvga.exe: $(VGA)
	$(CC) $(CFLAGS) -o kvvga.exe $(VGA)
	strip kvvga.exe

kvtest.exe: $(SRCS) kv.h
	$(CC) $(CFLAGS) -DKV_TEST -o kvtest.exe $(SRCS)

kvtestv.exe: $(VGASRCS) graph.c kv.h
	$(CC) $(CFLAGS) -DKV_TEST -DKV_SHADOW -c graph.c -o shadow.o
	$(CC) $(CFLAGS) -DKV_TEST -DKVVGA -o kvtestv.exe $(VGASRCS) shadow.o
	rm -f shadow.o

%.o: %.c kv.h
	$(CC) $(CFLAGS) -c $< -o $@

%.vo: %.c kv.h
	$(CC) $(CFLAGS) -DKVVGA -c $< -o $@

clean:
	rm -f $(ORIG) $(VGA) kv.exe kvvga.exe kvtest.exe kvtestv.exe

.PHONY: all orig vga test clean
