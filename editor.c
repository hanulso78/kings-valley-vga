/* ============================================================================
 *  editor.c  -  스테이지 편집기   (원본 편집기 유닛 0777:01A7)
 * ----------------------------------------------------------------------------
 *  kings-v.dat = 550바이트 레코드 파일
 *      레코드 0          스테이지별 방 수 (STAGE_ROOMS)
 *      레코드 1..        스테이지 1 의 방들, 스테이지 2 의 방들, ... 차례로
 *  스테이지 s 의 첫 방 = 1 + (스테이지 1..s-1 의 방 수 합).
 *  방 1 레코드의 21번 열(room_grid)이 3x3 배치표 'a'..'i' -> 방 번호다.
 *
 *  편집 키
 *      화살표   커서 이동 (F2 켜짐: 떠나는 칸에 타일을 찍음, F5 켜짐: 떠나는 칸을 지움)
 *      F1 타일 놓기, F3/F4 다음/이전 타일, F9 방 전체 지우기, Space 지우기,
 *      a..i 방 바꾸기, ESC 저장하고 끝
 * ========================================================================== */
#include <stdio.h>
#include <string.h>

#include "kv.h"

static FILE *dat;

/* 터보 파스칼 {$I+} 파일 입출력 - 실패하면 런타임 오류로 끝난다 */
static void dat_reset(void)
{
    dat = fopen("kings-v.dat", "r+b");
    if (dat == NULL)
        runtime_error(2);
}

static void dat_read(uint8_t *rec)
{
    if (fread(rec, 1, ROOM_SIZE, dat) != ROOM_SIZE)
        runtime_error(100);
}

static void dat_write(const uint8_t *rec)
{
    if (fwrite(rec, 1, ROOM_SIZE, dat) != ROOM_SIZE)
        runtime_error(101);
}

static void dat_seek(long rec)
{
    if (fseek(dat, rec * ROOM_SIZE, SEEK_SET) != 0)
        runtime_error(100);
}

static void dat_close(void)
{
    fclose(dat);
    dat = NULL;
}

/* 커서 = 고른 타일을 XOR 로 그린 것 */
static void draw_cursor(int x, int y, int tile)
{
    graph_put_image(x << 5, y << 3, SPR(editor_tiles[tile]), PUT_XOR);
}

/* 32픽셀 폭, n 줄을 검정 선으로 지운다 */
static void clear_cell_lines(int x, int y, int n)
{
    int i;

    graph_set_color(0);
    for (i = 0; i <= n; i++)
        graph_line(x << 5, (y << 3) + i, (x << 5) + 31, (y << 3) + i);
    graph_set_color(15);
}

static void draw_room(void)
{
    int x, y;

    for (x = 0; x < ROOM_COLS; x++)
        for (y = 0; y < ROOM_ROWS; y++) {
            uint8_t c = ROOM_CELL(x, y);

            if (c <= 88 || c == 175)
                graph_put_image(x << 5, y << 3, SPR(c), PUT_COPY);
        }
}

static void draw_room_title(char letter)
{
    char line[40];

    sprintf(text_buf, "%u", stage);             /* Str(stage, s) */
    sprintf(line, "stage %s    room %c", text_buf, letter);
    draw_text(5, 20, line);
}

/* 스테이지 번호 입력 칸의 숫자 지우기 */
static void erase_input(int from, int to)
{
    int x;

    graph_set_color(0);
    if (from <= to)
        for (x = from; x <= to; x++)
            graph_line(x, 20, x, 30);
    graph_set_color(15);
}

/* ---------------------------------------------------------------------------
 *  원래 0777:01A7
 * ------------------------------------------------------------------------- */
