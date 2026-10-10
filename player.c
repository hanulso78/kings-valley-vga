/* ============================================================================
 *  player.c  -  플레이어 움직임   (원본 메인 프로그램 0000:0020 .. 3311)
 * ----------------------------------------------------------------------------
 *  좌표 player_x, player_y 는 몸 가운데.  그림은 (x-16, y-8) 에 XOR 로 그리고
 *  지운다.  지도 칸은 열 = x/32, 줄 = y/8.
 *
 *  사다리: 오르내리기 시작하면 그 열의 사다리 칸(52, 102, 152)을 "밟은 사다리"
 *  (111, 161, 211)로 바꿔 둔다.  밟은 사다리 위에서 다시 오르내리려 하면
 *  ladder_leave 가 켜지고, 옆으로 걷거나 멈추면 remove_used_ladder 가 그 사다리를
 *  없앤다 (한 번만 쓸 수 있는 사다리).
 *
 *  다리: 무너지는 다리(175)를 밟으면 그 줄이 "밟은 다리"(222)로 바뀌고, 다리에서
 *  떠나면 collapse_bridge 가 그 줄을 없앤다.
 * ========================================================================== */
#include "kv.h"

/* ---------------------------------------------------------------------------
 *  원래 0000:0020
 *  ladder_col 열의 밟은 사다리를 아래 끝부터 위로 없앤다.
 *  111 -> 빈칸, 161/211 -> 56/106 (단검만 남는다).  맨 위 칸은 111 -> 벽돌(53).
 * ------------------------------------------------------------------------- */
void remove_used_ladder(void)
{
    loop_i = (uint8_t)((player_y - 4) / 8);
    do
        loop_i++;
    while (IN(ROOM_CELL(ladder_col, loop_i + 1), 111, 161, 211));

    do {
        if (ROOM_CELL(ladder_col, loop_i) == T_USED_LADDER)
            ROOM_CELL(ladder_col, loop_i) = T_EMPTY;
        else
            ROOM_CELL(ladder_col, loop_i) -= 105;
        graph_put_image(ladder_col << 5, loop_i << 3, SPR(T_LADDER), PUT_XOR);
        loop_i--;
        FOR_TO(loop_j, 1, 10) {
            crt_sound((uint16_t)(loop_j * 50 + loop_i * 300));
            crt_delay(4);
        }
    } while (IN(ROOM_CELL(ladder_col, (uint16_t)(loop_i - 1)), 111, 161, 211));

    graph_put_image(ladder_col << 5, loop_i << 3, SPR(T_LADDER), PUT_XOR);
    graph_put_image(ladder_col << 5, loop_i << 3, SPR(T_BRICK), PUT_XOR);
    if (ROOM_CELL(ladder_col, loop_i) == T_USED_LADDER)
        ROOM_CELL(ladder_col, loop_i) = T_BRICK;
    else
        ROOM_CELL(ladder_col, loop_i) -= 105;
    ladder_leave = 0;
}

/* ---------------------------------------------------------------------------
 *  원래 0000:024D
 *  bridge_row 줄에서 플레이어 옆의 밟은 다리(222)를 한 칸씩 없앤다.
 *  없앤 칸 두 줄 위에 돌이 있었으면 그 돌을 떨어뜨린다.
 * ------------------------------------------------------------------------- */
