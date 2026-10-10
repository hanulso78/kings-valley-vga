/* ============================================================================
 *  mummy.c  -  미라   (원본 게임 유닛 08E2:0E48)
 * ----------------------------------------------------------------------------
 *  미라는 최대 셋(mummies[1..3]).  timer 가 매 틱 1씩 늘면서 상태가 바뀐다.
 *      1 .. 0x42        나타남 (나오는 자리에서 그림 세 장, 깜박임)
 *      0x43 .. 0x2710   돌아다님 (벽 16번이면 돌아섬 + 수명 100 더함, 떨어짐,
 *                       사다리 오르내리기, 옆 방으로 넘어가기)
 *      0x2711           죽음 그림
 *      0x2713 .. 0x2724 죽는 소리
 *      0x2725           죽음 그림 지움
 *      0x2726 .. 0x27D8 기다림
 *      0x27D9           나오는 자리로 돌아가 다시 나타남
 *  단검에 맞거나, 수명(0x2706)이 다하거나, 네 방향 모두 막히면 0x2710 이 된다.
 *  다른 방에 있는 미라는 그리지 않는 대신 Delay 로 시간을 맞춘다.
 * ========================================================================== */
#include "kv.h"

static int16_t abs16(int16_t v)
{
    return v < 0 ? (int16_t)-v : v;
}

#define M_CELL(m, col, row)     MAP((m)->room, col, row)

static int blocks_mummy(uint8_t c)          /* 원래 집합 CS:0DA8 */
{
    return IN(c, 42, 43, 46, 47, 50, 53, 54, 175, 222);
}

static int mummy_falls(uint8_t c)           /* CS:0DC8 */
{
    return IN(c, 30, 33, 34, 35, 56, 76, 85, 86, 87, 88, 100, 106, 156, 206);
}

static int ladder_up(uint8_t c)             /* CS:0DE8 */
{
    return IN(c, 51, 52, 101, 102, 111, 151, 152, 161, 201, 202, 211, 251, 252);
}

static int ceiling(uint8_t c)               /* CS:0E08 */
{
    return IN(c, 50, 53, 54, 175, 222);
}

static int ladder_down(uint8_t c)           /* CS:0E28 */
{
    return IN(c, 51, 52, 100, 101, 102, 111, 151, 152, 161, 201, 202, 211, 251, 252);
}

/* 새 방향을 고른다.  같은 방이면 플레이어 쪽을 본다. */
static void face_player(struct mummy *m)
{
    m->dir = (int16_t)(pascal_random(2) * 2 - 1);
    if (m->room == cur_room && (int16_t)((player_x - m->x) * m->dir) < 0)
        m->dir = -m->dir;
}

/* ---------------------------------------------------------------------------
 *  0x43 .. 0x2710   돌아다니기
 * ------------------------------------------------------------------------- */
