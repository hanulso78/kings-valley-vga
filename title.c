/* ============================================================================
 *  title.c  -  타이틀 그림, 제작진 화면, 첫 메뉴   (원본 0000:34AB)
 * ========================================================================== */
#include <stdio.h>
#include <stdlib.h>

#include "kv.h"

/* ---------------------------------------------------------------------------
 *  원래 0000:34AB
 *  kings-v.ifm (16384바이트 = CGA 화면 메모리 덤프) 을 읽어 타이틀을 보여 주고,
 *  kings-v.dat 의 레코드 0(스테이지별 방 수)을 읽고, BIOS 스크롤로 제작진을
 *  올린 뒤 메뉴를 돈다.  '1' 이나 '3'(시작 스테이지 고름) 이면 돌아간다.
 * ------------------------------------------------------------------------- */
void title_and_menu(void)
{
    static uint8_t ifm[CGA_MEM_SIZE];
    FILE *f;
    uint8_t c, hi;

    f = fopen("kings-v.ifm", "rb");
    if (f == NULL) {
        printf("!! Cannot find \"kings-v.ifm\" file.\n");
        system_shutdown();
        exit(0);
    }
    fread(ifm, 1, CGA_MEM_SIZE, f);
    fclose(f);

    /* 351C: 원본은 여기서 DetectGraph 로 CGA/MCGA/EGA/VGA 가 아니면 끝냈다 */

    f = fopen("kings-v.dat", "rb");             /* {$I-} - 없어도 그냥 간다 */
    if (f) {
        fread(rooms, 1, ROOM_SIZE, f);
        fclose(f);
    }

    graph_init();                               /* InitGraph(CGA, CGAHi) */
    music_play(SONG_TITLE);                     /* (KVVGA) */
    graph_from_cga(ifm, CGA_MEM_SIZE);          /* Move(ifm, Mem[$B800:0], $4000) */
    crt_delay(3000);

    /* 35CC: 한 줄(8픽셀)씩 올리며 제작진 */
    FOR_TO(scratch, 1, 25) {
        graph_bios_scroll_up(1, 0, 0, 24, 79, 0);
#ifdef KVVGA
        /* (KVVGA) 한 줄씩 일찍 올려 위로 당기고, 아래에 256색 판 만든 이를 더한다 */
        switch (scratch) {
        case 5:  draw_text(10, 18, "staff");                          break;
        case 8:  draw_text(0, 18, "art design and main programmer");  break;
        case 10: draw_text(16, 18, "Oh Jeon Seok ");                  break;
        case 13: draw_text(0, 18, "technical assistant");             break;
        case 15: draw_text(16, 18, "Kim Hea Jin    ");                break;
        case 18: draw_text(0, 18, "game designer");                   break;
        case 20: draw_text(16, 18, "Kyeong yeol  ");                  break;
        case 23: draw_text(0, 18, "vga remaster");                    break;
        case 25: draw_text(16, 18, "Min In Hak");
                 crt_delay(2000);                                     break;
        }
#else
        switch (scratch) {
        case 6:  draw_text(10, 18, "staff");                          break;
        case 9:  draw_text(0, 18, "art design and main programmer");  break;
        case 11: draw_text(16, 18, "Oh Jeon Seok ");                  break;
        case 14: draw_text(0, 18, "technical assistant");             break;
        case 16: draw_text(16, 18, "Kim Hea Jin    ");                break;
        case 19: draw_text(0, 18, "game designer");                   break;
        case 21: draw_text(16, 18, "Kyeong yeol  ");                  break;
        case 25: crt_delay(2000);                                     break;
        }
#endif
        crt_delay(100);
    }
    FOR_TO(loop_i, 1, 25) {
        graph_bios_scroll_up(1, 0, 0, 24, 79, 0);
        crt_delay(100);
    }

    /* 3718: 메뉴 */
    do {
        graph_clear_device();
        stage = 1;
        draw_text(7, 6,  "1  game start");
        draw_text(7, 8,  "2  stage edit");
        draw_text(7, 10, "3  stage load");
        draw_text(7, 12, "4  exit to dos");
        last_key = crt_readkey();

        if (last_key == '2')
            stage_editor();

        if (last_key == '3') {
            char digit[2] = { 0, 0 };

            graph_clear_device();
            graph_set_color(15);
            draw_text(5, 2, "stage");
            graph_rectangle(0, 0, 0x27F, 0xC7);
            for (;;) {
                scratch = 11;                   /* 입력 칸 */
                stage = 0;
                do {
                    c = crt_readkey();
                    if (c >= '0' && c <= '9') {
                        digit[0] = (char)c;
                        draw_text(scratch, 2, digit);
                        scratch++;
                        stage = (uint8_t)(stage * 10 + c - '0');
                    }
                    if (c == 8 && scratch > 11) {           /* Backspace */
                        scratch--;
                        graph_set_color(0);
                        /* 3831: 바이트로 잘려서 둘째 자리부터는 한 줄도 안 지운다 (원본 그대로) */
                        hi = (uint8_t)(scratch * 20 + 20);
                        FOR_TO(loop_j, (uint8_t)(scratch * 20), hi)
                            graph_line(loop_j, 20, loop_j, 30);
                        graph_set_color(15);
                        stage /= 10;
                    }
                } while (c != 13);

                /* 389A: 1 이거나 앞 스테이지가 있으면 된다 */
                if (stage >= 1 && (stage <= 1 ||
                    (STAGE_ROOMS(stage - 1) >= 1 && STAGE_ROOMS(stage - 1) <= 9)))
                    break;

                graph_set_color(0);
                FOR_TO(old_x, 200, 400)
                    graph_line(old_x, 20, old_x, 30);
                graph_set_color(15);
            }
        }

        if (last_key == '4') {
            crt_nosound();
            graph_close();
            system_shutdown();
            exit(0);
        }
    } while (last_key != '1' && last_key != '3');
}