void collapse_bridge(void)
{
    loop_i = (uint8_t)((player_x + 16) / 32);
    do {
        if (facing_left == 0) loop_i--; else loop_i++;
    } while (ROOM_CELL(loop_i, bridge_row) == T_BRIDGE_USED);
    do {
        if (facing_left == 0) loop_i++; else loop_i--;
    } while (ROOM_CELL(loop_i, bridge_row) != T_BRIDGE_USED);

    do {
        ROOM_CELL(loop_i, bridge_row) = T_EMPTY;
        graph_put_image(loop_i << 5, bridge_row << 3, SPR(SPR_BRIDGE), PUT_XOR);
        if (facing_left == 0) loop_i++; else loop_i--;
        FOR_TO(loop_j, 1, 10) {
            crt_sound((uint16_t)(loop_j * 40 + loop_i * 100));
            crt_delay(4);
        }
        if (ROOM_CELL(loop_i, (uint16_t)(bridge_row - 2)) == T_STONE) {
            stone_col = loop_i;
            stone_row = (uint16_t)(bridge_row - 2);
            stone_falling = 1;
            ROOM_CELL(loop_i, (uint16_t)(bridge_row - 2)) = T_EMPTY;
        }
    } while (ROOM_CELL(loop_i, bridge_row) == T_BRIDGE_USED);

    bridge_left = 0;
    bridge_right = 0;
    bridge_latch = 0;
    on_bridge = 0;
}

/* ---------------------------------------------------------------------------
 *  사다리 한 걸음의 앞뒤 (0480, 085C 공통 부분)
 * ------------------------------------------------------------------------- */
static void ladder_step_begin(uint8_t *other_dir_marked)
{
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    player_x = (player_x / 32) * 32 + 16;                     /* 열 가운데로 */
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);

    if (dagger_flying) {
        move_dagger();
        crt_delay(1);
    } else {
        crt_delay(4);
    }
    move_mummies();

    if (*other_dir_marked) {
        ladder_marked = 0;
        *other_dir_marked = 0;
    }
    walk_count++;
    if (walk_count > 1000)
        walk_count = 1;
    check_pickup();
}

/* 발밑 사다리 열을 밟은 사다리로 표시 (05BC, 0999) */
static void mark_ladder(uint8_t *this_dir_marked)
{
    if (!IN(ROOM_CELL(player_x / 32, (player_y + 6) / 8), 52, 102, 111, 152, 161, 211) || ladder_marked)
        return;

    loop_i = (uint8_t)((player_y + 6) / 8);
    loop_j = (uint8_t)(player_x / 32);
    switch (ROOM_CELL(loop_j, loop_i)) {
    case 111: case 161: case 211:
        ladder_leave = 1;
        ladder_col = loop_j;
        break;
    case 52: case 102: case 152:
        loop_i--;
        do
            loop_i++;
        while (IN(ROOM_CELL(loop_j, loop_i + 1), 52, 102, 152));
        *this_dir_marked = 1;
        do {
            if (ROOM_CELL(loop_j, loop_i) == T_LADDER)
                ROOM_CELL(loop_j, loop_i) = T_USED_LADDER;
            else
                ROOM_CELL(loop_j, loop_i) += 59;
            loop_i--;
        } while (IN(ROOM_CELL(loop_j, loop_i), 52, 102, 152));
        break;
    }
    ladder_marked = 1;
}

/* ---------------------------------------------------------------------------
 *  원래 0000:0480   사다리 오르기 한 걸음 (4픽셀)
 * ------------------------------------------------------------------------- */
void climb_up(void)
{
    ladder_step_begin(&ladder_marked_down);

    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    player_y -= 4;
    if (player_y < 8)
        check_room_change();

    mark_ladder(&ladder_marked_up);

    /* 072D: 머리가 막혔으면 되돌린다 */
    probe_col = (uint8_t)((player_x - 12) / 32);
    probe_row = (uint8_t)((player_y - 7) / 8);
    if (IN(ROOM_CELL(probe_col, probe_row), 53, 54, 175, 222) ||
        IN(ROOM_CELL((player_x + 11) / 32, probe_row), 53, 54, 175, 222))
        player_y += 4;

    player_sprite = (uint8_t)(walk_count % 2 + 31);
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
}

/* ---------------------------------------------------------------------------
 *  원래 0000:085C   사다리 내려가기 한 걸음
 * ------------------------------------------------------------------------- */