static void walk_mummy(struct mummy *m)
{
    int16_t old_x = m->x, old_y = m->y;

    if (m->bump > 99) {                         /* 1273: 멈춰 서서 두리번 */
        if (m->bump == 100 && m->room == cur_room) {
            graph_put_image(old_x - 16, old_y - 8, SPR(m->sprite), PUT_XOR);
            graph_put_image(old_x - 16, old_y - 8, SPR(0x53), PUT_XOR);
            m->sprite = 0x53;
        }
        m->bump++;
        crt_delay(10);
        if (m->room == cur_room && m->bump % 5 == 0) {
            graph_put_image(old_x - 16, old_y - 8, SPR(m->sprite), PUT_XOR);
            graph_put_image(old_x - 16, old_y - 8, SPR((m->bump / 10) % 2 + 0x53), PUT_XOR);
            m->sprite = (uint8_t)((m->bump / 10) % 2 + 0x53);
        }
        if (m->bump == 120)
            m->bump = 0;
        crt_delay(10);
        return;
    }

    /* 1431: 걷기 */
    m->x += m->dir * 6;
    if (m->x < -1 || m->x > 0x280) {
        uint8_t before = m->room;

        move_to_next_room(&m->room, &m->x, &m->y);
        if (m->room != before)
            graph_put_image(old_x - 16, old_y - 8, SPR(m->sprite), PUT_XOR);
    }

    probe_x = (m->x + m->dir * 13) / 32;
    probe_y = (m->y - 4) / 8;
    if (blocks_mummy(M_CELL(m, probe_x, probe_y)) ||
        blocks_mummy(M_CELL(m, probe_x, (m->y + 6) / 8))) {
        m->x -= m->dir * 6;
        m->bump++;
        crt_delay(10);
        if (m->bump > 15) {                     /* 돌아선다 */
            m->bump = 0;
            m->dir = -m->dir;
            if (m->dir > 0) {
                m->turns_right++;
                if (m->turns_right > 1)
                    m->stuck_right = 1;
            } else {
                m->turns_left++;
                if (m->turns_left > 1)
                    m->stuck_left = 1;
            }
            m->timer += 100;
        }
    }

    if (m->room == cur_room)
        graph_put_image(old_x - 16, old_y - 8, SPR(m->sprite), PUT_XOR);
    else
        crt_delay(5);

    m->sprite = (uint8_t)((((m->timer / 3) % 2) << 1) + 0x4D - (m->dir + 1) / 2);

    /* 17BE: 떨어지기 */
    if (mummy_falls(M_CELL(m, (m->x + 11) / 32, (m->y + 9) / 8)) &&
        mummy_falls(M_CELL(m, (m->x - 12) / 32, (m->y + 9) / 8)) &&
        mummy_falls(M_CELL(m, (m->x + 11) / 32, m->y / 8)) &&
        mummy_falls(M_CELL(m, (m->x - 12) / 32, m->y / 8))) {
        m->unused_0c = -1;
        m->dir = 0;
        m->y += 6;
        m->sprite = (uint8_t)((m->dir + 1) / 2 + 0x4C);
        if (m->y > 0xB4)
            move_to_next_room(&m->room, &m->x, &m->y);
        if (!mummy_falls(M_CELL(m, m->x / 32, (m->y + 9) / 8))) {
            m->y -= 6;                          /* 내려섰다 */
            m->stuck_right = 0;
            m->stuck_left = 0;
            m->want_down = 0;
            face_player(m);
            m->y = (m->y / 8) * 8 + 8;
            m->bump = 100;
            m->unused_0c = -1;
        }
    }

    /* 1B9A: 사다리 오르기 */
    if (m->climbing_down == 0 &&
        ((ladder_up(M_CELL(m, (m->x + 12) / 32, (m->y + 7) / 8)) &&
          ladder_up(M_CELL(m, (m->x - 13) / 32, (m->y + 7) / 8))) ||
         (ladder_up(M_CELL(m, (m->x + 12) / 32, m->y / 8)) &&
          ladder_up(M_CELL(m, (m->x - 13) / 32, m->y / 8))))) {
        if (m->turns_right > 0 && m->turns_left > 0) {
            m->y -= 2;
            m->unused_0c = -1;
            m->want_down = 0;
            m->dir = 0;
            m->climbing_up = 1;
            if (m->y < 5)
                move_to_next_room(&m->room, &m->x, &m->y);
            m->sprite = (uint8_t)((m->timer / 5) % 2 + 0x50);
            probe_x = (m->x - 11) / 32;
            probe_y = (m->y - 7) / 8;
            if (ceiling(M_CELL(m, probe_x, probe_y)) ||
                ceiling(M_CELL(m, (m->x + 10) / 32, probe_y))) {
                m->y += 2;                      /* 머리가 막혔다 */
                m->ladder_end = 1;
                goto ladder_done;
            }
            m->want_down = 0;
        } else if (m->climbing_down == 0) {
            m->want_down = 0;
        }
    } else if (m->climbing_up) {
        m->ladder_end = 1;
        m->climbing_up = 0;
    } else if (m->turns_right > 0 && m->turns_left > 0) {
        m->want_down = 1;
    }

    /* 1FEF: 사다리 내려가기 */
    if (m->want_down) {
        if (ladder_down(M_CELL(m, (m->x + 12) / 32, (m->y + 8) / 8)) &&
            ladder_down(M_CELL(m, (m->x - 13) / 32, (m->y + 8) / 8))) {
            m->y += 2;
            m->stuck_down = 0;
            m->dir = 0;
            m->want_down = 1;
            m->climbing_down = 1;
            m->ladder_end = 0;
            m->climbing_up = 0;
            if (m->y > 0xB4)
                move_to_next_room(&m->room, &m->x, &m->y);
            m->sprite = (uint8_t)((m->timer / 5) % 2 + 0x50);
            probe_x = (m->x - 10) / 32;
            probe_y = (m->y + 7) / 8;
            if (blocks_mummy(M_CELL(m, probe_x, probe_y)) ||
                blocks_mummy(M_CELL(m, (m->x + 9) / 32, probe_y))) {
                m->y -= 2;                      /* 발이 막혔다 */
                m->ladder_end = 1;
                m->want_down = 0;
            } else {
                m->stuck_down = 0;
            }
        } else if (m->climbing_down) {
            m->ladder_end = 1;
            m->climbing_down = 0;
            m->want_down = 0;
        } else if (m->turns_right > 0 && m->turns_left > 0) {
            m->stuck_down = 1;
        }
    }

ladder_done:
    if (m->ladder_end) {                        /* 2365: 멈추고 방향을 새로 */
        m->stuck_right = 0;
        m->turns_right = 0;
        m->stuck_left = 0;
        m->turns_left = 0;
        m->dir = (int16_t)(pascal_random(2) * 2 - 1);
        m->bump = 100;
        m->ladder_end = 0;
    }

    if (m->room == cur_room)
        graph_put_image(m->x - 16, m->y - 8, SPR(m->sprite), PUT_XOR);
    else
        crt_delay(5);

    if (m->timer > 0x2706)                      /* 수명이 다했다 */
        m->timer = 0x2710;
    if (m->stuck_right && m->stuck_left && m->want_down && m->stuck_down)
        m->timer = 0x2710;                      /* 갇혔다 */
}