void stage_editor(void)
{
    int i, j, k, col, n;
    int cur_x, cur_y, tile;
    uint8_t key, paint, erase;
    char chr[2] = { 0, 0 };

    /* 01AE: 스프라이트를 처음부터 다시 */
    tune_pos = 0xFFFF;
    for (i = 0x00; i <= 0x32; i++) { SPR(i)[0] = 0x1F; SPR(i)[1] = 0; SPR(i)[2] = 0x0F; SPR(i)[3] = 0;
        for (j = 1; j <= 0x40; j++) { tune_pos++; SPR(i)[3 + j] = sprite_bits[tune_pos]; } }
    for (i = 0x33; i <= 0x40; i++) { SPR(i)[0] = 0x1F; SPR(i)[1] = 0; SPR(i)[2] = 0x07; SPR(i)[3] = 0;
        for (j = 1; j <= 0x20; j++) { tune_pos++; SPR(i)[3 + j] = sprite_bits[tune_pos]; } }
    for (i = 0x41; i <= 0x48; i++) { SPR(i)[0] = 0x27; SPR(i)[1] = 0; SPR(i)[2] = 0x0F; SPR(i)[3] = 0;
        for (j = 1; j <= 0x50; j++) { tune_pos++; SPR(i)[3 + j] = sprite_bits[tune_pos]; } }
    for (i = 0x49; i <= 0x6E; i++) { SPR(i)[0] = 0x1F; SPR(i)[1] = 0; SPR(i)[2] = 0x0F; SPR(i)[3] = 0;
        for (j = 1; j <= 0x40; j++) { tune_pos++; SPR(i)[3 + j] = sprite_bits[tune_pos]; } }
    for (i = 0x6F; i <= 0x8A; i++) { SPR(i)[0] = 0x1F; SPR(i)[1] = 0; SPR(i)[2] = 0x07; SPR(i)[3] = 0;
        for (j = 1; j <= 0x20; j++) { tune_pos++; SPR(i)[3 + j] = sprite_bits[tune_pos]; } }
    for (i = 0x8B; i <= 0xAE; i++) { SPR(i)[0] = 0x12; SPR(i)[1] = 0; SPR(i)[2] = 0x06; SPR(i)[3] = 0;
        for (j = 1; j <= 0x15; j++) { tune_pos++; SPR(i)[3 + j] = sprite_bits[tune_pos]; } }
    memmove(SPR(SPR_BRIDGE), SPR(0x33), SPRITE_REC);
    memmove(SPR(0x33), SPR(0x6F), SPRITE_REC);

    /* 0422: 스테이지 목록을 읽는다.  파일이 없으면 만든다 */
    for (i = 0; i <= 21; i++)
        for (j = 0; j <= 24; j++)
            rooms[i * ROOM_ROWS_ALL + j] = 0;
    dat = fopen("kings-v.dat", "r+b");
    if (dat == NULL) {
        dat = fopen("kings-v.dat", "w+b");
        if (dat == NULL)
            runtime_error(5);
    } else {
        dat_read(rooms);
    }
    dat_close();

    graph_init();                               /* InitGraph(Detect) */
    graph_clear_device();
    graph_set_color(15);
    graph_rectangle(0, 0, 0x27F, 0xC7);
    draw_text(7, 8, "insert data disk");
    draw_text(7, 10, "and press return");
    draw_text(10, 13, "esc to quit");
    key = crt_readkey();
    if (key == 0x1B)
        goto ask_more;

edit_another:
    graph_clear_device();
    graph_set_color(15);
    graph_rectangle(0, 0, 0x27F, 0xC7);
    draw_text(5, 2, "stage");
    graph_rectangle(0, 0, 0x27F, 0xC7);

enter_stage:
    /* 058A: 스테이지 번호 */
    col = 11;
    stage = 0;
    do {
        key = crt_readkey();
        if (key >= '0' && key <= '9') {
            chr[0] = (char)key;
            draw_text(col, 2, chr);
            col++;
            stage = (uint8_t)(stage * 10 + key - '0');
        }
        if (key == 8 && col > 11) {
            col--;
            erase_input(col * 20, col * 20 + 20);
            stage = (uint8_t)(stage / 10);
        }
    } while (key != 13);

    key = ' ';
    if (stage > 1 && !(STAGE_ROOMS(stage - 1) >= 1 && STAGE_ROOMS(stage - 1) <= 9)) {
        erase_input(220, 500);                  /* 앞 스테이지가 없으면 다시 */
        goto enter_stage;
    }

    /* 06D3: 벽 무늬 */
    col = ((stage - 1) / 10) % 7;
    memmove(SPR(0x33), SPR(col * 4 + 0x6F), SPRITE_REC);
    for (i = 1; i <= 3; i++)
        memmove(SPR(i + 0x34), SPR(col * 4 + 0x6F + i), SPRITE_REC);

    /* 0756: 있는 스테이지면 방들을 읽는다 */
    col = 1;
    if (STAGE_ROOMS(stage) >= 1 && STAGE_ROOMS(stage) <= 9) {
        if (stage > 1)
            for (i = 1; i <= stage - 1; i++)
                col += STAGE_ROOMS(i);
        dat_reset();
        dat_seek(col);
        n = STAGE_ROOMS(stage);
        for (i = 1; i <= n; i++)
            dat_read(rooms + i * ROOM_SIZE);
        dat_close();
        goto save_list;
    }

new_stage:
    /* 0889: 방 수와 배치 */
    draw_text(5, 4, "number of rooms");
    do {
        key = crt_readkey();
        if (key >= '1' && key <= '9') {
            chr[0] = (char)key;
            draw_text(22, 4, chr);
        }
    } while (!(key >= '1' && key <= '9'));
    STAGE_ROOMS(stage) = (uint8_t)(key - '0');

    n = STAGE_ROOMS(stage);
    for (i = 1; i <= n; i++)
        for (j = 0; j <= 21; j++)
            for (k = 0; k <= 23; k++)
                MAP(i, j, k) = T_EMPTY;

    for (col = 0; col <= 8; col++) {
        graph_rectangle((col % 3) * 115 + 100, (col / 3) * 30 + 60,
                        (col % 3) * 115 + 215, (col / 3) * 30 + 90);
        chr[0] = (char)(col + 'a');
        draw_text((col % 3) * 6 + 7, (col / 3) * 3 + 7, chr);
    }

    draw_text(5, 16, "select rooms");
    col = 3;
    key = ' ';
    n = STAGE_ROOMS(stage);
    for (k = 1; k <= n; k++) {                  /* 잘못 누른 키도 한 번으로 센다 */
        key = crt_readkey();
        if (key >= 'a' && key <= 'i') {
            col += 2;
            chr[0] = (char)key;
            draw_text(col, 17, chr);
            room_grid[key - 0x60] = (uint8_t)k;
        }
    }

    draw_text(5, 19, "if all right press y key");
    key = crt_readkey();
    if (key == 'N' || key == 'n') {
        graph_clear_device();
        graph_set_color(15);
        draw_text(5, 2, "stage");
        graph_rectangle(0, 0, 0x27F, 0xC7);
        STAGE_ROOMS(stage) = 0;
        goto enter_stage;
    }
    if (!(key == 'Y' || key == 'y'))
        goto new_stage;

save_list:
    /* 0B78: 스테이지 목록을 파일 처음에 쓴다 */
    dat_reset();
    dat_write(rooms);
    dat_close();

    graph_clear_device();
    tile = 1;
    cur_x = 0;
    cur_y = 0;
    paint = 0;
    erase = 0;

    i = 0;
    do
        i++;
    while (!(room_grid[i] >= 1 && room_grid[i] <= 9));
    cur_room = (uint8_t)i;                      /* 방 번호가 아니라 글자 번호를 넣는다 (원본 그대로) */
    start_room = (uint8_t)i;
    draw_room_title((char)(i + 0x60));
    draw_room();
    draw_cursor(cur_x, cur_y, tile);

    /* 0D3C: 편집 */
    do {
        key = crt_readkey();
        if (key == 0) {
            key = crt_readkey();
            crt_sound(100);
            crt_delay(10);
            crt_nosound();

            if (key == SC_UP || key == SC_LEFT || key == SC_RIGHT || key == SC_DOWN) {
                draw_cursor(cur_x, cur_y, tile);
                if (paint) {
                    if (!(ROOM_CELL(cur_x, cur_y) == 24 || ROOM_CELL(cur_x, cur_y) == 27))
                        clear_cell_lines(cur_x, cur_y, 7);
                    else
                        graph_set_color(15);
                    draw_cursor(cur_x, cur_y, tile);
                    ROOM_CELL(cur_x, cur_y) = editor_tiles[tile];
                }
                if (erase) {
                    clear_cell_lines(cur_x, cur_y, 7);
                    ROOM_CELL(cur_x, cur_y) = T_EMPTY;
                }
                if (key == SC_UP) {
                    if (--cur_y < 0) cur_y = 23;
                } else if (key == SC_LEFT) {
                    if (--cur_x < 0) cur_x = 19;
                } else if (key == SC_RIGHT) {
                    if (++cur_x > 19) cur_x = 0;
                } else if (key == SC_DOWN) {
                    if (++cur_y > 23) cur_y = 0;
                }
                draw_cursor(cur_x, cur_y, tile);
            } else if (key == SC_F1) {          /* 타일 놓기 */
                graph_put_image(cur_x << 5, cur_y << 3, SPR(editor_tiles[tile]), PUT_COPY);
                draw_cursor(cur_x, cur_y, tile);
                ROOM_CELL(cur_x, cur_y) = editor_tiles[tile];
            } else if (key == SC_F2) {
                paint = !paint;
            } else if (key == SC_F3) {
                draw_cursor(cur_x, cur_y, tile);
                if (++tile > EDITOR_TILES) tile = 1;
                draw_cursor(cur_x, cur_y, tile);
            } else if (key == SC_F4) {
                draw_cursor(cur_x, cur_y, tile);
                if (--tile < 1) tile = EDITOR_TILES;
                draw_cursor(cur_x, cur_y, tile);
            } else if (key == 0x3F) {           /* F5 */
                erase = !erase;
            } else if (key == 0x43) {           /* F9: 방 지우기 (뷰포트는 되돌리지 않는다) */
                graph_set_viewport(0, 0, 0x27F, 0xC0, 1);
                graph_clear_viewport();
                for (i = 0; i < ROOM_COLS; i++)
                    for (j = 0; j < ROOM_ROWS; j++)
                        ROOM_CELL(i, j) = T_EMPTY;
            }
        } else if (key == ' ') {                /* 지우기 */
            if (IN(editor_tiles[tile], 51, 52, 53, 54, 175)) {
                clear_cell_lines(cur_x, cur_y, 7);
                ROOM_CELL(cur_x, cur_y) = T_EMPTY;
            } else {
                clear_cell_lines(cur_x, cur_y, 15);
                ROOM_CELL(cur_x, cur_y) = T_EMPTY;
                ROOM_CELL(cur_x, cur_y + 1) = T_EMPTY;
            }
            draw_cursor(cur_x, cur_y, tile);
        } else if (key >= 'a' && key <= 'i') {  /* 방 바꾸기 */
            if (room_grid[key - 0x60] >= 1 && room_grid[key - 0x60] <= 9) {
                graph_clear_device();
                start_room = (uint8_t)(key - 0x60);
                cur_room = room_grid[key - 0x60];
                draw_room();
                draw_cursor(cur_x, cur_y, tile);
                graph_set_color(0);
                for (i = 0xC1; i <= 0xC7; i++)
                    graph_line(30, i, 60, i);
                graph_set_color(15);
                draw_room_title((char)key);
            }
        }
    } while (key != 0x1B);

    /* 150E: ESC - 방들을 제자리에 쓴다 */
    dat_reset();
    dat_read(rooms);
    col = 1;
    if (STAGE_ROOMS(stage) >= 1 && STAGE_ROOMS(stage) <= 9 && stage > 1)
        for (i = 1; i <= stage - 1; i++)
            col += STAGE_ROOMS(i);
    dat_seek(col);
    n = STAGE_ROOMS(stage);
    for (i = 1; i <= n; i++)
        dat_write(rooms + i * ROOM_SIZE);
    dat_close();

ask_more:
    graph_clear_device();
    graph_set_color(15);
    graph_rectangle(0, 0, 0x27F, 0xC7);
    draw_text(5, 5, "1  edit more");
    draw_text(5, 8, "2  exit edit mode");
    key = crt_readkey();
    if (key == '1')
        goto edit_another;
}