void climb_down(void)
{
    ladder_step_begin(&ladder_marked_up);

    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    player_y += 4;
    if (player_y > 0xB5)
        check_room_change();

    mark_ladder(&ladder_marked_down);

    /* 0B0A: 발이 막혔으면 되돌린다 */
    probe_col = (uint8_t)((player_x - 12) / 32);
    probe_row = (uint8_t)((player_y + 7) / 8);
    if (IN(ROOM_CELL(probe_col, probe_row), 53, 54, 175, 222) ||
        IN(ROOM_CELL((player_x + 11) / 32, probe_row), 53, 54, 175, 222))
        player_y -= 4;

    player_sprite = (uint8_t)(walk_count % 2 + 31);
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
}

/* ---------------------------------------------------------------------------
 *  회전문을 미는 동안의 소리 한 번.  loop_i = 30 .. 19 로 내려가며 부른다.
 * ------------------------------------------------------------------------- */
static void door_tick(int total)
{
    crt_sound(100);
    crt_delay(loop_i);
    if (dagger_flying)
        move_dagger();
    flush_key();
    crt_nosound();
    crt_delay((uint16_t)(total - loop_i));
    move_mummies();
    if (dagger_flying)
        move_dagger();
}

/* 돌을 못 밀어서 버티는 소리 (1142, 1EB6) */
static void strain_sound(void)
{
    FOR_DOWNTO(loop_i, 20, 15) {
        crt_sound(20);
        crt_delay((uint16_t)(loop_i - 10));
        crt_nosound();
        crt_delay((uint16_t)(21 - loop_i));
    }
}