/* ---------------------------------------------------------------------------
 *  원래 08E2:0E48   미라 셋을 한 틱씩
 * ------------------------------------------------------------------------- */
void move_mummies(void)
{
    graph_set_color(15);

    FOR_TO(mummy_i, 1, 3) {
        struct mummy *m = &mummies[mummy_i];
        int16_t t;

        if (!m->active) {
            crt_delay(10);
            continue;
        }
        m->timer++;

        /* 0E88: 단검에 맞았나 */
        if (m->room == dagger_room && dagger_flying && m->timer < 0x2710) {
            if (abs16(dagger_x + 16 - m->x) < 20 && abs16(dagger_y + 6 - m->y) < 10) {
                m->timer = 0x2710;
                dagger_hit = 1;
                continue;
            }
        } else if (dagger_flying) {
            move_dagger();
        }

        /* 0F29: 플레이어를 잡았나 */
        if (m->room == cur_room && m->timer > 0x1F && m->timer < 0x2711 &&
            abs16(player_x - m->x) < 20 && abs16(player_y - m->y) < 12 && player_caught == 0) {
            player_caught = 1;
            continue;
        }

        t = m->timer;
        if (t == 0x0B || t == 0x15 || t == 0x1F) {             /* 나오는 그림 세 장 */
            if (m->home_room == cur_room) {
                graph_put_image(m->home_x - 16, m->home_y - 8, SPR(t / 10 + 0x49), PUT_COPY);
                m->sprite = (uint8_t)(t / 10 + 0x49);
            }
        } else if (t >= 1 && t <= 0x1E) {
            crt_delay(12);
        } else if (t >= 0x20 && t <= 0x41) {                   /* 깜박임 */
            if (m->home_room == cur_room) {
                graph_put_image(m->home_x - 16, m->home_y - 8, SPR((t / 10) % 2 + 0x53), PUT_COPY);
                m->sprite = (uint8_t)((t / 10) % 2 + 0x53);
                crt_delay(10);
            } else {
                crt_delay(15);
            }
        } else if (t == 0x42) {                                 /* 나왔다 */
            if (m->home_room == cur_room) {
                graph_put_image(m->home_x - 16, m->home_y - 8, SPR(T_MUMMY_HOME), PUT_COPY);
                graph_put_image(m->home_x - 16, m->home_y - 8, SPR(m->sprite), PUT_XOR);
                crt_delay(20);
                m->bump = 0;
            } else {
                crt_delay(25);
            }
        } else if (t >= 0x43 && t <= 0x2710) {
            walk_mummy(m);
        } else if (t == 0x2711) {                               /* 죽음 */
            if (m->room == cur_room)
                graph_put_image(m->x - 16, m->y - 8, SPR(m->sprite), PUT_XOR);
            else
                crt_delay(5);
            if (m->home_room == cur_room)
                graph_put_image(m->home_x - 16, m->home_y - 8, SPR(T_MUMMY_HOME), PUT_COPY);
            else
                crt_delay(5);
            if (m->room == cur_room)
                graph_put_image(m->x - 16, m->y - 8, SPR(0x52), PUT_XOR);
            else
                crt_delay(5);
        } else if (t >= 0x2713 && t <= 0x2724) {               /* 죽는 소리 (NoSound 없음) */
            crt_sound((uint16_t)((t % 100) * 20));
            crt_delay(10);
        } else if (t == 0x2725) {
            if (m->room == cur_room)
                graph_put_image(m->x - 16, m->y - 8, SPR(0x52), PUT_XOR);
            else
                crt_delay(5);
        } else if (t >= 0x2726 && t <= 0x27D8) {
            crt_delay(18);
        } else if (t == 0x27D9) {                               /* 다시 나타날 준비 */
            m->timer = 1;
            m->ladder_end = 0;
            m->room = m->home_room;
            m->x = m->home_x;
            m->y = m->home_y;
            m->stuck_right = m->turns_right = 0;
            m->stuck_left = m->turns_left = 0;
            m->want_down = m->unused_14 = 0;
            m->stuck_down = m->unused_15 = 0;
            m->climbing_up = m->climbing_down = 0;
            m->bump = 0;
            m->unused_0c = -1;
            m->sprite = 0x4D;
            face_player(m);
        }
    }
}
