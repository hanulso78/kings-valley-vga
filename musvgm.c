/* ============================================================================
 *  musvgm.c  -  배경음악, 애드립(OPL2) VGM 재생  ->  KVVGA.EXE
 * ----------------------------------------------------------------------------
 *  원판은 타이머 인터럽트에서 PC 스피커로 한 곡을 되풀이했다.  이 판은
 *  tools/mkmusic.py 가 새로 지은 곡(SOUND.DAT)을 애드립으로 연주한다.
 *      SOUND.DAT   0..7 "KVSND10"+0,  8..9 곡 수,
 *                  곡마다 20바이트 (이름 12 / 시작 위치 4 / 길이 4), 그 뒤 VGM 자료
 *      KVTITLE  타이틀/메뉴 (되풀이)       KVGAME  게임 중 (되풀이)
 *      KVBEAT   게임 중 F3 (되풀이)         KVCLEAR 스테이지 깸
 *      KVDIE    죽음                        KVOVER  게임 끝
 *
 *  게임 곡은 원판에서 음악이 울리던 때 - 타이머 처리기가 걸려 있을 때 - 만
 *  울린다.  F1 로 멈추거나, 지도를 보거나, 죽거나, 곡괭이로 옆을 파는 동안에는
 *  원판처럼 멈췄다가 이어서 울린다.  F3 을 누르면(원판: 음악 <-> 똑딱) 곡과
 *  타악기만 있는 판을 오간다.
 *  효과음은 원판 그대로 PC 스피커.  애드립이 없거나 파일이 없으면 조용히 넘어간다.
 * ========================================================================== */
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>
#include <pc.h>

#include "kv.h"

#define OPL_ADDR    0x388
#define OPL_DATA    0x389
#define SOUND_DAT   "sound.dat"
#define SOUND_MAGIC "KVSND10"

enum { TRACK_NONE, TRACK_TITLE, TRACK_GAME, TRACK_BEAT, TRACK_CLEAR, TRACK_DIE, TRACK_OVER, TRACKS };

static const char *const track_file[TRACKS] = {
    NULL, "KVTITLE.VGM", "KVGAME.VGM", "KVBEAT.VGM", "KVCLEAR.VGM", "KVDIE.VGM", "KVOVER.VGM"
};

typedef struct {
    unsigned char *buf;
    long           len, pos, loop;
    uclock_t       next;
    int            started, loaded;
} vgm_stream;

static int        opl_found = -1;
static vgm_stream track[TRACKS];
static int        song = SONG_NONE;          /* music_play 로 고른 곡 */
static int        sounding = TRACK_NONE;     /* 지금 칩에 흘려보내는 트랙 */

static void opl_wait(int n)
{
    int i;
    for (i = 0; i < n; i++)
        (void)inportb(OPL_ADDR);
}

static void opl_write(int reg, int val)
{
    outportb(OPL_ADDR, (unsigned char)reg);
    opl_wait(6);
    outportb(OPL_DATA, (unsigned char)val);
    opl_wait(35);
}

static int opl_detect(void)
{
    unsigned char s1, s2;

    opl_write(4, 0x60);
    opl_write(4, 0x80);
    s1 = inportb(OPL_ADDR);
    opl_write(2, 0xFF);
    opl_write(4, 0x21);
    opl_wait(400);
    s2 = inportb(OPL_ADDR);
    opl_write(4, 0x60);
    opl_write(4, 0x80);
    return (s1 & 0xE0) == 0x00 && (s2 & 0xE0) == 0xC0;
}

static void opl_silence(void)
{
    int i;

    for (i = 0xB0; i <= 0xB8; i++)
        opl_write(i, 0x00);
    opl_write(0xBD, 0x00);
    for (i = 0x40; i <= 0x55; i++)
        opl_write(i, 0x3F);
}

static void opl_reset(void)
{
    int i;

    opl_silence();
    for (i = 0x01; i <= 0xF5; i++)
        opl_write(i, 0x00);
}

static unsigned long le32(const unsigned char *p)
{
    return p[0] | (unsigned long)p[1] << 8 | (unsigned long)p[2] << 16 | (unsigned long)p[3] << 24;
}

static uclock_t samples_to_uclock(long n)
{
    return (uclock_t)((double)n * UCLOCKS_PER_SEC / 44100.0);
}

/* SOUND.DAT 목차에서 이름을 찾아 읽어 온다 */
static int stream_load(vgm_stream *s, const char *name)
{
    unsigned char head[10], entry[20];
    unsigned long off = 0, size = 0;
    int fd, count, i, found = 0;

    s->loaded = -1;
    fd = open(SOUND_DAT, O_RDONLY | O_BINARY);
    if (fd == -1)
        return 0;
    if (read(fd, head, 10) != 10 || memcmp(head, SOUND_MAGIC, 8) != 0) {
        close(fd);
        return 0;
    }
    count = head[8] | head[9] << 8;
    for (i = 0; i < count && !found; i++) {
        if (read(fd, entry, 20) != 20)
            break;
        if (strncmp((char *)entry, name, 12) == 0) {
            off = le32(entry + 12);
            size = le32(entry + 16);
            found = 1;
        }
    }
    if (!found || size < 0x40 || size > 1024L * 1024L ||
        lseek(fd, off, SEEK_SET) != (off_t)off || (s->buf = malloc(size)) == NULL) {
        close(fd);
        return 0;
    }
    s->len = read(fd, s->buf, size);
    close(fd);
    if (s->len < 0x40 || memcmp(s->buf, "Vgm ", 4) != 0) {
        free(s->buf);
        s->buf = NULL;
        return 0;
    }
    s->loaded = 1;
    return 1;
}