/* 걷기 그림 (186C, 25CF): 옛 자리 old_x 를 지우고 새 자리에 그린다 */
static void walk_animate(void)
{
    walk_count++;
    if (walk_count > 1000)
        walk_count = 1;
    graph_put_image(old_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    switch ((walk_count / 2) % 4) {
    case 0: player_sprite = (uint8_t)((held_item << 1) + facing_left + 10); break;
    case 1: player_sprite = (uint8_t)(held_item + facing_left);             break;
    case 2: player_sprite = (uint8_t)((held_item << 1) + facing_left + 12); break;
    case 3: player_sprite = (uint8_t)(held_item + facing_left);             break;
    }
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
}

/* ---------------------------------------------------------------------------
 *  원래 0000:0CB9   왼쪽으로 한 걸음 (8픽셀)
 * ------------------------------------------------------------------------- */
void walk_left(void)
{
    uint8_t c;

    flush_key();
    if (ladder_leave)
        remove_used_ladder();

    ladder_marked = 0;
    if (bridge_right) {
        bridge_latch = 0;
        if (on_bridge == 0)
            bridge_right = 0;
    }

    move_mummies();
    if (on_bridge &&
        (ROOM_CELL(player_x / 32, (player_y + 9) / 8) != T_BRIDGE_USED || bridge_right))
        collapse_bridge();

    check_pickup();
    if (dagger_flying)
        move_dagger();

    old_x = player_x;
    player_x -= 8;
    facing_left = 1;
    standing = 0;
    push_right = 0;
    if (player_x < 16) {                        /* 왼쪽 방으로 */
        scratch = cur_room;
        check_room_change();
        if (scratch != cur_room) {
            graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
            old_x = player_x;
        }
    }

    probe_col = (uint8_t)((player_x - 15) / 32);
    probe_row = (uint8_t)((player_y - 6) / 8);

    /* 0DB6: 무너지는 다리에 올라섰나 */
    if (IN(ROOM_CELL(player_x / 32, (player_y + 12) / 8), T_BRIDGE, T_BRIDGE_USED)) {
        if (bridge_latch == 0) {
            loop_j = (uint8_t)((player_y + 12) / 8);
            loop_i = (uint8_t)(player_x / 32);
            c = ROOM_CELL(loop_i, loop_j);
            if (c == T_BRIDGE_USED) {
                on_bridge = 1;
                bridge_left = 1;
                bridge_row = loop_j;
            } else if (c == T_BRIDGE) {
                loop_i++;
                do
                    loop_i--;
                while (ROOM_CELL((uint16_t)(loop_i - 1), loop_j) == T_BRIDGE);
                bridge_left = 1;
                do {
                    ROOM_CELL(loop_i, loop_j) = T_BRIDGE_USED;
                    loop_i++;
                } while (ROOM_CELL(loop_i, loop_j) == T_BRIDGE);
            }
            bridge_latch = 1;
        }
    } else if (bridge_left) {
        bridge_latch = 0;
    }

    /* 0F25: 돌 밀기 */
    if (ROOM_CELL(probe_col, probe_row) == T_STONE) {
        push_left++;
        flush_key();
        if (push_left > 5) {
            if (!IN(ROOM_CELL((uint16_t)(probe_col - 1), probe_row),
                    27, 33, 34, 35, 50, 51, 52, 53, 54, 73, 101, 102, 111, 151, 152, 161, 175, 201, 202, 211, 222) &&
                !IN(ROOM_CELL((uint16_t)(probe_col - 1), (uint16_t)(probe_row + 1)),
                    50, 51, 52, 53, 54, 73, 175, 222)) {
                graph_put_image(probe_col << 5, probe_row << 3, SPR(T_STONE), PUT_XOR);
                ROOM_CELL(probe_col, probe_row) = T_EMPTY;
                stone_room = cur_room;
                if (probe_col == 0) {           /* 왼쪽 방으로 밀려 들어간다 */
                    cell_x = -2;
                    move_to_next_room(&stone_room, &cell_x, &cell_y);
                    probe_col = 19;
                }
                if (stone_room == cur_room)
                    graph_put_image((probe_col << 5) - 32, probe_row << 3, SPR(T_STONE), PUT_XOR);
                MAP(stone_room, (uint16_t)(probe_col - 1), probe_row) = T_STONE;
                if (!IN(MAP(stone_room, (uint16_t)(probe_col - 1), (uint16_t)(probe_row + 2)),
                        42, 43, 46, 47, 50, 51, 52, 53, 54, 175, 222)) {
                    MAP(stone_room, (uint16_t)(probe_col - 1), probe_row) = T_EMPTY;
                    stone_falling = 1;
                    stone_col = (uint16_t)(probe_col - 1);
                    stone_row = probe_row;
                }
                player_x -= 16;
                push_left = 0;
            } else {
                player_x += 8;
                push_left = 0;
            }
        } else {
            strain_sound();
            player_x += 8;
        }
    }

    /* 1187: 회전문 (42, 46) */
    probe_col = (uint8_t)((player_x - 8) / 32);
    if (IN(ROOM_CELL(probe_col, probe_row), T_DOOR_L, T_DOOR2_L)) {
        push_left++;
        flush_key();
        if (push_left > 10) {
            c = ROOM_CELL(probe_col, probe_row);
            if (c == T_DOOR_L) {
                FOR_DOWNTO(loop_i, 30, 28) door_tick(31);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(42), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(45), PUT_XOR);
                graph_put_image(old_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
                FOR_DOWNTO(loop_i, 27, 25) door_tick(28);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(45), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(44), PUT_XOR);
                FOR_DOWNTO(loop_i, 24, 22) door_tick(25);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(44), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(43), PUT_XOR);
                graph_put_image(old_x - 64, player_y - 8, SPR(player_sprite), PUT_XOR);
                move_mummies();
                if (dagger_flying)
                    move_dagger();
                flush_key();
                ROOM_CELL(probe_col, probe_row) = T_DOOR_R;
            } else if (c == T_DOOR2_L) {
                FOR_DOWNTO(loop_i, 30, 28) door_tick(31);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(46), PUT_XOR);
                graph_put_image(old_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(48), PUT_XOR);
                FOR_DOWNTO(loop_i, 27, 25) door_tick(28);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(48), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(48), PUT_XOR);
                FOR_DOWNTO(loop_i, 24, 22) door_tick(25);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(48), PUT_XOR);
                graph_put_image(old_x - 64, player_y - 8, SPR(player_sprite), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(46), PUT_XOR);
                FOR_DOWNTO(loop_i, 21, 19) door_tick(22);
                move_mummies();
                if (dagger_flying)
                    move_dagger();
            }
            player_x -= 48;
            push_left = 0;
            old_x -= 48;
        } else {
            player_x += 8;
        }
    }

    /* 17DA: 벽 */
    probe_col = (uint8_t)((player_x - 11) / 32);
    probe_row = (uint8_t)((player_y - 6) / 8);
    if (IN(ROOM_CELL(probe_col, probe_row), 43, 47, 53, 54, 175, 222) ||
        IN(ROOM_CELL(probe_col, (player_y + 6) / 8), 43, 47, 50, 53, 54, 175, 222))
        player_x += 8;

    walk_animate();
}

/* ---------------------------------------------------------------------------
 *  원래 0000:1A2C   오른쪽으로 한 걸음 (walk_left 의 거울)
 * ------------------------------------------------------------------------- */
void walk_right(void)
{
    uint8_t c;

    flush_key();
    if (ladder_leave)
        remove_used_ladder();

    ladder_marked = 0;
    if (bridge_left) {
        bridge_latch = 0;
        if (on_bridge == 0)
            bridge_left = 0;
    }

    move_mummies();
    if (on_bridge &&
        (ROOM_CELL(player_x / 32, (player_y + 9) / 8) != T_BRIDGE_USED || bridge_left))
        collapse_bridge();

    check_pickup();
    if (dagger_flying)
        move_dagger();

    old_x = player_x;
    player_x += 8;
    facing_left = 0;
    standing = 0;
    push_left = 0;
    if (player_x > 0x26F) {                     /* 오른쪽 방으로 */
        scratch = cur_room;
        check_room_change();
        if (scratch != cur_room) {
            graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
            old_x = player_x;
        }
    }

    /* 1B2A: 무너지는 다리 */
    if (!IN(ROOM_CELL(player_x / 32, (player_y + 12) / 8), T_BRIDGE, T_BRIDGE_USED)) {
        if (bridge_right)
            bridge_latch = 0;
    } else if (bridge_latch == 0) {
        loop_j = (uint8_t)((player_y + 12) / 8);
        loop_i = (uint8_t)(player_x / 32);
        c = ROOM_CELL(loop_i, loop_j);
        if (c == T_BRIDGE_USED) {
            on_bridge = 1;
            bridge_right = 1;
            bridge_row = loop_j;
        } else if (c == T_BRIDGE) {
            loop_i++;
            do
                loop_i--;
            while (ROOM_CELL((uint16_t)(loop_i - 1), loop_j) == T_BRIDGE);
            bridge_right = 1;
            do {
                ROOM_CELL(loop_i, loop_j) = T_BRIDGE_USED;
                loop_i++;
            } while (ROOM_CELL(loop_i, loop_j) == T_BRIDGE);
        }
        bridge_latch = 1;
    }

    /* 1C7B: 돌 밀기 */
    probe_col = (uint8_t)((player_x + 14) / 32);
    probe_row = (uint8_t)((player_y - 6) / 8);
    if (ROOM_CELL(probe_col, probe_row) == T_STONE) {
        push_right++;
        flush_key();
        if (push_right > 5) {
            if (!IN(ROOM_CELL((uint16_t)(probe_col + 1), probe_row),
                    27, 33, 34, 35, 50, 51, 52, 53, 54, 73, 101, 102, 111, 151, 152, 161, 175, 201, 202, 211, 222) &&
                !IN(ROOM_CELL((uint16_t)(probe_col + 1), (uint16_t)(probe_row + 1)),
                    50, 51, 52, 53, 54, 73, 175, 222)) {
                graph_put_image(probe_col << 5, probe_row << 3, SPR(T_STONE), PUT_XOR);
                ROOM_CELL(probe_col, probe_row) = T_EMPTY;
                stone_room = cur_room;
                if (probe_col == 19) {          /* 오른쪽 방으로 밀려 들어간다 */
                    cell_x = 0x285;
                    move_to_next_room(&stone_room, &cell_x, &cell_y);
                    probe_col = 0;
                }
                if (stone_room == cur_room)
                    graph_put_image((probe_col << 5) + 32, probe_row << 3, SPR(T_STONE), PUT_XOR);
                MAP(stone_room, (uint16_t)(probe_col + 1), probe_row) = T_STONE;
                if (!IN(MAP(stone_room, (uint16_t)(probe_col + 1), (uint16_t)(probe_row + 2)),
                        42, 43, 46, 47, 50, 51, 52, 53, 54, 175, 222)) {
                    /* 1E5F: 여기만 stone_room 이 아니라 cur_room 으로 지운다 (원본 그대로) */
                    ROOM_CELL((uint16_t)(probe_col + 1), probe_row) = T_EMPTY;
                    stone_falling = 1;
                    stone_col = (uint16_t)(probe_col + 1);
                    stone_row = probe_row;
                }
                player_x += 16;
                push_right = 0;
            } else {
                player_x -= 8;
                push_right = 0;
            }
        } else {
            strain_sound();
            player_x -= 8;
        }
    }

    /* 1EFB: 회전문 (43, 47).  probe_row 는 위에서 구한 값 그대로 */
    probe_col = (uint8_t)((player_x + 8) / 32);
    if (IN(ROOM_CELL(probe_col, probe_row), T_DOOR_R, T_DOOR2_R)) {
        push_right++;
        flush_key();
        if (push_right > 10) {
            c = ROOM_CELL(probe_col, probe_row);
            if (c == T_DOOR_R) {
                FOR_DOWNTO(loop_i, 30, 28) door_tick(31);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(43), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(44), PUT_XOR);
                graph_put_image(old_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
                FOR_DOWNTO(loop_i, 27, 25) door_tick(28);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(44), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(45), PUT_XOR);
                FOR_DOWNTO(loop_i, 24, 22) door_tick(25);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(45), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(42), PUT_XOR);
                graph_put_image(old_x + 32, player_y - 8, SPR(player_sprite), PUT_XOR);
                move_mummies();
                if (dagger_flying)
                    move_dagger();
                ROOM_CELL(probe_col, probe_row) = T_DOOR_L;
            } else if (c == T_DOOR2_R) {
                FOR_DOWNTO(loop_i, 30, 28) door_tick(31);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(47), PUT_XOR);
                graph_put_image(old_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(49), PUT_XOR);
                FOR_DOWNTO(loop_i, 27, 25) door_tick(28);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(49), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(49), PUT_XOR);
                FOR_DOWNTO(loop_i, 24, 22) door_tick(25);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(49), PUT_XOR);
                graph_put_image(probe_col << 5, probe_row << 3, SPR(47), PUT_XOR);
                graph_put_image(old_x + 32, player_y - 8, SPR(player_sprite), PUT_XOR);
                FOR_DOWNTO(loop_i, 21, 19) door_tick(22);
                move_mummies();
                if (dagger_flying)
                    move_dagger();
            }
            player_x += 48;
            push_right = 0;
            old_x += 48;
        } else {
            player_x -= 8;
        }
    }

    /* 253D: 벽 */
    probe_col = (uint8_t)((player_x + 11) / 32);
    probe_row = (uint8_t)((player_y - 6) / 8);
    if (IN(ROOM_CELL(probe_col, probe_row), 42, 46, 53, 54, 175, 222) ||
        IN(ROOM_CELL(probe_col, (player_y + 6) / 8), 42, 46, 50, 53, 54, 175, 222))
        player_x -= 8;

    walk_animate();
}