static void stream_rewind(vgm_stream *s)
{
    unsigned long loop = le32(s->buf + 0x1C), data = le32(s->buf + 0x34);

    s->loop = loop ? (long)(0x1C + loop) : 0;
    if (s->loop >= s->len)
        s->loop = 0;
    s->pos = data ? (long)(0x34 + data) : 0x40;
    s->started = 1;
}

/* 시각이 된 명령을 칩에 보낸다.  끝나면 0 */
static int stream_poll(vgm_stream *s)
{
    uclock_t now = uclock();
    const unsigned char *b = s->buf;
    unsigned char c;

    if (now > s->next + UCLOCKS_PER_SEC / 4)
        s->next = now;
    while (now >= s->next) {
        if (s->pos >= s->len) {
            if (!s->loop)
                return 0;
            s->pos = s->loop;
        }
        c = b[s->pos];
        if (c == 0x5A) {
            opl_write(b[s->pos + 1], b[s->pos + 2]);
            s->pos += 3;
        } else if (c == 0x61) {
            s->next += samples_to_uclock(b[s->pos + 1] | b[s->pos + 2] << 8);
            s->pos += 3;
        } else if (c == 0x62) {
            s->next += samples_to_uclock(735);
            s->pos++;
        } else if (c == 0x63) {
            s->next += samples_to_uclock(882);
            s->pos++;
        } else if (c >= 0x70 && c <= 0x7F) {
            s->next += samples_to_uclock((c & 15) + 1);
            s->pos++;
        } else if (c == 0x66) {
            if (!s->loop)
                return 0;
            s->pos = s->loop;
        } else if (c >= 0x51 && c <= 0x5F) {
            s->pos += 3;
        } else {
            s->pos++;
        }
        now = uclock();
    }
    return 1;
}

static void music_exit(void)
{
    if (opl_found == 1)
        opl_reset();
}

static int ready(void)
{
    if (opl_found < 0) {
        opl_found = opl_detect();
        if (opl_found)
            atexit(music_exit);
    }
    return opl_found;
}

/* 트랙 t 로 바꾼다.  restart 면 처음부터, 아니면 멈췄던 자리부터 */
static void switch_to(int t, int restart)
{
    vgm_stream *s;

    if (t == sounding && !restart)
        return;
    if (sounding != TRACK_NONE)
        opl_silence();
    sounding = TRACK_NONE;
    if (t == TRACK_NONE)
        return;
    s = &track[t];
    if (s->loaded == 0 && !stream_load(s, track_file[t]))
        return;
    if (s->loaded < 0)
        return;
    /* 음색이 곡 앞부분에만 있으므로, 이어서 울릴 때도 처음부터 다시 짚는다 */
    if (restart || !s->started || s->loop == 0) {
        stream_rewind(s);
    } else {
        long keep = s->pos;
        stream_rewind(s);
        s->next = uclock();
        stream_poll(s);                         /* 머리의 음색 설정(첫 쉼까지)만 다시 보낸다 */
        s->pos = keep;
    }
    opl_write(0x01, 0x20);
    s->next = uclock();
    sounding = t;
}

/* ---------------------------------------------------------------------------
 *  곡을 고른다.  SONG_GAME 은 타이머 처리기가 걸려 있을 때만 울린다.
 * ------------------------------------------------------------------------- */
void music_play(int which)
{
    if (!ready())
        return;
    song = which;
    switch (which) {
    case SONG_TITLE: switch_to(TRACK_TITLE, sounding != TRACK_TITLE); break;
    case SONG_CLEAR: switch_to(TRACK_CLEAR, 1); break;
    case SONG_DIE:   switch_to(TRACK_DIE, 1);   break;
    case SONG_OVER:  switch_to(TRACK_OVER, 1);  break;
    case SONG_GAME:  track[TRACK_GAME].started = track[TRACK_BEAT].started = 0;
                     switch_to(TRACK_NONE, 0);
                     music_poll();
                     break;
    default:         switch_to(TRACK_NONE, 0);  break;
    }
}

/* 기다리는 곳(Delay, 키 읽기)에서 계속 부른다 */
void music_poll(void)
{
    if (opl_found != 1)
        return;
    if (song == SONG_GAME) {
        int want = !timer_is_hooked() ? TRACK_NONE
                 : tune_len == BEAT_TICKS ? TRACK_BEAT : TRACK_GAME;
        if (want != sounding)
            switch_to(want, 0);
    }
    if (sounding != TRACK_NONE && !stream_poll(&track[sounding])) {
        opl_silence();
        track[sounding].started = 0;
        sounding = TRACK_NONE;
        if (song != SONG_GAME)
            song = SONG_NONE;
    }
}