/* ---------------------------------------------------------------------------
 *  원래 0000:278F   점프
 *  네 번 4픽셀씩 오르며 앞으로 가고, 꼭대기에서 한 번 더 앞으로 간 뒤,
 *  발이 닿을 때까지 떨어진다.  standing 이면 제자리 점프.
 * ------------------------------------------------------------------------- */
static void jump_wait(void)
{
    if (dagger_flying) {
        move_dagger();
        crt_delay(4);
    } else {
        crt_delay(6);
    }
}

void jump(void)
{
    probe_col = (uint8_t)((player_x - 10) / 32);
    probe_row = (uint8_t)((player_y - 9) / 8);

    if (!IN(ROOM_CELL(probe_col, probe_row), 53, 54, 175, 222) &&
        !IN(ROOM_CELL((player_x + 11) / 32, probe_row), 53, 54, 175)) {

        work = 1;                               /* 가로 방향 */
        if (facing_left == 1)
            work = -1;
        if (standing == 1)
            work = 0;

        FOR_TO(loop_i, 1, 4) {
            jump_wait();
            check_pickup();
            move_mummies();
            graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
            player_sprite = (uint8_t)(facing_left + 40);
            player_x = (int16_t)((loop_i * 2 - 1) * work + player_x + work);
            if (player_x < -1 || player_x > 0x280)
                check_room_change();
            player_y -= 4;
            crt_sound((uint16_t)(6000 - player_y * 10));
            crt_delay(3);
            crt_nosound();
            probe_col = (uint8_t)((work * 20 + player_x) / 32);
            probe_row = (uint8_t)(player_y / 8);
            if (IN(ROOM_CELL(probe_col, probe_row), 42, 43, 46, 47, 50, 53, 54, 175))
                player_x = (int16_t)(player_x - (loop_i * 2 - 1) * work - work);
            if (dagger_flying)
                move_dagger();
            graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
        }

        jump_wait();
        scratch = 0;                            /* 1 = 벽에 부딪혀 가로로 멈춤 */
        move_mummies();

        /* 29D8: 열을 32 로 나누지 않고 지도를 본다 (원본 그대로) */
        if (!IN(ROOM_CELL(work * 18 + player_x, (player_y - 3) / 8), 42, 43, 46, 47, 50, 53, 54, 175)) {
            graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
            player_x = (int16_t)(work * 8 + player_x);
            if (player_x < -1 || player_x > 0x280)
                check_room_change();
            graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
            check_pickup();
        }

        /* 2A94: 앞이 막혔으면 뒤로 밀린다 */
        {
            int16_t col = (work * 16 + player_x) / 32;

            if ((IN(ROOM_CELL(col, (player_y - 6) / 8), 50, 53, 54, 175, 222) &&
                 IN(ROOM_CELL(col, (player_y + 12) / 8), 50, 53, 54, 175, 222)) ||
                IN(ROOM_CELL(col, (player_y + 6) / 8), 50, 53, 54, 175, 222)) {
                graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
                loop_k++;
                player_x -= work * 14;
                scratch = 1;
                graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
                loop_k++;
            }
        }

        /* 2BD7: 떨어지기 */
        do {
            jump_wait();
            check_pickup();
            move_mummies();
            graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
            loop_k++;
            player_sprite = (uint8_t)(facing_left + 40);
            if (scratch == 0)
                player_x = (int16_t)((loop_i * 2 - 1) * work + player_x);
            if (player_x < -1 || player_x > 0x280)
                check_room_change();
            player_y += 4;
            if (player_y > 0xB7)
                check_room_change();
            crt_sound((uint16_t)(6000 - player_y * 10));
            crt_delay(3);
            crt_nosound();
            probe_col = (uint8_t)((work * 10 + player_x) / 32);
            probe_row = (uint8_t)((player_y - 4) / 8);
            if (IN(ROOM_CELL(probe_col, probe_row), 42, 43, 46, 47, 50, 53, 54, 175, 222) ||
                IN(ROOM_CELL(probe_col, (player_y + 7) / 8), 42, 43, 46, 47, 50, 53, 54, 175, 222)) {
                if (scratch == 0)
                    player_x -= (int16_t)((loop_i * 2 - 1) * work);
                scratch = 1;
                standing = 1;
            }
            if (dagger_flying)
                move_dagger();
            graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
        } while (!(IN(ROOM_CELL((player_x - 8) / 32, (player_y + 7) / 8), 50, 53, 54, 175, 222) ||
                   IN(ROOM_CELL((player_x + 8) / 32, (player_y + 7) / 8), 50, 53, 54, 175, 222) ||
                   (IN(ROOM_CELL(player_x / 32, (player_y + 8) / 8),
                       51, 52, 101, 102, 111, 151, 152, 161, 175, 201, 202, 211, 222, 251, 252) &&
                    IN(ROOM_CELL(player_x / 32, (player_y + 6) / 8), 30, 33, 34, 35, 100))));

        graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
        player_y = (player_y / 8) * 8;
        graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    }

    if (dagger_flying)
        move_dagger();
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    player_sprite = facing_left + held_item;
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    flush_key();
}

/* ---------------------------------------------------------------------------
 *  원래 0000:2F7A   미라에게 잡혀 죽음 (F4 로도)
 *  PCM 비명, 뒤집히는 그림, 떨어지는 소리, 화면을 바깥부터 소용돌이로 지운다.
 * ------------------------------------------------------------------------- */
void player_die(void)
{
    int16_t i;
    uint8_t hi;

    hook_keyboard(0);
    hook_timer(0);
    pcm_play(pcm_die, PCM_DIE_SIZE, 1);
    if (machine_speed >= 1)
        loop_i = machine_speed;                 /* 원본 빈 지연 루프가 남기는 값 */

    music_play(SONG_DIE);                       /* (KVVGA) */
    crt_delay(200);
    graph_put_image(player_x - 16, player_y - 8, SPR(player_sprite), PUT_XOR);
    graph_put_image(player_x - 16, player_y - 8, SPR(41), PUT_XOR);
    for (i = 1; i <= 10; i++) {
        int16_t k;

        for (k = 1; k <= 5; k++) {
            crt_sound((uint16_t)(k * 40 + 100));
            crt_delay(2);
            move_mummies();
        }
        crt_nosound();
        graph_put_image(player_x - 16, player_y - 8, SPR(i % 2 + 40), PUT_XOR);
        graph_put_image(player_x - 16, player_y - 8, SPR((i + 1) % 2 + 40), PUT_XOR);
    }
    graph_put_image(player_x - 16, player_y - 8, SPR(41), PUT_XOR);
    graph_put_image(player_x - 16, player_y - 8, SPR(36), PUT_XOR);

    FOR_DOWNTO(loop_i, 100, 10) {
        crt_sound(loop_i);
        crt_delay(10);
    }
    crt_nosound();
    graph_set_color(0);

    FOR_TO(loop_i, 1, 32)
        SPR(SPR_BLANK_CELL)[3 + loop_i] = 0;

    /* 3186: 바깥 테두리부터 안쪽으로 */
    FOR_TO(loop_i, 0, 11) {
        hi = (uint8_t)(19 - loop_i);
        FOR_TO(loop_j, loop_i, hi)
            graph_put_image(loop_j << 5, loop_i << 3, SPR(SPR_BLANK_CELL), PUT_COPY);
        hi = (uint8_t)(23 - loop_i);
        FOR_TO(loop_j, (uint8_t)(loop_i + 1), hi)
            graph_put_image((19 - loop_i) << 5, loop_j << 3, SPR(SPR_BLANK_CELL), PUT_COPY);
        FOR_DOWNTO(loop_j, (uint8_t)(18 - loop_i), loop_i)
            graph_put_image(loop_j << 5, (23 - loop_i) << 3, SPR(SPR_BLANK_CELL), PUT_COPY);
        FOR_DOWNTO(loop_j, (uint8_t)(22 - loop_i), (uint8_t)(loop_i + 1))
            graph_put_image(loop_i << 5, loop_j << 3, SPR(SPR_BLANK_CELL), PUT_COPY);
    }

    hook_keyboard(1);
    flush_key();
    scan_code = 0x32;
}
