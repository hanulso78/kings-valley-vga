
;==============================================================================
; SEGMENT 0000  MAIN   (linear 00000..07770)
;==============================================================================
0000  db 00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,00
0010  db 00,00,00,00,02,00,00,00,00,00,08,00,00,00,00,00

; ------------------------------------------------------------
remove_used_ladder:
0020  push   bp
0021  mov    bp, sp
0023  mov    ax, word ptr [0xb05a]             ; player_y
0026  sub    ax, 4
0029  cdq
002a  mov    cx, 8
002d  idiv   cx
002f  mov    byte ptr [0xa3b0], al             ; loop_i
  loc_0032:
0032  inc    byte ptr [0xa3b0]                 ; loop_i
0036  mov    al, byte ptr [0xa3b0]             ; loop_i
0039  xor    ah, ah
003b  inc    ax
003c  mov    bx, ax
003e  mov    al, byte ptr [0xa3c2]             ; ladder_col
0041  xor    ah, ah
0043  mov    dx, 0x19
0046  mul    dx
0048  mov    cx, ax
004a  mov    al, byte ptr [0xa3c5]             ; cur_room
004d  xor    ah, ah
004f  mov    dx, 0x226
0052  mul    dx
0054  mov    di, ax
0056  add    di, cx
0058  add    di, bx
005a  mov    al, byte ptr [di - 0x4a70]        ; +rooms
005e  push   ax
005f  mov    di, 0                             ; set cs:0000 = [111,161,211]
0062  push   cs
0063  push   di
0064  call   Sys_SetIn
0069  jne    0x32
  loc_006b:
006b  mov    al, byte ptr [0xa3b0]             ; loop_i
006e  xor    ah, ah
0070  mov    bx, ax
0072  mov    al, byte ptr [0xa3c2]             ; ladder_col
0075  xor    ah, ah
0077  mov    dx, 0x19
007a  mul    dx
007c  mov    cx, ax
007e  mov    al, byte ptr [0xa3c5]             ; cur_room
0081  xor    ah, ah
0083  mov    dx, 0x226
0086  mul    dx
0088  mov    di, ax
008a  add    di, cx
008c  add    di, bx
008e  cmp    byte ptr [di - 0x4a70], 0x6f      ; +rooms
0093  jne    0xbf
0095  mov    al, byte ptr [0xa3b0]             ; loop_i
0098  xor    ah, ah
009a  mov    bx, ax
009c  mov    al, byte ptr [0xa3c2]             ; ladder_col
009f  xor    ah, ah
00a1  mov    dx, 0x19
00a4  mul    dx
00a6  mov    cx, ax
00a8  mov    al, byte ptr [0xa3c5]             ; cur_room
00ab  xor    ah, ah
00ad  mov    dx, 0x226
00b0  mul    dx
00b2  mov    di, ax
00b4  add    di, cx
00b6  add    di, bx
00b8  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
00bd  jmp    0xe7
  loc_00bf:
00bf  mov    al, byte ptr [0xa3b0]             ; loop_i
00c2  xor    ah, ah
00c4  mov    bx, ax
00c6  mov    al, byte ptr [0xa3c2]             ; ladder_col
00c9  xor    ah, ah
00cb  mov    dx, 0x19
00ce  mul    dx
00d0  mov    cx, ax
00d2  mov    al, byte ptr [0xa3c5]             ; cur_room
00d5  xor    ah, ah
00d7  mov    dx, 0x226
00da  mul    dx
00dc  mov    di, ax
00de  add    di, cx
00e0  add    di, bx
00e2  sub    byte ptr [di - 0x4a70], 0x69      ; +rooms
  loc_00e7:
00e7  mov    al, byte ptr [0xa3c2]             ; ladder_col
00ea  xor    ah, ah
00ec  mov    cx, 5
00ef  shl    ax, cl
00f1  push   ax
00f2  mov    al, byte ptr [0xa3b0]             ; loop_i
00f5  xor    ah, ah
00f7  mov    cx, 3
00fa  shl    ax, cl
00fc  push   ax
00fd  mov    di, 0x7afc
0100  push   ds
0101  push   di
0102  mov    ax, 1
0105  push   ax
0106  call   Graph_PutImage
010b  dec    byte ptr [0xa3b0]                 ; loop_i
010f  mov    byte ptr [0xa3b1], 1              ; loop_j
0114  jmp    0x11a
  loc_0116:
0116  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_011a:
011a  mov    al, byte ptr [0xa3b1]             ; loop_j
011d  xor    ah, ah
011f  mov    cx, 0x32
0122  imul   cx
0124  mov    bx, ax
0126  mov    al, byte ptr [0xa3b0]             ; loop_i
0129  xor    ah, ah
012b  mov    cx, 0x12c
012e  imul   cx
0130  add    ax, bx
0132  push   ax
0133  call   Crt_Sound
0138  mov    ax, 4
013b  push   ax
013c  call   Crt_Delay
0141  cmp    byte ptr [0xa3b1], 0xa            ; loop_j
0146  jne    0x116
0148  mov    al, byte ptr [0xa3b0]             ; loop_i
014b  xor    ah, ah
014d  dec    ax
014e  mov    bx, ax
0150  mov    al, byte ptr [0xa3c2]             ; ladder_col
0153  xor    ah, ah
0155  mov    dx, 0x19
0158  mul    dx
015a  mov    cx, ax
015c  mov    al, byte ptr [0xa3c5]             ; cur_room
015f  xor    ah, ah
0161  mov    dx, 0x226
0164  mul    dx
0166  mov    di, ax
0168  add    di, cx
016a  add    di, bx
016c  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0170  push   ax
0171  mov    di, 0                             ; set cs:0000 = [111,161,211]
0174  push   cs
0175  push   di
0176  call   Sys_SetIn
017b  je     0x180
017d  jmp    0x6b
  loc_0180:
0180  mov    al, byte ptr [0xa3c2]             ; ladder_col
0183  xor    ah, ah
0185  mov    cx, 5
0188  shl    ax, cl
018a  push   ax
018b  mov    al, byte ptr [0xa3b0]             ; loop_i
018e  xor    ah, ah
0190  mov    cx, 3
0193  shl    ax, cl
0195  push   ax
0196  mov    di, 0x7afc
0199  push   ds
019a  push   di
019b  mov    ax, 1
019e  push   ax
019f  call   Graph_PutImage
01a4  mov    al, byte ptr [0xa3c2]             ; ladder_col
01a7  xor    ah, ah
01a9  mov    cx, 5
01ac  shl    ax, cl
01ae  push   ax
01af  mov    al, byte ptr [0xa3b0]             ; loop_i
01b2  xor    ah, ah
01b4  mov    cx, 3
01b7  shl    ax, cl
01b9  push   ax
01ba  mov    di, 0x7b50
01bd  push   ds
01be  push   di
01bf  mov    ax, 1
01c2  push   ax
01c3  call   Graph_PutImage
01c8  mov    al, byte ptr [0xa3b0]             ; loop_i
01cb  xor    ah, ah
01cd  mov    bx, ax
01cf  mov    al, byte ptr [0xa3c2]             ; ladder_col
01d2  xor    ah, ah
01d4  mov    dx, 0x19
01d7  mul    dx
01d9  mov    cx, ax
01db  mov    al, byte ptr [0xa3c5]             ; cur_room
01de  xor    ah, ah
01e0  mov    dx, 0x226
01e3  mul    dx
01e5  mov    di, ax
01e7  add    di, cx
01e9  add    di, bx
01eb  cmp    byte ptr [di - 0x4a70], 0x6f      ; +rooms
01f0  jne    0x21c
01f2  mov    al, byte ptr [0xa3b0]             ; loop_i
01f5  xor    ah, ah
01f7  mov    bx, ax
01f9  mov    al, byte ptr [0xa3c2]             ; ladder_col
01fc  xor    ah, ah
01fe  mov    dx, 0x19
0201  mul    dx
0203  mov    cx, ax
0205  mov    al, byte ptr [0xa3c5]             ; cur_room
0208  xor    ah, ah
020a  mov    dx, 0x226
020d  mul    dx
020f  mov    di, ax
0211  add    di, cx
0213  add    di, bx
0215  mov    byte ptr [di - 0x4a70], 0x35      ; +rooms
021a  jmp    0x244
  loc_021c:
021c  mov    al, byte ptr [0xa3b0]             ; loop_i
021f  xor    ah, ah
0221  mov    bx, ax
0223  mov    al, byte ptr [0xa3c2]             ; ladder_col
0226  xor    ah, ah
0228  mov    dx, 0x19
022b  mul    dx
022d  mov    cx, ax
022f  mov    al, byte ptr [0xa3c5]             ; cur_room
0232  xor    ah, ah
0234  mov    dx, 0x226
0237  mul    dx
0239  mov    di, ax
023b  add    di, cx
023d  add    di, bx
023f  sub    byte ptr [di - 0x4a70], 0x69      ; +rooms
  loc_0244:
0244  mov    byte ptr [0xcb16], 0              ; ladder_leave
0249  mov    sp, bp
024b  pop    bp
024c  retf

; ------------------------------------------------------------
collapse_bridge:
024d  push   bp
024e  mov    bp, sp
0250  mov    ax, word ptr [0xb058]             ; player_x
0253  add    ax, 0x10
0256  cdq
0257  mov    cx, 0x20
025a  idiv   cx
025c  mov    byte ptr [0xa3b0], al             ; loop_i
  loc_025f:
025f  cmp    byte ptr [0xa3bf], 0              ; facing_left
0264  jne    0x26c
0266  dec    byte ptr [0xa3b0]                 ; loop_i
026a  jmp    0x270
  loc_026c:
026c  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_0270:
0270  mov    al, byte ptr [0xa3c3]             ; bridge_row
0273  xor    ah, ah
0275  mov    bx, ax
0277  mov    al, byte ptr [0xa3b0]             ; loop_i
027a  xor    ah, ah
027c  mov    dx, 0x19
027f  mul    dx
0281  mov    cx, ax
0283  mov    al, byte ptr [0xa3c5]             ; cur_room
0286  xor    ah, ah
0288  mov    dx, 0x226
028b  mul    dx
028d  mov    di, ax
028f  add    di, cx
0291  add    di, bx
0293  cmp    byte ptr [di - 0x4a70], 0xde      ; +rooms
0298  je     0x25f
  loc_029a:
029a  cmp    byte ptr [0xa3bf], 0              ; facing_left
029f  jne    0x2a7
02a1  inc    byte ptr [0xa3b0]                 ; loop_i
02a5  jmp    0x2ab
  loc_02a7:
02a7  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_02ab:
02ab  mov    al, byte ptr [0xa3c3]             ; bridge_row
02ae  xor    ah, ah
02b0  mov    bx, ax
02b2  mov    al, byte ptr [0xa3b0]             ; loop_i
02b5  xor    ah, ah
02b7  mov    dx, 0x19
02ba  mul    dx
02bc  mov    cx, ax
02be  mov    al, byte ptr [0xa3c5]             ; cur_room
02c1  xor    ah, ah
02c3  mov    dx, 0x226
02c6  mul    dx
02c8  mov    di, ax
02ca  add    di, cx
02cc  add    di, bx
02ce  cmp    byte ptr [di - 0x4a70], 0xde      ; +rooms
02d3  jne    0x29a
  loc_02d5:
02d5  mov    al, byte ptr [0xa3c3]             ; bridge_row
02d8  xor    ah, ah
02da  mov    bx, ax
02dc  mov    al, byte ptr [0xa3b0]             ; loop_i
02df  xor    ah, ah
02e1  mov    dx, 0x19
02e4  mul    dx
02e6  mov    cx, ax
02e8  mov    al, byte ptr [0xa3c5]             ; cur_room
02eb  xor    ah, ah
02ed  mov    dx, 0x226
02f0  mul    dx
02f2  mov    di, ax
02f4  add    di, cx
02f6  add    di, bx
02f8  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
02fd  mov    al, byte ptr [0xa3b0]             ; loop_i
0300  xor    ah, ah
0302  mov    cx, 5
0305  shl    ax, cl
0307  push   ax
0308  mov    al, byte ptr [0xa3c3]             ; bridge_row
030b  xor    ah, ah
030d  mov    cx, 3
0310  shl    ax, cl
0312  push   ax
0313  mov    di, 0xa358
0316  push   ds
0317  push   di
0318  mov    ax, 1
031b  push   ax
031c  call   Graph_PutImage
0321  cmp    byte ptr [0xa3bf], 0              ; facing_left
0326  jne    0x32e
0328  inc    byte ptr [0xa3b0]                 ; loop_i
032c  jmp    0x332
  loc_032e:
032e  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_0332:
0332  mov    byte ptr [0xa3b1], 1              ; loop_j
0337  jmp    0x33d
  loc_0339:
0339  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_033d:
033d  mov    al, byte ptr [0xa3b1]             ; loop_j
0340  xor    ah, ah
0342  mov    cx, 0x28
0345  imul   cx
0347  mov    bx, ax
0349  mov    al, byte ptr [0xa3b0]             ; loop_i
034c  xor    ah, ah
034e  mov    cx, 0x64
0351  imul   cx
0353  add    ax, bx
0355  push   ax
0356  call   Crt_Sound
035b  mov    ax, 4
035e  push   ax
035f  call   Crt_Delay
0364  cmp    byte ptr [0xa3b1], 0xa            ; loop_j
0369  jne    0x339
036b  mov    al, byte ptr [0xa3c3]             ; bridge_row
036e  xor    ah, ah
0370  sub    ax, 2
0373  mov    bx, ax
0375  mov    al, byte ptr [0xa3b0]             ; loop_i
0378  xor    ah, ah
037a  mov    dx, 0x19
037d  mul    dx
037f  mov    cx, ax
0381  mov    al, byte ptr [0xa3c5]             ; cur_room
0384  xor    ah, ah
0386  mov    dx, 0x226
0389  mul    dx
038b  mov    di, ax
038d  add    di, cx
038f  add    di, bx
0391  cmp    byte ptr [di - 0x4a70], 0x32      ; +rooms
0396  jne    0x3db
0398  mov    al, byte ptr [0xa3b0]             ; loop_i
039b  xor    ah, ah
039d  mov    word ptr [0xb08a], ax             ; stone_col
03a0  mov    al, byte ptr [0xa3c3]             ; bridge_row
03a3  xor    ah, ah
03a5  sub    ax, 2
03a8  mov    word ptr [0xb08c], ax             ; stone_row
03ab  mov    byte ptr [0xcb0f], 1              ; stone_falling
03b0  mov    al, byte ptr [0xa3c3]             ; bridge_row
03b3  xor    ah, ah
03b5  sub    ax, 2
03b8  mov    bx, ax
03ba  mov    al, byte ptr [0xa3b0]             ; loop_i
03bd  xor    ah, ah
03bf  mov    dx, 0x19
03c2  mul    dx
03c4  mov    cx, ax
03c6  mov    al, byte ptr [0xa3c5]             ; cur_room
03c9  xor    ah, ah
03cb  mov    dx, 0x226
03ce  mul    dx
03d0  mov    di, ax
03d2  add    di, cx
03d4  add    di, bx
03d6  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
  loc_03db:
03db  mov    al, byte ptr [0xa3c3]             ; bridge_row
03de  xor    ah, ah
03e0  mov    bx, ax
03e2  mov    al, byte ptr [0xa3b0]             ; loop_i
03e5  xor    ah, ah
03e7  mov    dx, 0x19
03ea  mul    dx
03ec  mov    cx, ax
03ee  mov    al, byte ptr [0xa3c5]             ; cur_room
03f1  xor    ah, ah
03f3  mov    dx, 0x226
03f6  mul    dx
03f8  mov    di, ax
03fa  add    di, cx
03fc  add    di, bx
03fe  cmp    byte ptr [di - 0x4a70], 0xde      ; +rooms
0403  jne    0x408
0405  jmp    0x2d5
  loc_0408:
0408  mov    byte ptr [0xcb13], 0              ; bridge_left
040d  mov    byte ptr [0xcb14], 0              ; bridge_right
0412  mov    byte ptr [0xcb17], 0              ; bridge_latch
0417  mov    byte ptr [0xcb18], 0              ; on_bridge
041c  mov    sp, bp
041e  pop    bp
041f  retf
0420  db 00,00,00,00,00,00,10,00,00,00,00,00,40,80,00,00
0430  db 00,00,00,01,02,00,00,00,00,00,08,00,00,00,00,00
0440  db 00,00,00,00,00,00,10,00,00,00,00,00,40,00,00,00
0450  db 00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00
0460  db 00,00,00,00,00,00,60,00,00,00,00,00,00,00,00,00
0470  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00

; ------------------------------------------------------------
climb_up:
0480  push   bp
0481  mov    bp, sp
0483  mov    ax, word ptr [0xb058]             ; player_x
0486  sub    ax, 0x10
0489  push   ax
048a  mov    ax, word ptr [0xb05a]             ; player_y
048d  sub    ax, 8
0490  push   ax
0491  mov    al, byte ptr [0xa3c0]             ; player_sprite
0494  xor    ah, ah
0496  mov    dx, 0x54
0499  mul    dx
049b  mov    di, ax
049d  add    di, 0x69ec
04a1  push   ds
04a2  push   di
04a3  mov    ax, 1
04a6  push   ax
04a7  call   Graph_PutImage
04ac  mov    ax, word ptr [0xb058]             ; player_x
04af  cdq
04b0  mov    cx, 0x20
04b3  idiv   cx
04b5  mov    cx, 5
04b8  shl    ax, cl
04ba  add    ax, 0x10
04bd  mov    word ptr [0xb058], ax             ; player_x
04c0  mov    ax, word ptr [0xb058]             ; player_x
04c3  sub    ax, 0x10
04c6  push   ax
04c7  mov    ax, word ptr [0xb05a]             ; player_y
04ca  sub    ax, 8
04cd  push   ax
04ce  mov    al, byte ptr [0xa3c0]             ; player_sprite
04d1  xor    ah, ah
04d3  mov    dx, 0x54
04d6  mul    dx
04d8  mov    di, ax
04da  add    di, 0x69ec
04de  push   ds
04df  push   di
04e0  mov    ax, 1
04e3  push   ax
04e4  call   Graph_PutImage
04e9  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
04ee  je     0x500
04f0  call   move_dagger
04f5  mov    ax, 1
04f8  push   ax
04f9  call   Crt_Delay
04fe  jmp    0x509
  loc_0500:
0500  mov    ax, 4
0503  push   ax
0504  call   Crt_Delay
  loc_0509:
0509  call   move_mummies
050e  cmp    byte ptr [0x2965], 0              ; ladder_marked_down
0513  je     0x51f
0515  mov    byte ptr [0xcb15], 0              ; ladder_marked
051a  mov    byte ptr [0x2965], 0              ; ladder_marked_down
  loc_051f:
051f  inc    word ptr [0xb068]                 ; walk_count
0523  cmp    word ptr [0xb068], 0x3e8          ; walk_count
0529  jle    0x531
052b  mov    word ptr [0xb068], 1              ; walk_count
  loc_0531:
0531  call   check_pickup
0536  mov    ax, word ptr [0xb058]             ; player_x
0539  sub    ax, 0x10
053c  push   ax
053d  mov    ax, word ptr [0xb05a]             ; player_y
0540  sub    ax, 8
0543  push   ax
0544  mov    al, byte ptr [0xa3c0]             ; player_sprite
0547  xor    ah, ah
0549  mov    dx, 0x54
054c  mul    dx
054e  mov    di, ax
0550  add    di, 0x69ec
0554  push   ds
0555  push   di
0556  mov    ax, 1
0559  push   ax
055a  call   Graph_PutImage
055f  sub    word ptr [0xb05a], 4              ; player_y
0564  cmp    word ptr [0xb05a], 8              ; player_y
0569  jge    0x570
056b  call   check_room_change
  loc_0570:
0570  mov    ax, word ptr [0xb05a]             ; player_y
0573  add    ax, 6
0576  cdq
0577  mov    cx, 8
057a  idiv   cx
057c  mov    bx, ax
057e  mov    ax, word ptr [0xb058]             ; player_x
0581  cdq
0582  mov    cx, 0x20
0585  idiv   cx
0587  mov    dx, 0x19
058a  mul    dx
058c  mov    cx, ax
058e  mov    al, byte ptr [0xa3c5]             ; cur_room
0591  xor    ah, ah
0593  mov    dx, 0x226
0596  mul    dx
0598  mov    di, ax
059a  add    di, cx
059c  add    di, bx
059e  mov    al, byte ptr [di - 0x4a70]        ; +rooms
05a2  push   ax
05a3  mov    di, 0x420                         ; set cs:0420 = [52,102,111,152,161,211]
05a6  push   cs
05a7  push   di
05a8  call   Sys_SetIn
05ad  jne    0x5b2
05af  jmp    0x72d
  loc_05b2:
05b2  cmp    byte ptr [0xcb15], 0              ; ladder_marked
05b7  je     0x5bc
05b9  jmp    0x72d
  loc_05bc:
05bc  mov    ax, word ptr [0xb05a]             ; player_y
05bf  add    ax, 6
05c2  cdq
05c3  mov    cx, 8
05c6  idiv   cx
05c8  mov    byte ptr [0xa3b0], al             ; loop_i
05cb  mov    ax, word ptr [0xb058]             ; player_x
05ce  cdq
05cf  mov    cx, 0x20
05d2  idiv   cx
05d4  mov    byte ptr [0xa3b1], al             ; loop_j
05d7  mov    al, byte ptr [0xa3b0]             ; loop_i
05da  xor    ah, ah
05dc  mov    bx, ax
05de  mov    al, byte ptr [0xa3b1]             ; loop_j
05e1  xor    ah, ah
05e3  mov    dx, 0x19
05e6  mul    dx
05e8  mov    cx, ax
05ea  mov    al, byte ptr [0xa3c5]             ; cur_room
05ed  xor    ah, ah
05ef  mov    dx, 0x226
05f2  mul    dx
05f4  mov    di, ax
05f6  add    di, cx
05f8  add    di, bx
05fa  mov    al, byte ptr [di - 0x4a70]        ; +rooms
05fe  xor    ah, ah
0600  cmp    ax, 0x6f
0603  je     0x60f
0605  cmp    ax, 0xa1
0608  je     0x60f
060a  cmp    ax, 0xd3
060d  jne    0x61d
  loc_060f:
060f  mov    byte ptr [0xcb16], 1              ; ladder_leave
0614  mov    al, byte ptr [0xa3b1]             ; loop_j
0617  mov    byte ptr [0xa3c2], al             ; ladder_col
061a  jmp    0x728
  loc_061d:
061d  cmp    ax, 0x34
0620  je     0x62f
0622  cmp    ax, 0x66
0625  je     0x62f
0627  cmp    ax, 0x98
062a  je     0x62f
062c  jmp    0x728
  loc_062f:
062f  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_0633:
0633  inc    byte ptr [0xa3b0]                 ; loop_i
0637  mov    al, byte ptr [0xa3b0]             ; loop_i
063a  xor    ah, ah
063c  inc    ax
063d  mov    bx, ax
063f  mov    al, byte ptr [0xa3b1]             ; loop_j
0642  xor    ah, ah
0644  mov    dx, 0x19
0647  mul    dx
0649  mov    cx, ax
064b  mov    al, byte ptr [0xa3c5]             ; cur_room
064e  xor    ah, ah
0650  mov    dx, 0x226
0653  mul    dx
0655  mov    di, ax
0657  add    di, cx
0659  add    di, bx
065b  mov    al, byte ptr [di - 0x4a70]        ; +rooms
065f  push   ax
0660  mov    di, 0x440                         ; set cs:0440 = [52,102,152]
0663  push   cs
0664  push   di
0665  call   Sys_SetIn
066a  jne    0x633
066c  mov    byte ptr [0x2964], 1              ; ladder_marked_up
  loc_0671:
0671  mov    al, byte ptr [0xa3b0]             ; loop_i
0674  xor    ah, ah
0676  mov    bx, ax
0678  mov    al, byte ptr [0xa3b1]             ; loop_j
067b  xor    ah, ah
067d  mov    dx, 0x19
0680  mul    dx
0682  mov    cx, ax
0684  mov    al, byte ptr [0xa3c5]             ; cur_room
0687  xor    ah, ah
0689  mov    dx, 0x226
068c  mul    dx
068e  mov    di, ax
0690  add    di, cx
0692  add    di, bx
0694  cmp    byte ptr [di - 0x4a70], 0x34      ; +rooms
0699  jne    0x6c5
069b  mov    al, byte ptr [0xa3b0]             ; loop_i
069e  xor    ah, ah
06a0  mov    bx, ax
06a2  mov    al, byte ptr [0xa3b1]             ; loop_j
06a5  xor    ah, ah
06a7  mov    dx, 0x19
06aa  mul    dx
06ac  mov    cx, ax
06ae  mov    al, byte ptr [0xa3c5]             ; cur_room
06b1  xor    ah, ah
06b3  mov    dx, 0x226
06b6  mul    dx
06b8  mov    di, ax
06ba  add    di, cx
06bc  add    di, bx
06be  mov    byte ptr [di - 0x4a70], 0x6f      ; +rooms
06c3  jmp    0x6ed
  loc_06c5:
06c5  mov    al, byte ptr [0xa3b0]             ; loop_i
06c8  xor    ah, ah
06ca  mov    bx, ax
06cc  mov    al, byte ptr [0xa3b1]             ; loop_j
06cf  xor    ah, ah
06d1  mov    dx, 0x19
06d4  mul    dx
06d6  mov    cx, ax
06d8  mov    al, byte ptr [0xa3c5]             ; cur_room
06db  xor    ah, ah
06dd  mov    dx, 0x226
06e0  mul    dx
06e2  mov    di, ax
06e4  add    di, cx
06e6  add    di, bx
06e8  add    byte ptr [di - 0x4a70], 0x3b      ; +rooms
  loc_06ed:
06ed  dec    byte ptr [0xa3b0]                 ; loop_i
06f1  mov    al, byte ptr [0xa3b0]             ; loop_i
06f4  xor    ah, ah
06f6  mov    bx, ax
06f8  mov    al, byte ptr [0xa3b1]             ; loop_j
06fb  xor    ah, ah
06fd  mov    dx, 0x19
0700  mul    dx
0702  mov    cx, ax
0704  mov    al, byte ptr [0xa3c5]             ; cur_room
0707  xor    ah, ah
0709  mov    dx, 0x226
070c  mul    dx
070e  mov    di, ax
0710  add    di, cx
0712  add    di, bx
0714  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0718  push   ax
0719  mov    di, 0x440                         ; set cs:0440 = [52,102,152]
071c  push   cs
071d  push   di
071e  call   Sys_SetIn
0723  je     0x728
0725  jmp    0x671
  loc_0728:
0728  mov    byte ptr [0xcb15], 1              ; ladder_marked
  loc_072d:
072d  mov    ax, word ptr [0xb058]             ; player_x
0730  sub    ax, 0xc
0733  cdq
0734  mov    cx, 0x20
0737  idiv   cx
0739  mov    byte ptr [0xa3b5], al             ; probe_col
073c  mov    ax, word ptr [0xb05a]             ; player_y
073f  sub    ax, 7
0742  cdq
0743  mov    cx, 8
0746  idiv   cx
0748  mov    byte ptr [0xa3b6], al             ; probe_row
074b  mov    al, byte ptr [0xa3b6]             ; probe_row
074e  xor    ah, ah
0750  mov    bx, ax
0752  mov    al, byte ptr [0xa3b5]             ; probe_col
0755  xor    ah, ah
0757  mov    dx, 0x19
075a  mul    dx
075c  mov    cx, ax
075e  mov    al, byte ptr [0xa3c5]             ; cur_room
0761  xor    ah, ah
0763  mov    dx, 0x226
0766  mul    dx
0768  mov    di, ax
076a  add    di, cx
076c  add    di, bx
076e  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0772  push   ax
0773  mov    di, 0x460                         ; set cs:0460 = [53,54,175,222]
0776  push   cs
0777  push   di
0778  call   Sys_SetIn
077d  jne    0x7ba
077f  mov    al, byte ptr [0xa3b6]             ; probe_row
0782  xor    ah, ah
0784  mov    bx, ax
0786  mov    ax, word ptr [0xb058]             ; player_x
0789  add    ax, 0xb
078c  cdq
078d  mov    cx, 0x20
0790  idiv   cx
0792  mov    dx, 0x19
0795  mul    dx
0797  mov    cx, ax
0799  mov    al, byte ptr [0xa3c5]             ; cur_room
079c  xor    ah, ah
079e  mov    dx, 0x226
07a1  mul    dx
07a3  mov    di, ax
07a5  add    di, cx
07a7  add    di, bx
07a9  mov    al, byte ptr [di - 0x4a70]        ; +rooms
07ad  push   ax
07ae  mov    di, 0x460                         ; set cs:0460 = [53,54,175,222]
07b1  push   cs
07b2  push   di
07b3  call   Sys_SetIn
07b8  je     0x7bf
  loc_07ba:
07ba  add    word ptr [0xb05a], 4              ; player_y
  loc_07bf:
07bf  mov    ax, word ptr [0xb068]             ; walk_count
07c2  cdq
07c3  mov    cx, 2
07c6  idiv   cx
07c8  xchg   dx, ax
07c9  add    ax, 0x1f
07cc  mov    byte ptr [0xa3c0], al             ; player_sprite
07cf  mov    ax, word ptr [0xb058]             ; player_x
07d2  sub    ax, 0x10
07d5  push   ax
07d6  mov    ax, word ptr [0xb05a]             ; player_y
07d9  sub    ax, 8
07dc  push   ax
07dd  mov    al, byte ptr [0xa3c0]             ; player_sprite
07e0  xor    ah, ah
07e2  mov    dx, 0x54
07e5  mul    dx
07e7  mov    di, ax
07e9  add    di, 0x69ec
07ed  push   ds
07ee  push   di
07ef  mov    ax, 1
07f2  push   ax
07f3  call   Graph_PutImage
07f8  mov    sp, bp
07fa  pop    bp
07fb  retf
07fc  db 00,00,00,00,00,00,10,00,00,00,00,00,40,80,00,00
080c  db 00,00,00,01,02,00,00,00,00,00,08,00,00,00,00,00
081c  db 00,00,00,00,00,00,10,00,00,00,00,00,40,00,00,00
082c  db 00,00,00,01,00,00,00,00,00,00,00,00,00,00,00,00
083c  db 00,00,00,00,00,00,60,00,00,00,00,00,00,00,00,00
084c  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00

; ------------------------------------------------------------
climb_down:
085c  push   bp
085d  mov    bp, sp
085f  mov    ax, word ptr [0xb058]             ; player_x
0862  sub    ax, 0x10
0865  push   ax
0866  mov    ax, word ptr [0xb05a]             ; player_y
0869  sub    ax, 8
086c  push   ax
086d  mov    al, byte ptr [0xa3c0]             ; player_sprite
0870  xor    ah, ah
0872  mov    dx, 0x54
0875  mul    dx
0877  mov    di, ax
0879  add    di, 0x69ec
087d  push   ds
087e  push   di
087f  mov    ax, 1
0882  push   ax
0883  call   Graph_PutImage
0888  mov    ax, word ptr [0xb058]             ; player_x
088b  cdq
088c  mov    cx, 0x20
088f  idiv   cx
0891  mov    cx, 5
0894  shl    ax, cl
0896  add    ax, 0x10
0899  mov    word ptr [0xb058], ax             ; player_x
089c  mov    ax, word ptr [0xb058]             ; player_x
089f  sub    ax, 0x10
08a2  push   ax
08a3  mov    ax, word ptr [0xb05a]             ; player_y
08a6  sub    ax, 8
08a9  push   ax
08aa  mov    al, byte ptr [0xa3c0]             ; player_sprite
08ad  xor    ah, ah
08af  mov    dx, 0x54
08b2  mul    dx
08b4  mov    di, ax
08b6  add    di, 0x69ec
08ba  push   ds
08bb  push   di
08bc  mov    ax, 1
08bf  push   ax
08c0  call   Graph_PutImage
08c5  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
08ca  je     0x8dc
08cc  call   move_dagger
08d1  mov    ax, 1
08d4  push   ax
08d5  call   Crt_Delay
08da  jmp    0x8e5
  loc_08dc:
08dc  mov    ax, 4
08df  push   ax
08e0  call   Crt_Delay
  loc_08e5:
08e5  call   move_mummies
08ea  cmp    byte ptr [0x2964], 0              ; ladder_marked_up
08ef  je     0x8fb
08f1  mov    byte ptr [0xcb15], 0              ; ladder_marked
08f6  mov    byte ptr [0x2964], 0              ; ladder_marked_up
  loc_08fb:
08fb  inc    word ptr [0xb068]                 ; walk_count
08ff  cmp    word ptr [0xb068], 0x3e8          ; walk_count
0905  jle    0x90d
0907  mov    word ptr [0xb068], 1              ; walk_count
  loc_090d:
090d  call   check_pickup
0912  mov    ax, word ptr [0xb058]             ; player_x
0915  sub    ax, 0x10
0918  push   ax
0919  mov    ax, word ptr [0xb05a]             ; player_y
091c  sub    ax, 8
091f  push   ax
0920  mov    al, byte ptr [0xa3c0]             ; player_sprite
0923  xor    ah, ah
0925  mov    dx, 0x54
0928  mul    dx
092a  mov    di, ax
092c  add    di, 0x69ec
0930  push   ds
0931  push   di
0932  mov    ax, 1
0935  push   ax
0936  call   Graph_PutImage
093b  add    word ptr [0xb05a], 4              ; player_y
0940  cmp    word ptr [0xb05a], 0xb5           ; player_y
0946  jle    0x94d
0948  call   check_room_change
  loc_094d:
094d  mov    ax, word ptr [0xb05a]             ; player_y
0950  add    ax, 6
0953  cdq
0954  mov    cx, 8
0957  idiv   cx
0959  mov    bx, ax
095b  mov    ax, word ptr [0xb058]             ; player_x
095e  cdq
095f  mov    cx, 0x20
0962  idiv   cx
0964  mov    dx, 0x19
0967  mul    dx
0969  mov    cx, ax
096b  mov    al, byte ptr [0xa3c5]             ; cur_room
096e  xor    ah, ah
0970  mov    dx, 0x226
0973  mul    dx
0975  mov    di, ax
0977  add    di, cx
0979  add    di, bx
097b  mov    al, byte ptr [di - 0x4a70]        ; +rooms
097f  push   ax
0980  mov    di, 0x7fc                         ; set cs:07fc = [52,102,111,152,161,211]
0983  push   cs
0984  push   di
0985  call   Sys_SetIn
098a  jne    0x98f
098c  jmp    0xb0a
  loc_098f:
098f  cmp    byte ptr [0xcb15], 0              ; ladder_marked
0994  je     0x999
0996  jmp    0xb0a
  loc_0999:
0999  mov    ax, word ptr [0xb05a]             ; player_y
099c  add    ax, 6
099f  cdq
09a0  mov    cx, 8
09a3  idiv   cx
09a5  mov    byte ptr [0xa3b0], al             ; loop_i
09a8  mov    ax, word ptr [0xb058]             ; player_x
09ab  cdq
09ac  mov    cx, 0x20
09af  idiv   cx
09b1  mov    byte ptr [0xa3b1], al             ; loop_j
09b4  mov    al, byte ptr [0xa3b0]             ; loop_i
09b7  xor    ah, ah
09b9  mov    bx, ax
09bb  mov    al, byte ptr [0xa3b1]             ; loop_j
09be  xor    ah, ah
09c0  mov    dx, 0x19
09c3  mul    dx
09c5  mov    cx, ax
09c7  mov    al, byte ptr [0xa3c5]             ; cur_room
09ca  xor    ah, ah
09cc  mov    dx, 0x226
09cf  mul    dx
09d1  mov    di, ax
09d3  add    di, cx
09d5  add    di, bx
09d7  mov    al, byte ptr [di - 0x4a70]        ; +rooms
09db  xor    ah, ah
09dd  cmp    ax, 0x6f
09e0  je     0x9ec
09e2  cmp    ax, 0xa1
09e5  je     0x9ec
09e7  cmp    ax, 0xd3
09ea  jne    0x9fa
  loc_09ec:
09ec  mov    byte ptr [0xcb16], 1              ; ladder_leave
09f1  mov    al, byte ptr [0xa3b1]             ; loop_j
09f4  mov    byte ptr [0xa3c2], al             ; ladder_col
09f7  jmp    0xb05
  loc_09fa:
09fa  cmp    ax, 0x34
09fd  je     0xa0c
09ff  cmp    ax, 0x66
0a02  je     0xa0c
0a04  cmp    ax, 0x98
0a07  je     0xa0c
0a09  jmp    0xb05
  loc_0a0c:
0a0c  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_0a10:
0a10  inc    byte ptr [0xa3b0]                 ; loop_i
0a14  mov    al, byte ptr [0xa3b0]             ; loop_i
0a17  xor    ah, ah
0a19  inc    ax
0a1a  mov    bx, ax
0a1c  mov    al, byte ptr [0xa3b1]             ; loop_j
0a1f  xor    ah, ah
0a21  mov    dx, 0x19
0a24  mul    dx
0a26  mov    cx, ax
0a28  mov    al, byte ptr [0xa3c5]             ; cur_room
0a2b  xor    ah, ah
0a2d  mov    dx, 0x226
0a30  mul    dx
0a32  mov    di, ax
0a34  add    di, cx
0a36  add    di, bx
0a38  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0a3c  push   ax
0a3d  mov    di, 0x81c                         ; set cs:081c = [52,102,152]
0a40  push   cs
0a41  push   di
0a42  call   Sys_SetIn
0a47  jne    0xa10
0a49  mov    byte ptr [0x2965], 1              ; ladder_marked_down
  loc_0a4e:
0a4e  mov    al, byte ptr [0xa3b0]             ; loop_i
0a51  xor    ah, ah
0a53  mov    bx, ax
0a55  mov    al, byte ptr [0xa3b1]             ; loop_j
0a58  xor    ah, ah
0a5a  mov    dx, 0x19
0a5d  mul    dx
0a5f  mov    cx, ax
0a61  mov    al, byte ptr [0xa3c5]             ; cur_room
0a64  xor    ah, ah
0a66  mov    dx, 0x226
0a69  mul    dx
0a6b  mov    di, ax
0a6d  add    di, cx
0a6f  add    di, bx
0a71  cmp    byte ptr [di - 0x4a70], 0x34      ; +rooms
0a76  jne    0xaa2
0a78  mov    al, byte ptr [0xa3b0]             ; loop_i
0a7b  xor    ah, ah
0a7d  mov    bx, ax
0a7f  mov    al, byte ptr [0xa3b1]             ; loop_j
0a82  xor    ah, ah
0a84  mov    dx, 0x19
0a87  mul    dx
0a89  mov    cx, ax
0a8b  mov    al, byte ptr [0xa3c5]             ; cur_room
0a8e  xor    ah, ah
0a90  mov    dx, 0x226
0a93  mul    dx
0a95  mov    di, ax
0a97  add    di, cx
0a99  add    di, bx
0a9b  mov    byte ptr [di - 0x4a70], 0x6f      ; +rooms
0aa0  jmp    0xaca
  loc_0aa2:
0aa2  mov    al, byte ptr [0xa3b0]             ; loop_i
0aa5  xor    ah, ah
0aa7  mov    bx, ax
0aa9  mov    al, byte ptr [0xa3b1]             ; loop_j
0aac  xor    ah, ah
0aae  mov    dx, 0x19
0ab1  mul    dx
0ab3  mov    cx, ax
0ab5  mov    al, byte ptr [0xa3c5]             ; cur_room
0ab8  xor    ah, ah
0aba  mov    dx, 0x226
0abd  mul    dx
0abf  mov    di, ax
0ac1  add    di, cx
0ac3  add    di, bx
0ac5  add    byte ptr [di - 0x4a70], 0x3b      ; +rooms
  loc_0aca:
0aca  dec    byte ptr [0xa3b0]                 ; loop_i
0ace  mov    al, byte ptr [0xa3b0]             ; loop_i
0ad1  xor    ah, ah
0ad3  mov    bx, ax
0ad5  mov    al, byte ptr [0xa3b1]             ; loop_j
0ad8  xor    ah, ah
0ada  mov    dx, 0x19
0add  mul    dx
0adf  mov    cx, ax
0ae1  mov    al, byte ptr [0xa3c5]             ; cur_room
0ae4  xor    ah, ah
0ae6  mov    dx, 0x226
0ae9  mul    dx
0aeb  mov    di, ax
0aed  add    di, cx
0aef  add    di, bx
0af1  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0af5  push   ax
0af6  mov    di, 0x81c                         ; set cs:081c = [52,102,152]
0af9  push   cs
0afa  push   di
0afb  call   Sys_SetIn
0b00  je     0xb05
0b02  jmp    0xa4e
  loc_0b05:
0b05  mov    byte ptr [0xcb15], 1              ; ladder_marked
  loc_0b0a:
0b0a  mov    ax, word ptr [0xb058]             ; player_x
0b0d  sub    ax, 0xc
0b10  cdq
0b11  mov    cx, 0x20
0b14  idiv   cx
0b16  mov    byte ptr [0xa3b5], al             ; probe_col
0b19  mov    ax, word ptr [0xb05a]             ; player_y
0b1c  add    ax, 7
0b1f  cdq
0b20  mov    cx, 8
0b23  idiv   cx
0b25  mov    byte ptr [0xa3b6], al             ; probe_row
0b28  mov    al, byte ptr [0xa3b6]             ; probe_row
0b2b  xor    ah, ah
0b2d  mov    bx, ax
0b2f  mov    al, byte ptr [0xa3b5]             ; probe_col
0b32  xor    ah, ah
0b34  mov    dx, 0x19
0b37  mul    dx
0b39  mov    cx, ax
0b3b  mov    al, byte ptr [0xa3c5]             ; cur_room
0b3e  xor    ah, ah
0b40  mov    dx, 0x226
0b43  mul    dx
0b45  mov    di, ax
0b47  add    di, cx
0b49  add    di, bx
0b4b  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0b4f  push   ax
0b50  mov    di, 0x83c                         ; set cs:083c = [53,54,175,222]
0b53  push   cs
0b54  push   di
0b55  call   Sys_SetIn
0b5a  jne    0xb97
0b5c  mov    al, byte ptr [0xa3b6]             ; probe_row
0b5f  xor    ah, ah
0b61  mov    bx, ax
0b63  mov    ax, word ptr [0xb058]             ; player_x
0b66  add    ax, 0xb
0b69  cdq
0b6a  mov    cx, 0x20
0b6d  idiv   cx
0b6f  mov    dx, 0x19
0b72  mul    dx
0b74  mov    cx, ax
0b76  mov    al, byte ptr [0xa3c5]             ; cur_room
0b79  xor    ah, ah
0b7b  mov    dx, 0x226
0b7e  mul    dx
0b80  mov    di, ax
0b82  add    di, cx
0b84  add    di, bx
0b86  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0b8a  push   ax
0b8b  mov    di, 0x83c                         ; set cs:083c = [53,54,175,222]
0b8e  push   cs
0b8f  push   di
0b90  call   Sys_SetIn
0b95  je     0xb9c
  loc_0b97:
0b97  sub    word ptr [0xb05a], 4              ; player_y
  loc_0b9c:
0b9c  mov    ax, word ptr [0xb068]             ; walk_count
0b9f  cdq
0ba0  mov    cx, 2
0ba3  idiv   cx
0ba5  xchg   dx, ax
0ba6  add    ax, 0x1f
0ba9  mov    byte ptr [0xa3c0], al             ; player_sprite
0bac  mov    ax, word ptr [0xb058]             ; player_x
0baf  sub    ax, 0x10
0bb2  push   ax
0bb3  mov    ax, word ptr [0xb05a]             ; player_y
0bb6  sub    ax, 8
0bb9  push   ax
0bba  mov    al, byte ptr [0xa3c0]             ; player_sprite
0bbd  xor    ah, ah
0bbf  mov    dx, 0x54
0bc2  mul    dx
0bc4  mov    di, ax
0bc6  add    di, 0x69ec
0bca  push   ds
0bcb  push   di
0bcc  mov    ax, 1
0bcf  push   ax
0bd0  call   Graph_PutImage
0bd5  mov    sp, bp
0bd7  pop    bp
0bd8  retf
0bd9  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
0be9  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
0bf9  db 00,00,00,08,0e,00,7c,00,00,02,00,00,60,80,00,00
0c09  db 00,00,80,01,02,80,00,00,00,06,08,40,00,00,00,00
0c19  db 00,00,00,00,00,00,7c,00,00,02,00,00,00,00,00,00
0c29  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
0c39  db 00,00,00,00,00,cc,7c,00,00,00,00,00,00,00,00,00
0c49  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
0c59  db 00,00,00,00,00,44,00,00,00,00,00,00,00,00,00,00
0c69  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
0c79  db 00,00,00,00,00,88,60,00,00,00,00,00,00,00,00,00
0c89  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
0c99  db 00,00,00,00,00,88,64,00,00,00,00,00,00,00,00,00
0ca9  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00

; ------------------------------------------------------------
walk_left:
0cb9  push   bp
0cba  mov    bp, sp
0cbc  call   Crt_KeyPressed
0cc1  or     al, al
0cc3  je     0xccd
0cc5  call   Crt_ReadKey
0cca  mov    byte ptr [0xb08e], al             ; last_key
  loc_0ccd:
0ccd  cmp    byte ptr [0xcb16], 0              ; ladder_leave
0cd2  je     0xcd8
0cd4  push   cs
0cd5  call   remove_used_ladder
  loc_0cd8:
0cd8  mov    byte ptr [0xcb15], 0              ; ladder_marked
0cdd  cmp    byte ptr [0xcb14], 0              ; bridge_right
0ce2  je     0xcf5
0ce4  mov    byte ptr [0xcb17], 0              ; bridge_latch
0ce9  cmp    byte ptr [0xcb18], 0              ; on_bridge
0cee  jne    0xcf5
0cf0  mov    byte ptr [0xcb14], 0              ; bridge_right
  loc_0cf5:
0cf5  call   move_mummies
0cfa  cmp    byte ptr [0xcb18], 0              ; on_bridge
0cff  je     0xd41
0d01  mov    ax, word ptr [0xb05a]             ; player_y
0d04  add    ax, 9
0d07  cdq
0d08  mov    cx, 8
0d0b  idiv   cx
0d0d  mov    bx, ax
0d0f  mov    ax, word ptr [0xb058]             ; player_x
0d12  cdq
0d13  mov    cx, 0x20
0d16  idiv   cx
0d18  mov    dx, 0x19
0d1b  mul    dx
0d1d  mov    cx, ax
0d1f  mov    al, byte ptr [0xa3c5]             ; cur_room
0d22  xor    ah, ah
0d24  mov    dx, 0x226
0d27  mul    dx
0d29  mov    di, ax
0d2b  add    di, cx
0d2d  add    di, bx
0d2f  cmp    byte ptr [di - 0x4a70], 0xde      ; +rooms
0d34  jne    0xd3d
0d36  cmp    byte ptr [0xcb14], 0              ; bridge_right
0d3b  je     0xd41
  loc_0d3d:
0d3d  push   cs
0d3e  call   collapse_bridge
  loc_0d41:
0d41  call   check_pickup
0d46  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
0d4b  je     0xd52
0d4d  call   move_dagger
  loc_0d52:
0d52  mov    ax, word ptr [0xb058]             ; player_x
0d55  mov    word ptr [0xb086], ax             ; old_x
0d58  sub    word ptr [0xb058], 8              ; player_x
0d5d  mov    byte ptr [0xa3bf], 1              ; facing_left
0d62  mov    byte ptr [0xa3c4], 0              ; standing
0d67  mov    byte ptr [0xa3cb], 0              ; push_right
0d6c  cmp    word ptr [0xb058], 0x10           ; player_x
0d71  jge    0xdb6
0d73  mov    al, byte ptr [0xa3c5]             ; cur_room
0d76  mov    byte ptr [0xa3c1], al             ; scratch
0d79  call   check_room_change
0d7e  mov    al, byte ptr [0xa3c1]             ; scratch
0d81  cmp    al, byte ptr [0xa3c5]             ; cur_room
0d85  je     0xdb6
0d87  mov    ax, word ptr [0xb058]             ; player_x
0d8a  sub    ax, 0x10
0d8d  push   ax
0d8e  mov    ax, word ptr [0xb05a]             ; player_y
0d91  sub    ax, 8
0d94  push   ax
0d95  mov    al, byte ptr [0xa3c0]             ; player_sprite
0d98  xor    ah, ah
0d9a  mov    dx, 0x54
0d9d  mul    dx
0d9f  mov    di, ax
0da1  add    di, 0x69ec
0da5  push   ds
0da6  push   di
0da7  mov    ax, 1
0daa  push   ax
0dab  call   Graph_PutImage
0db0  mov    ax, word ptr [0xb058]             ; player_x
0db3  mov    word ptr [0xb086], ax             ; old_x
  loc_0db6:
0db6  mov    ax, word ptr [0xb058]             ; player_x
0db9  sub    ax, 0xf
0dbc  cdq
0dbd  mov    cx, 0x20
0dc0  idiv   cx
0dc2  mov    byte ptr [0xa3b5], al             ; probe_col
0dc5  mov    ax, word ptr [0xb05a]             ; player_y
0dc8  sub    ax, 6
0dcb  cdq
0dcc  mov    cx, 8
0dcf  idiv   cx
0dd1  mov    byte ptr [0xa3b6], al             ; probe_row
0dd4  mov    ax, word ptr [0xb05a]             ; player_y
0dd7  add    ax, 0xc
0dda  cdq
0ddb  mov    cx, 8
0dde  idiv   cx
0de0  mov    bx, ax
0de2  mov    ax, word ptr [0xb058]             ; player_x
0de5  cdq
0de6  mov    cx, 0x20
0de9  idiv   cx
0deb  mov    dx, 0x19
0dee  mul    dx
0df0  mov    cx, ax
0df2  mov    al, byte ptr [0xa3c5]             ; cur_room
0df5  xor    ah, ah
0df7  mov    dx, 0x226
0dfa  mul    dx
0dfc  mov    di, ax
0dfe  add    di, cx
0e00  add    di, bx
0e02  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0e06  push   ax
0e07  mov    di, 0xbd9                         ; set cs:0bd9 = [175,222]
0e0a  push   cs
0e0b  push   di
0e0c  call   Sys_SetIn
0e11  jne    0xe16
0e13  jmp    0xf19
  loc_0e16:
0e16  cmp    byte ptr [0xcb17], 0              ; bridge_latch
0e1b  je     0xe20
0e1d  jmp    0xf17
  loc_0e20:
0e20  mov    ax, word ptr [0xb05a]             ; player_y
0e23  add    ax, 0xc
0e26  cdq
0e27  mov    cx, 8
0e2a  idiv   cx
0e2c  mov    byte ptr [0xa3b1], al             ; loop_j
0e2f  mov    ax, word ptr [0xb058]             ; player_x
0e32  cdq
0e33  mov    cx, 0x20
0e36  idiv   cx
0e38  mov    byte ptr [0xa3b0], al             ; loop_i
0e3b  mov    al, byte ptr [0xa3b1]             ; loop_j
0e3e  xor    ah, ah
0e40  mov    bx, ax
0e42  mov    al, byte ptr [0xa3b0]             ; loop_i
0e45  xor    ah, ah
0e47  mov    dx, 0x19
0e4a  mul    dx
0e4c  mov    cx, ax
0e4e  mov    al, byte ptr [0xa3c5]             ; cur_room
0e51  xor    ah, ah
0e53  mov    dx, 0x226
0e56  mul    dx
0e58  mov    di, ax
0e5a  add    di, cx
0e5c  add    di, bx
0e5e  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0e62  xor    ah, ah
0e64  cmp    ax, 0xde
0e67  jne    0xe7c
0e69  mov    byte ptr [0xcb18], 1              ; on_bridge
0e6e  mov    byte ptr [0xcb13], 1              ; bridge_left
0e73  mov    al, byte ptr [0xa3b1]             ; loop_j
0e76  mov    byte ptr [0xa3c3], al             ; bridge_row
0e79  jmp    0xf12
  loc_0e7c:
0e7c  cmp    ax, 0xaf
0e7f  je     0xe84
0e81  jmp    0xf12
  loc_0e84:
0e84  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_0e88:
0e88  dec    byte ptr [0xa3b0]                 ; loop_i
0e8c  mov    al, byte ptr [0xa3b1]             ; loop_j
0e8f  xor    ah, ah
0e91  mov    bx, ax
0e93  mov    al, byte ptr [0xa3b0]             ; loop_i
0e96  xor    ah, ah
0e98  dec    ax
0e99  mov    dx, 0x19
0e9c  mul    dx
0e9e  mov    cx, ax
0ea0  mov    al, byte ptr [0xa3c5]             ; cur_room
0ea3  xor    ah, ah
0ea5  mov    dx, 0x226
0ea8  mul    dx
0eaa  mov    di, ax
0eac  add    di, cx
0eae  add    di, bx
0eb0  cmp    byte ptr [di - 0x4a70], 0xaf      ; +rooms
0eb5  je     0xe88
0eb7  mov    byte ptr [0xcb13], 1              ; bridge_left
  loc_0ebc:
0ebc  mov    al, byte ptr [0xa3b1]             ; loop_j
0ebf  xor    ah, ah
0ec1  mov    bx, ax
0ec3  mov    al, byte ptr [0xa3b0]             ; loop_i
0ec6  xor    ah, ah
0ec8  mov    dx, 0x19
0ecb  mul    dx
0ecd  mov    cx, ax
0ecf  mov    al, byte ptr [0xa3c5]             ; cur_room
0ed2  xor    ah, ah
0ed4  mov    dx, 0x226
0ed7  mul    dx
0ed9  mov    di, ax
0edb  add    di, cx
0edd  add    di, bx
0edf  mov    byte ptr [di - 0x4a70], 0xde      ; +rooms
0ee4  inc    byte ptr [0xa3b0]                 ; loop_i
0ee8  mov    al, byte ptr [0xa3b1]             ; loop_j
0eeb  xor    ah, ah
0eed  mov    bx, ax
0eef  mov    al, byte ptr [0xa3b0]             ; loop_i
0ef2  xor    ah, ah
0ef4  mov    dx, 0x19
0ef7  mul    dx
0ef9  mov    cx, ax
0efb  mov    al, byte ptr [0xa3c5]             ; cur_room
0efe  xor    ah, ah
0f00  mov    dx, 0x226
0f03  mul    dx
0f05  mov    di, ax
0f07  add    di, cx
0f09  add    di, bx
0f0b  cmp    byte ptr [di - 0x4a70], 0xaf      ; +rooms
0f10  je     0xebc
  loc_0f12:
0f12  mov    byte ptr [0xcb17], 1              ; bridge_latch
  loc_0f17:
0f17  jmp    0xf25
  loc_0f19:
0f19  cmp    byte ptr [0xcb13], 0              ; bridge_left
0f1e  je     0xf25
0f20  mov    byte ptr [0xcb17], 0              ; bridge_latch
  loc_0f25:
0f25  mov    al, byte ptr [0xa3b6]             ; probe_row
0f28  xor    ah, ah
0f2a  mov    bx, ax
0f2c  mov    al, byte ptr [0xa3b5]             ; probe_col
0f2f  xor    ah, ah
0f31  mov    dx, 0x19
0f34  mul    dx
0f36  mov    cx, ax
0f38  mov    al, byte ptr [0xa3c5]             ; cur_room
0f3b  xor    ah, ah
0f3d  mov    dx, 0x226
0f40  mul    dx
0f42  mov    di, ax
0f44  add    di, cx
0f46  add    di, bx
0f48  cmp    byte ptr [di - 0x4a70], 0x32      ; +rooms
0f4d  je     0xf52
0f4f  jmp    0x1187
  loc_0f52:
0f52  inc    byte ptr [0xa3ca]                 ; push_left
0f56  call   Crt_KeyPressed
0f5b  or     al, al
0f5d  je     0xf67
0f5f  call   Crt_ReadKey
0f64  mov    byte ptr [0xb08e], al             ; last_key
  loc_0f67:
0f67  cmp    byte ptr [0xa3ca], 5              ; push_left
0f6c  ja     0xf71
0f6e  jmp    0x1142
  loc_0f71:
0f71  mov    al, byte ptr [0xa3b6]             ; probe_row
0f74  xor    ah, ah
0f76  mov    bx, ax
0f78  mov    al, byte ptr [0xa3b5]             ; probe_col
0f7b  xor    ah, ah
0f7d  dec    ax
0f7e  mov    dx, 0x19
0f81  mul    dx
0f83  mov    cx, ax
0f85  mov    al, byte ptr [0xa3c5]             ; cur_room
0f88  xor    ah, ah
0f8a  mov    dx, 0x226
0f8d  mul    dx
0f8f  mov    di, ax
0f91  add    di, cx
0f93  add    di, bx
0f95  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0f99  push   ax
0f9a  mov    di, 0xbf9                         ; set cs:0bf9 = [27,33,34,35,50,51,52,53,54,73,101,102,111,151,152,161,175,201,202,211,222]
0f9d  push   cs
0f9e  push   di
0f9f  call   Sys_SetIn
0fa4  je     0xfa9
0fa6  jmp    0x1136
  loc_0fa9:
0fa9  mov    al, byte ptr [0xa3b6]             ; probe_row
0fac  xor    ah, ah
0fae  inc    ax
0faf  mov    bx, ax
0fb1  mov    al, byte ptr [0xa3b5]             ; probe_col
0fb4  xor    ah, ah
0fb6  dec    ax
0fb7  mov    dx, 0x19
0fba  mul    dx
0fbc  mov    cx, ax
0fbe  mov    al, byte ptr [0xa3c5]             ; cur_room
0fc1  xor    ah, ah
0fc3  mov    dx, 0x226
0fc6  mul    dx
0fc8  mov    di, ax
0fca  add    di, cx
0fcc  add    di, bx
0fce  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0fd2  push   ax
0fd3  mov    di, 0xc19                         ; set cs:0c19 = [50,51,52,53,54,73,175,222]
0fd6  push   cs
0fd7  push   di
0fd8  call   Sys_SetIn
0fdd  je     0xfe2
0fdf  jmp    0x1136
  loc_0fe2:
0fe2  mov    al, byte ptr [0xa3b5]             ; probe_col
0fe5  xor    ah, ah
0fe7  mov    cx, 5
0fea  shl    ax, cl
0fec  push   ax
0fed  mov    al, byte ptr [0xa3b6]             ; probe_row
0ff0  xor    ah, ah
0ff2  mov    cx, 3
0ff5  shl    ax, cl
0ff7  push   ax
0ff8  mov    di, 0x7a54
0ffb  push   ds
0ffc  push   di
0ffd  mov    ax, 1
1000  push   ax
1001  call   Graph_PutImage
1006  mov    al, byte ptr [0xa3b6]             ; probe_row
1009  xor    ah, ah
100b  mov    bx, ax
100d  mov    al, byte ptr [0xa3b5]             ; probe_col
1010  xor    ah, ah
1012  mov    dx, 0x19
1015  mul    dx
1017  mov    cx, ax
1019  mov    al, byte ptr [0xa3c5]             ; cur_room
101c  xor    ah, ah
101e  mov    dx, 0x226
1021  mul    dx
1023  mov    di, ax
1025  add    di, cx
1027  add    di, bx
1029  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
102e  mov    al, byte ptr [0xa3c5]             ; cur_room
1031  mov    byte ptr [0xa3c8], al             ; stone_room
1034  cmp    byte ptr [0xa3b5], 0              ; probe_col
1039  jne    0x105a
103b  mov    word ptr [0xb082], 0xfffe         ; cell_x
1041  mov    di, 0xa3c8                        ; &stone_room
1044  push   ds
1045  push   di
1046  mov    di, 0xb082                        ; &cell_x
1049  push   ds
104a  push   di
104b  mov    di, 0xb084                        ; &cell_y
104e  push   ds
104f  push   di
1050  call   move_to_next_room
1055  mov    byte ptr [0xa3b5], 0x13           ; probe_col
  loc_105a:
105a  mov    al, byte ptr [0xa3c8]             ; stone_room
105d  cmp    al, byte ptr [0xa3c5]             ; cur_room
1061  jne    0x108a
1063  mov    al, byte ptr [0xa3b5]             ; probe_col
1066  xor    ah, ah
1068  mov    cx, 5
106b  shl    ax, cl
106d  sub    ax, 0x20
1070  push   ax
1071  mov    al, byte ptr [0xa3b6]             ; probe_row
1074  xor    ah, ah
1076  mov    cx, 3
1079  shl    ax, cl
107b  push   ax
107c  mov    di, 0x7a54
107f  push   ds
1080  push   di
1081  mov    ax, 1
1084  push   ax
1085  call   Graph_PutImage
  loc_108a:
108a  mov    al, byte ptr [0xa3b6]             ; probe_row
108d  xor    ah, ah
108f  mov    bx, ax
1091  mov    al, byte ptr [0xa3b5]             ; probe_col
1094  xor    ah, ah
1096  dec    ax
1097  mov    dx, 0x19
109a  mul    dx
109c  mov    cx, ax
109e  mov    al, byte ptr [0xa3c8]             ; stone_room
10a1  xor    ah, ah
10a3  mov    dx, 0x226
10a6  mul    dx
10a8  mov    di, ax
10aa  add    di, cx
10ac  add    di, bx
10ae  mov    byte ptr [di - 0x4a70], 0x32      ; +rooms
10b3  mov    al, byte ptr [0xa3b6]             ; probe_row
10b6  xor    ah, ah
10b8  add    ax, 2
10bb  mov    bx, ax
10bd  mov    al, byte ptr [0xa3b5]             ; probe_col
10c0  xor    ah, ah
10c2  dec    ax
10c3  mov    dx, 0x19
10c6  mul    dx
10c8  mov    cx, ax
10ca  mov    al, byte ptr [0xa3c8]             ; stone_room
10cd  xor    ah, ah
10cf  mov    dx, 0x226
10d2  mul    dx
10d4  mov    di, ax
10d6  add    di, cx
10d8  add    di, bx
10da  mov    al, byte ptr [di - 0x4a70]        ; +rooms
10de  push   ax
10df  mov    di, 0xc39                         ; set cs:0c39 = [42,43,46,47,50,51,52,53,54,175,222]
10e2  push   cs
10e3  push   di
10e4  call   Sys_SetIn
10e9  jne    0x112a
10eb  mov    al, byte ptr [0xa3b6]             ; probe_row
10ee  xor    ah, ah
10f0  mov    bx, ax
10f2  mov    al, byte ptr [0xa3b5]             ; probe_col
10f5  xor    ah, ah
10f7  dec    ax
10f8  mov    dx, 0x19
10fb  mul    dx
10fd  mov    cx, ax
10ff  mov    al, byte ptr [0xa3c8]             ; stone_room
1102  xor    ah, ah
1104  mov    dx, 0x226
1107  mul    dx
1109  mov    di, ax
110b  add    di, cx
110d  add    di, bx
110f  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
1114  mov    byte ptr [0xcb0f], 1              ; stone_falling
1119  mov    al, byte ptr [0xa3b5]             ; probe_col
111c  xor    ah, ah
111e  dec    ax
111f  mov    word ptr [0xb08a], ax             ; stone_col
1122  mov    al, byte ptr [0xa3b6]             ; probe_row
1125  xor    ah, ah
1127  mov    word ptr [0xb08c], ax             ; stone_row
  loc_112a:
112a  sub    word ptr [0xb058], 0x10           ; player_x
112f  mov    byte ptr [0xa3ca], 0              ; push_left
1134  jmp    0x1140
  loc_1136:
1136  add    word ptr [0xb058], 8              ; player_x
113b  mov    byte ptr [0xa3ca], 0              ; push_left
  loc_1140:
1140  jmp    0x1187
  loc_1142:
1142  mov    byte ptr [0xa3b0], 0x14           ; loop_i
1147  jmp    0x114d
  loc_1149:
1149  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_114d:
114d  mov    ax, 0x14
1150  push   ax
1151  call   Crt_Sound
1156  mov    al, byte ptr [0xa3b0]             ; loop_i
1159  xor    ah, ah
115b  sub    ax, 0xa
115e  push   ax
115f  call   Crt_Delay
1164  call   Crt_NoSound
1169  mov    al, byte ptr [0xa3b0]             ; loop_i
116c  xor    ah, ah
116e  mov    dx, ax
1170  mov    ax, 0x15
1173  sub    ax, dx
1175  push   ax
1176  call   Crt_Delay
117b  cmp    byte ptr [0xa3b0], 0xf            ; loop_i
1180  jne    0x1149
1182  add    word ptr [0xb058], 8              ; player_x
  loc_1187:
1187  mov    ax, word ptr [0xb058]             ; player_x
118a  sub    ax, 8
118d  cdq
118e  mov    cx, 0x20
1191  idiv   cx
1193  mov    byte ptr [0xa3b5], al             ; probe_col
1196  mov    al, byte ptr [0xa3b6]             ; probe_row
1199  xor    ah, ah
119b  mov    bx, ax
119d  mov    al, byte ptr [0xa3b5]             ; probe_col
11a0  xor    ah, ah
11a2  mov    dx, 0x19
11a5  mul    dx
11a7  mov    cx, ax
11a9  mov    al, byte ptr [0xa3c5]             ; cur_room
11ac  xor    ah, ah
11ae  mov    dx, 0x226
11b1  mul    dx
11b3  mov    di, ax
11b5  add    di, cx
11b7  add    di, bx
11b9  mov    al, byte ptr [di - 0x4a70]        ; +rooms
11bd  push   ax
11be  mov    di, 0xc59                         ; set cs:0c59 = [42,46]
11c1  push   cs
11c2  push   di
11c3  call   Sys_SetIn
11c8  jne    0x11cd
11ca  jmp    0x17da
  loc_11cd:
11cd  inc    byte ptr [0xa3ca]                 ; push_left
11d1  call   Crt_KeyPressed
11d6  or     al, al
11d8  je     0x11e2
11da  call   Crt_ReadKey
11df  mov    byte ptr [0xb08e], al             ; last_key
  loc_11e2:
11e2  cmp    byte ptr [0xa3ca], 0xa            ; push_left
11e7  ja     0x11ec
11e9  jmp    0x17d5
  loc_11ec:
11ec  mov    al, byte ptr [0xa3b6]             ; probe_row
11ef  xor    ah, ah
11f1  mov    bx, ax
11f3  mov    al, byte ptr [0xa3b5]             ; probe_col
11f6  xor    ah, ah
11f8  mov    dx, 0x19
11fb  mul    dx
11fd  mov    cx, ax
11ff  mov    al, byte ptr [0xa3c5]             ; cur_room
1202  xor    ah, ah
1204  mov    dx, 0x226
1207  mul    dx
1209  mov    di, ax
120b  add    di, cx
120d  add    di, bx
120f  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1213  xor    ah, ah
1215  cmp    ax, 0x2a
1218  je     0x121d
121a  jmp    0x14d5
  loc_121d:
121d  mov    byte ptr [0xa3b0], 0x1e           ; loop_i
1222  jmp    0x1228
  loc_1224:
1224  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_1228:
1228  mov    ax, 0x64
122b  push   ax
122c  call   Crt_Sound
1231  mov    al, byte ptr [0xa3b0]             ; loop_i
1234  xor    ah, ah
1236  push   ax
1237  call   Crt_Delay
123c  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1241  je     0x1248
1243  call   move_dagger
  loc_1248:
1248  call   Crt_KeyPressed
124d  or     al, al
124f  je     0x1259
1251  call   Crt_ReadKey
1256  mov    byte ptr [0xb08e], al             ; last_key
  loc_1259:
1259  call   Crt_NoSound
125e  mov    al, byte ptr [0xa3b0]             ; loop_i
1261  xor    ah, ah
1263  mov    dx, ax
1265  mov    ax, 0x1f
1268  sub    ax, dx
126a  push   ax
126b  call   Crt_Delay
1270  call   move_mummies
1275  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
127a  je     0x1281
127c  call   move_dagger
  loc_1281:
1281  cmp    byte ptr [0xa3b0], 0x1c           ; loop_i
1286  jne    0x1224
1288  mov    al, byte ptr [0xa3b5]             ; probe_col
128b  xor    ah, ah
128d  mov    cx, 5
1290  shl    ax, cl
1292  push   ax
1293  mov    al, byte ptr [0xa3b6]             ; probe_row
1296  xor    ah, ah
1298  mov    cx, 3
129b  shl    ax, cl
129d  push   ax
129e  mov    di, 0x77b4
12a1  push   ds
12a2  push   di
12a3  mov    ax, 1
12a6  push   ax
12a7  call   Graph_PutImage
12ac  mov    al, byte ptr [0xa3b5]             ; probe_col
12af  xor    ah, ah
12b1  mov    cx, 5
12b4  shl    ax, cl
12b6  push   ax
12b7  mov    al, byte ptr [0xa3b6]             ; probe_row
12ba  xor    ah, ah
12bc  mov    cx, 3
12bf  shl    ax, cl
12c1  push   ax
12c2  mov    di, 0x78b0
12c5  push   ds
12c6  push   di
12c7  mov    ax, 1
12ca  push   ax
12cb  call   Graph_PutImage
12d0  mov    ax, word ptr [0xb086]             ; old_x
12d3  sub    ax, 0x10
12d6  push   ax
12d7  mov    ax, word ptr [0xb05a]             ; player_y
12da  sub    ax, 8
12dd  push   ax
12de  mov    al, byte ptr [0xa3c0]             ; player_sprite
12e1  xor    ah, ah
12e3  mov    dx, 0x54
12e6  mul    dx
12e8  mov    di, ax
12ea  add    di, 0x69ec
12ee  push   ds
12ef  push   di
12f0  mov    ax, 1
12f3  push   ax
12f4  call   Graph_PutImage
12f9  mov    byte ptr [0xa3b0], 0x1b           ; loop_i
12fe  jmp    0x1304
  loc_1300:
1300  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_1304:
1304  mov    ax, 0x64
1307  push   ax
1308  call   Crt_Sound
130d  mov    al, byte ptr [0xa3b0]             ; loop_i
1310  xor    ah, ah
1312  push   ax
1313  call   Crt_Delay
1318  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
131d  je     0x1324
131f  call   move_dagger
  loc_1324:
1324  call   Crt_KeyPressed
1329  or     al, al
132b  je     0x1335
132d  call   Crt_ReadKey
1332  mov    byte ptr [0xb08e], al             ; last_key
  loc_1335:
1335  call   Crt_NoSound
133a  mov    al, byte ptr [0xa3b0]             ; loop_i
133d  xor    ah, ah
133f  mov    dx, ax
1341  mov    ax, 0x1c
1344  sub    ax, dx
1346  push   ax
1347  call   Crt_Delay
134c  call   move_mummies
1351  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1356  je     0x135d
1358  call   move_dagger
  loc_135d:
135d  cmp    byte ptr [0xa3b0], 0x19           ; loop_i
1362  jne    0x1300
1364  mov    al, byte ptr [0xa3b5]             ; probe_col
1367  xor    ah, ah
1369  mov    cx, 5
136c  shl    ax, cl
136e  push   ax
136f  mov    al, byte ptr [0xa3b6]             ; probe_row
1372  xor    ah, ah
1374  mov    cx, 3
1377  shl    ax, cl
1379  push   ax
137a  mov    di, 0x78b0
137d  push   ds
137e  push   di
137f  mov    ax, 1
1382  push   ax
1383  call   Graph_PutImage
1388  mov    al, byte ptr [0xa3b5]             ; probe_col
138b  xor    ah, ah
138d  mov    cx, 5
1390  shl    ax, cl
1392  push   ax
1393  mov    al, byte ptr [0xa3b6]             ; probe_row
1396  xor    ah, ah
1398  mov    cx, 3
139b  shl    ax, cl
139d  push   ax
139e  mov    di, 0x785c
13a1  push   ds
13a2  push   di
13a3  mov    ax, 1
13a6  push   ax
13a7  call   Graph_PutImage
13ac  mov    byte ptr [0xa3b0], 0x18           ; loop_i
13b1  jmp    0x13b7
  loc_13b3:
13b3  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_13b7:
13b7  mov    ax, 0x64
13ba  push   ax
13bb  call   Crt_Sound
13c0  mov    al, byte ptr [0xa3b0]             ; loop_i
13c3  xor    ah, ah
13c5  push   ax
13c6  call   Crt_Delay
13cb  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
13d0  je     0x13d7
13d2  call   move_dagger
  loc_13d7:
13d7  call   Crt_KeyPressed
13dc  or     al, al
13de  je     0x13e8
13e0  call   Crt_ReadKey
13e5  mov    byte ptr [0xb08e], al             ; last_key
  loc_13e8:
13e8  call   Crt_NoSound
13ed  mov    al, byte ptr [0xa3b0]             ; loop_i
13f0  xor    ah, ah
13f2  mov    dx, ax
13f4  mov    ax, 0x19
13f7  sub    ax, dx
13f9  push   ax
13fa  call   Crt_Delay
13ff  call   move_mummies
1404  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1409  je     0x1410
140b  call   move_dagger
  loc_1410:
1410  cmp    byte ptr [0xa3b0], 0x16           ; loop_i
1415  jne    0x13b3
1417  mov    al, byte ptr [0xa3b5]             ; probe_col
141a  xor    ah, ah
141c  mov    cx, 5
141f  shl    ax, cl
1421  push   ax
1422  mov    al, byte ptr [0xa3b6]             ; probe_row
1425  xor    ah, ah
1427  mov    cx, 3
142a  shl    ax, cl
142c  push   ax
142d  mov    di, 0x785c
1430  push   ds
1431  push   di
1432  mov    ax, 1
1435  push   ax
1436  call   Graph_PutImage
143b  mov    al, byte ptr [0xa3b5]             ; probe_col
143e  xor    ah, ah
1440  mov    cx, 5
1443  shl    ax, cl
1445  push   ax
1446  mov    al, byte ptr [0xa3b6]             ; probe_row
1449  xor    ah, ah
144b  mov    cx, 3
144e  shl    ax, cl
1450  push   ax
1451  mov    di, 0x7808
1454  push   ds
1455  push   di
1456  mov    ax, 1
1459  push   ax
145a  call   Graph_PutImage
145f  mov    ax, word ptr [0xb086]             ; old_x
1462  sub    ax, 0x40
1465  push   ax
1466  mov    ax, word ptr [0xb05a]             ; player_y
1469  sub    ax, 8
146c  push   ax
146d  mov    al, byte ptr [0xa3c0]             ; player_sprite
1470  xor    ah, ah
1472  mov    dx, 0x54
1475  mul    dx
1477  mov    di, ax
1479  add    di, 0x69ec
147d  push   ds
147e  push   di
147f  mov    ax, 1
1482  push   ax
1483  call   Graph_PutImage
1488  call   move_mummies
148d  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1492  je     0x1499
1494  call   move_dagger
  loc_1499:
1499  call   Crt_KeyPressed
149e  or     al, al
14a0  je     0x14aa
14a2  call   Crt_ReadKey
14a7  mov    byte ptr [0xb08e], al             ; last_key
  loc_14aa:
14aa  mov    al, byte ptr [0xa3b6]             ; probe_row
14ad  xor    ah, ah
14af  mov    bx, ax
14b1  mov    al, byte ptr [0xa3b5]             ; probe_col
14b4  xor    ah, ah
14b6  mov    dx, 0x19
14b9  mul    dx
14bb  mov    cx, ax
14bd  mov    al, byte ptr [0xa3c5]             ; cur_room
14c0  xor    ah, ah
14c2  mov    dx, 0x226
14c5  mul    dx
14c7  mov    di, ax
14c9  add    di, cx
14cb  add    di, bx
14cd  mov    byte ptr [di - 0x4a70], 0x2b      ; +rooms
14d2  jmp    0x17c4
  loc_14d5:
14d5  cmp    ax, 0x2e
14d8  je     0x14dd
14da  jmp    0x17c4
  loc_14dd:
14dd  mov    byte ptr [0xa3b0], 0x1e           ; loop_i
14e2  jmp    0x14e8
  loc_14e4:
14e4  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_14e8:
14e8  mov    ax, 0x64
14eb  push   ax
14ec  call   Crt_Sound
14f1  mov    al, byte ptr [0xa3b0]             ; loop_i
14f4  xor    ah, ah
14f6  push   ax
14f7  call   Crt_Delay
14fc  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1501  je     0x1508
1503  call   move_dagger
  loc_1508:
1508  call   Crt_KeyPressed
150d  or     al, al
150f  je     0x1519
1511  call   Crt_ReadKey
1516  mov    byte ptr [0xb08e], al             ; last_key
  loc_1519:
1519  call   Crt_NoSound
151e  mov    al, byte ptr [0xa3b0]             ; loop_i
1521  xor    ah, ah
1523  mov    dx, ax
1525  mov    ax, 0x1f
1528  sub    ax, dx
152a  push   ax
152b  call   Crt_Delay
1530  call   move_mummies
1535  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
153a  je     0x1541
153c  call   move_dagger
  loc_1541:
1541  cmp    byte ptr [0xa3b0], 0x1c           ; loop_i
1546  jne    0x14e4
1548  mov    al, byte ptr [0xa3b5]             ; probe_col
154b  xor    ah, ah
154d  mov    cx, 5
1550  shl    ax, cl
1552  push   ax
1553  mov    al, byte ptr [0xa3b6]             ; probe_row
1556  xor    ah, ah
1558  mov    cx, 3
155b  shl    ax, cl
155d  push   ax
155e  mov    di, 0x7904
1561  push   ds
1562  push   di
1563  mov    ax, 1
1566  push   ax
1567  call   Graph_PutImage
156c  mov    ax, word ptr [0xb086]             ; old_x
156f  sub    ax, 0x10
1572  push   ax
1573  mov    ax, word ptr [0xb05a]             ; player_y
1576  sub    ax, 8
1579  push   ax
157a  mov    al, byte ptr [0xa3c0]             ; player_sprite
157d  xor    ah, ah
157f  mov    dx, 0x54
1582  mul    dx
1584  mov    di, ax
1586  add    di, 0x69ec
158a  push   ds
158b  push   di
158c  mov    ax, 1
158f  push   ax
1590  call   Graph_PutImage
1595  mov    al, byte ptr [0xa3b5]             ; probe_col
1598  xor    ah, ah
159a  mov    cx, 5
159d  shl    ax, cl
159f  push   ax
15a0  mov    al, byte ptr [0xa3b6]             ; probe_row
15a3  xor    ah, ah
15a5  mov    cx, 3
15a8  shl    ax, cl
15aa  push   ax
15ab  mov    di, 0x79ac
15ae  push   ds
15af  push   di
15b0  mov    ax, 1
15b3  push   ax
15b4  call   Graph_PutImage
15b9  mov    byte ptr [0xa3b0], 0x1b           ; loop_i
15be  jmp    0x15c4
  loc_15c0:
15c0  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_15c4:
15c4  mov    ax, 0x64
15c7  push   ax
15c8  call   Crt_Sound
15cd  mov    al, byte ptr [0xa3b0]             ; loop_i
15d0  xor    ah, ah
15d2  push   ax
15d3  call   Crt_Delay
15d8  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
15dd  je     0x15e4
15df  call   move_dagger
  loc_15e4:
15e4  call   Crt_KeyPressed
15e9  or     al, al
15eb  je     0x15f5
15ed  call   Crt_ReadKey
15f2  mov    byte ptr [0xb08e], al             ; last_key
  loc_15f5:
15f5  call   Crt_NoSound
15fa  mov    al, byte ptr [0xa3b0]             ; loop_i
15fd  xor    ah, ah
15ff  mov    dx, ax
1601  mov    ax, 0x1c
1604  sub    ax, dx
1606  push   ax
1607  call   Crt_Delay
160c  call   move_mummies
1611  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1616  je     0x161d
1618  call   move_dagger
  loc_161d:
161d  cmp    byte ptr [0xa3b0], 0x19           ; loop_i
1622  jne    0x15c0
1624  mov    al, byte ptr [0xa3b5]             ; probe_col
1627  xor    ah, ah
1629  mov    cx, 5
162c  shl    ax, cl
162e  push   ax
162f  mov    al, byte ptr [0xa3b6]             ; probe_row
1632  xor    ah, ah
1634  mov    cx, 3
1637  shl    ax, cl
1639  push   ax
163a  mov    di, 0x79ac
163d  push   ds
163e  push   di
163f  mov    ax, 1
1642  push   ax
1643  call   Graph_PutImage
1648  mov    al, byte ptr [0xa3b5]             ; probe_col
164b  xor    ah, ah
164d  mov    cx, 5
1650  shl    ax, cl
1652  push   ax
1653  mov    al, byte ptr [0xa3b6]             ; probe_row
1656  xor    ah, ah
1658  mov    cx, 3
165b  shl    ax, cl
165d  push   ax
165e  mov    di, 0x79ac
1661  push   ds
1662  push   di
1663  mov    ax, 1
1666  push   ax
1667  call   Graph_PutImage
166c  mov    byte ptr [0xa3b0], 0x18           ; loop_i
1671  jmp    0x1677
  loc_1673:
1673  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_1677:
1677  mov    ax, 0x64
167a  push   ax
167b  call   Crt_Sound
1680  mov    al, byte ptr [0xa3b0]             ; loop_i
1683  xor    ah, ah
1685  push   ax
1686  call   Crt_Delay
168b  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1690  je     0x1697
1692  call   move_dagger
  loc_1697:
1697  call   Crt_KeyPressed
169c  or     al, al
169e  je     0x16a8
16a0  call   Crt_ReadKey
16a5  mov    byte ptr [0xb08e], al             ; last_key
  loc_16a8:
16a8  call   Crt_NoSound
16ad  mov    al, byte ptr [0xa3b0]             ; loop_i
16b0  xor    ah, ah
16b2  mov    dx, ax
16b4  mov    ax, 0x19
16b7  sub    ax, dx
16b9  push   ax
16ba  call   Crt_Delay
16bf  call   move_mummies
16c4  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
16c9  je     0x16d0
16cb  call   move_dagger
  loc_16d0:
16d0  cmp    byte ptr [0xa3b0], 0x16           ; loop_i
16d5  jne    0x1673
16d7  mov    al, byte ptr [0xa3b5]             ; probe_col
16da  xor    ah, ah
16dc  mov    cx, 5
16df  shl    ax, cl
16e1  push   ax
16e2  mov    al, byte ptr [0xa3b6]             ; probe_row
16e5  xor    ah, ah
16e7  mov    cx, 3
16ea  shl    ax, cl
16ec  push   ax
16ed  mov    di, 0x79ac
16f0  push   ds
16f1  push   di
16f2  mov    ax, 1
16f5  push   ax
16f6  call   Graph_PutImage
16fb  mov    ax, word ptr [0xb086]             ; old_x
16fe  sub    ax, 0x40
1701  push   ax
1702  mov    ax, word ptr [0xb05a]             ; player_y
1705  sub    ax, 8
1708  push   ax
1709  mov    al, byte ptr [0xa3c0]             ; player_sprite
170c  xor    ah, ah
170e  mov    dx, 0x54
1711  mul    dx
1713  mov    di, ax
1715  add    di, 0x69ec
1719  push   ds
171a  push   di
171b  mov    ax, 1
171e  push   ax
171f  call   Graph_PutImage
1724  mov    al, byte ptr [0xa3b5]             ; probe_col
1727  xor    ah, ah
1729  mov    cx, 5
172c  shl    ax, cl
172e  push   ax
172f  mov    al, byte ptr [0xa3b6]             ; probe_row
1732  xor    ah, ah
1734  mov    cx, 3
1737  shl    ax, cl
1739  push   ax
173a  mov    di, 0x7904
173d  push   ds
173e  push   di
173f  mov    ax, 1
1742  push   ax
1743  call   Graph_PutImage
1748  mov    byte ptr [0xa3b0], 0x15           ; loop_i
174d  jmp    0x1753
  loc_174f:
174f  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_1753:
1753  mov    ax, 0x64
1756  push   ax
1757  call   Crt_Sound
175c  mov    al, byte ptr [0xa3b0]             ; loop_i
175f  xor    ah, ah
1761  push   ax
1762  call   Crt_Delay
1767  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
176c  je     0x1773
176e  call   move_dagger
  loc_1773:
1773  call   Crt_KeyPressed
1778  or     al, al
177a  je     0x1784
177c  call   Crt_ReadKey
1781  mov    byte ptr [0xb08e], al             ; last_key
  loc_1784:
1784  call   Crt_NoSound
1789  mov    al, byte ptr [0xa3b0]             ; loop_i
178c  xor    ah, ah
178e  mov    dx, ax
1790  mov    ax, 0x16
1793  sub    ax, dx
1795  push   ax
1796  call   Crt_Delay
179b  call   move_mummies
17a0  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
17a5  je     0x17ac
17a7  call   move_dagger
  loc_17ac:
17ac  cmp    byte ptr [0xa3b0], 0x13           ; loop_i
17b1  jne    0x174f
17b3  call   move_mummies
17b8  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
17bd  je     0x17c4
17bf  call   move_dagger
  loc_17c4:
17c4  sub    word ptr [0xb058], 0x30           ; player_x
17c9  mov    byte ptr [0xa3ca], 0              ; push_left
17ce  sub    word ptr [0xb086], 0x30           ; old_x
17d3  jmp    0x17da
  loc_17d5:
17d5  add    word ptr [0xb058], 8              ; player_x
  loc_17da:
17da  mov    ax, word ptr [0xb058]             ; player_x
17dd  sub    ax, 0xb
17e0  cdq
17e1  mov    cx, 0x20
17e4  idiv   cx
17e6  mov    byte ptr [0xa3b5], al             ; probe_col
17e9  mov    ax, word ptr [0xb05a]             ; player_y
17ec  sub    ax, 6
17ef  cdq
17f0  mov    cx, 8
17f3  idiv   cx
17f5  mov    byte ptr [0xa3b6], al             ; probe_row
17f8  mov    al, byte ptr [0xa3b6]             ; probe_row
17fb  xor    ah, ah
17fd  mov    bx, ax
17ff  mov    al, byte ptr [0xa3b5]             ; probe_col
1802  xor    ah, ah
1804  mov    dx, 0x19
1807  mul    dx
1809  mov    cx, ax
180b  mov    al, byte ptr [0xa3c5]             ; cur_room
180e  xor    ah, ah
1810  mov    dx, 0x226
1813  mul    dx
1815  mov    di, ax
1817  add    di, cx
1819  add    di, bx
181b  mov    al, byte ptr [di - 0x4a70]        ; +rooms
181f  push   ax
1820  mov    di, 0xc79                         ; set cs:0c79 = [43,47,53,54,175,222]
1823  push   cs
1824  push   di
1825  call   Sys_SetIn
182a  jne    0x1867
182c  mov    ax, word ptr [0xb05a]             ; player_y
182f  add    ax, 6
1832  cdq
1833  mov    cx, 8
1836  idiv   cx
1838  mov    bx, ax
183a  mov    al, byte ptr [0xa3b5]             ; probe_col
183d  xor    ah, ah
183f  mov    dx, 0x19
1842  mul    dx
1844  mov    cx, ax
1846  mov    al, byte ptr [0xa3c5]             ; cur_room
1849  xor    ah, ah
184b  mov    dx, 0x226
184e  mul    dx
1850  mov    di, ax
1852  add    di, cx
1854  add    di, bx
1856  mov    al, byte ptr [di - 0x4a70]        ; +rooms
185a  push   ax
185b  mov    di, 0xc99                         ; set cs:0c99 = [43,47,50,53,54,175,222]
185e  push   cs
185f  push   di
1860  call   Sys_SetIn
1865  je     0x186c
  loc_1867:
1867  add    word ptr [0xb058], 8              ; player_x
  loc_186c:
186c  inc    word ptr [0xb068]                 ; walk_count
1870  cmp    word ptr [0xb068], 0x3e8          ; walk_count
1876  jle    0x187e
1878  mov    word ptr [0xb068], 1              ; walk_count
  loc_187e:
187e  mov    ax, word ptr [0xb086]             ; old_x
1881  sub    ax, 0x10
1884  push   ax
1885  mov    ax, word ptr [0xb05a]             ; player_y
1888  sub    ax, 8
188b  push   ax
188c  mov    al, byte ptr [0xa3c0]             ; player_sprite
188f  xor    ah, ah
1891  mov    dx, 0x54
1894  mul    dx
1896  mov    di, ax
1898  add    di, 0x69ec
189c  push   ds
189d  push   di
189e  mov    ax, 1
18a1  push   ax
18a2  call   Graph_PutImage
18a7  mov    ax, word ptr [0xb068]             ; walk_count
18aa  cdq
18ab  mov    cx, 2
18ae  idiv   cx
18b0  cdq
18b1  mov    cx, 4
18b4  idiv   cx
18b6  xchg   dx, ax
18b7  cmp    ax, 0
18ba  jne    0x18d4
18bc  mov    al, byte ptr [0xa3bf]             ; facing_left
18bf  xor    ah, ah
18c1  mov    dx, ax
18c3  mov    al, byte ptr [0xa3be]             ; held_item
18c6  xor    ah, ah
18c8  shl    ax, 1
18ca  add    ax, dx
18cc  add    ax, 0xa
18cf  mov    byte ptr [0xa3c0], al             ; player_sprite
18d2  jmp    0x191f
  loc_18d4:
18d4  cmp    ax, 1
18d7  jne    0x18ec
18d9  mov    al, byte ptr [0xa3bf]             ; facing_left
18dc  xor    ah, ah
18de  mov    dx, ax
18e0  mov    al, byte ptr [0xa3be]             ; held_item
18e3  xor    ah, ah
18e5  add    ax, dx
18e7  mov    byte ptr [0xa3c0], al             ; player_sprite
18ea  jmp    0x191f
  loc_18ec:
18ec  cmp    ax, 2
18ef  jne    0x1909
18f1  mov    al, byte ptr [0xa3bf]             ; facing_left
18f4  xor    ah, ah
18f6  mov    dx, ax
18f8  mov    al, byte ptr [0xa3be]             ; held_item
18fb  xor    ah, ah
18fd  shl    ax, 1
18ff  add    ax, dx
1901  add    ax, 0xc
1904  mov    byte ptr [0xa3c0], al             ; player_sprite
1907  jmp    0x191f
  loc_1909:
1909  cmp    ax, 3
190c  jne    0x191f
190e  mov    al, byte ptr [0xa3bf]             ; facing_left
1911  xor    ah, ah
1913  mov    dx, ax
1915  mov    al, byte ptr [0xa3be]             ; held_item
1918  xor    ah, ah
191a  add    ax, dx
191c  mov    byte ptr [0xa3c0], al             ; player_sprite
  loc_191f:
191f  mov    ax, word ptr [0xb058]             ; player_x
1922  sub    ax, 0x10
1925  push   ax
1926  mov    ax, word ptr [0xb05a]             ; player_y
1929  sub    ax, 8
192c  push   ax
192d  mov    al, byte ptr [0xa3c0]             ; player_sprite
1930  xor    ah, ah
1932  mov    dx, 0x54
1935  mul    dx
1937  mov    di, ax
1939  add    di, 0x69ec
193d  push   ds
193e  push   di
193f  mov    ax, 1
1942  push   ax
1943  call   Graph_PutImage
1948  mov    sp, bp
194a  pop    bp
194b  retf
194c  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
195c  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
196c  db 00,00,00,08,0e,00,7c,00,00,02,00,00,60,80,00,00
197c  db 00,00,80,01,02,80,00,00,00,06,08,40,00,00,00,00
198c  db 00,00,00,00,00,00,7c,00,00,02,00,00,00,00,00,00
199c  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
19ac  db 00,00,00,00,00,cc,7c,00,00,00,00,00,00,00,00,00
19bc  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
19cc  db 00,00,00,00,00,88,00,00,00,00,00,00,00,00,00,00
19dc  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
19ec  db 00,00,00,00,00,44,60,00,00,00,00,00,00,00,00,00
19fc  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
1a0c  db 00,00,00,00,00,44,64,00,00,00,00,00,00,00,00,00
1a1c  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00

; ------------------------------------------------------------
walk_right:
1a2c  push   bp
1a2d  mov    bp, sp
1a2f  call   Crt_KeyPressed
1a34  or     al, al
1a36  je     0x1a40
1a38  call   Crt_ReadKey
1a3d  mov    byte ptr [0xb08e], al             ; last_key
  loc_1a40:
1a40  cmp    byte ptr [0xcb16], 0              ; ladder_leave
1a45  je     0x1a4b
1a47  push   cs
1a48  call   remove_used_ladder
  loc_1a4b:
1a4b  mov    byte ptr [0xcb15], 0              ; ladder_marked
1a50  cmp    byte ptr [0xcb13], 0              ; bridge_left
1a55  je     0x1a68
1a57  mov    byte ptr [0xcb17], 0              ; bridge_latch
1a5c  cmp    byte ptr [0xcb18], 0              ; on_bridge
1a61  jne    0x1a68
1a63  mov    byte ptr [0xcb13], 0              ; bridge_left
  loc_1a68:
1a68  call   move_mummies
1a6d  cmp    byte ptr [0xcb18], 0              ; on_bridge
1a72  je     0x1ab4
1a74  mov    ax, word ptr [0xb05a]             ; player_y
1a77  add    ax, 9
1a7a  cdq
1a7b  mov    cx, 8
1a7e  idiv   cx
1a80  mov    bx, ax
1a82  mov    ax, word ptr [0xb058]             ; player_x
1a85  cdq
1a86  mov    cx, 0x20
1a89  idiv   cx
1a8b  mov    dx, 0x19
1a8e  mul    dx
1a90  mov    cx, ax
1a92  mov    al, byte ptr [0xa3c5]             ; cur_room
1a95  xor    ah, ah
1a97  mov    dx, 0x226
1a9a  mul    dx
1a9c  mov    di, ax
1a9e  add    di, cx
1aa0  add    di, bx
1aa2  cmp    byte ptr [di - 0x4a70], 0xde      ; +rooms
1aa7  jne    0x1ab0
1aa9  cmp    byte ptr [0xcb13], 0              ; bridge_left
1aae  je     0x1ab4
  loc_1ab0:
1ab0  push   cs
1ab1  call   collapse_bridge
  loc_1ab4:
1ab4  call   check_pickup
1ab9  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1abe  je     0x1ac5
1ac0  call   move_dagger
  loc_1ac5:
1ac5  mov    ax, word ptr [0xb058]             ; player_x
1ac8  mov    word ptr [0xb086], ax             ; old_x
1acb  add    word ptr [0xb058], 8              ; player_x
1ad0  mov    byte ptr [0xa3bf], 0              ; facing_left
1ad5  mov    byte ptr [0xa3c4], 0              ; standing
1ada  mov    byte ptr [0xa3ca], 0              ; push_left
1adf  cmp    word ptr [0xb058], 0x26f          ; player_x
1ae5  jle    0x1b2a
1ae7  mov    al, byte ptr [0xa3c5]             ; cur_room
1aea  mov    byte ptr [0xa3c1], al             ; scratch
1aed  call   check_room_change
1af2  mov    al, byte ptr [0xa3c1]             ; scratch
1af5  cmp    al, byte ptr [0xa3c5]             ; cur_room
1af9  je     0x1b2a
1afb  mov    ax, word ptr [0xb058]             ; player_x
1afe  sub    ax, 0x10
1b01  push   ax
1b02  mov    ax, word ptr [0xb05a]             ; player_y
1b05  sub    ax, 8
1b08  push   ax
1b09  mov    al, byte ptr [0xa3c0]             ; player_sprite
1b0c  xor    ah, ah
1b0e  mov    dx, 0x54
1b11  mul    dx
1b13  mov    di, ax
1b15  add    di, 0x69ec
1b19  push   ds
1b1a  push   di
1b1b  mov    ax, 1
1b1e  push   ax
1b1f  call   Graph_PutImage
1b24  mov    ax, word ptr [0xb058]             ; player_x
1b27  mov    word ptr [0xb086], ax             ; old_x
  loc_1b2a:
1b2a  mov    ax, word ptr [0xb05a]             ; player_y
1b2d  add    ax, 0xc
1b30  cdq
1b31  mov    cx, 8
1b34  idiv   cx
1b36  mov    bx, ax
1b38  mov    ax, word ptr [0xb058]             ; player_x
1b3b  cdq
1b3c  mov    cx, 0x20
1b3f  idiv   cx
1b41  mov    dx, 0x19
1b44  mul    dx
1b46  mov    cx, ax
1b48  mov    al, byte ptr [0xa3c5]             ; cur_room
1b4b  xor    ah, ah
1b4d  mov    dx, 0x226
1b50  mul    dx
1b52  mov    di, ax
1b54  add    di, cx
1b56  add    di, bx
1b58  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1b5c  push   ax
1b5d  mov    di, 0x194c                        ; set cs:194c = [175,222]
1b60  push   cs
1b61  push   di
1b62  call   Sys_SetIn
1b67  jne    0x1b6c
1b69  jmp    0x1c6f
  loc_1b6c:
1b6c  cmp    byte ptr [0xcb17], 0              ; bridge_latch
1b71  je     0x1b76
1b73  jmp    0x1c6d
  loc_1b76:
1b76  mov    ax, word ptr [0xb05a]             ; player_y
1b79  add    ax, 0xc
1b7c  cdq
1b7d  mov    cx, 8
1b80  idiv   cx
1b82  mov    byte ptr [0xa3b1], al             ; loop_j
1b85  mov    ax, word ptr [0xb058]             ; player_x
1b88  cdq
1b89  mov    cx, 0x20
1b8c  idiv   cx
1b8e  mov    byte ptr [0xa3b0], al             ; loop_i
1b91  mov    al, byte ptr [0xa3b1]             ; loop_j
1b94  xor    ah, ah
1b96  mov    bx, ax
1b98  mov    al, byte ptr [0xa3b0]             ; loop_i
1b9b  xor    ah, ah
1b9d  mov    dx, 0x19
1ba0  mul    dx
1ba2  mov    cx, ax
1ba4  mov    al, byte ptr [0xa3c5]             ; cur_room
1ba7  xor    ah, ah
1ba9  mov    dx, 0x226
1bac  mul    dx
1bae  mov    di, ax
1bb0  add    di, cx
1bb2  add    di, bx
1bb4  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1bb8  xor    ah, ah
1bba  cmp    ax, 0xde
1bbd  jne    0x1bd2
1bbf  mov    byte ptr [0xcb18], 1              ; on_bridge
1bc4  mov    byte ptr [0xcb14], 1              ; bridge_right
1bc9  mov    al, byte ptr [0xa3b1]             ; loop_j
1bcc  mov    byte ptr [0xa3c3], al             ; bridge_row
1bcf  jmp    0x1c68
  loc_1bd2:
1bd2  cmp    ax, 0xaf
1bd5  je     0x1bda
1bd7  jmp    0x1c68
  loc_1bda:
1bda  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_1bde:
1bde  dec    byte ptr [0xa3b0]                 ; loop_i
1be2  mov    al, byte ptr [0xa3b1]             ; loop_j
1be5  xor    ah, ah
1be7  mov    bx, ax
1be9  mov    al, byte ptr [0xa3b0]             ; loop_i
1bec  xor    ah, ah
1bee  dec    ax
1bef  mov    dx, 0x19
1bf2  mul    dx
1bf4  mov    cx, ax
1bf6  mov    al, byte ptr [0xa3c5]             ; cur_room
1bf9  xor    ah, ah
1bfb  mov    dx, 0x226
1bfe  mul    dx
1c00  mov    di, ax
1c02  add    di, cx
1c04  add    di, bx
1c06  cmp    byte ptr [di - 0x4a70], 0xaf      ; +rooms
1c0b  je     0x1bde
1c0d  mov    byte ptr [0xcb14], 1              ; bridge_right
  loc_1c12:
1c12  mov    al, byte ptr [0xa3b1]             ; loop_j
1c15  xor    ah, ah
1c17  mov    bx, ax
1c19  mov    al, byte ptr [0xa3b0]             ; loop_i
1c1c  xor    ah, ah
1c1e  mov    dx, 0x19
1c21  mul    dx
1c23  mov    cx, ax
1c25  mov    al, byte ptr [0xa3c5]             ; cur_room
1c28  xor    ah, ah
1c2a  mov    dx, 0x226
1c2d  mul    dx
1c2f  mov    di, ax
1c31  add    di, cx
1c33  add    di, bx
1c35  mov    byte ptr [di - 0x4a70], 0xde      ; +rooms
1c3a  inc    byte ptr [0xa3b0]                 ; loop_i
1c3e  mov    al, byte ptr [0xa3b1]             ; loop_j
1c41  xor    ah, ah
1c43  mov    bx, ax
1c45  mov    al, byte ptr [0xa3b0]             ; loop_i
1c48  xor    ah, ah
1c4a  mov    dx, 0x19
1c4d  mul    dx
1c4f  mov    cx, ax
1c51  mov    al, byte ptr [0xa3c5]             ; cur_room
1c54  xor    ah, ah
1c56  mov    dx, 0x226
1c59  mul    dx
1c5b  mov    di, ax
1c5d  add    di, cx
1c5f  add    di, bx
1c61  cmp    byte ptr [di - 0x4a70], 0xaf      ; +rooms
1c66  je     0x1c12
  loc_1c68:
1c68  mov    byte ptr [0xcb17], 1              ; bridge_latch
  loc_1c6d:
1c6d  jmp    0x1c7b
  loc_1c6f:
1c6f  cmp    byte ptr [0xcb14], 0              ; bridge_right
1c74  je     0x1c7b
1c76  mov    byte ptr [0xcb17], 0              ; bridge_latch
  loc_1c7b:
1c7b  mov    ax, word ptr [0xb058]             ; player_x
1c7e  add    ax, 0xe
1c81  cdq
1c82  mov    cx, 0x20
1c85  idiv   cx
1c87  mov    byte ptr [0xa3b5], al             ; probe_col
1c8a  mov    ax, word ptr [0xb05a]             ; player_y
1c8d  sub    ax, 6
1c90  cdq
1c91  mov    cx, 8
1c94  idiv   cx
1c96  mov    byte ptr [0xa3b6], al             ; probe_row
1c99  mov    al, byte ptr [0xa3b6]             ; probe_row
1c9c  xor    ah, ah
1c9e  mov    bx, ax
1ca0  mov    al, byte ptr [0xa3b5]             ; probe_col
1ca3  xor    ah, ah
1ca5  mov    dx, 0x19
1ca8  mul    dx
1caa  mov    cx, ax
1cac  mov    al, byte ptr [0xa3c5]             ; cur_room
1caf  xor    ah, ah
1cb1  mov    dx, 0x226
1cb4  mul    dx
1cb6  mov    di, ax
1cb8  add    di, cx
1cba  add    di, bx
1cbc  cmp    byte ptr [di - 0x4a70], 0x32      ; +rooms
1cc1  je     0x1cc6
1cc3  jmp    0x1efb
  loc_1cc6:
1cc6  inc    byte ptr [0xa3cb]                 ; push_right
1cca  call   Crt_KeyPressed
1ccf  or     al, al
1cd1  je     0x1cdb
1cd3  call   Crt_ReadKey
1cd8  mov    byte ptr [0xb08e], al             ; last_key
  loc_1cdb:
1cdb  cmp    byte ptr [0xa3cb], 5              ; push_right
1ce0  ja     0x1ce5
1ce2  jmp    0x1eb6
  loc_1ce5:
1ce5  mov    al, byte ptr [0xa3b6]             ; probe_row
1ce8  xor    ah, ah
1cea  mov    bx, ax
1cec  mov    al, byte ptr [0xa3b5]             ; probe_col
1cef  xor    ah, ah
1cf1  inc    ax
1cf2  mov    dx, 0x19
1cf5  mul    dx
1cf7  mov    cx, ax
1cf9  mov    al, byte ptr [0xa3c5]             ; cur_room
1cfc  xor    ah, ah
1cfe  mov    dx, 0x226
1d01  mul    dx
1d03  mov    di, ax
1d05  add    di, cx
1d07  add    di, bx
1d09  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1d0d  push   ax
1d0e  mov    di, 0x196c                        ; set cs:196c = [27,33,34,35,50,51,52,53,54,73,101,102,111,151,152,161,175,201,202,211,222]
1d11  push   cs
1d12  push   di
1d13  call   Sys_SetIn
1d18  je     0x1d1d
1d1a  jmp    0x1eaa
  loc_1d1d:
1d1d  mov    al, byte ptr [0xa3b6]             ; probe_row
1d20  xor    ah, ah
1d22  inc    ax
1d23  mov    bx, ax
1d25  mov    al, byte ptr [0xa3b5]             ; probe_col
1d28  xor    ah, ah
1d2a  inc    ax
1d2b  mov    dx, 0x19
1d2e  mul    dx
1d30  mov    cx, ax
1d32  mov    al, byte ptr [0xa3c5]             ; cur_room
1d35  xor    ah, ah
1d37  mov    dx, 0x226
1d3a  mul    dx
1d3c  mov    di, ax
1d3e  add    di, cx
1d40  add    di, bx
1d42  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1d46  push   ax
1d47  mov    di, 0x198c                        ; set cs:198c = [50,51,52,53,54,73,175,222]
1d4a  push   cs
1d4b  push   di
1d4c  call   Sys_SetIn
1d51  je     0x1d56
1d53  jmp    0x1eaa
  loc_1d56:
1d56  mov    al, byte ptr [0xa3b5]             ; probe_col
1d59  xor    ah, ah
1d5b  mov    cx, 5
1d5e  shl    ax, cl
1d60  push   ax
1d61  mov    al, byte ptr [0xa3b6]             ; probe_row
1d64  xor    ah, ah
1d66  mov    cx, 3
1d69  shl    ax, cl
1d6b  push   ax
1d6c  mov    di, 0x7a54
1d6f  push   ds
1d70  push   di
1d71  mov    ax, 1
1d74  push   ax
1d75  call   Graph_PutImage
1d7a  mov    al, byte ptr [0xa3b6]             ; probe_row
1d7d  xor    ah, ah
1d7f  mov    bx, ax
1d81  mov    al, byte ptr [0xa3b5]             ; probe_col
1d84  xor    ah, ah
1d86  mov    dx, 0x19
1d89  mul    dx
1d8b  mov    cx, ax
1d8d  mov    al, byte ptr [0xa3c5]             ; cur_room
1d90  xor    ah, ah
1d92  mov    dx, 0x226
1d95  mul    dx
1d97  mov    di, ax
1d99  add    di, cx
1d9b  add    di, bx
1d9d  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
1da2  mov    al, byte ptr [0xa3c5]             ; cur_room
1da5  mov    byte ptr [0xa3c8], al             ; stone_room
1da8  cmp    byte ptr [0xa3b5], 0x13           ; probe_col
1dad  jne    0x1dce
1daf  mov    word ptr [0xb082], 0x285          ; cell_x
1db5  mov    di, 0xa3c8                        ; &stone_room
1db8  push   ds
1db9  push   di
1dba  mov    di, 0xb082                        ; &cell_x
1dbd  push   ds
1dbe  push   di
1dbf  mov    di, 0xb084                        ; &cell_y
1dc2  push   ds
1dc3  push   di
1dc4  call   move_to_next_room
1dc9  mov    byte ptr [0xa3b5], 0              ; probe_col
  loc_1dce:
1dce  mov    al, byte ptr [0xa3c8]             ; stone_room
1dd1  cmp    al, byte ptr [0xa3c5]             ; cur_room
1dd5  jne    0x1dfe
1dd7  mov    al, byte ptr [0xa3b5]             ; probe_col
1dda  xor    ah, ah
1ddc  mov    cx, 5
1ddf  shl    ax, cl
1de1  add    ax, 0x20
1de4  push   ax
1de5  mov    al, byte ptr [0xa3b6]             ; probe_row
1de8  xor    ah, ah
1dea  mov    cx, 3
1ded  shl    ax, cl
1def  push   ax
1df0  mov    di, 0x7a54
1df3  push   ds
1df4  push   di
1df5  mov    ax, 1
1df8  push   ax
1df9  call   Graph_PutImage
  loc_1dfe:
1dfe  mov    al, byte ptr [0xa3b6]             ; probe_row
1e01  xor    ah, ah
1e03  mov    bx, ax
1e05  mov    al, byte ptr [0xa3b5]             ; probe_col
1e08  xor    ah, ah
1e0a  inc    ax
1e0b  mov    dx, 0x19
1e0e  mul    dx
1e10  mov    cx, ax
1e12  mov    al, byte ptr [0xa3c8]             ; stone_room
1e15  xor    ah, ah
1e17  mov    dx, 0x226
1e1a  mul    dx
1e1c  mov    di, ax
1e1e  add    di, cx
1e20  add    di, bx
1e22  mov    byte ptr [di - 0x4a70], 0x32      ; +rooms
1e27  mov    al, byte ptr [0xa3b6]             ; probe_row
1e2a  xor    ah, ah
1e2c  add    ax, 2
1e2f  mov    bx, ax
1e31  mov    al, byte ptr [0xa3b5]             ; probe_col
1e34  xor    ah, ah
1e36  inc    ax
1e37  mov    dx, 0x19
1e3a  mul    dx
1e3c  mov    cx, ax
1e3e  mov    al, byte ptr [0xa3c8]             ; stone_room
1e41  xor    ah, ah
1e43  mov    dx, 0x226
1e46  mul    dx
1e48  mov    di, ax
1e4a  add    di, cx
1e4c  add    di, bx
1e4e  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1e52  push   ax
1e53  mov    di, 0x19ac                        ; set cs:19ac = [42,43,46,47,50,51,52,53,54,175,222]
1e56  push   cs
1e57  push   di
1e58  call   Sys_SetIn
1e5d  jne    0x1e9e
1e5f  mov    al, byte ptr [0xa3b6]             ; probe_row
1e62  xor    ah, ah
1e64  mov    bx, ax
1e66  mov    al, byte ptr [0xa3b5]             ; probe_col
1e69  xor    ah, ah
1e6b  inc    ax
1e6c  mov    dx, 0x19
1e6f  mul    dx
1e71  mov    cx, ax
1e73  mov    al, byte ptr [0xa3c5]             ; cur_room
1e76  xor    ah, ah
1e78  mov    dx, 0x226
1e7b  mul    dx
1e7d  mov    di, ax
1e7f  add    di, cx
1e81  add    di, bx
1e83  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
1e88  mov    byte ptr [0xcb0f], 1              ; stone_falling
1e8d  mov    al, byte ptr [0xa3b5]             ; probe_col
1e90  xor    ah, ah
1e92  inc    ax
1e93  mov    word ptr [0xb08a], ax             ; stone_col
1e96  mov    al, byte ptr [0xa3b6]             ; probe_row
1e99  xor    ah, ah
1e9b  mov    word ptr [0xb08c], ax             ; stone_row
  loc_1e9e:
1e9e  add    word ptr [0xb058], 0x10           ; player_x
1ea3  mov    byte ptr [0xa3cb], 0              ; push_right
1ea8  jmp    0x1eb4
  loc_1eaa:
1eaa  sub    word ptr [0xb058], 8              ; player_x
1eaf  mov    byte ptr [0xa3cb], 0              ; push_right
  loc_1eb4:
1eb4  jmp    0x1efb
  loc_1eb6:
1eb6  mov    byte ptr [0xa3b0], 0x14           ; loop_i
1ebb  jmp    0x1ec1
  loc_1ebd:
1ebd  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_1ec1:
1ec1  mov    ax, 0x14
1ec4  push   ax
1ec5  call   Crt_Sound
1eca  mov    al, byte ptr [0xa3b0]             ; loop_i
1ecd  xor    ah, ah
1ecf  sub    ax, 0xa
1ed2  push   ax
1ed3  call   Crt_Delay
1ed8  call   Crt_NoSound
1edd  mov    al, byte ptr [0xa3b0]             ; loop_i
1ee0  xor    ah, ah
1ee2  mov    dx, ax
1ee4  mov    ax, 0x15
1ee7  sub    ax, dx
1ee9  push   ax
1eea  call   Crt_Delay
1eef  cmp    byte ptr [0xa3b0], 0xf            ; loop_i
1ef4  jne    0x1ebd
1ef6  sub    word ptr [0xb058], 8              ; player_x
  loc_1efb:
1efb  mov    ax, word ptr [0xb058]             ; player_x
1efe  add    ax, 8
1f01  cdq
1f02  mov    cx, 0x20
1f05  idiv   cx
1f07  mov    byte ptr [0xa3b5], al             ; probe_col
1f0a  mov    al, byte ptr [0xa3b6]             ; probe_row
1f0d  xor    ah, ah
1f0f  mov    bx, ax
1f11  mov    al, byte ptr [0xa3b5]             ; probe_col
1f14  xor    ah, ah
1f16  mov    dx, 0x19
1f19  mul    dx
1f1b  mov    cx, ax
1f1d  mov    al, byte ptr [0xa3c5]             ; cur_room
1f20  xor    ah, ah
1f22  mov    dx, 0x226
1f25  mul    dx
1f27  mov    di, ax
1f29  add    di, cx
1f2b  add    di, bx
1f2d  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1f31  push   ax
1f32  mov    di, 0x19cc                        ; set cs:19cc = [43,47]
1f35  push   cs
1f36  push   di
1f37  call   Sys_SetIn
1f3c  jne    0x1f41
1f3e  jmp    0x253d
  loc_1f41:
1f41  inc    byte ptr [0xa3cb]                 ; push_right
1f45  call   Crt_KeyPressed
1f4a  or     al, al
1f4c  je     0x1f56
1f4e  call   Crt_ReadKey
1f53  mov    byte ptr [0xb08e], al             ; last_key
  loc_1f56:
1f56  cmp    byte ptr [0xa3cb], 0xa            ; push_right
1f5b  ja     0x1f60
1f5d  jmp    0x2538
  loc_1f60:
1f60  mov    al, byte ptr [0xa3b6]             ; probe_row
1f63  xor    ah, ah
1f65  mov    bx, ax
1f67  mov    al, byte ptr [0xa3b5]             ; probe_col
1f6a  xor    ah, ah
1f6c  mov    dx, 0x19
1f6f  mul    dx
1f71  mov    cx, ax
1f73  mov    al, byte ptr [0xa3c5]             ; cur_room
1f76  xor    ah, ah
1f78  mov    dx, 0x226
1f7b  mul    dx
1f7d  mov    di, ax
1f7f  add    di, cx
1f81  add    di, bx
1f83  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1f87  xor    ah, ah
1f89  cmp    ax, 0x2b
1f8c  je     0x1f91
1f8e  jmp    0x2238
  loc_1f91:
1f91  mov    byte ptr [0xa3b0], 0x1e           ; loop_i
1f96  jmp    0x1f9c
  loc_1f98:
1f98  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_1f9c:
1f9c  mov    ax, 0x64
1f9f  push   ax
1fa0  call   Crt_Sound
1fa5  mov    al, byte ptr [0xa3b0]             ; loop_i
1fa8  xor    ah, ah
1faa  push   ax
1fab  call   Crt_Delay
1fb0  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1fb5  je     0x1fbc
1fb7  call   move_dagger
  loc_1fbc:
1fbc  call   Crt_KeyPressed
1fc1  or     al, al
1fc3  je     0x1fcd
1fc5  call   Crt_ReadKey
1fca  mov    byte ptr [0xb08e], al             ; last_key
  loc_1fcd:
1fcd  call   Crt_NoSound
1fd2  mov    al, byte ptr [0xa3b0]             ; loop_i
1fd5  xor    ah, ah
1fd7  mov    dx, ax
1fd9  mov    ax, 0x1f
1fdc  sub    ax, dx
1fde  push   ax
1fdf  call   Crt_Delay
1fe4  call   move_mummies
1fe9  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
1fee  je     0x1ff5
1ff0  call   move_dagger
  loc_1ff5:
1ff5  cmp    byte ptr [0xa3b0], 0x1c           ; loop_i
1ffa  jne    0x1f98
1ffc  mov    al, byte ptr [0xa3b5]             ; probe_col
1fff  xor    ah, ah
2001  mov    cx, 5
2004  shl    ax, cl
2006  push   ax
2007  mov    al, byte ptr [0xa3b6]             ; probe_row
200a  xor    ah, ah
200c  mov    cx, 3
200f  shl    ax, cl
2011  push   ax
2012  mov    di, 0x7808
2015  push   ds
2016  push   di
2017  mov    ax, 1
201a  push   ax
201b  call   Graph_PutImage
2020  mov    al, byte ptr [0xa3b5]             ; probe_col
2023  xor    ah, ah
2025  mov    cx, 5
2028  shl    ax, cl
202a  push   ax
202b  mov    al, byte ptr [0xa3b6]             ; probe_row
202e  xor    ah, ah
2030  mov    cx, 3
2033  shl    ax, cl
2035  push   ax
2036  mov    di, 0x785c
2039  push   ds
203a  push   di
203b  mov    ax, 1
203e  push   ax
203f  call   Graph_PutImage
2044  mov    ax, word ptr [0xb086]             ; old_x
2047  sub    ax, 0x10
204a  push   ax
204b  mov    ax, word ptr [0xb05a]             ; player_y
204e  sub    ax, 8
2051  push   ax
2052  mov    al, byte ptr [0xa3c0]             ; player_sprite
2055  xor    ah, ah
2057  mov    dx, 0x54
205a  mul    dx
205c  mov    di, ax
205e  add    di, 0x69ec
2062  push   ds
2063  push   di
2064  mov    ax, 1
2067  push   ax
2068  call   Graph_PutImage
206d  mov    byte ptr [0xa3b0], 0x1b           ; loop_i
2072  jmp    0x2078
  loc_2074:
2074  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_2078:
2078  mov    ax, 0x64
207b  push   ax
207c  call   Crt_Sound
2081  mov    al, byte ptr [0xa3b0]             ; loop_i
2084  xor    ah, ah
2086  push   ax
2087  call   Crt_Delay
208c  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2091  je     0x2098
2093  call   move_dagger
  loc_2098:
2098  call   Crt_KeyPressed
209d  or     al, al
209f  je     0x20a9
20a1  call   Crt_ReadKey
20a6  mov    byte ptr [0xb08e], al             ; last_key
  loc_20a9:
20a9  call   Crt_NoSound
20ae  mov    al, byte ptr [0xa3b0]             ; loop_i
20b1  xor    ah, ah
20b3  mov    dx, ax
20b5  mov    ax, 0x1c
20b8  sub    ax, dx
20ba  push   ax
20bb  call   Crt_Delay
20c0  call   move_mummies
20c5  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
20ca  je     0x20d1
20cc  call   move_dagger
  loc_20d1:
20d1  cmp    byte ptr [0xa3b0], 0x19           ; loop_i
20d6  jne    0x2074
20d8  mov    al, byte ptr [0xa3b5]             ; probe_col
20db  xor    ah, ah
20dd  mov    cx, 5
20e0  shl    ax, cl
20e2  push   ax
20e3  mov    al, byte ptr [0xa3b6]             ; probe_row
20e6  xor    ah, ah
20e8  mov    cx, 3
20eb  shl    ax, cl
20ed  push   ax
20ee  mov    di, 0x785c
20f1  push   ds
20f2  push   di
20f3  mov    ax, 1
20f6  push   ax
20f7  call   Graph_PutImage
20fc  mov    al, byte ptr [0xa3b5]             ; probe_col
20ff  xor    ah, ah
2101  mov    cx, 5
2104  shl    ax, cl
2106  push   ax
2107  mov    al, byte ptr [0xa3b6]             ; probe_row
210a  xor    ah, ah
210c  mov    cx, 3
210f  shl    ax, cl
2111  push   ax
2112  mov    di, 0x78b0
2115  push   ds
2116  push   di
2117  mov    ax, 1
211a  push   ax
211b  call   Graph_PutImage
2120  mov    byte ptr [0xa3b0], 0x18           ; loop_i
2125  jmp    0x212b
  loc_2127:
2127  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_212b:
212b  mov    ax, 0x64
212e  push   ax
212f  call   Crt_Sound
2134  mov    al, byte ptr [0xa3b0]             ; loop_i
2137  xor    ah, ah
2139  push   ax
213a  call   Crt_Delay
213f  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2144  je     0x214b
2146  call   move_dagger
  loc_214b:
214b  call   Crt_KeyPressed
2150  or     al, al
2152  je     0x215c
2154  call   Crt_ReadKey
2159  mov    byte ptr [0xb08e], al             ; last_key
  loc_215c:
215c  call   Crt_NoSound
2161  mov    al, byte ptr [0xa3b0]             ; loop_i
2164  xor    ah, ah
2166  mov    dx, ax
2168  mov    ax, 0x19
216b  sub    ax, dx
216d  push   ax
216e  call   Crt_Delay
2173  call   move_mummies
2178  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
217d  je     0x2184
217f  call   move_dagger
  loc_2184:
2184  cmp    byte ptr [0xa3b0], 0x16           ; loop_i
2189  jne    0x2127
218b  mov    al, byte ptr [0xa3b5]             ; probe_col
218e  xor    ah, ah
2190  mov    cx, 5
2193  shl    ax, cl
2195  push   ax
2196  mov    al, byte ptr [0xa3b6]             ; probe_row
2199  xor    ah, ah
219b  mov    cx, 3
219e  shl    ax, cl
21a0  push   ax
21a1  mov    di, 0x78b0
21a4  push   ds
21a5  push   di
21a6  mov    ax, 1
21a9  push   ax
21aa  call   Graph_PutImage
21af  mov    al, byte ptr [0xa3b5]             ; probe_col
21b2  xor    ah, ah
21b4  mov    cx, 5
21b7  shl    ax, cl
21b9  push   ax
21ba  mov    al, byte ptr [0xa3b6]             ; probe_row
21bd  xor    ah, ah
21bf  mov    cx, 3
21c2  shl    ax, cl
21c4  push   ax
21c5  mov    di, 0x77b4
21c8  push   ds
21c9  push   di
21ca  mov    ax, 1
21cd  push   ax
21ce  call   Graph_PutImage
21d3  mov    ax, word ptr [0xb086]             ; old_x
21d6  add    ax, 0x20
21d9  push   ax
21da  mov    ax, word ptr [0xb05a]             ; player_y
21dd  sub    ax, 8
21e0  push   ax
21e1  mov    al, byte ptr [0xa3c0]             ; player_sprite
21e4  xor    ah, ah
21e6  mov    dx, 0x54
21e9  mul    dx
21eb  mov    di, ax
21ed  add    di, 0x69ec
21f1  push   ds
21f2  push   di
21f3  mov    ax, 1
21f6  push   ax
21f7  call   Graph_PutImage
21fc  call   move_mummies
2201  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2206  je     0x220d
2208  call   move_dagger
  loc_220d:
220d  mov    al, byte ptr [0xa3b6]             ; probe_row
2210  xor    ah, ah
2212  mov    bx, ax
2214  mov    al, byte ptr [0xa3b5]             ; probe_col
2217  xor    ah, ah
2219  mov    dx, 0x19
221c  mul    dx
221e  mov    cx, ax
2220  mov    al, byte ptr [0xa3c5]             ; cur_room
2223  xor    ah, ah
2225  mov    dx, 0x226
2228  mul    dx
222a  mov    di, ax
222c  add    di, cx
222e  add    di, bx
2230  mov    byte ptr [di - 0x4a70], 0x2a      ; +rooms
2235  jmp    0x2527
  loc_2238:
2238  cmp    ax, 0x2f
223b  je     0x2240
223d  jmp    0x2527
  loc_2240:
2240  mov    byte ptr [0xa3b0], 0x1e           ; loop_i
2245  jmp    0x224b
  loc_2247:
2247  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_224b:
224b  mov    ax, 0x64
224e  push   ax
224f  call   Crt_Sound
2254  mov    al, byte ptr [0xa3b0]             ; loop_i
2257  xor    ah, ah
2259  push   ax
225a  call   Crt_Delay
225f  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2264  je     0x226b
2266  call   move_dagger
  loc_226b:
226b  call   Crt_KeyPressed
2270  or     al, al
2272  je     0x227c
2274  call   Crt_ReadKey
2279  mov    byte ptr [0xb08e], al             ; last_key
  loc_227c:
227c  call   Crt_NoSound
2281  mov    al, byte ptr [0xa3b0]             ; loop_i
2284  xor    ah, ah
2286  mov    dx, ax
2288  mov    ax, 0x1f
228b  sub    ax, dx
228d  push   ax
228e  call   Crt_Delay
2293  call   move_mummies
2298  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
229d  je     0x22a4
229f  call   move_dagger
  loc_22a4:
22a4  cmp    byte ptr [0xa3b0], 0x1c           ; loop_i
22a9  jne    0x2247
22ab  mov    al, byte ptr [0xa3b5]             ; probe_col
22ae  xor    ah, ah
22b0  mov    cx, 5
22b3  shl    ax, cl
22b5  push   ax
22b6  mov    al, byte ptr [0xa3b6]             ; probe_row
22b9  xor    ah, ah
22bb  mov    cx, 3
22be  shl    ax, cl
22c0  push   ax
22c1  mov    di, 0x7958
22c4  push   ds
22c5  push   di
22c6  mov    ax, 1
22c9  push   ax
22ca  call   Graph_PutImage
22cf  mov    ax, word ptr [0xb086]             ; old_x
22d2  sub    ax, 0x10
22d5  push   ax
22d6  mov    ax, word ptr [0xb05a]             ; player_y
22d9  sub    ax, 8
22dc  push   ax
22dd  mov    al, byte ptr [0xa3c0]             ; player_sprite
22e0  xor    ah, ah
22e2  mov    dx, 0x54
22e5  mul    dx
22e7  mov    di, ax
22e9  add    di, 0x69ec
22ed  push   ds
22ee  push   di
22ef  mov    ax, 1
22f2  push   ax
22f3  call   Graph_PutImage
22f8  mov    al, byte ptr [0xa3b5]             ; probe_col
22fb  xor    ah, ah
22fd  mov    cx, 5
2300  shl    ax, cl
2302  push   ax
2303  mov    al, byte ptr [0xa3b6]             ; probe_row
2306  xor    ah, ah
2308  mov    cx, 3
230b  shl    ax, cl
230d  push   ax
230e  mov    di, 0x7a00
2311  push   ds
2312  push   di
2313  mov    ax, 1
2316  push   ax
2317  call   Graph_PutImage
231c  mov    byte ptr [0xa3b0], 0x1b           ; loop_i
2321  jmp    0x2327
  loc_2323:
2323  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_2327:
2327  mov    ax, 0x64
232a  push   ax
232b  call   Crt_Sound
2330  mov    al, byte ptr [0xa3b0]             ; loop_i
2333  xor    ah, ah
2335  push   ax
2336  call   Crt_Delay
233b  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2340  je     0x2347
2342  call   move_dagger
  loc_2347:
2347  call   Crt_KeyPressed
234c  or     al, al
234e  je     0x2358
2350  call   Crt_ReadKey
2355  mov    byte ptr [0xb08e], al             ; last_key
  loc_2358:
2358  call   Crt_NoSound
235d  mov    al, byte ptr [0xa3b0]             ; loop_i
2360  xor    ah, ah
2362  mov    dx, ax
2364  mov    ax, 0x1c
2367  sub    ax, dx
2369  push   ax
236a  call   Crt_Delay
236f  call   move_mummies
2374  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2379  je     0x2380
237b  call   move_dagger
  loc_2380:
2380  cmp    byte ptr [0xa3b0], 0x19           ; loop_i
2385  jne    0x2323
2387  mov    al, byte ptr [0xa3b5]             ; probe_col
238a  xor    ah, ah
238c  mov    cx, 5
238f  shl    ax, cl
2391  push   ax
2392  mov    al, byte ptr [0xa3b6]             ; probe_row
2395  xor    ah, ah
2397  mov    cx, 3
239a  shl    ax, cl
239c  push   ax
239d  mov    di, 0x7a00
23a0  push   ds
23a1  push   di
23a2  mov    ax, 1
23a5  push   ax
23a6  call   Graph_PutImage
23ab  mov    al, byte ptr [0xa3b5]             ; probe_col
23ae  xor    ah, ah
23b0  mov    cx, 5
23b3  shl    ax, cl
23b5  push   ax
23b6  mov    al, byte ptr [0xa3b6]             ; probe_row
23b9  xor    ah, ah
23bb  mov    cx, 3
23be  shl    ax, cl
23c0  push   ax
23c1  mov    di, 0x7a00
23c4  push   ds
23c5  push   di
23c6  mov    ax, 1
23c9  push   ax
23ca  call   Graph_PutImage
23cf  mov    byte ptr [0xa3b0], 0x18           ; loop_i
23d4  jmp    0x23da
  loc_23d6:
23d6  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_23da:
23da  mov    ax, 0x64
23dd  push   ax
23de  call   Crt_Sound
23e3  mov    al, byte ptr [0xa3b0]             ; loop_i
23e6  xor    ah, ah
23e8  push   ax
23e9  call   Crt_Delay
23ee  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
23f3  je     0x23fa
23f5  call   move_dagger
  loc_23fa:
23fa  call   Crt_KeyPressed
23ff  or     al, al
2401  je     0x240b
2403  call   Crt_ReadKey
2408  mov    byte ptr [0xb08e], al             ; last_key
  loc_240b:
240b  call   Crt_NoSound
2410  mov    al, byte ptr [0xa3b0]             ; loop_i
2413  xor    ah, ah
2415  mov    dx, ax
2417  mov    ax, 0x19
241a  sub    ax, dx
241c  push   ax
241d  call   Crt_Delay
2422  call   move_mummies
2427  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
242c  je     0x2433
242e  call   move_dagger
  loc_2433:
2433  cmp    byte ptr [0xa3b0], 0x16           ; loop_i
2438  jne    0x23d6
243a  mov    al, byte ptr [0xa3b5]             ; probe_col
243d  xor    ah, ah
243f  mov    cx, 5
2442  shl    ax, cl
2444  push   ax
2445  mov    al, byte ptr [0xa3b6]             ; probe_row
2448  xor    ah, ah
244a  mov    cx, 3
244d  shl    ax, cl
244f  push   ax
2450  mov    di, 0x7a00
2453  push   ds
2454  push   di
2455  mov    ax, 1
2458  push   ax
2459  call   Graph_PutImage
245e  mov    al, byte ptr [0xa3b5]             ; probe_col
2461  xor    ah, ah
2463  mov    cx, 5
2466  shl    ax, cl
2468  push   ax
2469  mov    al, byte ptr [0xa3b6]             ; probe_row
246c  xor    ah, ah
246e  mov    cx, 3
2471  shl    ax, cl
2473  push   ax
2474  mov    di, 0x7958
2477  push   ds
2478  push   di
2479  mov    ax, 1
247c  push   ax
247d  call   Graph_PutImage
2482  mov    ax, word ptr [0xb086]             ; old_x
2485  add    ax, 0x20
2488  push   ax
2489  mov    ax, word ptr [0xb05a]             ; player_y
248c  sub    ax, 8
248f  push   ax
2490  mov    al, byte ptr [0xa3c0]             ; player_sprite
2493  xor    ah, ah
2495  mov    dx, 0x54
2498  mul    dx
249a  mov    di, ax
249c  add    di, 0x69ec
24a0  push   ds
24a1  push   di
24a2  mov    ax, 1
24a5  push   ax
24a6  call   Graph_PutImage
24ab  mov    byte ptr [0xa3b0], 0x15           ; loop_i
24b0  jmp    0x24b6
  loc_24b2:
24b2  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_24b6:
24b6  mov    ax, 0x64
24b9  push   ax
24ba  call   Crt_Sound
24bf  mov    al, byte ptr [0xa3b0]             ; loop_i
24c2  xor    ah, ah
24c4  push   ax
24c5  call   Crt_Delay
24ca  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
24cf  je     0x24d6
24d1  call   move_dagger
  loc_24d6:
24d6  call   Crt_KeyPressed
24db  or     al, al
24dd  je     0x24e7
24df  call   Crt_ReadKey
24e4  mov    byte ptr [0xb08e], al             ; last_key
  loc_24e7:
24e7  call   Crt_NoSound
24ec  mov    al, byte ptr [0xa3b0]             ; loop_i
24ef  xor    ah, ah
24f1  mov    dx, ax
24f3  mov    ax, 0x16
24f6  sub    ax, dx
24f8  push   ax
24f9  call   Crt_Delay
24fe  call   move_mummies
2503  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2508  je     0x250f
250a  call   move_dagger
  loc_250f:
250f  cmp    byte ptr [0xa3b0], 0x13           ; loop_i
2514  jne    0x24b2
2516  call   move_mummies
251b  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2520  je     0x2527
2522  call   move_dagger
  loc_2527:
2527  add    word ptr [0xb058], 0x30           ; player_x
252c  mov    byte ptr [0xa3cb], 0              ; push_right
2531  add    word ptr [0xb086], 0x30           ; old_x
2536  jmp    0x253d
  loc_2538:
2538  sub    word ptr [0xb058], 8              ; player_x
  loc_253d:
253d  mov    ax, word ptr [0xb058]             ; player_x
2540  add    ax, 0xb
2543  cdq
2544  mov    cx, 0x20
2547  idiv   cx
2549  mov    byte ptr [0xa3b5], al             ; probe_col
254c  mov    ax, word ptr [0xb05a]             ; player_y
254f  sub    ax, 6
2552  cdq
2553  mov    cx, 8
2556  idiv   cx
2558  mov    byte ptr [0xa3b6], al             ; probe_row
255b  mov    al, byte ptr [0xa3b6]             ; probe_row
255e  xor    ah, ah
2560  mov    bx, ax
2562  mov    al, byte ptr [0xa3b5]             ; probe_col
2565  xor    ah, ah
2567  mov    dx, 0x19
256a  mul    dx
256c  mov    cx, ax
256e  mov    al, byte ptr [0xa3c5]             ; cur_room
2571  xor    ah, ah
2573  mov    dx, 0x226
2576  mul    dx
2578  mov    di, ax
257a  add    di, cx
257c  add    di, bx
257e  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2582  push   ax
2583  mov    di, 0x19ec                        ; set cs:19ec = [42,46,53,54,175,222]
2586  push   cs
2587  push   di
2588  call   Sys_SetIn
258d  jne    0x25ca
258f  mov    ax, word ptr [0xb05a]             ; player_y
2592  add    ax, 6
2595  cdq
2596  mov    cx, 8
2599  idiv   cx
259b  mov    bx, ax
259d  mov    al, byte ptr [0xa3b5]             ; probe_col
25a0  xor    ah, ah
25a2  mov    dx, 0x19
25a5  mul    dx
25a7  mov    cx, ax
25a9  mov    al, byte ptr [0xa3c5]             ; cur_room
25ac  xor    ah, ah
25ae  mov    dx, 0x226
25b1  mul    dx
25b3  mov    di, ax
25b5  add    di, cx
25b7  add    di, bx
25b9  mov    al, byte ptr [di - 0x4a70]        ; +rooms
25bd  push   ax
25be  mov    di, 0x1a0c                        ; set cs:1a0c = [42,46,50,53,54,175,222]
25c1  push   cs
25c2  push   di
25c3  call   Sys_SetIn
25c8  je     0x25cf
  loc_25ca:
25ca  sub    word ptr [0xb058], 8              ; player_x
  loc_25cf:
25cf  inc    word ptr [0xb068]                 ; walk_count
25d3  cmp    word ptr [0xb068], 0x3e8          ; walk_count
25d9  jle    0x25e1
25db  mov    word ptr [0xb068], 1              ; walk_count
  loc_25e1:
25e1  mov    ax, word ptr [0xb086]             ; old_x
25e4  sub    ax, 0x10
25e7  push   ax
25e8  mov    ax, word ptr [0xb05a]             ; player_y
25eb  sub    ax, 8
25ee  push   ax
25ef  mov    al, byte ptr [0xa3c0]             ; player_sprite
25f2  xor    ah, ah
25f4  mov    dx, 0x54
25f7  mul    dx
25f9  mov    di, ax
25fb  add    di, 0x69ec
25ff  push   ds
2600  push   di
2601  mov    ax, 1
2604  push   ax
2605  call   Graph_PutImage
260a  mov    ax, word ptr [0xb068]             ; walk_count
260d  cdq
260e  mov    cx, 2
2611  idiv   cx
2613  cdq
2614  mov    cx, 4
2617  idiv   cx
2619  xchg   dx, ax
261a  cmp    ax, 0
261d  jne    0x2637
261f  mov    al, byte ptr [0xa3bf]             ; facing_left
2622  xor    ah, ah
2624  mov    dx, ax
2626  mov    al, byte ptr [0xa3be]             ; held_item
2629  xor    ah, ah
262b  shl    ax, 1
262d  add    ax, dx
262f  add    ax, 0xa
2632  mov    byte ptr [0xa3c0], al             ; player_sprite
2635  jmp    0x2682
  loc_2637:
2637  cmp    ax, 1
263a  jne    0x264f
263c  mov    al, byte ptr [0xa3bf]             ; facing_left
263f  xor    ah, ah
2641  mov    dx, ax
2643  mov    al, byte ptr [0xa3be]             ; held_item
2646  xor    ah, ah
2648  add    ax, dx
264a  mov    byte ptr [0xa3c0], al             ; player_sprite
264d  jmp    0x2682
  loc_264f:
264f  cmp    ax, 2
2652  jne    0x266c
2654  mov    al, byte ptr [0xa3bf]             ; facing_left
2657  xor    ah, ah
2659  mov    dx, ax
265b  mov    al, byte ptr [0xa3be]             ; held_item
265e  xor    ah, ah
2660  shl    ax, 1
2662  add    ax, dx
2664  add    ax, 0xc
2667  mov    byte ptr [0xa3c0], al             ; player_sprite
266a  jmp    0x2682
  loc_266c:
266c  cmp    ax, 3
266f  jne    0x2682
2671  mov    al, byte ptr [0xa3bf]             ; facing_left
2674  xor    ah, ah
2676  mov    dx, ax
2678  mov    al, byte ptr [0xa3be]             ; held_item
267b  xor    ah, ah
267d  add    ax, dx
267f  mov    byte ptr [0xa3c0], al             ; player_sprite
  loc_2682:
2682  mov    ax, word ptr [0xb058]             ; player_x
2685  sub    ax, 0x10
2688  push   ax
2689  mov    ax, word ptr [0xb05a]             ; player_y
268c  sub    ax, 8
268f  push   ax
2690  mov    al, byte ptr [0xa3c0]             ; player_sprite
2693  xor    ah, ah
2695  mov    dx, 0x54
2698  mul    dx
269a  mov    di, ax
269c  add    di, 0x69ec
26a0  push   ds
26a1  push   di
26a2  mov    ax, 1
26a5  push   ax
26a6  call   Graph_PutImage
26ab  mov    sp, bp
26ad  pop    bp
26ae  retf
26af  db 00,00,00,00,00,00,60,00,00,00,00,00,00,00,00,00
26bf  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
26cf  db 00,00,00,00,00,00,60,00,00,00,00,00,00,00,00,00
26df  db 00,00,00,00,00,80,00,00,00,00,00,00,00,00,00,00
26ef  db 00,00,00,00,00,cc,64,00,00,00,00,00,00,00,00,00
26ff  db 00,00,00,00,00,80,00,00,00,00,00,00,00,00,00,00
270f  db 00,00,00,00,00,00,64,00,00,00,00,00,00,00,00,00
271f  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
272f  db 00,00,00,00,00,cc,64,00,00,00,00,00,00,00,00,00
273f  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
274f  db 00,00,00,00,00,00,18,00,00,00,00,00,60,80,00,00
275f  db 00,00,80,01,02,80,00,00,00,06,08,40,00,00,00,18
276f  db 00,00,00,40,0e,00,00,00,00,00,00,00,10,00,00,00
277f  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00

; ------------------------------------------------------------
jump:
278f  push   bp
2790  mov    bp, sp
2792  mov    ax, word ptr [0xb058]             ; player_x
2795  sub    ax, 0xa
2798  cdq
2799  mov    cx, 0x20
279c  idiv   cx
279e  mov    byte ptr [0xa3b5], al             ; probe_col
27a1  mov    ax, word ptr [0xb05a]             ; player_y
27a4  sub    ax, 9
27a7  cdq
27a8  mov    cx, 8
27ab  idiv   cx
27ad  mov    byte ptr [0xa3b6], al             ; probe_row
27b0  mov    al, byte ptr [0xa3b6]             ; probe_row
27b3  xor    ah, ah
27b5  mov    bx, ax
27b7  mov    al, byte ptr [0xa3b5]             ; probe_col
27ba  xor    ah, ah
27bc  mov    dx, 0x19
27bf  mul    dx
27c1  mov    cx, ax
27c3  mov    al, byte ptr [0xa3c5]             ; cur_room
27c6  xor    ah, ah
27c8  mov    dx, 0x226
27cb  mul    dx
27cd  mov    di, ax
27cf  add    di, cx
27d1  add    di, bx
27d3  mov    al, byte ptr [di - 0x4a70]        ; +rooms
27d7  push   ax
27d8  mov    di, 0x26af                        ; set cs:26af = [53,54,175,222]
27db  push   cs
27dc  push   di
27dd  call   Sys_SetIn
27e2  je     0x27e7
27e4  jmp    0x2ef6
  loc_27e7:
27e7  mov    al, byte ptr [0xa3b6]             ; probe_row
27ea  xor    ah, ah
27ec  mov    bx, ax
27ee  mov    ax, word ptr [0xb058]             ; player_x
27f1  add    ax, 0xb
27f4  cdq
27f5  mov    cx, 0x20
27f8  idiv   cx
27fa  mov    dx, 0x19
27fd  mul    dx
27ff  mov    cx, ax
2801  mov    al, byte ptr [0xa3c5]             ; cur_room
2804  xor    ah, ah
2806  mov    dx, 0x226
2809  mul    dx
280b  mov    di, ax
280d  add    di, cx
280f  add    di, bx
2811  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2815  push   ax
2816  mov    di, 0x26cf                        ; set cs:26cf = [53,54,175]
2819  push   cs
281a  push   di
281b  call   Sys_SetIn
2820  je     0x2825
2822  jmp    0x2ef6
  loc_2825:
2825  mov    word ptr [0xb080], 1              ; work
282b  cmp    byte ptr [0xa3bf], 1              ; facing_left
2830  jne    0x2838
2832  mov    word ptr [0xb080], 0xffff         ; work
  loc_2838:
2838  cmp    byte ptr [0xa3c4], 1              ; standing
283d  jne    0x2844
283f  xor    ax, ax
2841  mov    word ptr [0xb080], ax             ; work
  loc_2844:
2844  mov    byte ptr [0xa3b0], 1              ; loop_i
2849  jmp    0x284f
  loc_284b:
284b  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_284f:
284f  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2854  je     0x2866
2856  call   move_dagger
285b  mov    ax, 4
285e  push   ax
285f  call   Crt_Delay
2864  jmp    0x286f
  loc_2866:
2866  mov    ax, 6
2869  push   ax
286a  call   Crt_Delay
  loc_286f:
286f  call   check_pickup
2874  call   move_mummies
2879  mov    ax, word ptr [0xb058]             ; player_x
287c  sub    ax, 0x10
287f  push   ax
2880  mov    ax, word ptr [0xb05a]             ; player_y
2883  sub    ax, 8
2886  push   ax
2887  mov    al, byte ptr [0xa3c0]             ; player_sprite
288a  xor    ah, ah
288c  mov    dx, 0x54
288f  mul    dx
2891  mov    di, ax
2893  add    di, 0x69ec
2897  push   ds
2898  push   di
2899  mov    ax, 1
289c  push   ax
289d  call   Graph_PutImage
28a2  mov    al, byte ptr [0xa3bf]             ; facing_left
28a5  xor    ah, ah
28a7  add    ax, 0x28
28aa  mov    byte ptr [0xa3c0], al             ; player_sprite
28ad  mov    al, byte ptr [0xa3b0]             ; loop_i
28b0  xor    ah, ah
28b2  shl    ax, 1
28b4  dec    ax
28b5  imul   word ptr [0xb080]                 ; work
28b9  add    ax, word ptr [0xb058]             ; player_x
28bd  add    ax, word ptr [0xb080]             ; work
28c1  mov    word ptr [0xb058], ax             ; player_x
28c4  cmp    word ptr [0xb058], -1             ; player_x
28c9  jl     0x28d3
28cb  cmp    word ptr [0xb058], 0x280          ; player_x
28d1  jle    0x28d8
  loc_28d3:
28d3  call   check_room_change
  loc_28d8:
28d8  sub    word ptr [0xb05a], 4              ; player_y
28dd  mov    ax, word ptr [0xb05a]             ; player_y
28e0  mov    cx, 0xa
28e3  imul   cx
28e5  mov    dx, ax
28e7  mov    ax, 0x1770
28ea  sub    ax, dx
28ec  push   ax
28ed  call   Crt_Sound
28f2  mov    ax, 3
28f5  push   ax
28f6  call   Crt_Delay
28fb  call   Crt_NoSound
2900  mov    ax, word ptr [0xb080]             ; work
2903  mov    cx, 0x14
2906  imul   cx
2908  add    ax, word ptr [0xb058]             ; player_x
290c  cdq
290d  mov    cx, 0x20
2910  idiv   cx
2912  mov    byte ptr [0xa3b5], al             ; probe_col
2915  mov    ax, word ptr [0xb05a]             ; player_y
2918  cdq
2919  mov    cx, 8
291c  idiv   cx
291e  mov    byte ptr [0xa3b6], al             ; probe_row
2921  mov    al, byte ptr [0xa3b6]             ; probe_row
2924  xor    ah, ah
2926  mov    bx, ax
2928  mov    al, byte ptr [0xa3b5]             ; probe_col
292b  xor    ah, ah
292d  mov    dx, 0x19
2930  mul    dx
2932  mov    cx, ax
2934  mov    al, byte ptr [0xa3c5]             ; cur_room
2937  xor    ah, ah
2939  mov    dx, 0x226
293c  mul    dx
293e  mov    di, ax
2940  add    di, cx
2942  add    di, bx
2944  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2948  push   ax
2949  mov    di, 0x26ef                        ; set cs:26ef = [42,43,46,47,50,53,54,175]
294c  push   cs
294d  push   di
294e  call   Sys_SetIn
2953  je     0x296f
2955  mov    al, byte ptr [0xa3b0]             ; loop_i
2958  xor    ah, ah
295a  shl    ax, 1
295c  dec    ax
295d  imul   word ptr [0xb080]                 ; work
2961  mov    dx, ax
2963  mov    ax, word ptr [0xb058]             ; player_x
2966  sub    ax, dx
2968  sub    ax, word ptr [0xb080]             ; work
296c  mov    word ptr [0xb058], ax             ; player_x
  loc_296f:
296f  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2974  je     0x297b
2976  call   move_dagger
  loc_297b:
297b  mov    ax, word ptr [0xb058]             ; player_x
297e  sub    ax, 0x10
2981  push   ax
2982  mov    ax, word ptr [0xb05a]             ; player_y
2985  sub    ax, 8
2988  push   ax
2989  mov    al, byte ptr [0xa3c0]             ; player_sprite
298c  xor    ah, ah
298e  mov    dx, 0x54
2991  mul    dx
2993  mov    di, ax
2995  add    di, 0x69ec
2999  push   ds
299a  push   di
299b  mov    ax, 1
299e  push   ax
299f  call   Graph_PutImage
29a4  cmp    byte ptr [0xa3b0], 4              ; loop_i
29a9  je     0x29ae
29ab  jmp    0x284b
  loc_29ae:
29ae  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
29b3  je     0x29c5
29b5  call   move_dagger
29ba  mov    ax, 4
29bd  push   ax
29be  call   Crt_Delay
29c3  jmp    0x29ce
  loc_29c5:
29c5  mov    ax, 6
29c8  push   ax
29c9  call   Crt_Delay
  loc_29ce:
29ce  mov    byte ptr [0xa3c1], 0              ; scratch
29d3  call   move_mummies
29d8  mov    ax, word ptr [0xb05a]             ; player_y
29db  sub    ax, 3
29de  cdq
29df  mov    cx, 8
29e2  idiv   cx
29e4  mov    bx, ax
29e6  mov    ax, word ptr [0xb080]             ; work
29e9  mov    cx, 0x12
29ec  imul   cx
29ee  add    ax, word ptr [0xb058]             ; player_x
29f2  mov    dx, 0x19
29f5  mul    dx
29f7  mov    cx, ax
29f9  mov    al, byte ptr [0xa3c5]             ; cur_room
29fc  xor    ah, ah
29fe  mov    dx, 0x226
2a01  mul    dx
2a03  mov    di, ax
2a05  add    di, cx
2a07  add    di, bx
2a09  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2a0d  push   ax
2a0e  mov    di, 0x26ef                        ; set cs:26ef = [42,43,46,47,50,53,54,175]
2a11  push   cs
2a12  push   di
2a13  call   Sys_SetIn
2a18  jne    0x2a94
2a1a  mov    ax, word ptr [0xb058]             ; player_x
2a1d  sub    ax, 0x10
2a20  push   ax
2a21  mov    ax, word ptr [0xb05a]             ; player_y
2a24  sub    ax, 8
2a27  push   ax
2a28  mov    al, byte ptr [0xa3c0]             ; player_sprite
2a2b  xor    ah, ah
2a2d  mov    dx, 0x54
2a30  mul    dx
2a32  mov    di, ax
2a34  add    di, 0x69ec
2a38  push   ds
2a39  push   di
2a3a  mov    ax, 1
2a3d  push   ax
2a3e  call   Graph_PutImage
2a43  mov    ax, word ptr [0xb080]             ; work
2a46  mov    cx, 3
2a49  shl    ax, cl
2a4b  add    ax, word ptr [0xb058]             ; player_x
2a4f  mov    word ptr [0xb058], ax             ; player_x
2a52  cmp    word ptr [0xb058], -1             ; player_x
2a57  jl     0x2a61
2a59  cmp    word ptr [0xb058], 0x280          ; player_x
2a5f  jle    0x2a66
  loc_2a61:
2a61  call   check_room_change
  loc_2a66:
2a66  mov    ax, word ptr [0xb058]             ; player_x
2a69  sub    ax, 0x10
2a6c  push   ax
2a6d  mov    ax, word ptr [0xb05a]             ; player_y
2a70  sub    ax, 8
2a73  push   ax
2a74  mov    al, byte ptr [0xa3c0]             ; player_sprite
2a77  xor    ah, ah
2a79  mov    dx, 0x54
2a7c  mul    dx
2a7e  mov    di, ax
2a80  add    di, 0x69ec
2a84  push   ds
2a85  push   di
2a86  mov    ax, 1
2a89  push   ax
2a8a  call   Graph_PutImage
2a8f  call   check_pickup
  loc_2a94:
2a94  mov    ax, word ptr [0xb05a]             ; player_y
2a97  sub    ax, 6
2a9a  cdq
2a9b  mov    cx, 8
2a9e  idiv   cx
2aa0  mov    bx, ax
2aa2  mov    ax, word ptr [0xb080]             ; work
2aa5  mov    cx, 4
2aa8  shl    ax, cl
2aaa  add    ax, word ptr [0xb058]             ; player_x
2aae  cdq
2aaf  mov    cx, 0x20
2ab2  idiv   cx
2ab4  mov    dx, 0x19
2ab7  mul    dx
2ab9  mov    cx, ax
2abb  mov    al, byte ptr [0xa3c5]             ; cur_room
2abe  xor    ah, ah
2ac0  mov    dx, 0x226
2ac3  mul    dx
2ac5  mov    di, ax
2ac7  add    di, cx
2ac9  add    di, bx
2acb  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2acf  push   ax
2ad0  mov    di, 0x270f                        ; set cs:270f = [50,53,54,175,222]
2ad3  push   cs
2ad4  push   di
2ad5  call   Sys_SetIn
2ada  je     0x2b24
2adc  mov    ax, word ptr [0xb05a]             ; player_y
2adf  add    ax, 0xc
2ae2  cdq
2ae3  mov    cx, 8
2ae6  idiv   cx
2ae8  mov    bx, ax
2aea  mov    ax, word ptr [0xb080]             ; work
2aed  mov    cx, 4
2af0  shl    ax, cl
2af2  add    ax, word ptr [0xb058]             ; player_x
2af6  cdq
2af7  mov    cx, 0x20
2afa  idiv   cx
2afc  mov    dx, 0x19
2aff  mul    dx
2b01  mov    cx, ax
2b03  mov    al, byte ptr [0xa3c5]             ; cur_room
2b06  xor    ah, ah
2b08  mov    dx, 0x226
2b0b  mul    dx
2b0d  mov    di, ax
2b0f  add    di, cx
2b11  add    di, bx
2b13  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2b17  push   ax
2b18  mov    di, 0x270f                        ; set cs:270f = [50,53,54,175,222]
2b1b  push   cs
2b1c  push   di
2b1d  call   Sys_SetIn
2b22  jne    0x2b6c
  loc_2b24:
2b24  mov    ax, word ptr [0xb05a]             ; player_y
2b27  add    ax, 6
2b2a  cdq
2b2b  mov    cx, 8
2b2e  idiv   cx
2b30  mov    bx, ax
2b32  mov    ax, word ptr [0xb080]             ; work
2b35  mov    cx, 4
2b38  shl    ax, cl
2b3a  add    ax, word ptr [0xb058]             ; player_x
2b3e  cdq
2b3f  mov    cx, 0x20
2b42  idiv   cx
2b44  mov    dx, 0x19
2b47  mul    dx
2b49  mov    cx, ax
2b4b  mov    al, byte ptr [0xa3c5]             ; cur_room
2b4e  xor    ah, ah
2b50  mov    dx, 0x226
2b53  mul    dx
2b55  mov    di, ax
2b57  add    di, cx
2b59  add    di, bx
2b5b  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2b5f  push   ax
2b60  mov    di, 0x270f                        ; set cs:270f = [50,53,54,175,222]
2b63  push   cs
2b64  push   di
2b65  call   Sys_SetIn
2b6a  je     0x2bd7
  loc_2b6c:
2b6c  mov    ax, word ptr [0xb058]             ; player_x
2b6f  sub    ax, 0x10
2b72  push   ax
2b73  mov    ax, word ptr [0xb05a]             ; player_y
2b76  sub    ax, 8
2b79  push   ax
2b7a  mov    al, byte ptr [0xa3c0]             ; player_sprite
2b7d  xor    ah, ah
2b7f  mov    dx, 0x54
2b82  mul    dx
2b84  mov    di, ax
2b86  add    di, 0x69ec
2b8a  push   ds
2b8b  push   di
2b8c  mov    ax, 1
2b8f  push   ax
2b90  call   Graph_PutImage
2b95  inc    byte ptr [0xa3b2]                 ; loop_k
2b99  mov    ax, word ptr [0xb080]             ; work
2b9c  mov    cx, 0xe
2b9f  imul   cx
2ba1  sub    word ptr [0xb058], ax             ; player_x
2ba5  mov    byte ptr [0xa3c1], 1              ; scratch
2baa  mov    ax, word ptr [0xb058]             ; player_x
2bad  sub    ax, 0x10
2bb0  push   ax
2bb1  mov    ax, word ptr [0xb05a]             ; player_y
2bb4  sub    ax, 8
2bb7  push   ax
2bb8  mov    al, byte ptr [0xa3c0]             ; player_sprite
2bbb  xor    ah, ah
2bbd  mov    dx, 0x54
2bc0  mul    dx
2bc2  mov    di, ax
2bc4  add    di, 0x69ec
2bc8  push   ds
2bc9  push   di
2bca  mov    ax, 1
2bcd  push   ax
2bce  call   Graph_PutImage
2bd3  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_2bd7:
2bd7  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2bdc  je     0x2bee
2bde  call   move_dagger
2be3  mov    ax, 4
2be6  push   ax
2be7  call   Crt_Delay
2bec  jmp    0x2bf7
  loc_2bee:
2bee  mov    ax, 6
2bf1  push   ax
2bf2  call   Crt_Delay
  loc_2bf7:
2bf7  call   check_pickup
2bfc  call   move_mummies
2c01  mov    ax, word ptr [0xb058]             ; player_x
2c04  sub    ax, 0x10
2c07  push   ax
2c08  mov    ax, word ptr [0xb05a]             ; player_y
2c0b  sub    ax, 8
2c0e  push   ax
2c0f  mov    al, byte ptr [0xa3c0]             ; player_sprite
2c12  xor    ah, ah
2c14  mov    dx, 0x54
2c17  mul    dx
2c19  mov    di, ax
2c1b  add    di, 0x69ec
2c1f  push   ds
2c20  push   di
2c21  mov    ax, 1
2c24  push   ax
2c25  call   Graph_PutImage
2c2a  inc    byte ptr [0xa3b2]                 ; loop_k
2c2e  mov    al, byte ptr [0xa3bf]             ; facing_left
2c31  xor    ah, ah
2c33  add    ax, 0x28
2c36  mov    byte ptr [0xa3c0], al             ; player_sprite
2c39  cmp    byte ptr [0xa3c1], 0              ; scratch
2c3e  jne    0x2c53
2c40  mov    al, byte ptr [0xa3b0]             ; loop_i
2c43  xor    ah, ah
2c45  shl    ax, 1
2c47  dec    ax
2c48  imul   word ptr [0xb080]                 ; work
2c4c  add    ax, word ptr [0xb058]             ; player_x
2c50  mov    word ptr [0xb058], ax             ; player_x
  loc_2c53:
2c53  cmp    word ptr [0xb058], -1             ; player_x
2c58  jl     0x2c62
2c5a  cmp    word ptr [0xb058], 0x280          ; player_x
2c60  jle    0x2c67
  loc_2c62:
2c62  call   check_room_change
  loc_2c67:
2c67  add    word ptr [0xb05a], 4              ; player_y
2c6c  cmp    word ptr [0xb05a], 0xb7           ; player_y
2c72  jle    0x2c79
2c74  call   check_room_change
  loc_2c79:
2c79  mov    ax, word ptr [0xb05a]             ; player_y
2c7c  mov    cx, 0xa
2c7f  imul   cx
2c81  mov    dx, ax
2c83  mov    ax, 0x1770
2c86  sub    ax, dx
2c88  push   ax
2c89  call   Crt_Sound
2c8e  mov    ax, 3
2c91  push   ax
2c92  call   Crt_Delay
2c97  call   Crt_NoSound
2c9c  mov    ax, word ptr [0xb080]             ; work
2c9f  mov    cx, 0xa
2ca2  imul   cx
2ca4  add    ax, word ptr [0xb058]             ; player_x
2ca8  cdq
2ca9  mov    cx, 0x20
2cac  idiv   cx
2cae  mov    byte ptr [0xa3b5], al             ; probe_col
2cb1  mov    ax, word ptr [0xb05a]             ; player_y
2cb4  sub    ax, 4
2cb7  cdq
2cb8  mov    cx, 8
2cbb  idiv   cx
2cbd  mov    byte ptr [0xa3b6], al             ; probe_row
2cc0  mov    al, byte ptr [0xa3b6]             ; probe_row
2cc3  xor    ah, ah
2cc5  mov    bx, ax
2cc7  mov    al, byte ptr [0xa3b5]             ; probe_col
2cca  xor    ah, ah
2ccc  mov    dx, 0x19
2ccf  mul    dx
2cd1  mov    cx, ax
2cd3  mov    al, byte ptr [0xa3c5]             ; cur_room
2cd6  xor    ah, ah
2cd8  mov    dx, 0x226
2cdb  mul    dx
2cdd  mov    di, ax
2cdf  add    di, cx
2ce1  add    di, bx
2ce3  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2ce7  push   ax
2ce8  mov    di, 0x272f                        ; set cs:272f = [42,43,46,47,50,53,54,175,222]
2ceb  push   cs
2cec  push   di
2ced  call   Sys_SetIn
2cf2  jne    0x2d2f
2cf4  mov    ax, word ptr [0xb05a]             ; player_y
2cf7  add    ax, 7
2cfa  cdq
2cfb  mov    cx, 8
2cfe  idiv   cx
2d00  mov    bx, ax
2d02  mov    al, byte ptr [0xa3b5]             ; probe_col
2d05  xor    ah, ah
2d07  mov    dx, 0x19
2d0a  mul    dx
2d0c  mov    cx, ax
2d0e  mov    al, byte ptr [0xa3c5]             ; cur_room
2d11  xor    ah, ah
2d13  mov    dx, 0x226
2d16  mul    dx
2d18  mov    di, ax
2d1a  add    di, cx
2d1c  add    di, bx
2d1e  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2d22  push   ax
2d23  mov    di, 0x272f                        ; set cs:272f = [42,43,46,47,50,53,54,175,222]
2d26  push   cs
2d27  push   di
2d28  call   Sys_SetIn
2d2d  je     0x2d50
  loc_2d2f:
2d2f  cmp    byte ptr [0xa3c1], 0              ; scratch
2d34  jne    0x2d46
2d36  mov    al, byte ptr [0xa3b0]             ; loop_i
2d39  xor    ah, ah
2d3b  shl    ax, 1
2d3d  dec    ax
2d3e  imul   word ptr [0xb080]                 ; work
2d42  sub    word ptr [0xb058], ax             ; player_x
  loc_2d46:
2d46  mov    byte ptr [0xa3c1], 1              ; scratch
2d4b  mov    byte ptr [0xa3c4], 1              ; standing
  loc_2d50:
2d50  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2d55  je     0x2d5c
2d57  call   move_dagger
  loc_2d5c:
2d5c  mov    ax, word ptr [0xb058]             ; player_x
2d5f  sub    ax, 0x10
2d62  push   ax
2d63  mov    ax, word ptr [0xb05a]             ; player_y
2d66  sub    ax, 8
2d69  push   ax
2d6a  mov    al, byte ptr [0xa3c0]             ; player_sprite
2d6d  xor    ah, ah
2d6f  mov    dx, 0x54
2d72  mul    dx
2d74  mov    di, ax
2d76  add    di, 0x69ec
2d7a  push   ds
2d7b  push   di
2d7c  mov    ax, 1
2d7f  push   ax
2d80  call   Graph_PutImage
2d85  mov    ax, word ptr [0xb05a]             ; player_y
2d88  add    ax, 7
2d8b  cdq
2d8c  mov    cx, 8
2d8f  idiv   cx
2d91  mov    bx, ax
2d93  mov    ax, word ptr [0xb058]             ; player_x
2d96  sub    ax, 8
2d99  cdq
2d9a  mov    cx, 0x20
2d9d  idiv   cx
2d9f  mov    dx, 0x19
2da2  mul    dx
2da4  mov    cx, ax
2da6  mov    al, byte ptr [0xa3c5]             ; cur_room
2da9  xor    ah, ah
2dab  mov    dx, 0x226
2dae  mul    dx
2db0  mov    di, ax
2db2  add    di, cx
2db4  add    di, bx
2db6  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2dba  push   ax
2dbb  mov    di, 0x270f                        ; set cs:270f = [50,53,54,175,222]
2dbe  push   cs
2dbf  push   di
2dc0  call   Sys_SetIn
2dc5  je     0x2dca
2dc7  jmp    0x2e93
  loc_2dca:
2dca  mov    ax, word ptr [0xb05a]             ; player_y
2dcd  add    ax, 7
2dd0  cdq
2dd1  mov    cx, 8
2dd4  idiv   cx
2dd6  mov    bx, ax
2dd8  mov    ax, word ptr [0xb058]             ; player_x
2ddb  add    ax, 8
2dde  cdq
2ddf  mov    cx, 0x20
2de2  idiv   cx
2de4  mov    dx, 0x19
2de7  mul    dx
2de9  mov    cx, ax
2deb  mov    al, byte ptr [0xa3c5]             ; cur_room
2dee  xor    ah, ah
2df0  mov    dx, 0x226
2df3  mul    dx
2df5  mov    di, ax
2df7  add    di, cx
2df9  add    di, bx
2dfb  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2dff  push   ax
2e00  mov    di, 0x270f                        ; set cs:270f = [50,53,54,175,222]
2e03  push   cs
2e04  push   di
2e05  call   Sys_SetIn
2e0a  je     0x2e0f
2e0c  jmp    0x2e93
  loc_2e0f:
2e0f  mov    ax, word ptr [0xb05a]             ; player_y
2e12  add    ax, 8
2e15  cdq
2e16  mov    cx, 8
2e19  idiv   cx
2e1b  mov    bx, ax
2e1d  mov    ax, word ptr [0xb058]             ; player_x
2e20  cdq
2e21  mov    cx, 0x20
2e24  idiv   cx
2e26  mov    dx, 0x19
2e29  mul    dx
2e2b  mov    cx, ax
2e2d  mov    al, byte ptr [0xa3c5]             ; cur_room
2e30  xor    ah, ah
2e32  mov    dx, 0x226
2e35  mul    dx
2e37  mov    di, ax
2e39  add    di, cx
2e3b  add    di, bx
2e3d  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2e41  push   ax
2e42  mov    di, 0x274f                        ; set cs:274f = [51,52,101,102,111,151,152,161,175,201,202,211,222,251,252]
2e45  push   cs
2e46  push   di
2e47  call   Sys_SetIn
2e4c  jne    0x2e51
2e4e  jmp    0x2bd7
  loc_2e51:
2e51  mov    ax, word ptr [0xb05a]             ; player_y
2e54  add    ax, 6
2e57  cdq
2e58  mov    cx, 8
2e5b  idiv   cx
2e5d  mov    bx, ax
2e5f  mov    ax, word ptr [0xb058]             ; player_x
2e62  cdq
2e63  mov    cx, 0x20
2e66  idiv   cx
2e68  mov    dx, 0x19
2e6b  mul    dx
2e6d  mov    cx, ax
2e6f  mov    al, byte ptr [0xa3c5]             ; cur_room
2e72  xor    ah, ah
2e74  mov    dx, 0x226
2e77  mul    dx
2e79  mov    di, ax
2e7b  add    di, cx
2e7d  add    di, bx
2e7f  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2e83  push   ax
2e84  mov    di, 0x276f                        ; set cs:276f = [30,33,34,35,100]
2e87  push   cs
2e88  push   di
2e89  call   Sys_SetIn
2e8e  jne    0x2e93
2e90  jmp    0x2bd7
  loc_2e93:
2e93  mov    ax, word ptr [0xb058]             ; player_x
2e96  sub    ax, 0x10
2e99  push   ax
2e9a  mov    ax, word ptr [0xb05a]             ; player_y
2e9d  sub    ax, 8
2ea0  push   ax
2ea1  mov    al, byte ptr [0xa3c0]             ; player_sprite
2ea4  xor    ah, ah
2ea6  mov    dx, 0x54
2ea9  mul    dx
2eab  mov    di, ax
2ead  add    di, 0x69ec
2eb1  push   ds
2eb2  push   di
2eb3  mov    ax, 1
2eb6  push   ax
2eb7  call   Graph_PutImage
2ebc  mov    ax, word ptr [0xb05a]             ; player_y
2ebf  cdq
2ec0  mov    cx, 8
2ec3  idiv   cx
2ec5  mov    cx, 3
2ec8  shl    ax, cl
2eca  mov    word ptr [0xb05a], ax             ; player_y
2ecd  mov    ax, word ptr [0xb058]             ; player_x
2ed0  sub    ax, 0x10
2ed3  push   ax
2ed4  mov    ax, word ptr [0xb05a]             ; player_y
2ed7  sub    ax, 8
2eda  push   ax
2edb  mov    al, byte ptr [0xa3c0]             ; player_sprite
2ede  xor    ah, ah
2ee0  mov    dx, 0x54
2ee3  mul    dx
2ee5  mov    di, ax
2ee7  add    di, 0x69ec
2eeb  push   ds
2eec  push   di
2eed  mov    ax, 1
2ef0  push   ax
2ef1  call   Graph_PutImage
  loc_2ef6:
2ef6  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2efb  je     0x2f02
2efd  call   move_dagger
  loc_2f02:
2f02  mov    ax, word ptr [0xb058]             ; player_x
2f05  sub    ax, 0x10
2f08  push   ax
2f09  mov    ax, word ptr [0xb05a]             ; player_y
2f0c  sub    ax, 8
2f0f  push   ax
2f10  mov    al, byte ptr [0xa3c0]             ; player_sprite
2f13  xor    ah, ah
2f15  mov    dx, 0x54
2f18  mul    dx
2f1a  mov    di, ax
2f1c  add    di, 0x69ec
2f20  push   ds
2f21  push   di
2f22  mov    ax, 1
2f25  push   ax
2f26  call   Graph_PutImage
2f2b  mov    al, byte ptr [0xa3bf]             ; facing_left
2f2e  xor    ah, ah
2f30  mov    dx, ax
2f32  mov    al, byte ptr [0xa3be]             ; held_item
2f35  xor    ah, ah
2f37  add    ax, dx
2f39  mov    byte ptr [0xa3c0], al             ; player_sprite
2f3c  mov    ax, word ptr [0xb058]             ; player_x
2f3f  sub    ax, 0x10
2f42  push   ax
2f43  mov    ax, word ptr [0xb05a]             ; player_y
2f46  sub    ax, 8
2f49  push   ax
2f4a  mov    al, byte ptr [0xa3c0]             ; player_sprite
2f4d  xor    ah, ah
2f4f  mov    dx, 0x54
2f52  mul    dx
2f54  mov    di, ax
2f56  add    di, 0x69ec
2f5a  push   ds
2f5b  push   di
2f5c  mov    ax, 1
2f5f  push   ax
2f60  call   Graph_PutImage
2f65  call   Crt_KeyPressed
2f6a  or     al, al
2f6c  je     0x2f76
2f6e  call   Crt_ReadKey
2f73  mov    byte ptr [0xb08e], al             ; last_key
  loc_2f76:
2f76  mov    sp, bp
2f78  pop    bp
2f79  retf

; ------------------------------------------------------------
player_die:
2f7a  push   bp
2f7b  mov    bp, sp
2f7d  sub    sp, 6
2f80  mov    al, 9
2f82  push   ax
2f83  push   word ptr [0xb042]
2f87  push   word ptr [0xb040]                 ; saved_int9
2f8b  call   Dos_SetIntVec
2f90  mov    al, 8
2f92  push   ax
2f93  push   word ptr [0xb03e]
2f97  push   word ptr [0xb03c]                 ; saved_int8
2f9b  call   Dos_SetIntVec
2fa0  mov    word ptr [bp - 2], 1
2fa5  jmp    0x2faa
  loc_2fa7:
2fa7  inc    word ptr [bp - 2]
  loc_2faa:
2faa  xor    ax, ax
2fac  mov    word ptr [bp - 4], ax
2faf  jmp    0x2fb4
  loc_2fb1:
2fb1  inc    word ptr [bp - 4]
  loc_2fb4:
2fb4  mov    ax, 7
2fb7  sub    ax, word ptr [bp - 4]
2fba  mov    dx, ax
2fbc  mov    di, word ptr [bp - 2]
2fbf  mov    al, byte ptr [di + 0x2425]        ; +pcm_die
2fc3  xor    ah, ah
2fc5  mov    cx, dx
2fc7  shr    ax, cl
2fc9  shl    ax, 1
2fcb  and    ax, 2
2fce  mov    dx, ax
2fd0  in     al, 0x61
2fd2  and    al, 0xfc
2fd4  xor    ah, ah
2fd6  or     ax, dx
2fd8  out    0x61, al
2fda  mov    al, byte ptr [0x2966]             ; machine_speed
2fdd  mov    byte ptr [bp - 5], al
2fe0  mov    al, 1
2fe2  cmp    al, byte ptr [bp - 5]
2fe5  ja     0x2ff8
2fe7  mov    byte ptr [0xa3b0], al             ; loop_i
2fea  jmp    0x2ff0
  loc_2fec:
2fec  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_2ff0:
2ff0  mov    al, byte ptr [0xa3b0]             ; loop_i
2ff3  cmp    al, byte ptr [bp - 5]
2ff6  jne    0x2fec
  loc_2ff8:
2ff8  cmp    word ptr [bp - 4], 7
2ffc  jne    0x2fb1
2ffe  cmp    word ptr [bp - 2], 0x130
3003  jne    0x2fa7
3005  mov    ax, 0xc8
3008  push   ax
3009  call   Crt_Delay
300e  mov    ax, word ptr [0xb058]             ; player_x
3011  sub    ax, 0x10
3014  push   ax
3015  mov    ax, word ptr [0xb05a]             ; player_y
3018  sub    ax, 8
301b  push   ax
301c  mov    al, byte ptr [0xa3c0]             ; player_sprite
301f  xor    ah, ah
3021  mov    dx, 0x54
3024  mul    dx
3026  mov    di, ax
3028  add    di, 0x69ec
302c  push   ds
302d  push   di
302e  mov    ax, 1
3031  push   ax
3032  call   Graph_PutImage
3037  mov    ax, word ptr [0xb058]             ; player_x
303a  sub    ax, 0x10
303d  push   ax
303e  mov    ax, word ptr [0xb05a]             ; player_y
3041  sub    ax, 8
3044  push   ax
3045  mov    di, 0x7760
3048  push   ds
3049  push   di
304a  mov    ax, 1
304d  push   ax
304e  call   Graph_PutImage
3053  mov    word ptr [bp - 2], 1
3058  jmp    0x305d
  loc_305a:
305a  inc    word ptr [bp - 2]
  loc_305d:
305d  mov    word ptr [bp - 4], 1
3062  jmp    0x3067
  loc_3064:
3064  inc    word ptr [bp - 4]
  loc_3067:
3067  mov    ax, word ptr [bp - 4]
306a  mov    cx, 0x28
306d  imul   cx
306f  add    ax, 0x64
3072  push   ax
3073  call   Crt_Sound
3078  mov    ax, 2
307b  push   ax
307c  call   Crt_Delay
3081  call   move_mummies
3086  cmp    word ptr [bp - 4], 5
308a  jne    0x3064
308c  call   Crt_NoSound
3091  mov    ax, word ptr [0xb058]             ; player_x
3094  sub    ax, 0x10
3097  push   ax
3098  mov    ax, word ptr [0xb05a]             ; player_y
309b  sub    ax, 8
309e  push   ax
309f  mov    ax, word ptr [bp - 2]
30a2  cdq
30a3  mov    cx, 2
30a6  idiv   cx
30a8  xchg   dx, ax
30a9  add    ax, 0x28
30ac  mov    dx, 0x54
30af  mul    dx
30b1  mov    di, ax
30b3  add    di, 0x69ec
30b7  push   ds
30b8  push   di
30b9  mov    ax, 1
30bc  push   ax
30bd  call   Graph_PutImage
30c2  mov    ax, word ptr [0xb058]             ; player_x
30c5  sub    ax, 0x10
30c8  push   ax
30c9  mov    ax, word ptr [0xb05a]             ; player_y
30cc  sub    ax, 8
30cf  push   ax
30d0  mov    ax, word ptr [bp - 2]
30d3  inc    ax
30d4  cdq
30d5  mov    cx, 2
30d8  idiv   cx
30da  xchg   dx, ax
30db  add    ax, 0x28
30de  mov    dx, 0x54
30e1  mul    dx
30e3  mov    di, ax
30e5  add    di, 0x69ec
30e9  push   ds
30ea  push   di
30eb  mov    ax, 1
30ee  push   ax
30ef  call   Graph_PutImage
30f4  cmp    word ptr [bp - 2], 0xa
30f8  je     0x30fd
30fa  jmp    0x305a
  loc_30fd:
30fd  mov    ax, word ptr [0xb058]             ; player_x
3100  sub    ax, 0x10
3103  push   ax
3104  mov    ax, word ptr [0xb05a]             ; player_y
3107  sub    ax, 8
310a  push   ax
310b  mov    di, 0x7760
310e  push   ds
310f  push   di
3110  mov    ax, 1
3113  push   ax
3114  call   Graph_PutImage
3119  mov    ax, word ptr [0xb058]             ; player_x
311c  sub    ax, 0x10
311f  push   ax
3120  mov    ax, word ptr [0xb05a]             ; player_y
3123  sub    ax, 8
3126  push   ax
3127  mov    di, 0x75bc
312a  push   ds
312b  push   di
312c  mov    ax, 1
312f  push   ax
3130  call   Graph_PutImage
3135  mov    byte ptr [0xa3b0], 0x64           ; loop_i
313a  jmp    0x3140
  loc_313c:
313c  dec    byte ptr [0xa3b0]                 ; loop_i
  loc_3140:
3140  mov    al, byte ptr [0xa3b0]             ; loop_i
3143  xor    ah, ah
3145  push   ax
3146  call   Crt_Sound
314b  mov    ax, 0xa
314e  push   ax
314f  call   Crt_Delay
3154  cmp    byte ptr [0xa3b0], 0xa            ; loop_i
3159  jne    0x313c
315b  call   Crt_NoSound
3160  xor    ax, ax
3162  push   ax
3163  call   Graph_SetColor
3168  mov    byte ptr [0xa3b0], 1              ; loop_i
316d  jmp    0x3173
  loc_316f:
316f  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3173:
3173  mov    al, byte ptr [0xa3b0]             ; loop_i
3176  xor    ah, ah
3178  mov    di, ax
317a  mov    byte ptr [di + 0x7aab], 0
317f  cmp    byte ptr [0xa3b0], 0x20           ; loop_i
3184  jne    0x316f
3186  mov    byte ptr [0xa3b0], 0              ; loop_i
318b  jmp    0x3191
  loc_318d:
318d  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3191:
3191  mov    al, byte ptr [0xa3b0]             ; loop_i
3194  xor    ah, ah
3196  mov    dx, ax
3198  mov    ax, 0x13
319b  sub    ax, dx
319d  mov    byte ptr [bp - 5], al
31a0  mov    al, byte ptr [0xa3b0]             ; loop_i
31a3  cmp    al, byte ptr [bp - 5]
31a6  ja     0x31dc
31a8  mov    byte ptr [0xa3b1], al             ; loop_j
31ab  jmp    0x31b1
  loc_31ad:
31ad  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_31b1:
31b1  mov    al, byte ptr [0xa3b1]             ; loop_j
31b4  xor    ah, ah
31b6  mov    cx, 5
31b9  shl    ax, cl
31bb  push   ax
31bc  mov    al, byte ptr [0xa3b0]             ; loop_i
31bf  xor    ah, ah
31c1  mov    cx, 3
31c4  shl    ax, cl
31c6  push   ax
31c7  mov    di, 0x7aa8
31ca  push   ds
31cb  push   di
31cc  xor    ax, ax
31ce  push   ax
31cf  call   Graph_PutImage
31d4  mov    al, byte ptr [0xa3b1]             ; loop_j
31d7  cmp    al, byte ptr [bp - 5]
31da  jne    0x31ad
  loc_31dc:
31dc  mov    al, byte ptr [0xa3b0]             ; loop_i
31df  xor    ah, ah
31e1  mov    dx, ax
31e3  mov    ax, 0x17
31e6  sub    ax, dx
31e8  mov    byte ptr [bp - 5], al
31eb  mov    al, byte ptr [0xa3b0]             ; loop_i
31ee  xor    ah, ah
31f0  inc    ax
31f1  cmp    al, byte ptr [bp - 5]
31f4  ja     0x3231
31f6  mov    byte ptr [0xa3b1], al             ; loop_j
31f9  jmp    0x31ff
  loc_31fb:
31fb  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_31ff:
31ff  mov    al, byte ptr [0xa3b0]             ; loop_i
3202  xor    ah, ah
3204  mov    dx, ax
3206  mov    ax, 0x13
3209  sub    ax, dx
320b  mov    cx, 5
320e  shl    ax, cl
3210  push   ax
3211  mov    al, byte ptr [0xa3b1]             ; loop_j
3214  xor    ah, ah
3216  mov    cx, 3
3219  shl    ax, cl
321b  push   ax
321c  mov    di, 0x7aa8
321f  push   ds
3220  push   di
3221  xor    ax, ax
3223  push   ax
3224  call   Graph_PutImage
3229  mov    al, byte ptr [0xa3b1]             ; loop_j
322c  cmp    al, byte ptr [bp - 5]
322f  jne    0x31fb
  loc_3231:
3231  mov    al, byte ptr [0xa3b0]             ; loop_i
3234  mov    byte ptr [bp - 5], al
3237  mov    al, byte ptr [0xa3b0]             ; loop_i
323a  xor    ah, ah
323c  mov    dx, ax
323e  mov    ax, 0x12
3241  sub    ax, dx
3243  cmp    al, byte ptr [bp - 5]
3246  jb     0x3283
3248  mov    byte ptr [0xa3b1], al             ; loop_j
324b  jmp    0x3251
  loc_324d:
324d  dec    byte ptr [0xa3b1]                 ; loop_j
  loc_3251:
3251  mov    al, byte ptr [0xa3b1]             ; loop_j
3254  xor    ah, ah
3256  mov    cx, 5
3259  shl    ax, cl
325b  push   ax
325c  mov    al, byte ptr [0xa3b0]             ; loop_i
325f  xor    ah, ah
3261  mov    dx, ax
3263  mov    ax, 0x17
3266  sub    ax, dx
3268  mov    cx, 3
326b  shl    ax, cl
326d  push   ax
326e  mov    di, 0x7aa8
3271  push   ds
3272  push   di
3273  xor    ax, ax
3275  push   ax
3276  call   Graph_PutImage
327b  mov    al, byte ptr [0xa3b1]             ; loop_j
327e  cmp    al, byte ptr [bp - 5]
3281  jne    0x324d
  loc_3283:
3283  mov    al, byte ptr [0xa3b0]             ; loop_i
3286  xor    ah, ah
3288  inc    ax
3289  mov    byte ptr [bp - 5], al
328c  mov    al, byte ptr [0xa3b0]             ; loop_i
328f  xor    ah, ah
3291  mov    dx, ax
3293  mov    ax, 0x16
3296  sub    ax, dx
3298  cmp    al, byte ptr [bp - 5]
329b  jb     0x32d1
329d  mov    byte ptr [0xa3b1], al             ; loop_j
32a0  jmp    0x32a6
  loc_32a2:
32a2  dec    byte ptr [0xa3b1]                 ; loop_j
  loc_32a6:
32a6  mov    al, byte ptr [0xa3b0]             ; loop_i
32a9  xor    ah, ah
32ab  mov    cx, 5
32ae  shl    ax, cl
32b0  push   ax
32b1  mov    al, byte ptr [0xa3b1]             ; loop_j
32b4  xor    ah, ah
32b6  mov    cx, 3
32b9  shl    ax, cl
32bb  push   ax
32bc  mov    di, 0x7aa8
32bf  push   ds
32c0  push   di
32c1  xor    ax, ax
32c3  push   ax
32c4  call   Graph_PutImage
32c9  mov    al, byte ptr [0xa3b1]             ; loop_j
32cc  cmp    al, byte ptr [bp - 5]
32cf  jne    0x32a2
  loc_32d1:
32d1  cmp    byte ptr [0xa3b0], 0xb            ; loop_i
32d6  je     0x32db
32d8  jmp    0x318d
  loc_32db:
32db  mov    al, 9
32dd  push   ax
32de  mov    di, 0xb040                        ; &saved_int9
32e1  push   ds
32e2  push   di
32e3  call   Dos_GetIntVec
32e8  mov    al, 9
32ea  push   ax
32eb  mov    ax, 0x16
32ee  mov    dx, 0x8e2                         ; seg GAMELIB
32f1  push   dx
32f2  push   ax
32f3  call   Dos_SetIntVec
32f8  call   Crt_KeyPressed
32fd  or     al, al
32ff  je     0x3309
3301  call   Crt_ReadKey
3306  mov    byte ptr [0xb08e], al             ; last_key
  loc_3309:
3309  mov    byte ptr [0xa3b7], 0x32           ; scan_code
330e  mov    sp, bp
3310  pop    bp
3311  retf
3312  db 11,'kings-v.ifm'
331e  db 34,'!! Cannot find "kings-v.ifm" file.'
3341  db 0e,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00
3351  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
3361  db 43,'!! You must have CGA or EGA or VGA or MCGA.'
338d  db 11,'kings-v.dat'
3399  db 5,'staff'
339f  db 30,'art design and main programmer'
33be  db 13,'Oh Jeon Seok '
33cc  db 19,'technical assistant'
33e0  db 15,'Kim Hea Jin    '
33f0  db 13,'game designer'
33fe  db 13,'Kyeong yeol  '
340c  db 13,'1  game start'
341a  db 13,'2  stage edit'
3428  db 13,'3  stage load'
3436  db 14,'4  exit to dos'
3445  db 5,'stage'
344b  db 00,00,00,00,00,00,ff,03,00,00,00,00,00,00,00,00
345b  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
346b  db fe,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00
347b  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
348b  db 00,00,00,00,00,00,0a,00,00,00,00,00,00,00,00,00
349b  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00

; ------------------------------------------------------------
title_and_menu:
34ab  push   bp
34ac  mov    bp, sp
34ae  sub    sp, 0x116
34b2  mov    byte ptr [0xcdfe], 0
34b7  mov    di, 0xcb1a
34ba  push   ds
34bb  push   di
34bc  mov    di, 0x3312                        ; cs:'kings-v.ifm'
34bf  push   cs
34c0  push   di
34c1  call   Sys_Assign
34c6  mov    di, 0xcb1a
34c9  push   ds
34ca  push   di
34cb  mov    ax, 1
34ce  push   ax
34cf  call   Sys_ResetFile
34d4  call   Sys_IOResult
34d9  or     ax, ax
34db  jle    0x34fb
34dd  mov    di, 0xcf12
34e0  push   ds
34e1  push   di
34e2  mov    di, 0x331e                        ; cs:'!! Cannot find "kings-v.ifm" file.'
34e5  push   cs
34e6  push   di
34e7  xor    ax, ax
34e9  push   ax
34ea  call   Sys_WriteStr
34ef  call   Sys_WriteLn
34f4  xor    ax, ax
34f6  call   Sys_Halt
  loc_34fb:
34fb  mov    di, 0xcb1a
34fe  push   ds
34ff  push   di
3500  mov    di, 0x2968
3503  push   ds
3504  push   di
3505  mov    ax, 0x4000
3508  push   ax
3509  xor    ax, ax
350b  push   ax
350c  push   ax
350d  call   Sys_BlockRead
3512  mov    di, 0xcb1a
3515  push   ds
3516  push   di
3517  call   Sys_Close
351c  mov    di, 0xb07a
351f  push   ds
3520  push   di
3521  mov    di, 0xb07c
3524  push   ds
3525  push   di
3526  call   Graph_DetectGraph
352b  mov    al, byte ptr [0xb07a]
352e  push   ax
352f  mov    di, 0x3341                        ; set cs:3341 = [1,2,3,9]
3532  push   cs
3533  push   di
3534  call   Sys_SetIn
3539  jne    0x3559
353b  mov    di, 0xcf12
353e  push   ds
353f  push   di
3540  mov    di, 0x3361                        ; cs:'!! You must have CGA or EGA or VGA or MCGA.'
3543  push   cs
3544  push   di
3545  xor    ax, ax
3547  push   ax
3548  call   Sys_WriteStr
354d  call   Sys_WriteLn
3552  xor    ax, ax
3554  call   Sys_Halt
  loc_3559:
3559  mov    di, 0xcb9a
355c  push   ds
355d  push   di
355e  mov    di, 0x338d                        ; cs:'kings-v.dat'
3561  push   cs
3562  push   di
3563  call   Sys_Assign
3568  mov    di, 0xcb9a
356b  push   ds
356c  push   di
356d  mov    ax, 0x226
3570  push   ax
3571  call   Sys_ResetFile
3576  mov    di, 0xcb9a
3579  push   ds
357a  push   di
357b  mov    di, 0xb590                        ; &rooms
357e  push   ds
357f  push   di
3580  call   Sys_ReadRec
3585  add    sp, 4
3588  mov    di, 0xcb9a
358b  push   ds
358c  push   di
358d  call   Sys_Close
3592  mov    word ptr [0xb07a], 1
3598  mov    di, 0xb07a
359b  push   ds
359c  push   di
359d  mov    di, 0xb07c
35a0  push   ds
35a1  push   di
35a2  mov    di, 0x3343
35a5  push   cs
35a6  push   di
35a7  call   Graph_InitGraph
35ac  mov    di, 0x2968
35af  push   ds
35b0  push   di
35b1  mov    ax, 0xb800
35b4  push   ax
35b5  xor    di, di
35b7  pop    es
35b8  push   es
35b9  push   di
35ba  mov    ax, 0x4000
35bd  push   ax
35be  call   Sys_Move
35c3  mov    ax, 0xbb8
35c6  push   ax
35c7  call   Crt_Delay
35cc  mov    byte ptr [0xa3c1], 1              ; scratch
35d1  jmp    0x35d7
  loc_35d3:
35d3  inc    byte ptr [0xa3c1]                 ; scratch
  loc_35d7:
35d7  mov    byte ptr [bp - 0x13], 6
35db  mov    byte ptr [bp - 0x14], 1
35df  mov    byte ptr [bp - 0x11], 0
35e3  mov    byte ptr [bp - 0xf], 0
35e7  mov    byte ptr [bp - 0x10], 0
35eb  mov    byte ptr [bp - 0xd], 0x18
35ef  mov    byte ptr [bp - 0xe], 0x4f
35f3  mov    al, 0x10
35f5  push   ax
35f6  lea    di, [bp - 0x14]
35f9  push   ss
35fa  push   di
35fb  call   Dos_Intr
3600  mov    al, byte ptr [0xa3c1]             ; scratch
3603  xor    ah, ah
3605  cmp    ax, 6
3608  jne    0x361f
360a  mov    ax, 0xa
360d  push   ax
360e  mov    ax, 0x12
3611  push   ax
3612  mov    di, 0x3399                        ; cs:'staff'
3615  push   cs
3616  push   di
3617  call   draw_text
361c  jmp    0x36c1
  loc_361f:
361f  cmp    ax, 9
3622  jne    0x3638
3624  xor    ax, ax
3626  push   ax
3627  mov    ax, 0x12
362a  push   ax
362b  mov    di, 0x339f                        ; cs:'art design and main programmer'
362e  push   cs
362f  push   di
3630  call   draw_text
3635  jmp    0x36c1
  loc_3638:
3638  cmp    ax, 0xb
363b  jne    0x3651
363d  mov    ax, 0x10
3640  push   ax
3641  mov    ax, 0x12
3644  push   ax
3645  mov    di, 0x33be                        ; cs:'Oh Jeon Seok '
3648  push   cs
3649  push   di
364a  call   draw_text
364f  jmp    0x36c1
  loc_3651:
3651  cmp    ax, 0xe
3654  jne    0x3669
3656  xor    ax, ax
3658  push   ax
3659  mov    ax, 0x12
365c  push   ax
365d  mov    di, 0x33cc                        ; cs:'technical assistant'
3660  push   cs
3661  push   di
3662  call   draw_text
3667  jmp    0x36c1
  loc_3669:
3669  cmp    ax, 0x10
366c  jne    0x3682
366e  mov    ax, 0x10
3671  push   ax
3672  mov    ax, 0x12
3675  push   ax
3676  mov    di, 0x33e0                        ; cs:'Kim Hea Jin    '
3679  push   cs
367a  push   di
367b  call   draw_text
3680  jmp    0x36c1
  loc_3682:
3682  cmp    ax, 0x13
3685  jne    0x369a
3687  xor    ax, ax
3689  push   ax
368a  mov    ax, 0x12
368d  push   ax
368e  mov    di, 0x33f0                        ; cs:'game designer'
3691  push   cs
3692  push   di
3693  call   draw_text
3698  jmp    0x36c1
  loc_369a:
369a  cmp    ax, 0x15
369d  jne    0x36b3
369f  mov    ax, 0x10
36a2  push   ax
36a3  mov    ax, 0x12
36a6  push   ax
36a7  mov    di, 0x33fe                        ; cs:'Kyeong yeol  '
36aa  push   cs
36ab  push   di
36ac  call   draw_text
36b1  jmp    0x36c1
  loc_36b3:
36b3  cmp    ax, 0x19
36b6  jne    0x36c1
36b8  mov    ax, 0x7d0
36bb  push   ax
36bc  call   Crt_Delay
  loc_36c1:
36c1  mov    ax, 0x64
36c4  push   ax
36c5  call   Crt_Delay
36ca  cmp    byte ptr [0xa3c1], 0x19           ; scratch
36cf  je     0x36d4
36d1  jmp    0x35d3
  loc_36d4:
36d4  mov    byte ptr [0xa3b0], 1              ; loop_i
36d9  jmp    0x36df
  loc_36db:
36db  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_36df:
36df  mov    byte ptr [bp - 0x13], 6
36e3  mov    byte ptr [bp - 0x14], 1
36e7  mov    byte ptr [bp - 0x11], 0
36eb  mov    byte ptr [bp - 0xf], 0
36ef  mov    byte ptr [bp - 0x10], 0
36f3  mov    byte ptr [bp - 0xd], 0x18
36f7  mov    byte ptr [bp - 0xe], 0x4f
36fb  mov    al, 0x10
36fd  push   ax
36fe  lea    di, [bp - 0x14]
3701  push   ss
3702  push   di
3703  call   Dos_Intr
3708  mov    ax, 0x64
370b  push   ax
370c  call   Crt_Delay
3711  cmp    byte ptr [0xa3b0], 0x19           ; loop_i
3716  jne    0x36db
  loc_3718:
3718  call   Graph_ClearDevice
371d  mov    byte ptr [0xa3bc], 1              ; stage
3722  mov    ax, 7
3725  push   ax
3726  mov    ax, 6
3729  push   ax
372a  mov    di, 0x340c                        ; cs:'1  game start'
372d  push   cs
372e  push   di
372f  call   draw_text
3734  mov    ax, 7
3737  push   ax
3738  mov    ax, 8
373b  push   ax
373c  mov    di, 0x341a                        ; cs:'2  stage edit'
373f  push   cs
3740  push   di
3741  call   draw_text
3746  mov    ax, 7
3749  push   ax
374a  mov    ax, 0xa
374d  push   ax
374e  mov    di, 0x3428                        ; cs:'3  stage load'
3751  push   cs
3752  push   di
3753  call   draw_text
3758  mov    ax, 7
375b  push   ax
375c  mov    ax, 0xc
375f  push   ax
3760  mov    di, 0x3436                        ; cs:'4  exit to dos'
3763  push   cs
3764  push   di
3765  call   draw_text
376a  call   Crt_ReadKey
376f  mov    byte ptr [0xb08e], al             ; last_key
3772  cmp    byte ptr [0xb08e], 0x32           ; last_key
3777  jne    0x377e
3779  call   stage_editor
  loc_377e:
377e  cmp    byte ptr [0xb08e], 0x33           ; last_key
3783  je     0x3788
3785  jmp    0x391e
  loc_3788:
3788  call   Graph_ClearDevice
378d  mov    ax, 0xf
3790  push   ax
3791  call   Graph_SetColor
3796  mov    ax, 5
3799  push   ax
379a  mov    ax, 2
379d  push   ax
379e  mov    di, 0x3445                        ; cs:'stage'
37a1  push   cs
37a2  push   di
37a3  call   draw_text
37a8  xor    ax, ax
37aa  push   ax
37ab  xor    ax, ax
37ad  push   ax
37ae  mov    ax, 0x27f
37b1  push   ax
37b2  mov    ax, 0xc7
37b5  push   ax
37b6  call   Graph_Rectangle
  loc_37bb:
37bb  mov    byte ptr [0xa3c1], 0xb            ; scratch
37c0  mov    byte ptr [0xa3bc], 0              ; stage
  loc_37c5:
37c5  call   Crt_ReadKey
37ca  mov    byte ptr [bp - 0x15], al
37cd  mov    al, byte ptr [bp - 0x15]
37d0  push   ax
37d1  mov    di, 0x344b                        ; set cs:344b = [48,49,50,51,52,53,54,55,56,57]
37d4  push   cs
37d5  push   di
37d6  call   Sys_SetIn
37db  je     0x3818
37dd  mov    al, byte ptr [0xa3c1]             ; scratch
37e0  xor    ah, ah
37e2  push   ax
37e3  mov    ax, 2
37e6  push   ax
37e7  lea    di, [bp - 0x116]
37eb  push   ss
37ec  push   di
37ed  mov    al, byte ptr [bp - 0x15]
37f0  push   ax
37f1  call   Sys_CharToStr
37f6  call   draw_text
37fb  inc    byte ptr [0xa3c1]                 ; scratch
37ff  mov    al, byte ptr [bp - 0x15]
3802  xor    ah, ah
3804  mov    bx, ax
3806  mov    al, byte ptr [0xa3bc]             ; stage
3809  xor    ah, ah
380b  mov    cx, 0xa
380e  imul   cx
3810  add    ax, bx
3812  sub    ax, 0x30
3815  mov    byte ptr [0xa3bc], al             ; stage
  loc_3818:
3818  cmp    byte ptr [bp - 0x15], 8
381c  jne    0x3891
381e  cmp    byte ptr [0xa3c1], 0xb            ; scratch
3823  jbe    0x3891
3825  dec    byte ptr [0xa3c1]                 ; scratch
3829  xor    ax, ax
382b  push   ax
382c  call   Graph_SetColor
3831  mov    al, byte ptr [0xa3c1]             ; scratch
3834  xor    ah, ah
3836  mov    cx, 0x14
3839  imul   cx
383b  add    ax, 0x14
383e  mov    byte ptr [bp - 0x16], al
3841  mov    al, byte ptr [0xa3c1]             ; scratch
3844  xor    ah, ah
3846  mov    cx, 0x14
3849  imul   cx
384b  cmp    al, byte ptr [bp - 0x16]
384e  ja     0x387a
3850  mov    byte ptr [0xa3b1], al             ; loop_j
3853  jmp    0x3859
  loc_3855:
3855  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_3859:
3859  mov    al, byte ptr [0xa3b1]             ; loop_j
385c  xor    ah, ah
385e  push   ax
385f  mov    ax, 0x14
3862  push   ax
3863  mov    al, byte ptr [0xa3b1]             ; loop_j
3866  xor    ah, ah
3868  push   ax
3869  mov    ax, 0x1e
386c  push   ax
386d  call   Graph_Line
3872  mov    al, byte ptr [0xa3b1]             ; loop_j
3875  cmp    al, byte ptr [bp - 0x16]
3878  jne    0x3855
  loc_387a:
387a  mov    ax, 0xf
387d  push   ax
387e  call   Graph_SetColor
3883  mov    al, byte ptr [0xa3bc]             ; stage
3886  xor    ah, ah
3888  cdq
3889  mov    cx, 0xa
388c  idiv   cx
388e  mov    byte ptr [0xa3bc], al             ; stage
  loc_3891:
3891  cmp    byte ptr [bp - 0x15], 0xd
3895  je     0x389a
3897  jmp    0x37c5
  loc_389a:
389a  mov    byte ptr [bp - 0x15], 0x20
389e  cmp    byte ptr [0xa3bc], 1              ; stage
38a3  jb     0x38e1
38a5  cmp    byte ptr [0xa3bc], 1              ; stage
38aa  jbe    0x391e
38ac  mov    al, byte ptr [0xa3bc]             ; stage
38af  xor    ah, ah
38b1  dec    ax
38b2  cdq
38b3  mov    cx, 0x14
38b6  idiv   cx
38b8  xchg   dx, ax
38b9  mov    bx, ax
38bb  mov    al, byte ptr [0xa3bc]             ; stage
38be  xor    ah, ah
38c0  dec    ax
38c1  cdq
38c2  mov    cx, 0x14
38c5  idiv   cx
38c7  mov    dx, 0x19
38ca  mul    dx
38cc  mov    di, ax
38ce  add    di, bx
38d0  mov    al, byte ptr [di - 0x4a70]        ; +rooms
38d4  push   ax
38d5  mov    di, 0x346b                        ; set cs:346b = [1,2,3,4,5,6,7,8,9]
38d8  push   cs
38d9  push   di
38da  call   Sys_SetIn
38df  jne    0x391e
  loc_38e1:
38e1  xor    ax, ax
38e3  push   ax
38e4  call   Graph_SetColor
38e9  mov    word ptr [0xb086], 0xc8           ; old_x
38ef  jmp    0x38f5
  loc_38f1:
38f1  inc    word ptr [0xb086]                 ; old_x
  loc_38f5:
38f5  push   word ptr [0xb086]                 ; old_x
38f9  mov    ax, 0x14
38fc  push   ax
38fd  push   word ptr [0xb086]                 ; old_x
3901  mov    ax, 0x1e
3904  push   ax
3905  call   Graph_Line
390a  cmp    word ptr [0xb086], 0x190          ; old_x
3910  jne    0x38f1
3912  mov    ax, 0xf
3915  push   ax
3916  call   Graph_SetColor
391b  jmp    0x37bb
  loc_391e:
391e  cmp    byte ptr [0xb08e], 0x34           ; last_key
3923  jne    0x393b
3925  call   Crt_NoSound
392a  call   sub_0c93_0a5d
392f  call   Graph_CloseGraph
3934  xor    ax, ax
3936  call   Sys_Halt
  loc_393b:
393b  mov    al, byte ptr [0xb08e]             ; last_key
393e  push   ax
393f  mov    di, 0x348b                        ; set cs:348b = [49,51]
3942  push   cs
3943  push   di
3944  call   Sys_SetIn
3949  jne    0x394e
394b  jmp    0x3718
  loc_394e:
394e  mov    sp, bp
3950  pop    bp
3951  retf
3952  db fe,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00
3962  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
3972  db 01,30,08,20,73,74,61,67,65,20,20,0d,73,6f,75,6c
3982  db 20,73,74,6f,6e,65,73,20,20,1e,73,74,61,67,65,20
3992  db 20,20,20,20,73,63,6f,72,65,20,20,20,20,20,20,20
39a2  db 20,20,20,20,72,65,73,74,00,00,00,40,0e,00,00,01
39b2  db 00,02,e0,01,10,00,00,00,00,00,00,10,00,00,00,00
39c2  db 00,00,00,00,00,00,00,00,00,00,00,00,00,cc,7c,00
39d2  db 00,00,00,00,00,80,00,00,00,00,00,00,00,80,00,00
39e2  db 00,00,00,40,00,00,00,00,00,00,00,00,00,00,00,00
39f2  db 00,28,00,00,00,00,00,00,00,00,00,00,00,00,00,00
3a02  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,18,00
3a12  db 00,00,00,00,60,80,00,00,00,00,80,01,02,80,00,00
3a22  db 00,06,00,00,00,00,00,18,00,00,00,00,00,00,64,00
3a32  db 00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,00
3a42  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,60,00
3a52  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
3a62  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,18,00
3a72  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
3a82  db 00,00,00,00,00,00,00,00,00,00,00,40,0e,00,00,01
3a92  db 00,00,80,01,10,00,00,00,00,00,00,00,00,00,00,00
3aa2  db 00,00,00,00,00,00,00,00,04,6e,69,63,65,16,6c,65
3ab2  db 74,20,73,20,67,6f,20,74,6f,20,6e,65,78,74,20,73
3ac2  db 74,61,67,65,00,00,00,08,0e,00,00,01,00,10,e0,01
3ad2  db 10,04,00,00,00,00,00,10,00,00,00,00,00,40,00,00
3ae2  db 00,00,00,00,0c,31,20,20,67,61,6d,65,20,6f,76,65
3af2  db 72,0b,32,20,20,63,6f,6e,74,69,6e,75,65,00,00,00
3b02  db 00,00,00,06,00,00,00,00,00,00,00,00,00,00,00,00
3b12  db 00,00,00,00,00,00,00,00,00,00,00,00,00

; ------------------------------------------------------------
main:
3b1f  call   System_init
3b24  call   Crt_init
3b29  call   Graph_init
3b2e  call   gamelib_init
3b33  push   bp
3b34  mov    bp, sp
3b36  sub    sp, 0x100
3b3a  call   Crt_ClrScr
3b3f  mov    ax, 0x5ef6
3b42  mov    dx, 0                             ; seg MAIN
3b45  push   dx
3b46  push   ax
3b47  call   Graph_RegisterBGIdriver
3b4c  mov    word ptr [0xb086], ax             ; old_x
3b4f  mov    byte ptr [0xcdfe], 0
3b54  mov    si, 0xffff
3b57  mov    es, si
3b59  mov    al, byte ptr es:[0xe]
3b5d  xor    ah, ah
3b5f  cmp    ax, 0xff
3b62  je     0x3b69
3b64  cmp    ax, 0xfe
3b67  jne    0x3b70
  loc_3b69:
3b69  mov    byte ptr [0x2966], 2              ; machine_speed
3b6e  jmp    0x3b7a
  loc_3b70:
3b70  cmp    ax, 0xfc
3b73  jne    0x3b7a
3b75  mov    byte ptr [0x2966], 0xa            ; machine_speed
  loc_3b7a:
3b7a  mov    word ptr [0xb07e], 0xffff         ; tune_pos
3b80  mov    byte ptr [0xa3b0], 0              ; loop_i
3b85  jmp    0x3b8b
  loc_3b87:
3b87  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3b8b:
3b8b  mov    al, byte ptr [0xa3b0]             ; loop_i
3b8e  xor    ah, ah
3b90  mov    dx, 0x54
3b93  mul    dx
3b95  mov    di, ax
3b97  mov    word ptr [di + 0x69ec], 0x1f      ; +sprites
3b9d  mov    al, byte ptr [0xa3b0]             ; loop_i
3ba0  xor    ah, ah
3ba2  mov    dx, 0x54
3ba5  mul    dx
3ba7  mov    di, ax
3ba9  mov    word ptr [di + 0x69ee], 0xf
3baf  mov    byte ptr [0xa3b1], 1              ; loop_j
3bb4  jmp    0x3bba
  loc_3bb6:
3bb6  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_3bba:
3bba  inc    word ptr [0xb07e]                 ; tune_pos
3bbe  mov    di, word ptr [0xb07e]             ; tune_pos
3bc2  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
3bc6  mov    al, byte ptr [0xa3b1]             ; loop_j
3bc9  xor    ah, ah
3bcb  mov    cx, ax
3bcd  mov    al, byte ptr [0xa3b0]             ; loop_i
3bd0  xor    ah, ah
3bd2  mov    dx, 0x54
3bd5  mul    dx
3bd7  mov    di, ax
3bd9  add    di, cx
3bdb  mov    byte ptr [di + 0x69ef], bl
3bdf  cmp    byte ptr [0xa3b1], 0x40           ; loop_j
3be4  jne    0x3bb6
3be6  cmp    byte ptr [0xa3b0], 0x32           ; loop_i
3beb  jne    0x3b87
3bed  mov    byte ptr [0xa3b0], 0x33           ; loop_i
3bf2  jmp    0x3bf8
  loc_3bf4:
3bf4  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3bf8:
3bf8  mov    al, byte ptr [0xa3b0]             ; loop_i
3bfb  xor    ah, ah
3bfd  mov    dx, 0x54
3c00  mul    dx
3c02  mov    di, ax
3c04  mov    word ptr [di + 0x69ec], 0x1f      ; +sprites
3c0a  mov    al, byte ptr [0xa3b0]             ; loop_i
3c0d  xor    ah, ah
3c0f  mov    dx, 0x54
3c12  mul    dx
3c14  mov    di, ax
3c16  mov    word ptr [di + 0x69ee], 7
3c1c  mov    byte ptr [0xa3b1], 1              ; loop_j
3c21  jmp    0x3c27
  loc_3c23:
3c23  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_3c27:
3c27  inc    word ptr [0xb07e]                 ; tune_pos
3c2b  mov    di, word ptr [0xb07e]             ; tune_pos
3c2f  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
3c33  mov    al, byte ptr [0xa3b1]             ; loop_j
3c36  xor    ah, ah
3c38  mov    cx, ax
3c3a  mov    al, byte ptr [0xa3b0]             ; loop_i
3c3d  xor    ah, ah
3c3f  mov    dx, 0x54
3c42  mul    dx
3c44  mov    di, ax
3c46  add    di, cx
3c48  mov    byte ptr [di + 0x69ef], bl
3c4c  cmp    byte ptr [0xa3b1], 0x20           ; loop_j
3c51  jne    0x3c23
3c53  cmp    byte ptr [0xa3b0], 0x40           ; loop_i
3c58  jne    0x3bf4
3c5a  mov    byte ptr [0xa3b0], 0x41           ; loop_i
3c5f  jmp    0x3c65
  loc_3c61:
3c61  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3c65:
3c65  mov    al, byte ptr [0xa3b0]             ; loop_i
3c68  xor    ah, ah
3c6a  mov    dx, 0x54
3c6d  mul    dx
3c6f  mov    di, ax
3c71  mov    word ptr [di + 0x69ec], 0x27      ; +sprites
3c77  mov    al, byte ptr [0xa3b0]             ; loop_i
3c7a  xor    ah, ah
3c7c  mov    dx, 0x54
3c7f  mul    dx
3c81  mov    di, ax
3c83  mov    word ptr [di + 0x69ee], 0xf
3c89  mov    byte ptr [0xa3b1], 1              ; loop_j
3c8e  jmp    0x3c94
  loc_3c90:
3c90  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_3c94:
3c94  inc    word ptr [0xb07e]                 ; tune_pos
3c98  mov    di, word ptr [0xb07e]             ; tune_pos
3c9c  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
3ca0  mov    al, byte ptr [0xa3b1]             ; loop_j
3ca3  xor    ah, ah
3ca5  mov    cx, ax
3ca7  mov    al, byte ptr [0xa3b0]             ; loop_i
3caa  xor    ah, ah
3cac  mov    dx, 0x54
3caf  mul    dx
3cb1  mov    di, ax
3cb3  add    di, cx
3cb5  mov    byte ptr [di + 0x69ef], bl
3cb9  cmp    byte ptr [0xa3b1], 0x50           ; loop_j
3cbe  jne    0x3c90
3cc0  cmp    byte ptr [0xa3b0], 0x48           ; loop_i
3cc5  jne    0x3c61
3cc7  mov    byte ptr [0xa3b0], 0x49           ; loop_i
3ccc  jmp    0x3cd2
  loc_3cce:
3cce  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3cd2:
3cd2  mov    al, byte ptr [0xa3b0]             ; loop_i
3cd5  xor    ah, ah
3cd7  mov    dx, 0x54
3cda  mul    dx
3cdc  mov    di, ax
3cde  mov    word ptr [di + 0x69ec], 0x1f      ; +sprites
3ce4  mov    al, byte ptr [0xa3b0]             ; loop_i
3ce7  xor    ah, ah
3ce9  mov    dx, 0x54
3cec  mul    dx
3cee  mov    di, ax
3cf0  mov    word ptr [di + 0x69ee], 0xf
3cf6  mov    byte ptr [0xa3b1], 1              ; loop_j
3cfb  jmp    0x3d01
  loc_3cfd:
3cfd  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_3d01:
3d01  inc    word ptr [0xb07e]                 ; tune_pos
3d05  mov    di, word ptr [0xb07e]             ; tune_pos
3d09  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
3d0d  mov    al, byte ptr [0xa3b1]             ; loop_j
3d10  xor    ah, ah
3d12  mov    cx, ax
3d14  mov    al, byte ptr [0xa3b0]             ; loop_i
3d17  xor    ah, ah
3d19  mov    dx, 0x54
3d1c  mul    dx
3d1e  mov    di, ax
3d20  add    di, cx
3d22  mov    byte ptr [di + 0x69ef], bl
3d26  cmp    byte ptr [0xa3b1], 0x40           ; loop_j
3d2b  jne    0x3cfd
3d2d  cmp    byte ptr [0xa3b0], 0x6e           ; loop_i
3d32  jne    0x3cce
3d34  mov    byte ptr [0xa3b0], 0x6f           ; loop_i
3d39  jmp    0x3d3f
  loc_3d3b:
3d3b  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3d3f:
3d3f  mov    al, byte ptr [0xa3b0]             ; loop_i
3d42  xor    ah, ah
3d44  mov    dx, 0x54
3d47  mul    dx
3d49  mov    di, ax
3d4b  mov    word ptr [di + 0x69ec], 0x1f      ; +sprites
3d51  mov    al, byte ptr [0xa3b0]             ; loop_i
3d54  xor    ah, ah
3d56  mov    dx, 0x54
3d59  mul    dx
3d5b  mov    di, ax
3d5d  mov    word ptr [di + 0x69ee], 7
3d63  mov    byte ptr [0xa3b1], 1              ; loop_j
3d68  jmp    0x3d6e
  loc_3d6a:
3d6a  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_3d6e:
3d6e  inc    word ptr [0xb07e]                 ; tune_pos
3d72  mov    di, word ptr [0xb07e]             ; tune_pos
3d76  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
3d7a  mov    al, byte ptr [0xa3b1]             ; loop_j
3d7d  xor    ah, ah
3d7f  mov    cx, ax
3d81  mov    al, byte ptr [0xa3b0]             ; loop_i
3d84  xor    ah, ah
3d86  mov    dx, 0x54
3d89  mul    dx
3d8b  mov    di, ax
3d8d  add    di, cx
3d8f  mov    byte ptr [di + 0x69ef], bl
3d93  cmp    byte ptr [0xa3b1], 0x20           ; loop_j
3d98  jne    0x3d6a
3d9a  cmp    byte ptr [0xa3b0], 0x8a           ; loop_i
3d9f  jne    0x3d3b
3da1  mov    byte ptr [0xa3b0], 0x8b           ; loop_i
3da6  jmp    0x3dac
  loc_3da8:
3da8  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3dac:
3dac  mov    al, byte ptr [0xa3b0]             ; loop_i
3daf  xor    ah, ah
3db1  mov    dx, 0x54
3db4  mul    dx
3db6  mov    di, ax
3db8  mov    word ptr [di + 0x69ec], 0x12      ; +sprites
3dbe  mov    al, byte ptr [0xa3b0]             ; loop_i
3dc1  xor    ah, ah
3dc3  mov    dx, 0x54
3dc6  mul    dx
3dc8  mov    di, ax
3dca  mov    word ptr [di + 0x69ee], 6
3dd0  mov    byte ptr [0xa3b1], 1              ; loop_j
3dd5  jmp    0x3ddb
  loc_3dd7:
3dd7  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_3ddb:
3ddb  inc    word ptr [0xb07e]                 ; tune_pos
3ddf  mov    di, word ptr [0xb07e]             ; tune_pos
3de3  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
3de7  mov    al, byte ptr [0xa3b1]             ; loop_j
3dea  xor    ah, ah
3dec  mov    cx, ax
3dee  mov    al, byte ptr [0xa3b0]             ; loop_i
3df1  xor    ah, ah
3df3  mov    dx, 0x54
3df6  mul    dx
3df8  mov    di, ax
3dfa  add    di, cx
3dfc  mov    byte ptr [di + 0x69ef], bl
3e00  cmp    byte ptr [0xa3b1], 0x15           ; loop_j
3e05  jne    0x3dd7
3e07  cmp    byte ptr [0xa3b0], 0xae           ; loop_i
3e0c  jne    0x3da8
3e0e  mov    di, 0x7aa8
3e11  push   ds
3e12  push   di
3e13  mov    di, 0xa358
3e16  push   ds
3e17  push   di
3e18  mov    ax, 0x54
3e1b  push   ax
3e1c  call   Sys_MoveFwd
3e21  mov    byte ptr [0xa3b7], 0              ; scan_code
3e26  mov    byte ptr [0xa3b9], 2              ; lives
3e2b  xor    ax, ax
3e2d  mov    word ptr [0xb034], ax             ; score
3e30  mov    word ptr [0xb036], ax             ; score+2
3e33  xor    ax, ax
3e35  mov    word ptr [0xb038], ax             ; hi_score
3e38  mov    word ptr [0xb03a], ax             ; hi_score+2
3e3b  push   cs
3e3c  call   title_and_menu
3e3f  call   Graph_ClearDevice
3e44  xor    ax, ax
3e46  mov    word ptr [0xb086], ax             ; old_x
3e49  mov    word ptr [0xb066], 0x2c7          ; tune_len
3e4f  mov    byte ptr [0xa3b0], 1              ; loop_i
3e54  jmp    0x3e5a
  loc_3e56:
3e56  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3e5a:
3e5a  mov    al, byte ptr [0xa3b0]             ; loop_i
3e5d  xor    ah, ah
3e5f  shl    ax, 1
3e61  mov    di, ax
3e63  shl    di, 1
3e65  mov    al, byte ptr [di - 2]
3e69  mov    byte ptr [bp - 1], al
3e6c  mov    al, 1
3e6e  cmp    al, byte ptr [bp - 1]
3e71  ja     0x3ec8
3e73  mov    byte ptr [0xa3b2], al             ; loop_k
3e76  jmp    0x3e7c
  loc_3e78:
3e78  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_3e7c:
3e7c  mov    al, byte ptr [0xa3b2]             ; loop_k
3e7f  shr    al, 1
3e81  jae    0x3e9f
3e83  mov    al, byte ptr [0xa3b0]             ; loop_i
3e86  xor    ah, ah
3e88  shl    ax, 1
3e8a  dec    ax
3e8b  mov    di, ax
3e8d  shl    di, 1
3e8f  mov    ax, word ptr [di - 2]
3e93  mov    di, word ptr [0xb086]             ; old_x
3e97  shl    di, 1
3e99  mov    word ptr [di - 0x5c34], ax        ; +tune
3e9d  jmp    0x3ebc
  loc_3e9f:
3e9f  mov    al, byte ptr [0xa3b0]             ; loop_i
3ea2  xor    ah, ah
3ea4  shl    ax, 1
3ea6  dec    ax
3ea7  mov    di, ax
3ea9  shl    di, 1
3eab  mov    ax, word ptr [di - 2]
3eaf  sub    ax, 5
3eb2  mov    di, word ptr [0xb086]             ; old_x
3eb6  shl    di, 1
3eb8  mov    word ptr [di - 0x5c34], ax        ; +tune
  loc_3ebc:
3ebc  inc    word ptr [0xb086]                 ; old_x
3ec0  mov    al, byte ptr [0xa3b2]             ; loop_k
3ec3  cmp    al, byte ptr [bp - 1]
3ec6  jne    0x3e78
  loc_3ec8:
3ec8  cmp    byte ptr [0xa3b0], 0x88           ; loop_i
3ecd  jne    0x3e56
3ecf  mov    al, 9
3ed1  push   ax
3ed2  mov    di, 0xb040                        ; &saved_int9
3ed5  push   ds
3ed6  push   di
3ed7  call   Dos_GetIntVec
3edc  mov    al, 9
3ede  push   ax
3edf  mov    ax, 0x16
3ee2  mov    dx, 0x8e2                         ; seg GAMELIB
3ee5  push   dx
3ee6  push   ax
3ee7  call   Dos_SetIntVec
3eec  mov    byte ptr [0xcb10], 1              ; show_stage_intro
  loc_3ef1:
3ef1  xor    ax, ax
3ef3  mov    word ptr [0xb06c], ax             ; dagger_hit_step
3ef6  xor    ax, ax
3ef8  mov    word ptr [0xb07e], ax             ; tune_pos
3efb  mov    byte ptr [0xa3ca], 0              ; push_left
3f00  mov    byte ptr [0xa3cb], 0              ; push_right
3f05  mov    byte ptr [0xcb15], 0              ; ladder_marked
3f0a  mov    byte ptr [0xcb16], 0              ; ladder_leave
3f0f  mov    byte ptr [0xcb17], 0              ; bridge_latch
3f14  mov    byte ptr [0xcb18], 0              ; on_bridge
3f19  mov    byte ptr [0x2964], 0              ; ladder_marked_up
3f1e  mov    byte ptr [0x2965], 0              ; ladder_marked_down
3f23  mov    byte ptr [0xcb13], 0              ; bridge_left
3f28  mov    byte ptr [0xcb14], 0              ; bridge_right
3f2d  mov    byte ptr [0xcb0e], 0              ; player_caught
3f32  mov    byte ptr [0xcb0d], 0              ; dagger_hit
3f37  mov    al, byte ptr [0xa3bc]             ; stage
3f3a  xor    ah, ah
3f3c  dec    ax
3f3d  cdq
3f3e  mov    cx, 0xa
3f41  idiv   cx
3f43  cdq
3f44  mov    cx, 7
3f47  idiv   cx
3f49  xchg   dx, ax
3f4a  mov    byte ptr [0xa3c1], al             ; scratch
3f4d  mov    al, byte ptr [0xa3c1]             ; scratch
3f50  xor    ah, ah
3f52  mov    cx, 2
3f55  shl    ax, cl
3f57  add    ax, 0x6f
3f5a  mov    dx, 0x54
3f5d  mul    dx
3f5f  mov    di, ax
3f61  add    di, 0x69ec
3f65  push   ds
3f66  push   di
3f67  mov    di, 0x7aa8
3f6a  push   ds
3f6b  push   di
3f6c  mov    ax, 0x54
3f6f  push   ax
3f70  call   Sys_MoveFwd
3f75  mov    byte ptr [0xa3b0], 1              ; loop_i
3f7a  jmp    0x3f80
  loc_3f7c:
3f7c  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3f80:
3f80  mov    al, byte ptr [0xa3b0]             ; loop_i
3f83  xor    ah, ah
3f85  mov    dx, ax
3f87  mov    al, byte ptr [0xa3c1]             ; scratch
3f8a  xor    ah, ah
3f8c  mov    cx, 2
3f8f  shl    ax, cl
3f91  add    ax, 0x6f
3f94  add    ax, dx
3f96  mov    dx, 0x54
3f99  mul    dx
3f9b  mov    di, ax
3f9d  add    di, 0x69ec
3fa1  push   ds
3fa2  push   di
3fa3  mov    al, byte ptr [0xa3b0]             ; loop_i
3fa6  xor    ah, ah
3fa8  add    ax, 0x34
3fab  mov    dx, 0x54
3fae  mul    dx
3fb0  mov    di, ax
3fb2  add    di, 0x69ec
3fb6  push   ds
3fb7  push   di
3fb8  mov    ax, 0x54
3fbb  push   ax
3fbc  call   Sys_MoveFwd
3fc1  cmp    byte ptr [0xa3b0], 3              ; loop_i
3fc6  jne    0x3f7c
3fc8  mov    byte ptr [0xa3b0], 1              ; loop_i
3fcd  jmp    0x3fd3
  loc_3fcf:
3fcf  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3fd3:
3fd3  mov    byte ptr [0xa3b1], 0              ; loop_j
3fd8  jmp    0x3fde
  loc_3fda:
3fda  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_3fde:
3fde  mov    al, byte ptr [0xa3b1]             ; loop_j
3fe1  xor    ah, ah
3fe3  cdq
3fe4  mov    cx, 0x20
3fe7  idiv   cx
3fe9  xchg   dx, ax
3fea  inc    ax
3feb  mov    di, ax
3fed  mov    bl, byte ptr [di + 0x7b53]
3ff1  mov    al, byte ptr [0xa3b1]             ; loop_j
3ff4  xor    ah, ah
3ff6  inc    ax
3ff7  mov    cx, ax
3ff9  mov    al, byte ptr [0xa3b0]             ; loop_i
3ffc  xor    ah, ah
3ffe  add    ax, 0x66
4001  mov    dx, 0x54
4004  mul    dx
4006  mov    di, ax
4008  add    di, cx
400a  mov    al, byte ptr [di + 0x69ef]
400e  and    al, bl
4010  mov    bl, al
4012  mov    al, byte ptr [0xa3b1]             ; loop_j
4015  xor    ah, ah
4017  inc    ax
4018  mov    cx, ax
401a  mov    al, byte ptr [0xa3b0]             ; loop_i
401d  xor    ah, ah
401f  add    ax, 0x66
4022  mov    dx, 0x54
4025  mul    dx
4027  mov    di, ax
4029  add    di, cx
402b  mov    byte ptr [di + 0x69ef], bl
402f  cmp    byte ptr [0xa3b1], 0x3f           ; loop_j
4034  jne    0x3fda
4036  cmp    byte ptr [0xa3b0], 8              ; loop_i
403b  jne    0x3fcf
403d  mov    byte ptr [0xa3c1], 0              ; scratch
4042  mov    al, byte ptr [0xa3bc]             ; stage
4045  xor    ah, ah
4047  cdq
4048  mov    cx, 0x14
404b  idiv   cx
404d  xchg   dx, ax
404e  mov    bx, ax
4050  mov    al, byte ptr [0xa3bc]             ; stage
4053  xor    ah, ah
4055  cdq
4056  mov    cx, 0x14
4059  idiv   cx
405b  mov    dx, 0x19
405e  mul    dx
4060  mov    di, ax
4062  add    di, bx
4064  mov    al, byte ptr [di - 0x4a70]        ; +rooms
4068  push   ax
4069  mov    di, 0x3952                        ; set cs:3952 = [1,2,3,4,5,6,7,8,9]
406c  push   cs
406d  push   di
406e  call   Sys_SetIn
4073  jne    0x4078
4075  jmp    0x4155
  loc_4078:
4078  cmp    byte ptr [0xa3bc], 1              ; stage
407d  jbe    0x40ca
407f  mov    al, byte ptr [0xa3bc]             ; stage
4082  xor    ah, ah
4084  dec    ax
4085  mov    byte ptr [bp - 1], al
4088  mov    al, 1
408a  cmp    al, byte ptr [bp - 1]
408d  ja     0x40ca
408f  mov    byte ptr [0xa3b0], al             ; loop_i
4092  jmp    0x4098
  loc_4094:
4094  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_4098:
4098  mov    al, byte ptr [0xa3b0]             ; loop_i
409b  xor    ah, ah
409d  cdq
409e  mov    cx, 0x14
40a1  idiv   cx
40a3  xchg   dx, ax
40a4  mov    bx, ax
40a6  mov    al, byte ptr [0xa3b0]             ; loop_i
40a9  xor    ah, ah
40ab  cdq
40ac  mov    cx, 0x14
40af  idiv   cx
40b1  mov    dx, 0x19
40b4  mul    dx
40b6  mov    di, ax
40b8  add    di, bx
40ba  mov    al, byte ptr [di - 0x4a70]        ; +rooms
40be  add    byte ptr [0xa3c1], al             ; scratch
40c2  mov    al, byte ptr [0xa3b0]             ; loop_i
40c5  cmp    al, byte ptr [bp - 1]
40c8  jne    0x4094
  loc_40ca:
40ca  mov    di, 0xcb9a
40cd  push   ds
40ce  push   di
40cf  mov    ax, 0x226
40d2  push   ax
40d3  call   Sys_ResetFile
40d8  mov    di, 0xcb9a
40db  push   ds
40dc  push   di
40dd  mov    al, byte ptr [0xa3c1]             ; scratch
40e0  xor    ah, ah
40e2  inc    ax
40e3  cdq
40e4  push   dx
40e5  push   ax
40e6  call   Sys_Seek
40eb  mov    al, byte ptr [0xa3bc]             ; stage
40ee  xor    ah, ah
40f0  cdq
40f1  mov    cx, 0x14
40f4  idiv   cx
40f6  xchg   dx, ax
40f7  mov    bx, ax
40f9  mov    al, byte ptr [0xa3bc]             ; stage
40fc  xor    ah, ah
40fe  cdq
40ff  mov    cx, 0x14
4102  idiv   cx
4104  mov    dx, 0x19
4107  mul    dx
4109  mov    di, ax
410b  add    di, bx
410d  mov    al, byte ptr [di - 0x4a70]        ; +rooms
4111  mov    byte ptr [bp - 1], al
4114  mov    al, 1
4116  cmp    al, byte ptr [bp - 1]
4119  ja     0x414b
411b  mov    byte ptr [0xa3b0], al             ; loop_i
411e  jmp    0x4124
  loc_4120:
4120  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_4124:
4124  mov    di, 0xcb9a
4127  push   ds
4128  push   di
4129  mov    al, byte ptr [0xa3b0]             ; loop_i
412c  xor    ah, ah
412e  mov    dx, 0x226
4131  mul    dx
4133  mov    di, ax
4135  add    di, 0xb590
4139  push   ds
413a  push   di
413b  call   Sys_ReadRec
4140  add    sp, 4
4143  mov    al, byte ptr [0xa3b0]             ; loop_i
4146  cmp    al, byte ptr [bp - 1]
4149  jne    0x4120
  loc_414b:
414b  mov    di, 0xcb9a
414e  push   ds
414f  push   di
4150  call   Sys_Close
  loc_4155:
4155  mov    byte ptr [0xa3bd], 0              ; stones_left
415a  xor    ax, ax
415c  mov    word ptr [0xb080], ax             ; work
415f  mov    byte ptr [0xb011], 0
4164  mov    byte ptr [0xb02f], 0
4169  mov    al, byte ptr [0xa3bc]             ; stage
416c  xor    ah, ah
416e  cdq
416f  mov    cx, 0x14
4172  idiv   cx
4174  xchg   dx, ax
4175  mov    bx, ax
4177  mov    al, byte ptr [0xa3bc]             ; stage
417a  xor    ah, ah
417c  cdq
417d  mov    cx, 0x14
4180  idiv   cx
4182  mov    dx, 0x19
4185  mul    dx
4187  mov    di, ax
4189  add    di, bx
418b  mov    al, byte ptr [di - 0x4a70]        ; +rooms
418f  mov    byte ptr [bp - 1], al
4192  mov    al, 1
4194  cmp    al, byte ptr [bp - 1]
4197  jbe    0x419c
4199  jmp    0x4501
  loc_419c:
419c  mov    byte ptr [0xa3b0], al             ; loop_i
419f  jmp    0x41a5
  loc_41a1:
41a1  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_41a5:
41a5  mov    byte ptr [0xa3b1], 0              ; loop_j
41aa  jmp    0x41b0
  loc_41ac:
41ac  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_41b0:
41b0  mov    byte ptr [0xa3b2], 0              ; loop_k
41b5  jmp    0x41bb
  loc_41b7:
41b7  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_41bb:
41bb  cmp    byte ptr [0xa3b2], 0x17           ; loop_k
41c0  jne    0x41fe
41c2  mov    al, byte ptr [0xa3b1]             ; loop_j
41c5  xor    ah, ah
41c7  mov    dx, 0x19
41ca  mul    dx
41cc  mov    cx, ax
41ce  mov    al, byte ptr [0xa3b0]             ; loop_i
41d1  xor    ah, ah
41d3  mov    dx, 0x226
41d6  mul    dx
41d8  mov    di, ax
41da  add    di, cx
41dc  mov    bl, byte ptr [di - 0x4a59]
41e0  mov    al, byte ptr [0xa3b1]             ; loop_j
41e3  xor    ah, ah
41e5  mov    dx, 0x19
41e8  mul    dx
41ea  mov    cx, ax
41ec  mov    al, byte ptr [0xa3b0]             ; loop_i
41ef  xor    ah, ah
41f1  mov    dx, 0x226
41f4  mul    dx
41f6  mov    di, ax
41f8  add    di, cx
41fa  mov    byte ptr [di - 0x4a58], bl
  loc_41fe:
41fe  mov    al, byte ptr [0xa3b2]             ; loop_k
4201  xor    ah, ah
4203  mov    bx, ax
4205  mov    al, byte ptr [0xa3b1]             ; loop_j
4208  xor    ah, ah
420a  mov    dx, 0x19
420d  mul    dx
420f  mov    cx, ax
4211  mov    al, byte ptr [0xa3b0]             ; loop_i
4214  xor    ah, ah
4216  mov    dx, 0x226
4219  mul    dx
421b  mov    di, ax
421d  add    di, cx
421f  add    di, bx
4221  cmp    byte ptr [di - 0x4a70], 0x21      ; +rooms
4226  jne    0x422c
4228  inc    byte ptr [0xa3bd]                 ; stones_left
  loc_422c:
422c  mov    al, byte ptr [0xa3b2]             ; loop_k
422f  xor    ah, ah
4231  mov    bx, ax
4233  mov    al, byte ptr [0xa3b1]             ; loop_j
4236  xor    ah, ah
4238  mov    dx, 0x19
423b  mul    dx
423d  mov    cx, ax
423f  mov    al, byte ptr [0xa3b0]             ; loop_i
4242  xor    ah, ah
4244  mov    dx, 0x226
4247  mul    dx
4249  mov    di, ax
424b  add    di, cx
424d  add    di, bx
424f  cmp    byte ptr [di - 0x4a70], 0         ; +rooms
4254  jne    0x425c
4256  mov    al, byte ptr [0xa3b0]             ; loop_i
4259  mov    byte ptr [0xa3c9], al             ; start_room
  loc_425c:
425c  mov    al, byte ptr [0xa3b2]             ; loop_k
425f  xor    ah, ah
4261  mov    bx, ax
4263  mov    al, byte ptr [0xa3b1]             ; loop_j
4266  xor    ah, ah
4268  mov    dx, 0x19
426b  mul    dx
426d  mov    cx, ax
426f  mov    al, byte ptr [0xa3b0]             ; loop_i
4272  xor    ah, ah
4274  mov    dx, 0x226
4277  mul    dx
4279  mov    di, ax
427b  add    di, cx
427d  add    di, bx
427f  cmp    byte ptr [di - 0x4a70], 0x58      ; +rooms
4284  jne    0x42ab
4286  mov    al, byte ptr [0xa3b1]             ; loop_j
4289  xor    ah, ah
428b  mov    cx, 5
428e  shl    ax, cl
4290  mov    word ptr [0xb074], ax             ; exit_x
4293  mov    al, byte ptr [0xa3b2]             ; loop_k
4296  xor    ah, ah
4298  mov    cx, 3
429b  shl    ax, cl
429d  add    ax, 8
42a0  mov    word ptr [0xb076], ax             ; exit_y
42a3  mov    al, byte ptr [0xa3b0]             ; loop_i
42a6  xor    ah, ah
42a8  mov    word ptr [0xb078], ax             ; exit_room
  loc_42ab:
42ab  mov    al, byte ptr [0xa3b2]             ; loop_k
42ae  xor    ah, ah
42b0  mov    bx, ax
42b2  mov    al, byte ptr [0xa3b1]             ; loop_j
42b5  xor    ah, ah
42b7  mov    dx, 0x19
42ba  mul    dx
42bc  mov    cx, ax
42be  mov    al, byte ptr [0xa3b0]             ; loop_i
42c1  xor    ah, ah
42c3  mov    dx, 0x226
42c6  mul    dx
42c8  mov    di, ax
42ca  add    di, cx
42cc  add    di, bx
42ce  cmp    byte ptr [di - 0x4a70], 0x4c      ; +rooms
42d3  je     0x42d8
42d5  jmp    0x44e2
  loc_42d8:
42d8  cmp    word ptr [0xb080], 3              ; work
42dd  jl     0x42e2
42df  jmp    0x44e2
  loc_42e2:
42e2  inc    word ptr [0xb080]                 ; work
42e6  mov    ax, word ptr [0xb080]             ; work
42e9  mov    dx, 0x1e
42ec  mul    dx
42ee  mov    di, ax
42f0  mov    byte ptr [di - 0x502b], 1
42f5  mov    ax, word ptr [0xb080]             ; work
42f8  mov    dx, 0x1e
42fb  mul    dx
42fd  mov    di, ax
42ff  mov    word ptr [di - 0x5044], 1
4305  mov    al, byte ptr [0xa3b1]             ; loop_j
4308  xor    ah, ah
430a  mov    cx, 5
430d  shl    ax, cl
430f  add    ax, 0x10
4312  mov    cx, ax
4314  mov    ax, word ptr [0xb080]             ; work
4317  mov    dx, 0x1e
431a  mul    dx
431c  mov    di, ax
431e  mov    word ptr [di - 0x5042], cx
4322  mov    al, byte ptr [0xa3b2]             ; loop_k
4325  xor    ah, ah
4327  mov    cx, 3
432a  shl    ax, cl
432c  add    ax, 8
432f  mov    cx, ax
4331  mov    ax, word ptr [0xb080]             ; work
4334  mov    dx, 0x1e
4337  mul    dx
4339  mov    di, ax
433b  mov    word ptr [di - 0x5040], cx
433f  mov    al, byte ptr [0xa3b1]             ; loop_j
4342  xor    ah, ah
4344  mov    cx, 5
4347  shl    ax, cl
4349  add    ax, 0x10
434c  mov    cx, ax
434e  mov    ax, word ptr [0xb080]             ; work
4351  mov    dx, 0x1e
4354  mul    dx
4356  mov    di, ax
4358  mov    word ptr [di - 0x5048], cx        ; +mummies
435c  mov    al, byte ptr [0xa3b2]             ; loop_k
435f  xor    ah, ah
4361  mov    cx, 3
4364  shl    ax, cl
4366  add    ax, 8
4369  mov    cx, ax
436b  mov    ax, word ptr [0xb080]             ; work
436e  mov    dx, 0x1e
4371  mul    dx
4373  mov    di, ax
4375  mov    word ptr [di - 0x5046], cx
4379  mov    ax, word ptr [0xb080]             ; work
437c  mov    dx, 0x1e
437f  mul    dx
4381  mov    di, ax
4383  mov    byte ptr [di - 0x5032], 0
4388  mov    ax, word ptr [0xb080]             ; work
438b  mov    dx, 0x1e
438e  mul    dx
4390  mov    di, ax
4392  mov    byte ptr [di - 0x5031], 0
4397  mov    ax, word ptr [0xb080]             ; work
439a  mov    dx, 0x1e
439d  mul    dx
439f  mov    di, ax
43a1  mov    byte ptr [di - 0x5030], 0
43a6  mov    ax, word ptr [0xb080]             ; work
43a9  mov    dx, 0x1e
43ac  mul    dx
43ae  mov    di, ax
43b0  mov    byte ptr [di - 0x502f], 0
43b5  mov    ax, word ptr [0xb080]             ; work
43b8  mov    dx, 0x1e
43bb  mul    dx
43bd  mov    di, ax
43bf  mov    byte ptr [di - 0x5036], 0
43c4  mov    ax, word ptr [0xb080]             ; work
43c7  mov    dx, 0x1e
43ca  mul    dx
43cc  mov    di, ax
43ce  mov    byte ptr [di - 0x5035], 0
43d3  mov    ax, word ptr [0xb080]             ; work
43d6  mov    dx, 0x1e
43d9  mul    dx
43db  mov    di, ax
43dd  mov    byte ptr [di - 0x5034], 0
43e2  mov    ax, word ptr [0xb080]             ; work
43e5  mov    dx, 0x1e
43e8  mul    dx
43ea  mov    di, ax
43ec  mov    byte ptr [di - 0x5033], 0
43f1  mov    cl, byte ptr [0xa3b0]             ; loop_i
43f5  mov    ax, word ptr [0xb080]             ; work
43f8  mov    dx, 0x1e
43fb  mul    dx
43fd  mov    di, ax
43ff  mov    byte ptr [di - 0x503a], cl
4403  mov    cl, byte ptr [0xa3b0]             ; loop_i
4407  mov    ax, word ptr [0xb080]             ; work
440a  mov    dx, 0x1e
440d  mul    dx
440f  mov    di, ax
4411  mov    byte ptr [di - 0x5039], cl
4415  mov    ax, 2
4418  push   ax
4419  call   Sys_Random
441e  shl    ax, 1
4420  dec    ax
4421  mov    cx, ax
4423  mov    ax, word ptr [0xb080]             ; work
4426  mov    dx, 0x1e
4429  mul    dx
442b  mov    di, ax
442d  mov    word ptr [di - 0x503e], cx
4431  mov    ax, word ptr [0xb080]             ; work
4434  mov    dx, 0x1e
4437  mul    dx
4439  mov    di, ax
443b  mov    al, byte ptr [di - 0x503a]
443f  cmp    al, byte ptr [0xa3c5]             ; cur_room
4443  jne    0x448c
4445  mov    ax, word ptr [0xb080]             ; work
4448  mov    dx, 0x1e
444b  mul    dx
444d  mov    di, ax
444f  mov    cx, word ptr [di - 0x503e]
4453  mov    ax, word ptr [0xb080]             ; work
4456  mov    dx, 0x1e
4459  mul    dx
445b  mov    di, ax
445d  mov    dx, word ptr [di - 0x5048]        ; +mummies
4461  mov    ax, word ptr [0xb058]             ; player_x
4464  sub    ax, dx
4466  imul   cx
4468  or     ax, ax
446a  jge    0x448c
446c  mov    ax, word ptr [0xb080]             ; work
446f  mov    dx, 0x1e
4472  mul    dx
4474  mov    di, ax
4476  mov    ax, word ptr [di - 0x503e]
447a  neg    ax
447c  mov    cx, ax
447e  mov    ax, word ptr [0xb080]             ; work
4481  mov    dx, 0x1e
4484  mul    dx
4486  mov    di, ax
4488  mov    word ptr [di - 0x503e], cx
  loc_448c:
448c  mov    ax, word ptr [0xb080]             ; work
448f  mov    dx, 0x1e
4492  mul    dx
4494  mov    di, ax
4496  mov    word ptr [di - 0x503c], 0xffff
449c  mov    ax, word ptr [0xb080]             ; work
449f  mov    dx, 0x1e
44a2  mul    dx
44a4  mov    di, ax
44a6  mov    byte ptr [di - 0x5038], 0x4d
44ab  mov    al, byte ptr [0xa3b2]             ; loop_k
44ae  xor    ah, ah
44b0  mov    bx, ax
44b2  mov    al, byte ptr [0xa3b1]             ; loop_j
44b5  xor    ah, ah
44b7  mov    dx, 0x19
44ba  mul    dx
44bc  mov    cx, ax
44be  mov    al, byte ptr [0xa3b0]             ; loop_i
44c1  xor    ah, ah
44c3  mov    dx, 0x226
44c6  mul    dx
44c8  mov    di, ax
44ca  add    di, cx
44cc  add    di, bx
44ce  mov    byte ptr [di - 0x4a70], 0x49      ; +rooms
44d3  mov    ax, word ptr [0xb080]             ; work
44d6  mov    dx, 0x1e
44d9  mul    dx
44db  mov    di, ax
44dd  mov    byte ptr [di - 0x5037], 0
  loc_44e2:
44e2  cmp    byte ptr [0xa3b2], 0x17           ; loop_k
44e7  je     0x44ec
44e9  jmp    0x41b7
  loc_44ec:
44ec  cmp    byte ptr [0xa3b1], 0x13           ; loop_j
44f1  je     0x44f6
44f3  jmp    0x41ac
  loc_44f6:
44f6  mov    al, byte ptr [0xa3b0]             ; loop_i
44f9  cmp    al, byte ptr [bp - 1]
44fc  je     0x4501
44fe  jmp    0x41a1
  loc_4501:
4501  mov    al, byte ptr [0xa3c9]             ; start_room
4504  mov    byte ptr [0xa3c5], al             ; cur_room
4507  cmp    byte ptr [0xcb10], 0              ; show_stage_intro
450c  jne    0x4511
450e  jmp    0x4603
  loc_4511:
4511  mov    al, byte ptr [0xa3bc]             ; stage
4514  xor    ah, ah
4516  xor    dx, dx
4518  push   dx
4519  push   ax
451a  xor    ax, ax
451c  push   ax
451d  mov    di, 0xb090                        ; &text_buf
4520  push   ds
4521  push   di
4522  mov    ax, 0xff
4525  push   ax
4526  call   Sys_StrLong
452b  cmp    byte ptr [0xa3bc], 0xa            ; stage
4530  jae    0x455a
4532  lea    di, [bp - 0x100]
4536  push   ss
4537  push   di
4538  mov    di, 0x3972                        ; cs:'0'
453b  push   cs
453c  push   di
453d  call   Sys_StrAssign
4542  mov    di, 0xb090                        ; &text_buf
4545  push   ds
4546  push   di
4547  call   Sys_StrConcat
454c  mov    di, 0xb090                        ; &text_buf
454f  push   ds
4550  push   di
4551  mov    ax, 0xff
4554  push   ax
4555  call   Sys_StrStore
  loc_455a:
455a  mov    ax, 0xa
455d  push   ax
455e  mov    ax, 9
4561  push   ax
4562  lea    di, [bp - 0x100]
4566  push   ss
4567  push   di
4568  mov    di, 0x3974                        ; cs:' stage  '
456b  push   cs
456c  push   di
456d  call   Sys_StrAssign
4572  mov    di, 0xb090                        ; &text_buf
4575  push   ds
4576  push   di
4577  call   Sys_StrConcat
457c  call   draw_text
4581  mov    al, byte ptr [0xa3bd]             ; stones_left
4584  xor    ah, ah
4586  xor    dx, dx
4588  push   dx
4589  push   ax
458a  xor    ax, ax
458c  push   ax
458d  mov    di, 0xb090                        ; &text_buf
4590  push   ds
4591  push   di
4592  mov    ax, 0xff
4595  push   ax
4596  call   Sys_StrLong
459b  cmp    byte ptr [0xa3bd], 0xa            ; stones_left
45a0  jae    0x45ca
45a2  lea    di, [bp - 0x100]
45a6  push   ss
45a7  push   di
45a8  mov    di, 0x3972                        ; cs:'0'
45ab  push   cs
45ac  push   di
45ad  call   Sys_StrAssign
45b2  mov    di, 0xb090                        ; &text_buf
45b5  push   ds
45b6  push   di
45b7  call   Sys_StrConcat
45bc  mov    di, 0xb090                        ; &text_buf
45bf  push   ds
45c0  push   di
45c1  mov    ax, 0xff
45c4  push   ax
45c5  call   Sys_StrStore
  loc_45ca:
45ca  mov    ax, 8
45cd  push   ax
45ce  mov    ax, 0xd
45d1  push   ax
45d2  lea    di, [bp - 0x100]
45d6  push   ss
45d7  push   di
45d8  mov    di, 0x397d                        ; cs:'soul stones  '
45db  push   cs
45dc  push   di
45dd  call   Sys_StrAssign
45e2  mov    di, 0xb090                        ; &text_buf
45e5  push   ds
45e6  push   di
45e7  call   Sys_StrConcat
45ec  call   draw_text
45f1  mov    byte ptr [0xcb10], 0              ; show_stage_intro
45f6  call   Crt_ReadKey
45fb  mov    byte ptr [0xb08e], al             ; last_key
45fe  call   Graph_ClearViewPort
  loc_4603:
4603  mov    byte ptr [0xa3b1], 0              ; loop_j
4608  jmp    0x460e
  loc_460a:
460a  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_460e:
460e  mov    byte ptr [0xa3b2], 0              ; loop_k
4613  jmp    0x4619
  loc_4615:
4615  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_4619:
4619  mov    al, byte ptr [0xa3b1]             ; loop_j
461c  xor    ah, ah
461e  mov    cx, 5
4621  shl    ax, cl
4623  mov    word ptr [0xb082], ax             ; cell_x
4626  mov    al, byte ptr [0xa3b2]             ; loop_k
4629  xor    ah, ah
462b  mov    cx, 3
462e  shl    ax, cl
4630  mov    word ptr [0xb084], ax             ; cell_y
4633  mov    al, byte ptr [0xa3b2]             ; loop_k
4636  xor    ah, ah
4638  mov    bx, ax
463a  mov    al, byte ptr [0xa3b1]             ; loop_j
463d  xor    ah, ah
463f  mov    dx, 0x19
4642  mul    dx
4644  mov    cx, ax
4646  mov    al, byte ptr [0xa3c5]             ; cur_room
4649  xor    ah, ah
464b  mov    dx, 0x226
464e  mul    dx
4650  mov    di, ax
4652  add    di, cx
4654  add    di, bx
4656  cmp    byte ptr [di - 0x4a70], 0         ; +rooms
465b  jne    0x46a5
465d  mov    al, byte ptr [0xa3b1]             ; loop_j
4660  xor    ah, ah
4662  mov    cx, 5
4665  shl    ax, cl
4667  add    ax, 0x10
466a  mov    word ptr [0xb058], ax             ; player_x
466d  mov    al, byte ptr [0xa3b2]             ; loop_k
4670  xor    ah, ah
4672  mov    cx, 3
4675  shl    ax, cl
4677  add    ax, 8
467a  mov    word ptr [0xb05a], ax             ; player_y
467d  mov    al, byte ptr [0xa3b2]             ; loop_k
4680  xor    ah, ah
4682  mov    bx, ax
4684  mov    al, byte ptr [0xa3b1]             ; loop_j
4687  xor    ah, ah
4689  mov    dx, 0x19
468c  mul    dx
468e  mov    cx, ax
4690  mov    al, byte ptr [0xa3c5]             ; cur_room
4693  xor    ah, ah
4695  mov    dx, 0x226
4698  mul    dx
469a  mov    di, ax
469c  add    di, cx
469e  add    di, bx
46a0  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
  loc_46a5:
46a5  mov    al, byte ptr [0xa3b2]             ; loop_k
46a8  xor    ah, ah
46aa  mov    bx, ax
46ac  mov    al, byte ptr [0xa3b1]             ; loop_j
46af  xor    ah, ah
46b1  mov    dx, 0x19
46b4  mul    dx
46b6  mov    cx, ax
46b8  mov    al, byte ptr [0xa3c5]             ; cur_room
46bb  xor    ah, ah
46bd  mov    dx, 0x226
46c0  mul    dx
46c2  mov    di, ax
46c4  add    di, cx
46c6  add    di, bx
46c8  cmp    byte ptr [di - 0x4a70], 0x64      ; +rooms
46cd  jae    0x4717
46cf  push   word ptr [0xb082]                 ; cell_x
46d3  push   word ptr [0xb084]                 ; cell_y
46d7  mov    al, byte ptr [0xa3b2]             ; loop_k
46da  xor    ah, ah
46dc  mov    bx, ax
46de  mov    al, byte ptr [0xa3b1]             ; loop_j
46e1  xor    ah, ah
46e3  mov    dx, 0x19
46e6  mul    dx
46e8  mov    cx, ax
46ea  mov    al, byte ptr [0xa3c5]             ; cur_room
46ed  xor    ah, ah
46ef  mov    dx, 0x226
46f2  mul    dx
46f4  mov    di, ax
46f6  add    di, cx
46f8  add    di, bx
46fa  mov    al, byte ptr [di - 0x4a70]        ; +rooms
46fe  xor    ah, ah
4700  mov    dx, 0x54
4703  mul    dx
4705  mov    di, ax
4707  add    di, 0x69ec
470b  push   ds
470c  push   di
470d  xor    ax, ax
470f  push   ax
4710  call   Graph_PutImage
4715  jmp    0x477b
  loc_4717:
4717  mov    al, byte ptr [0xa3b2]             ; loop_k
471a  xor    ah, ah
471c  mov    bx, ax
471e  mov    al, byte ptr [0xa3b1]             ; loop_j
4721  xor    ah, ah
4723  mov    dx, 0x19
4726  mul    dx
4728  mov    cx, ax
472a  mov    al, byte ptr [0xa3c5]             ; cur_room
472d  xor    ah, ah
472f  mov    dx, 0x226
4732  mul    dx
4734  mov    di, ax
4736  add    di, cx
4738  add    di, bx
473a  mov    al, byte ptr [di - 0x4a70]        ; +rooms
473e  xor    ah, ah
4740  cmp    ax, 0x6f
4743  jne    0x475c
4745  push   word ptr [0xb082]                 ; cell_x
4749  push   word ptr [0xb084]                 ; cell_y
474d  mov    di, 0x7afc
4750  push   ds
4751  push   di
4752  xor    ax, ax
4754  push   ax
4755  call   Graph_PutImage
475a  jmp    0x477b
  loc_475c:
475c  cmp    ax, 0xaf
475f  je     0x4766
4761  cmp    ax, 0xde
4764  jne    0x477b
  loc_4766:
4766  push   word ptr [0xb082]                 ; cell_x
476a  push   word ptr [0xb084]                 ; cell_y
476e  mov    di, 0xa358
4771  push   ds
4772  push   di
4773  xor    ax, ax
4775  push   ax
4776  call   Graph_PutImage
  loc_477b:
477b  cmp    byte ptr [0xa3b2], 0x17           ; loop_k
4780  je     0x4785
4782  jmp    0x4615
  loc_4785:
4785  cmp    byte ptr [0xa3b1], 0x13           ; loop_j
478a  je     0x478f
478c  jmp    0x460a
  loc_478f:
478f  mov    di, 0x398b                        ; cs:'stage     score           rest'
4792  push   cs
4793  push   di
4794  mov    di, 0xb090                        ; &text_buf
4797  push   ds
4798  push   di
4799  mov    ax, 0xff
479c  push   ax
479d  call   Sys_StrStore
47a2  mov    al, byte ptr [0xb090]             ; text_buf
47a5  mov    byte ptr [bp - 1], al
47a8  mov    al, 1
47aa  cmp    al, byte ptr [bp - 1]
47ad  ja     0x4805
47af  mov    byte ptr [0xa3b0], al             ; loop_i
47b2  jmp    0x47b8
  loc_47b4:
47b4  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_47b8:
47b8  mov    al, byte ptr [0xa3b0]             ; loop_i
47bb  xor    ah, ah
47bd  mov    di, ax
47bf  cmp    byte ptr [di - 0x4f70], 0x20      ; +text_buf
47c4  je     0x47fd
47c6  mov    al, byte ptr [0xa3b0]             ; loop_i
47c9  xor    ah, ah
47cb  mov    cx, 0x14
47ce  imul   cx
47d0  sub    ax, 0x14
47d3  push   ax
47d4  mov    ax, 0xc1
47d7  push   ax
47d8  mov    al, byte ptr [0xa3b0]             ; loop_i
47db  xor    ah, ah
47dd  mov    di, ax
47df  mov    al, byte ptr [di - 0x4f70]        ; +text_buf
47e3  xor    ah, ah
47e5  add    ax, 0x34
47e8  mov    dx, 0x54
47eb  mul    dx
47ed  mov    di, ax
47ef  add    di, 0x69ec
47f3  push   ds
47f4  push   di
47f5  xor    ax, ax
47f7  push   ax
47f8  call   Graph_PutImage
  loc_47fd:
47fd  mov    al, byte ptr [0xa3b0]             ; loop_i
4800  cmp    al, byte ptr [bp - 1]
4803  jne    0x47b4
  loc_4805:
4805  mov    al, 1
4807  push   ax
4808  call   draw_status_number
480d  mov    al, 2
480f  push   ax
4810  call   draw_status_number
4815  mov    al, 3
4817  push   ax
4818  call   draw_status_number
481d  mov    byte ptr [0xa3be], 0              ; held_item
4822  mov    byte ptr [0xa3bf], 0              ; facing_left
4827  mov    byte ptr [0xa3c4], 1              ; standing
482c  xor    ax, ax
482e  mov    word ptr [0xb080], ax             ; work
4831  mov    byte ptr [0xcb0c], 0              ; dagger_flying
4836  mov    ax, word ptr [0xb058]             ; player_x
4839  sub    ax, 0x10
483c  push   ax
483d  mov    ax, word ptr [0xb05a]             ; player_y
4840  sub    ax, 8
4843  push   ax
4844  mov    al, byte ptr [0xa3bf]             ; facing_left
4847  xor    ah, ah
4849  mov    dx, ax
484b  mov    al, byte ptr [0xa3be]             ; held_item
484e  xor    ah, ah
4850  add    ax, dx
4852  mov    dx, 0x54
4855  mul    dx
4857  mov    di, ax
4859  add    di, 0x69ec
485d  push   ds
485e  push   di
485f  xor    ax, ax
4861  push   ax
4862  call   Graph_PutImage
4867  mov    al, byte ptr [0xa3bf]             ; facing_left
486a  xor    ah, ah
486c  mov    dx, ax
486e  mov    al, byte ptr [0xa3be]             ; held_item
4871  xor    ah, ah
4873  add    ax, dx
4875  mov    byte ptr [0xa3c0], al             ; player_sprite
4878  xor    ax, ax
487a  mov    word ptr [0xb068], ax             ; walk_count
487d  mov    al, 8
487f  push   ax
4880  mov    di, 0xb03c                        ; &saved_int8
4883  push   ds
4884  push   di
4885  call   Dos_GetIntVec
488a  mov    al, 8
488c  push   ax
488d  mov    ax, 0x45
4890  mov    dx, 0x8e2                         ; seg GAMELIB
4893  push   dx
4894  push   ax
4895  call   Dos_SetIntVec
  loc_489a:
489a  call   Crt_KeyPressed
489f  or     al, al
48a1  je     0x48ab
48a3  call   Crt_ReadKey
48a8  mov    byte ptr [0xb08e], al             ; last_key
  loc_48ab:
48ab  inc    word ptr [0xb06e]                 ; frame_count
48af  mov    ax, word ptr [0xb06e]             ; frame_count
48b2  cdq
48b3  mov    cx, 6
48b6  idiv   cx
48b8  xchg   dx, ax
48b9  or     ax, ax
48bb  jne    0x48c2
48bd  call   move_mummies
  loc_48c2:
48c2  mov    ax, word ptr [0xb05a]             ; player_y
48c5  add    ax, 8
48c8  cdq
48c9  mov    cx, 8
48cc  idiv   cx
48ce  mov    bx, ax
48d0  mov    ax, word ptr [0xb058]             ; player_x
48d3  add    ax, 0xb
48d6  cdq
48d7  mov    cx, 0x20
48da  idiv   cx
48dc  mov    dx, 0x19
48df  mul    dx
48e1  mov    cx, ax
48e3  mov    al, byte ptr [0xa3c5]             ; cur_room
48e6  xor    ah, ah
48e8  mov    dx, 0x226
48eb  mul    dx
48ed  mov    di, ax
48ef  add    di, cx
48f1  add    di, bx
48f3  mov    al, byte ptr [di - 0x4a70]        ; +rooms
48f7  push   ax
48f8  mov    di, 0x39aa                        ; set cs:39aa = [30,33,34,35,56,73,85,86,87,88,100,156]
48fb  push   cs
48fc  push   di
48fd  call   Sys_SetIn
4902  jne    0x4907
4904  jmp    0x4c45
  loc_4907:
4907  mov    ax, word ptr [0xb05a]             ; player_y
490a  cdq
490b  mov    cx, 8
490e  idiv   cx
4910  mov    bx, ax
4912  mov    ax, word ptr [0xb058]             ; player_x
4915  add    ax, 0xb
4918  cdq
4919  mov    cx, 0x20
491c  idiv   cx
491e  mov    dx, 0x19
4921  mul    dx
4923  mov    cx, ax
4925  mov    al, byte ptr [0xa3c5]             ; cur_room
4928  xor    ah, ah
492a  mov    dx, 0x226
492d  mul    dx
492f  mov    di, ax
4931  add    di, cx
4933  add    di, bx
4935  mov    al, byte ptr [di - 0x4a70]        ; +rooms
4939  push   ax
493a  mov    di, 0x39aa                        ; set cs:39aa = [30,33,34,35,56,73,85,86,87,88,100,156]
493d  push   cs
493e  push   di
493f  call   Sys_SetIn
4944  jne    0x4949
4946  jmp    0x4c45
  loc_4949:
4949  mov    ax, word ptr [0xb05a]             ; player_y
494c  add    ax, 8
494f  cdq
4950  mov    cx, 8
4953  idiv   cx
4955  mov    bx, ax
4957  mov    ax, word ptr [0xb058]             ; player_x
495a  sub    ax, 0xb
495d  cdq
495e  mov    cx, 0x20
4961  idiv   cx
4963  mov    dx, 0x19
4966  mul    dx
4968  mov    cx, ax
496a  mov    al, byte ptr [0xa3c5]             ; cur_room
496d  xor    ah, ah
496f  mov    dx, 0x226
4972  mul    dx
4974  mov    di, ax
4976  add    di, cx
4978  add    di, bx
497a  mov    al, byte ptr [di - 0x4a70]        ; +rooms
497e  push   ax
497f  mov    di, 0x39aa                        ; set cs:39aa = [30,33,34,35,56,73,85,86,87,88,100,156]
4982  push   cs
4983  push   di
4984  call   Sys_SetIn
4989  jne    0x498e
498b  jmp    0x4c45
  loc_498e:
498e  mov    ax, word ptr [0xb05a]             ; player_y
4991  cdq
4992  mov    cx, 8
4995  idiv   cx
4997  mov    bx, ax
4999  mov    ax, word ptr [0xb058]             ; player_x
499c  sub    ax, 0xb
499f  cdq
49a0  mov    cx, 0x20
49a3  idiv   cx
49a5  mov    dx, 0x19
49a8  mul    dx
49aa  mov    cx, ax
49ac  mov    al, byte ptr [0xa3c5]             ; cur_room
49af  xor    ah, ah
49b1  mov    dx, 0x226
49b4  mul    dx
49b6  mov    di, ax
49b8  add    di, cx
49ba  add    di, bx
49bc  mov    al, byte ptr [di - 0x4a70]        ; +rooms
49c0  push   ax
49c1  mov    di, 0x39aa                        ; set cs:39aa = [30,33,34,35,56,73,85,86,87,88,100,156]
49c4  push   cs
49c5  push   di
49c6  call   Sys_SetIn
49cb  jne    0x49d0
49cd  jmp    0x4c45
  loc_49d0:
49d0  mov    word ptr [0xb080], 0xbb8          ; work
  loc_49d6:
49d6  sub    word ptr [0xb080], 0x32           ; work
49db  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
49e0  je     0x49e7
49e2  call   move_dagger
  loc_49e7:
49e7  push   word ptr [0xb080]                 ; work
49eb  call   Crt_Sound
49f0  mov    ax, 2
49f3  push   ax
49f4  call   Crt_Delay
49f9  call   check_pickup
49fe  inc    word ptr [0xb06e]                 ; frame_count
4a02  mov    ax, word ptr [0xb06e]             ; frame_count
4a05  cdq
4a06  mov    cx, 3
4a09  idiv   cx
4a0b  xchg   dx, ax
4a0c  or     ax, ax
4a0e  jne    0x4a15
4a10  call   move_mummies
  loc_4a15:
4a15  mov    ax, word ptr [0xb058]             ; player_x
4a18  sub    ax, 0x10
4a1b  push   ax
4a1c  mov    ax, word ptr [0xb05a]             ; player_y
4a1f  sub    ax, 8
4a22  push   ax
4a23  mov    al, byte ptr [0xa3c0]             ; player_sprite
4a26  xor    ah, ah
4a28  mov    dx, 0x54
4a2b  mul    dx
4a2d  mov    di, ax
4a2f  add    di, 0x69ec
4a33  push   ds
4a34  push   di
4a35  mov    ax, 1
4a38  push   ax
4a39  call   Graph_PutImage
4a3e  add    word ptr [0xb05a], 4              ; player_y
4a43  cmp    word ptr [0xb05a], 0xb4           ; player_y
4a49  jle    0x4a50
4a4b  call   check_room_change
  loc_4a50:
4a50  mov    al, byte ptr [0xa3bf]             ; facing_left
4a53  xor    ah, ah
4a55  mov    dx, ax
4a57  mov    al, byte ptr [0xa3be]             ; held_item
4a5a  xor    ah, ah
4a5c  add    ax, dx
4a5e  mov    byte ptr [0xa3c0], al             ; player_sprite
4a61  mov    ax, word ptr [0xb058]             ; player_x
4a64  sub    ax, 0x10
4a67  push   ax
4a68  mov    ax, word ptr [0xb05a]             ; player_y
4a6b  sub    ax, 8
4a6e  push   ax
4a6f  mov    al, byte ptr [0xa3c0]             ; player_sprite
4a72  xor    ah, ah
4a74  mov    dx, 0x54
4a77  mul    dx
4a79  mov    di, ax
4a7b  add    di, 0x69ec
4a7f  push   ds
4a80  push   di
4a81  mov    ax, 1
4a84  push   ax
4a85  call   Graph_PutImage
4a8a  call   Crt_KeyPressed
4a8f  or     al, al
4a91  je     0x4a9b
4a93  call   Crt_ReadKey
4a98  mov    byte ptr [0xb08e], al             ; last_key
  loc_4a9b:
4a9b  cmp    byte ptr [0xcb0f], 0              ; stone_falling
4aa0  jne    0x4aa5
4aa2  jmp    0x4b96
  loc_4aa5:
4aa5  mov    ax, word ptr [0xb08c]             ; stone_row
4aa8  add    ax, 2
4aab  mov    bx, ax
4aad  mov    ax, word ptr [0xb08a]             ; stone_col
4ab0  mov    dx, 0x19
4ab3  mul    dx
4ab5  mov    cx, ax
4ab7  mov    al, byte ptr [0xa3c8]             ; stone_room
4aba  xor    ah, ah
4abc  mov    dx, 0x226
4abf  mul    dx
4ac1  mov    di, ax
4ac3  add    di, cx
4ac5  add    di, bx
4ac7  cmp    byte ptr [di - 0x4a70], 0x64      ; +rooms
4acc  je     0x4ad1
4ace  jmp    0x4b5b
  loc_4ad1:
4ad1  mov    al, byte ptr [0xa3c8]             ; stone_room
4ad4  cmp    al, byte ptr [0xa3c5]             ; cur_room
4ad8  jne    0x4afa
4ada  mov    ax, word ptr [0xb08a]             ; stone_col
4add  mov    cx, 5
4ae0  shl    ax, cl
4ae2  push   ax
4ae3  mov    ax, word ptr [0xb08c]             ; stone_row
4ae6  mov    cx, 3
4ae9  shl    ax, cl
4aeb  push   ax
4aec  mov    di, 0x7a54
4aef  push   ds
4af0  push   di
4af1  mov    ax, 1
4af4  push   ax
4af5  call   Graph_PutImage
  loc_4afa:
4afa  inc    word ptr [0xb08c]                 ; stone_row
4afe  mov    ax, 0x3e8
4b01  push   ax
4b02  call   Crt_Sound
4b07  mov    ax, 2
4b0a  push   ax
4b0b  call   Crt_Delay
4b10  cmp    word ptr [0xb08c], 0x16           ; stone_row
4b15  jle    0x4b30
4b17  mov    di, 0xa3c8                        ; &stone_room
4b1a  push   ds
4b1b  push   di
4b1c  mov    di, 0xb086                        ; &old_x
4b1f  push   ds
4b20  push   di
4b21  mov    di, 0xb088                        ; &tmp_y
4b24  push   ds
4b25  push   di
4b26  call   move_to_next_room
4b2b  xor    ax, ax
4b2d  mov    word ptr [0xb08c], ax             ; stone_row
  loc_4b30:
4b30  mov    al, byte ptr [0xa3c8]             ; stone_room
4b33  cmp    al, byte ptr [0xa3c5]             ; cur_room
4b37  jne    0x4b59
4b39  mov    ax, word ptr [0xb08a]             ; stone_col
4b3c  mov    cx, 5
4b3f  shl    ax, cl
4b41  push   ax
4b42  mov    ax, word ptr [0xb08c]             ; stone_row
4b45  mov    cx, 3
4b48  shl    ax, cl
4b4a  push   ax
4b4b  mov    di, 0x7a54
4b4e  push   ds
4b4f  push   di
4b50  mov    ax, 1
4b53  push   ax
4b54  call   Graph_PutImage
  loc_4b59:
4b59  jmp    0x4b96
  loc_4b5b:
4b5b  mov    ax, word ptr [0xb08c]             ; stone_row
4b5e  mov    bx, ax
4b60  mov    ax, word ptr [0xb08a]             ; stone_col
4b63  mov    dx, 0x19
4b66  mul    dx
4b68  mov    cx, ax
4b6a  mov    al, byte ptr [0xa3c8]             ; stone_room
4b6d  xor    ah, ah
4b6f  mov    dx, 0x226
4b72  mul    dx
4b74  mov    di, ax
4b76  add    di, cx
4b78  add    di, bx
4b7a  mov    byte ptr [di - 0x4a70], 0x32      ; +rooms
4b7f  mov    byte ptr [0xcb0f], 0              ; stone_falling
4b84  mov    ax, 0x1e
4b87  push   ax
4b88  call   Crt_Sound
4b8d  mov    ax, 0x14
4b90  push   ax
4b91  call   Crt_Delay
  loc_4b96:
4b96  mov    ax, word ptr [0xb05a]             ; player_y
4b99  add    ax, 8
4b9c  cdq
4b9d  mov    cx, 8
4ba0  idiv   cx
4ba2  mov    bx, ax
4ba4  mov    ax, word ptr [0xb058]             ; player_x
4ba7  cdq
4ba8  mov    cx, 0x20
4bab  idiv   cx
4bad  mov    dx, 0x19
4bb0  mul    dx
4bb2  mov    cx, ax
4bb4  mov    al, byte ptr [0xa3c5]             ; cur_room
4bb7  xor    ah, ah
4bb9  mov    dx, 0x226
4bbc  mul    dx
4bbe  mov    di, ax
4bc0  add    di, cx
4bc2  add    di, bx
4bc4  mov    al, byte ptr [di - 0x4a70]        ; +rooms
4bc8  push   ax
4bc9  mov    di, 0x39ca                        ; set cs:39ca = [42,43,46,47,50,51,52,53,54,111,175,222]
4bcc  push   cs
4bcd  push   di
4bce  call   Sys_SetIn
4bd3  jne    0x4bd8
4bd5  jmp    0x49d6
  loc_4bd8:
4bd8  call   Crt_NoSound
4bdd  mov    ax, word ptr [0xb058]             ; player_x
4be0  sub    ax, 0x10
4be3  push   ax
4be4  mov    ax, word ptr [0xb05a]             ; player_y
4be7  sub    ax, 8
4bea  push   ax
4beb  mov    al, byte ptr [0xa3c0]             ; player_sprite
4bee  xor    ah, ah
4bf0  mov    dx, 0x54
4bf3  mul    dx
4bf5  mov    di, ax
4bf7  add    di, 0x69ec
4bfb  push   ds
4bfc  push   di
4bfd  mov    ax, 1
4c00  push   ax
4c01  call   Graph_PutImage
4c06  mov    ax, word ptr [0xb05a]             ; player_y
4c09  cdq
4c0a  mov    cx, 8
4c0d  idiv   cx
4c0f  mov    cx, 3
4c12  shl    ax, cl
4c14  mov    word ptr [0xb05a], ax             ; player_y
4c17  xor    ax, ax
4c19  mov    word ptr [0xb080], ax             ; work
4c1c  mov    ax, word ptr [0xb058]             ; player_x
4c1f  sub    ax, 0x10
4c22  push   ax
4c23  mov    ax, word ptr [0xb05a]             ; player_y
4c26  sub    ax, 8
4c29  push   ax
4c2a  mov    al, byte ptr [0xa3c0]             ; player_sprite
4c2d  xor    ah, ah
4c2f  mov    dx, 0x54
4c32  mul    dx
4c34  mov    di, ax
4c36  add    di, 0x69ec
4c3a  push   ds
4c3b  push   di
4c3c  mov    ax, 1
4c3f  push   ax
4c40  call   Graph_PutImage
  loc_4c45:
4c45  mov    al, byte ptr [0xa3b7]             ; scan_code
4c48  push   ax
4c49  mov    di, 0x39ea                        ; set cs:39ea = [75,77]
4c4c  push   cs
4c4d  push   di
4c4e  call   Sys_SetIn
4c53  jne    0x4c63
4c55  cmp    byte ptr [0xa3b7], 0xb9           ; scan_code
4c5a  jne    0x4c85
4c5c  cmp    byte ptr [0xa3c4], 0              ; standing
4c61  jne    0x4c85
  loc_4c63:
4c63  cmp    byte ptr [0xa3b7], 0x4b           ; scan_code
4c68  je     0x4c78
4c6a  cmp    byte ptr [0xa3b7], 0xb9           ; scan_code
4c6f  jne    0x4c7e
4c71  cmp    byte ptr [0xa3bf], 1              ; facing_left
4c76  jne    0x4c7e
  loc_4c78:
4c78  push   cs
4c79  call   walk_left
4c7c  jmp    0x4c82
  loc_4c7e:
4c7e  push   cs
4c7f  call   walk_right
  loc_4c82:
4c82  jmp    0x5a3c
  loc_4c85:
4c85  mov    al, byte ptr [0xa3b7]             ; scan_code
4c88  xor    ah, ah
4c8a  cmp    ax, 0x48
4c8d  je     0x4c92
4c8f  jmp    0x4d2a
  loc_4c92:
4c92  mov    ax, word ptr [0xb05a]             ; player_y
4c95  add    ax, 7
4c98  cdq
4c99  mov    cx, 8
4c9c  idiv   cx
4c9e  mov    bx, ax
4ca0  mov    ax, word ptr [0xb058]             ; player_x
4ca3  cdq
4ca4  mov    cx, 0x20
4ca7  idiv   cx
4ca9  mov    dx, 0x19
4cac  mul    dx
4cae  mov    cx, ax
4cb0  mov    al, byte ptr [0xa3c5]             ; cur_room
4cb3  xor    ah, ah
4cb5  mov    dx, 0x226
4cb8  mul    dx
4cba  mov    di, ax
4cbc  add    di, cx
4cbe  add    di, bx
4cc0  mov    al, byte ptr [di - 0x4a70]        ; +rooms
4cc4  push   ax
4cc5  mov    di, 0x3a0a                        ; set cs:3a0a = [51,52,101,102,111,151,152,161,175,201,202,251,252]
4cc8  push   cs
4cc9  push   di
4cca  call   Sys_SetIn
4ccf  jne    0x4d0d
4cd1  mov    ax, word ptr [0xb05a]             ; player_y
4cd4  cdq
4cd5  mov    cx, 8
4cd8  idiv   cx
4cda  mov    bx, ax
4cdc  mov    ax, word ptr [0xb058]             ; player_x
4cdf  cdq
4ce0  mov    cx, 0x20
4ce3  idiv   cx
4ce5  mov    dx, 0x19
4ce8  mul    dx
4cea  mov    cx, ax
4cec  mov    al, byte ptr [0xa3c5]             ; cur_room
4cef  xor    ah, ah
4cf1  mov    dx, 0x226
4cf4  mul    dx
4cf6  mov    di, ax
4cf8  add    di, cx
4cfa  add    di, bx
4cfc  mov    al, byte ptr [di - 0x4a70]        ; +rooms
4d00  push   ax
4d01  mov    di, 0x3a0a                        ; set cs:3a0a = [51,52,101,102,111,151,152,161,175,201,202,251,252]
4d04  push   cs
4d05  push   di
4d06  call   Sys_SetIn
4d0b  je     0x4d13
  loc_4d0d:
4d0d  push   cs
4d0e  call   climb_up
4d11  jmp    0x4d27
  loc_4d13:
4d13  mov    ax, 7
4d16  push   ax
4d17  call   Crt_Delay
4d1c  cmp    byte ptr [0xcb16], 0              ; ladder_leave
4d21  je     0x4d27
4d23  push   cs
4d24  call   remove_used_ladder
  loc_4d27:
4d27  jmp    0x5a3c
  loc_4d2a:
4d2a  cmp    ax, 0x50
4d2d  jne    0x4d82
4d2f  mov    ax, word ptr [0xb05a]             ; player_y
4d32  add    ax, 9
4d35  cdq
4d36  mov    cx, 8
4d39  idiv   cx
4d3b  mov    bx, ax
4d3d  mov    ax, word ptr [0xb058]             ; player_x
4d40  cdq
4d41  mov    cx, 0x20
4d44  idiv   cx
4d46  mov    dx, 0x19
4d49  mul    dx
4d4b  mov    cx, ax
4d4d  mov    al, byte ptr [0xa3c5]             ; cur_room
4d50  xor    ah, ah
4d52  mov    dx, 0x226
4d55  mul    dx
4d57  mov    di, ax
4d59  add    di, cx
4d5b  add    di, bx
4d5d  mov    al, byte ptr [di - 0x4a70]        ; +rooms
4d61  push   ax
4d62  mov    di, 0x3a2a                        ; set cs:3a2a = [50,53,54,175]
4d65  push   cs
4d66  push   di
4d67  call   Sys_SetIn
4d6c  jne    0x4d74
4d6e  push   cs
4d6f  call   climb_down
4d72  jmp    0x4d7f
  loc_4d74:
4d74  cmp    byte ptr [0xcb16], 0              ; ladder_leave
4d79  je     0x4d7f
4d7b  push   cs
4d7c  call   remove_used_ladder
  loc_4d7f:
4d7f  jmp    0x5a3c
  loc_4d82:
4d82  cmp    ax, 0x3b
4d85  jne    0x4ddd
4d87  mov    al, 8
4d89  push   ax
4d8a  push   word ptr [0xb03e]
4d8e  push   word ptr [0xb03c]                 ; saved_int8
4d92  call   Dos_SetIntVec
4d97  call   Crt_NoSound
4d9c  call   Crt_ReadKey
4da1  mov    byte ptr [0xb08e], al             ; last_key
  loc_4da4:
4da4  call   Crt_ReadKey
4da9  or     al, al
4dab  jne    0x4da4
4dad  call   Crt_ReadKey
4db2  cmp    al, 0x3b
4db4  jne    0x4da4
  loc_4db6:
4db6  cmp    byte ptr [0xa3b7], 0x3b           ; scan_code
4dbb  je     0x4db6
4dbd  mov    al, 8
4dbf  push   ax
4dc0  mov    di, 0xb03c                        ; &saved_int8
4dc3  push   ds
4dc4  push   di
4dc5  call   Dos_GetIntVec
4dca  mov    al, 8
4dcc  push   ax
4dcd  mov    ax, 0x45
4dd0  mov    dx, 0x8e2                         ; seg GAMELIB
4dd3  push   dx
4dd4  push   ax
4dd5  call   Dos_SetIntVec
4dda  jmp    0x5a3c
  loc_4ddd:
4ddd  cmp    ax, 0x3c
4de0  je     0x4de5
4de2  jmp    0x4f55
  loc_4de5:
4de5  mov    al, 8
4de7  push   ax
4de8  push   word ptr [0xb03e]
4dec  push   word ptr [0xb03c]                 ; saved_int8
4df0  call   Dos_SetIntVec
4df5  call   Crt_NoSound
4dfa  call   Crt_ReadKey
4dff  mov    byte ptr [0xb08e], al             ; last_key
4e02  mov    ax, 0xb800
4e05  push   ax
4e06  xor    di, di
4e08  pop    es
4e09  push   es
4e0a  push   di
4e0b  mov    di, 0x2968
4e0e  push   ds
4e0f  push   di
4e10  mov    ax, 0x3f48
4e13  push   ax
4e14  call   Sys_Move
4e19  call   Graph_ClearDevice
4e1e  mov    byte ptr [0xa3b0], 1              ; loop_i
4e23  jmp    0x4e29
  loc_4e25:
4e25  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_4e29:
4e29  mov    al, byte ptr [0xa3b0]             ; loop_i
4e2c  xor    ah, ah
4e2e  mov    di, ax
4e30  mov    al, byte ptr [di - 0x463d]        ; +room_grid
4e34  push   ax
4e35  mov    di, 0x3952                        ; set cs:3952 = [1,2,3,4,5,6,7,8,9]
4e38  push   cs
4e39  push   di
4e3a  call   Sys_SetIn
4e3f  je     0x4e9c
4e41  mov    al, byte ptr [0xa3b0]             ; loop_i
4e44  xor    ah, ah
4e46  dec    ax
4e47  cdq
4e48  mov    cx, 3
4e4b  idiv   cx
4e4d  xchg   dx, ax
4e4e  mov    cx, 0x96
4e51  imul   cx
4e53  add    ax, 0x64
4e56  push   ax
4e57  mov    al, byte ptr [0xa3b0]             ; loop_i
4e5a  xor    ah, ah
4e5c  dec    ax
4e5d  cdq
4e5e  mov    cx, 3
4e61  idiv   cx
4e63  mov    cx, 0x3c
4e66  imul   cx
4e68  add    ax, 0xa
4e6b  push   ax
4e6c  mov    al, byte ptr [0xa3b0]             ; loop_i
4e6f  xor    ah, ah
4e71  dec    ax
4e72  cdq
4e73  mov    cx, 3
4e76  idiv   cx
4e78  xchg   dx, ax
4e79  mov    cx, 0x96
4e7c  imul   cx
4e7e  add    ax, 0xfa
4e81  push   ax
4e82  mov    al, byte ptr [0xa3b0]             ; loop_i
4e85  xor    ah, ah
4e87  dec    ax
4e88  cdq
4e89  mov    cx, 3
4e8c  idiv   cx
4e8e  mov    cx, 0x3c
4e91  imul   cx
4e93  add    ax, 0x46
4e96  push   ax
4e97  call   Graph_Rectangle
  loc_4e9c:
4e9c  cmp    byte ptr [0xa3b0], 9              ; loop_i
4ea1  jne    0x4e25
4ea3  mov    byte ptr [0xa3b0], 1              ; loop_i
4ea8  jmp    0x4eae
  loc_4eaa:
4eaa  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_4eae:
4eae  mov    al, byte ptr [0xa3b0]             ; loop_i
4eb1  xor    ah, ah
4eb3  mov    di, ax
4eb5  mov    al, byte ptr [di - 0x463d]        ; +room_grid
4eb9  cmp    al, byte ptr [0xa3c5]             ; cur_room
4ebd  jne    0x4ec5
4ebf  mov    al, byte ptr [0xa3b0]             ; loop_i
4ec2  mov    byte ptr [0xa3c1], al             ; scratch
  loc_4ec5:
4ec5  cmp    byte ptr [0xa3b0], 9              ; loop_i
4eca  jne    0x4eaa
4ecc  mov    al, byte ptr [0xa3c1]             ; scratch
4ecf  xor    ah, ah
4ed1  dec    ax
4ed2  cdq
4ed3  mov    cx, 3
4ed6  idiv   cx
4ed8  xchg   dx, ax
4ed9  mov    cx, 0x96
4edc  imul   cx
4ede  add    ax, 0xa0
4ee1  push   ax
4ee2  mov    al, byte ptr [0xa3c1]             ; scratch
4ee5  xor    ah, ah
4ee7  dec    ax
4ee8  cdq
4ee9  mov    cx, 3
4eec  idiv   cx
4eee  mov    cx, 0x3c
4ef1  imul   cx
4ef3  add    ax, 0x20
4ef6  push   ax
4ef7  mov    di, 0x69ec                        ; &sprites
4efa  push   ds
4efb  push   di
4efc  mov    ax, 1
4eff  push   ax
4f00  call   Graph_PutImage
  loc_4f05:
4f05  call   Crt_ReadKey
4f0a  or     al, al
4f0c  jne    0x4f05
4f0e  call   Crt_ReadKey
4f13  cmp    al, 0x3c
4f15  jne    0x4f05
  loc_4f17:
4f17  cmp    byte ptr [0xa3b7], 0x3c           ; scan_code
4f1c  je     0x4f17
4f1e  mov    di, 0x2968
4f21  push   ds
4f22  push   di
4f23  mov    ax, 0xb800
4f26  push   ax
4f27  xor    di, di
4f29  pop    es
4f2a  push   es
4f2b  push   di
4f2c  mov    ax, 0x3f48
4f2f  push   ax
4f30  call   Sys_Move
4f35  mov    al, 8
4f37  push   ax
4f38  mov    di, 0xb03c                        ; &saved_int8
4f3b  push   ds
4f3c  push   di
4f3d  call   Dos_GetIntVec
4f42  mov    al, 8
4f44  push   ax
4f45  mov    ax, 0x45
4f48  mov    dx, 0x8e2                         ; seg GAMELIB
4f4b  push   dx
4f4c  push   ax
4f4d  call   Dos_SetIntVec
4f52  jmp    0x5a3c
  loc_4f55:
4f55  cmp    ax, 0x3d
4f58  je     0x4f5d
4f5a  jmp    0x5081
  loc_4f5d:
4f5d  cmp    word ptr [0xb066], 0x2c7          ; tune_len
4f63  jne    0x4fdf
4f65  mov    byte ptr [0xa3b2], 0              ; loop_k
4f6a  xor    ax, ax
4f6c  mov    word ptr [0xb07e], ax             ; tune_pos
4f6f  mov    byte ptr [0xa3b1], 0              ; loop_j
4f74  mov    byte ptr [0xa3b0], 1              ; loop_i
4f79  jmp    0x4f7f
  loc_4f7b:
4f7b  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_4f7f:
4f7f  mov    al, byte ptr [0xa3b0]             ; loop_i
4f82  xor    ah, ah
4f84  shl    ax, 1
4f86  mov    di, ax
4f88  shl    di, 1
4f8a  mov    al, byte ptr [di + 0x21e]
4f8e  mov    byte ptr [bp - 1], al
4f91  mov    al, 1
4f93  cmp    al, byte ptr [bp - 1]
4f96  ja     0x4fca
4f98  mov    byte ptr [0xa3b1], al             ; loop_j
4f9b  jmp    0x4fa1
  loc_4f9d:
4f9d  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_4fa1:
4fa1  mov    al, byte ptr [0xa3b0]             ; loop_i
4fa4  xor    ah, ah
4fa6  shl    ax, 1
4fa8  dec    ax
4fa9  mov    di, ax
4fab  shl    di, 1
4fad  mov    dx, word ptr [di + 0x21e]
4fb1  mov    al, byte ptr [0xa3b2]             ; loop_k
4fb4  xor    ah, ah
4fb6  mov    di, ax
4fb8  shl    di, 1
4fba  mov    word ptr [di - 0x5c34], dx        ; +tune
4fbe  inc    byte ptr [0xa3b2]                 ; loop_k
4fc2  mov    al, byte ptr [0xa3b1]             ; loop_j
4fc5  cmp    al, byte ptr [bp - 1]
4fc8  jne    0x4f9d
  loc_4fca:
4fca  cmp    byte ptr [0xa3b0], 0x12           ; loop_i
4fcf  jne    0x4f7b
4fd1  mov    word ptr [0xb066], 0x20           ; tune_len
4fd7  mov    byte ptr [0xa3b7], 0xa            ; scan_code
4fdc  jmp    0x507e
  loc_4fdf:
4fdf  cmp    word ptr [0xb066], 0x20           ; tune_len
4fe4  je     0x4fe9
4fe6  jmp    0x507e
  loc_4fe9:
4fe9  mov    word ptr [0xb066], 0x2c7          ; tune_len
4fef  xor    ax, ax
4ff1  mov    word ptr [0xb086], ax             ; old_x
4ff4  xor    ax, ax
4ff6  mov    word ptr [0xb07e], ax             ; tune_pos
4ff9  mov    byte ptr [0xa3b0], 1              ; loop_i
4ffe  jmp    0x5004
  loc_5000:
5000  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_5004:
5004  mov    al, byte ptr [0xa3b0]             ; loop_i
5007  xor    ah, ah
5009  shl    ax, 1
500b  mov    di, ax
500d  shl    di, 1
500f  mov    al, byte ptr [di - 2]
5013  mov    byte ptr [bp - 1], al
5016  mov    al, 1
5018  cmp    al, byte ptr [bp - 1]
501b  ja     0x5072
501d  mov    byte ptr [0xa3b2], al             ; loop_k
5020  jmp    0x5026
  loc_5022:
5022  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_5026:
5026  mov    al, byte ptr [0xa3b2]             ; loop_k
5029  shr    al, 1
502b  jae    0x5049
502d  mov    al, byte ptr [0xa3b0]             ; loop_i
5030  xor    ah, ah
5032  shl    ax, 1
5034  dec    ax
5035  mov    di, ax
5037  shl    di, 1
5039  mov    ax, word ptr [di - 2]
503d  mov    di, word ptr [0xb086]             ; old_x
5041  shl    di, 1
5043  mov    word ptr [di - 0x5c34], ax        ; +tune
5047  jmp    0x5066
  loc_5049:
5049  mov    al, byte ptr [0xa3b0]             ; loop_i
504c  xor    ah, ah
504e  shl    ax, 1
5050  dec    ax
5051  mov    di, ax
5053  shl    di, 1
5055  mov    ax, word ptr [di - 2]
5059  sub    ax, 5
505c  mov    di, word ptr [0xb086]             ; old_x
5060  shl    di, 1
5062  mov    word ptr [di - 0x5c34], ax        ; +tune
  loc_5066:
5066  inc    word ptr [0xb086]                 ; old_x
506a  mov    al, byte ptr [0xa3b2]             ; loop_k
506d  cmp    al, byte ptr [bp - 1]
5070  jne    0x5022
  loc_5072:
5072  cmp    byte ptr [0xa3b0], 0x88           ; loop_i
5077  jne    0x5000
5079  mov    byte ptr [0xa3b7], 0xa            ; scan_code
  loc_507e:
507e  jmp    0x5a3c
  loc_5081:
5081  cmp    ax, 0x39
5084  je     0x5089
5086  jmp    0x5a32
  loc_5089:
5089  mov    al, byte ptr [0xa3be]             ; held_item
508c  xor    ah, ah
508e  cmp    ax, 0
5091  je     0x5096
5093  jmp    0x511b
  loc_5096:
5096  mov    ax, word ptr [0xb05a]             ; player_y
5099  sub    ax, 9
509c  cdq
509d  mov    cx, 8
50a0  idiv   cx
50a2  mov    bx, ax
50a4  mov    ax, word ptr [0xb058]             ; player_x
50a7  cdq
50a8  mov    cx, 0x20
50ab  idiv   cx
50ad  mov    dx, 0x19
50b0  mul    dx
50b2  mov    cx, ax
50b4  mov    al, byte ptr [0xa3c5]             ; cur_room
50b7  xor    ah, ah
50b9  mov    dx, 0x226
50bc  mul    dx
50be  mov    di, ax
50c0  add    di, cx
50c2  add    di, bx
50c4  mov    al, byte ptr [di - 0x4a70]        ; +rooms
50c8  push   ax
50c9  mov    di, 0x3a4a                        ; set cs:3a4a = [53,54]
50cc  push   cs
50cd  push   di
50ce  call   Sys_SetIn
50d3  je     0x5114
50d5  mov    ax, word ptr [0xb05a]             ; player_y
50d8  add    ax, 9
50db  cdq
50dc  mov    cx, 8
50df  idiv   cx
50e1  mov    bx, ax
50e3  mov    ax, word ptr [0xb058]             ; player_x
50e6  cdq
50e7  mov    cx, 0x20
50ea  idiv   cx
50ec  mov    dx, 0x19
50ef  mul    dx
50f1  mov    cx, ax
50f3  mov    al, byte ptr [0xa3c5]             ; cur_room
50f6  xor    ah, ah
50f8  mov    dx, 0x226
50fb  mul    dx
50fd  mov    di, ax
50ff  add    di, cx
5101  add    di, bx
5103  mov    al, byte ptr [di - 0x4a70]        ; +rooms
5107  push   ax
5108  mov    di, 0x3a6a                        ; set cs:3a6a = [51,52]
510b  push   cs
510c  push   di
510d  call   Sys_SetIn
5112  jne    0x5118
  loc_5114:
5114  push   cs
5115  call   jump
  loc_5118:
5118  jmp    0x5a30
  loc_511b:
511b  cmp    ax, 2
511e  je     0x5123
5120  jmp    0x531f
  loc_5123:
5123  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
5128  je     0x512d
512a  jmp    0x531c
  loc_512d:
512d  call   Crt_KeyPressed
5132  or     al, al
5134  je     0x513e
5136  call   Crt_ReadKey
513b  mov    byte ptr [0xb08e], al             ; last_key
  loc_513e:
513e  mov    byte ptr [0xcb0c], 1              ; dagger_flying
5143  mov    ax, word ptr [0xb058]             ; player_x
5146  sub    ax, 0x10
5149  push   ax
514a  mov    ax, word ptr [0xb05a]             ; player_y
514d  sub    ax, 8
5150  push   ax
5151  mov    al, byte ptr [0xa3c0]             ; player_sprite
5154  xor    ah, ah
5156  mov    dx, 0x54
5159  mul    dx
515b  mov    di, ax
515d  add    di, 0x69ec
5161  push   ds
5162  push   di
5163  mov    ax, 1
5166  push   ax
5167  call   Graph_PutImage
516c  mov    ax, word ptr [0xb058]             ; player_x
516f  sub    ax, 0x10
5172  push   ax
5173  mov    ax, word ptr [0xb05a]             ; player_y
5176  sub    ax, 8
5179  push   ax
517a  mov    al, byte ptr [0xa3bf]             ; facing_left
517d  xor    ah, ah
517f  add    ax, 2
5182  mov    dx, 0x54
5185  mul    dx
5187  mov    di, ax
5189  add    di, 0x69ec
518d  push   ds
518e  push   di
518f  mov    ax, 1
5192  push   ax
5193  call   Graph_PutImage
5198  mov    ax, 0x28
519b  push   ax
519c  call   Crt_Delay
51a1  mov    ax, word ptr [0xb058]             ; player_x
51a4  sub    ax, 0x10
51a7  push   ax
51a8  mov    ax, word ptr [0xb05a]             ; player_y
51ab  sub    ax, 8
51ae  push   ax
51af  mov    al, byte ptr [0xa3bf]             ; facing_left
51b2  xor    ah, ah
51b4  add    ax, 2
51b7  mov    dx, 0x54
51ba  mul    dx
51bc  mov    di, ax
51be  add    di, 0x69ec
51c2  push   ds
51c3  push   di
51c4  mov    ax, 1
51c7  push   ax
51c8  call   Graph_PutImage
51cd  mov    ax, word ptr [0xb058]             ; player_x
51d0  sub    ax, 0x10
51d3  push   ax
51d4  mov    ax, word ptr [0xb05a]             ; player_y
51d7  sub    ax, 8
51da  push   ax
51db  mov    al, byte ptr [0xa3bf]             ; facing_left
51de  xor    ah, ah
51e0  add    ax, 0x26
51e3  mov    dx, 0x54
51e6  mul    dx
51e8  mov    di, ax
51ea  add    di, 0x69ec
51ee  push   ds
51ef  push   di
51f0  mov    ax, 1
51f3  push   ax
51f4  call   Graph_PutImage
51f9  mov    ax, 0x46
51fc  push   ax
51fd  call   Crt_Delay
5202  mov    ax, word ptr [0xb058]             ; player_x
5205  sub    ax, 0x10
5208  push   ax
5209  mov    ax, word ptr [0xb05a]             ; player_y
520c  sub    ax, 8
520f  push   ax
5210  mov    al, byte ptr [0xa3bf]             ; facing_left
5213  xor    ah, ah
5215  add    ax, 0x26
5218  mov    dx, 0x54
521b  mul    dx
521d  mov    di, ax
521f  add    di, 0x69ec
5223  push   ds
5224  push   di
5225  mov    ax, 1
5228  push   ax
5229  call   Graph_PutImage
522e  mov    ax, word ptr [0xb058]             ; player_x
5231  sub    ax, 0x10
5234  push   ax
5235  mov    ax, word ptr [0xb05a]             ; player_y
5238  sub    ax, 8
523b  push   ax
523c  mov    al, byte ptr [0xa3bf]             ; facing_left
523f  xor    ah, ah
5241  add    ax, 2
5244  mov    dx, 0x54
5247  mul    dx
5249  mov    di, ax
524b  add    di, 0x69ec
524f  push   ds
5250  push   di
5251  mov    ax, 1
5254  push   ax
5255  call   Graph_PutImage
525a  mov    ax, 0x1e
525d  push   ax
525e  call   Crt_Delay
5263  mov    ax, word ptr [0xb058]             ; player_x
5266  sub    ax, 0x10
5269  push   ax
526a  mov    ax, word ptr [0xb05a]             ; player_y
526d  sub    ax, 8
5270  push   ax
5271  mov    al, byte ptr [0xa3bf]             ; facing_left
5274  xor    ah, ah
5276  add    ax, 2
5279  mov    dx, 0x54
527c  mul    dx
527e  mov    di, ax
5280  add    di, 0x69ec
5284  push   ds
5285  push   di
5286  mov    ax, 1
5289  push   ax
528a  call   Graph_PutImage
528f  mov    ax, word ptr [0xb058]             ; player_x
5292  sub    ax, 0x10
5295  push   ax
5296  mov    ax, word ptr [0xb05a]             ; player_y
5299  sub    ax, 8
529c  push   ax
529d  mov    al, byte ptr [0xa3bf]             ; facing_left
52a0  xor    ah, ah
52a2  mov    dx, 0x54
52a5  mul    dx
52a7  mov    di, ax
52a9  add    di, 0x69ec
52ad  push   ds
52ae  push   di
52af  mov    ax, 1
52b2  push   ax
52b3  call   Graph_PutImage
52b8  mov    al, byte ptr [0xa3bf]             ; facing_left
52bb  mov    byte ptr [0xa3c0], al             ; player_sprite
52be  xor    ax, ax
52c0  mov    word ptr [0xb064], ax             ; dagger_spin
52c3  mov    al, byte ptr [0xa3c5]             ; cur_room
52c6  mov    byte ptr [0xa3c6], al             ; dagger_room
52c9  xor    ax, ax
52cb  mov    word ptr [0xb062], ax             ; dagger_dy
52ce  mov    ax, word ptr [0xb05a]             ; player_y
52d1  sub    ax, 4
52d4  mov    word ptr [0xb05e], ax             ; dagger_y
52d7  mov    al, byte ptr [0xa3bf]             ; facing_left
52da  xor    ah, ah
52dc  shl    ax, 1
52de  dec    ax
52df  mov    word ptr [0xb060], ax             ; dagger_dx
52e2  mov    ax, word ptr [0xb060]             ; dagger_dx
52e5  mov    cx, 0xa
52e8  imul   cx
52ea  mov    dx, ax
52ec  mov    ax, word ptr [0xb058]             ; player_x
52ef  sub    ax, 0x10
52f2  sub    ax, dx
52f4  mov    word ptr [0xb05c], ax             ; dagger_x
52f7  mov    byte ptr [0xa3be], 0              ; held_item
52fc  xor    ax, ax
52fe  mov    word ptr [0xb064], ax             ; dagger_spin
5301  xor    ax, ax
5303  mov    word ptr [0xb06a], ax             ; dagger_stopped
5306  push   word ptr [0xb05c]                 ; dagger_x
530a  push   word ptr [0xb05e]                 ; dagger_y
530e  mov    di, 0x7ca0
5311  push   ds
5312  push   di
5313  mov    ax, 1
5316  push   ax
5317  call   Graph_PutImage
  loc_531c:
531c  jmp    0x5a30
  loc_531f:
531f  cmp    ax, 4
5322  je     0x532c
5324  cmp    ax, 8
5327  je     0x532c
5329  jmp    0x56d3
  loc_532c:
532c  mov    al, byte ptr [0xa3bf]             ; facing_left
532f  xor    ah, ah
5331  shl    ax, 1
5333  dec    ax
5334  mov    cx, 0x12
5337  imul   cx
5339  mov    dx, ax
533b  mov    ax, word ptr [0xb058]             ; player_x
533e  sub    ax, dx
5340  cdq
5341  mov    cx, 0x20
5344  idiv   cx
5346  mov    byte ptr [0xa3b5], al             ; probe_col
5349  mov    ax, word ptr [0xb05a]             ; player_y
534c  add    ax, 8
534f  cdq
5350  mov    cx, 8
5353  idiv   cx
5355  mov    byte ptr [0xa3b6], al             ; probe_row
5358  mov    word ptr [0xb080], 1              ; work
535e  mov    ax, 7
5361  push   ax
5362  call   Crt_Delay
5367  call   move_mummies
  loc_536c:
536c  mov    al, byte ptr [0xa3b6]             ; probe_row
536f  xor    ah, ah
5371  mov    bx, ax
5373  mov    al, byte ptr [0xa3b5]             ; probe_col
5376  xor    ah, ah
5378  mov    dx, 0x19
537b  mul    dx
537d  mov    cx, ax
537f  mov    al, byte ptr [0xa3c5]             ; cur_room
5382  xor    ah, ah
5384  mov    dx, 0x226
5387  mul    dx
5389  mov    di, ax
538b  add    di, cx
538d  add    di, bx
538f  cmp    byte ptr [di - 0x4a70], 0x35      ; +rooms
5394  je     0x5399
5396  jmp    0x5636
  loc_5399:
5399  cmp    word ptr [0xb080], 3              ; work
539e  jl     0x53a3
53a0  jmp    0x5636
  loc_53a3:
53a3  mov    ax, word ptr [0xb05a]             ; player_y
53a6  sub    ax, 6
53a9  cdq
53aa  mov    cx, 8
53ad  idiv   cx
53af  mov    bx, ax
53b1  mov    al, byte ptr [0xa3b5]             ; probe_col
53b4  xor    ah, ah
53b6  mov    dx, 0x19
53b9  mul    dx
53bb  mov    cx, ax
53bd  mov    al, byte ptr [0xa3c5]             ; cur_room
53c0  xor    ah, ah
53c2  mov    dx, 0x226
53c5  mul    dx
53c7  mov    di, ax
53c9  add    di, cx
53cb  add    di, bx
53cd  mov    al, byte ptr [di - 0x4a70]        ; +rooms
53d1  push   ax
53d2  mov    di, 0x3a8a                        ; set cs:3a8a = [30,33,34,35,56,87,88,100]
53d5  push   cs
53d6  push   di
53d7  call   Sys_SetIn
53dc  jne    0x53e1
53de  jmp    0x5636
  loc_53e1:
53e1  mov    ax, word ptr [0xb05a]             ; player_y
53e4  add    ax, 6
53e7  cdq
53e8  mov    cx, 8
53eb  idiv   cx
53ed  mov    bx, ax
53ef  mov    al, byte ptr [0xa3b5]             ; probe_col
53f2  xor    ah, ah
53f4  mov    dx, 0x19
53f7  mul    dx
53f9  mov    cx, ax
53fb  mov    al, byte ptr [0xa3c5]             ; cur_room
53fe  xor    ah, ah
5400  mov    dx, 0x226
5403  mul    dx
5405  mov    di, ax
5407  add    di, cx
5409  add    di, bx
540b  mov    al, byte ptr [di - 0x4a70]        ; +rooms
540f  push   ax
5410  mov    di, 0x3a8a                        ; set cs:3a8a = [30,33,34,35,56,87,88,100]
5413  push   cs
5414  push   di
5415  call   Sys_SetIn
541a  jne    0x541f
541c  jmp    0x5636
  loc_541f:
541f  cmp    word ptr [0xb080], 1              ; work
5424  jne    0x5486
5426  mov    ax, word ptr [0xb058]             ; player_x
5429  sub    ax, 0x10
542c  push   ax
542d  mov    ax, word ptr [0xb05a]             ; player_y
5430  sub    ax, 8
5433  push   ax
5434  mov    al, byte ptr [0xa3c0]             ; player_sprite
5437  xor    ah, ah
5439  mov    dx, 0x54
543c  mul    dx
543e  mov    di, ax
5440  add    di, 0x69ec
5444  push   ds
5445  push   di
5446  mov    ax, 1
5449  push   ax
544a  call   Graph_PutImage
544f  mov    al, byte ptr [0xa3bf]             ; facing_left
5452  xor    ah, ah
5454  mov    cx, 0xa
5457  imul   cx
5459  mov    dx, ax
545b  mov    ax, word ptr [0xb058]             ; player_x
545e  sub    ax, 0xe
5461  sub    ax, dx
5463  push   ax
5464  mov    ax, word ptr [0xb05a]             ; player_y
5467  sub    ax, 8
546a  push   ax
546b  mov    al, byte ptr [0xa3c0]             ; player_sprite
546e  xor    ah, ah
5470  mov    dx, 0x54
5473  mul    dx
5475  mov    di, ax
5477  add    di, 0x69ec
547b  push   ds
547c  push   di
547d  mov    ax, 1
5480  push   ax
5481  call   Graph_PutImage
  loc_5486:
5486  cmp    word ptr [0xb080], 2              ; work
548b  jne    0x5497
548d  cmp    byte ptr [0xa3be], 8              ; held_item
5492  jne    0x5497
5494  jmp    0x5636
  loc_5497:
5497  mov    byte ptr [0xa3b1], 1              ; loop_j
549c  jmp    0x54a2
  loc_549e:
549e  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_54a2:
54a2  mov    byte ptr [0xa3b2], 1              ; loop_k
54a7  jmp    0x54ad
  loc_54a9:
54a9  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_54ad:
54ad  mov    al, byte ptr [0xa3b2]             ; loop_k
54b0  xor    ah, ah
54b2  mov    cx, 5
54b5  imul   cx
54b7  push   ax
54b8  call   Crt_Sound
54bd  mov    ax, 2
54c0  push   ax
54c1  call   Crt_Delay
54c6  call   Crt_NoSound
54cb  mov    ax, 2
54ce  push   ax
54cf  call   Crt_Delay
54d4  mov    al, byte ptr [0xa3b2]             ; loop_k
54d7  xor    ah, ah
54d9  mov    cx, 0xa
54dc  imul   cx
54de  push   ax
54df  call   Crt_Sound
54e4  mov    ax, 1
54e7  push   ax
54e8  call   Crt_Delay
54ed  call   Crt_NoSound
54f2  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
54f7  je     0x5505
54f9  cmp    byte ptr [0xa3b2], 5              ; loop_k
54fe  jne    0x5505
5500  call   move_dagger
  loc_5505:
5505  cmp    byte ptr [0xa3b2], 5              ; loop_k
550a  jne    0x54a9
550c  mov    al, byte ptr [0xa3bf]             ; facing_left
550f  xor    ah, ah
5511  mov    cx, 0xa
5514  imul   cx
5516  mov    dx, ax
5518  mov    ax, word ptr [0xb058]             ; player_x
551b  sub    ax, 0xe
551e  sub    ax, dx
5520  push   ax
5521  mov    ax, word ptr [0xb05a]             ; player_y
5524  sub    ax, 8
5527  push   ax
5528  mov    al, byte ptr [0xa3c0]             ; player_sprite
552b  xor    ah, ah
552d  mov    dx, 0x54
5530  mul    dx
5532  mov    di, ax
5534  add    di, 0x69ec
5538  push   ds
5539  push   di
553a  mov    ax, 1
553d  push   ax
553e  call   Graph_PutImage
5543  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
5548  je     0x5551
554a  call   move_dagger
554f  jmp    0x555a
  loc_5551:
5551  mov    ax, 2
5554  push   ax
5555  call   Crt_Delay
  loc_555a:
555a  mov    al, byte ptr [0xa3be]             ; held_item
555d  xor    ah, ah
555f  mov    bx, ax
5561  mov    al, byte ptr [0xa3b1]             ; loop_j
5564  xor    ah, ah
5566  cdq
5567  mov    cx, 2
556a  idiv   cx
556c  xchg   dx, ax
556d  mov    dx, ax
556f  mov    al, byte ptr [0xa3bf]             ; facing_left
5572  xor    ah, ah
5574  shl    ax, 1
5576  add    ax, 0x3d
5579  add    ax, dx
557b  add    ax, bx
557d  mov    byte ptr [0xa3c0], al             ; player_sprite
5580  mov    al, byte ptr [0xa3bf]             ; facing_left
5583  xor    ah, ah
5585  mov    cx, 0xa
5588  imul   cx
558a  mov    dx, ax
558c  mov    ax, word ptr [0xb058]             ; player_x
558f  sub    ax, 0xe
5592  sub    ax, dx
5594  push   ax
5595  mov    ax, word ptr [0xb05a]             ; player_y
5598  sub    ax, 8
559b  push   ax
559c  mov    al, byte ptr [0xa3c0]             ; player_sprite
559f  xor    ah, ah
55a1  mov    dx, 0x54
55a4  mul    dx
55a6  mov    di, ax
55a8  add    di, 0x69ec
55ac  push   ds
55ad  push   di
55ae  mov    ax, 1
55b1  push   ax
55b2  call   Graph_PutImage
55b7  mov    al, byte ptr [0xa3b1]             ; loop_j
55ba  xor    ah, ah
55bc  cdq
55bd  mov    cx, 6
55c0  idiv   cx
55c2  xchg   dx, ax
55c3  or     ax, ax
55c5  jne    0x55f4
55c7  mov    al, byte ptr [0xa3b5]             ; probe_col
55ca  xor    ah, ah
55cc  mov    cx, 5
55cf  shl    ax, cl
55d1  push   ax
55d2  mov    al, byte ptr [0xa3b6]             ; probe_row
55d5  xor    ah, ah
55d7  mov    cx, 3
55da  shl    ax, cl
55dc  push   ax
55dd  mov    di, 0x7bf8
55e0  push   ds
55e1  push   di
55e2  mov    al, byte ptr [0xa3b1]             ; loop_j
55e5  xor    ah, ah
55e7  dec    ax
55e8  cdq
55e9  mov    cx, 6
55ec  idiv   cx
55ee  push   ax
55ef  call   Graph_PutImage
  loc_55f4:
55f4  mov    al, byte ptr [0xa3b6]             ; probe_row
55f7  xor    ah, ah
55f9  mov    bx, ax
55fb  mov    al, byte ptr [0xa3b5]             ; probe_col
55fe  xor    ah, ah
5600  mov    dx, 0x19
5603  mul    dx
5605  mov    cx, ax
5607  mov    al, byte ptr [0xa3c5]             ; cur_room
560a  xor    ah, ah
560c  mov    dx, 0x226
560f  mul    dx
5611  mov    di, ax
5613  add    di, cx
5615  add    di, bx
5617  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
561c  call   move_mummies
5621  cmp    byte ptr [0xa3b1], 0xc            ; loop_j
5626  je     0x562b
5628  jmp    0x549e
  loc_562b:
562b  inc    byte ptr [0xa3b6]                 ; probe_row
562f  inc    word ptr [0xb080]                 ; work
5633  jmp    0x536c
  loc_5636:
5636  cmp    word ptr [0xb080], 1              ; work
563b  jg     0x5640
563d  jmp    0x56d0
  loc_5640:
5640  mov    al, byte ptr [0xa3bf]             ; facing_left
5643  xor    ah, ah
5645  mov    cx, 0xa
5648  imul   cx
564a  mov    dx, ax
564c  mov    ax, word ptr [0xb058]             ; player_x
564f  sub    ax, 0xe
5652  sub    ax, dx
5654  push   ax
5655  mov    ax, word ptr [0xb05a]             ; player_y
5658  sub    ax, 8
565b  push   ax
565c  mov    al, byte ptr [0xa3c0]             ; player_sprite
565f  xor    ah, ah
5661  mov    dx, 0x54
5664  mul    dx
5666  mov    di, ax
5668  add    di, 0x69ec
566c  push   ds
566d  push   di
566e  mov    ax, 1
5671  push   ax
5672  call   Graph_PutImage
5677  mov    byte ptr [0xa3be], 0              ; held_item
567c  mov    byte ptr [0xa3c4], 1              ; standing
5681  mov    al, byte ptr [0xa3bf]             ; facing_left
5684  xor    ah, ah
5686  mov    dx, ax
5688  mov    al, byte ptr [0xa3be]             ; held_item
568b  xor    ah, ah
568d  add    ax, dx
568f  mov    byte ptr [0xa3c0], al             ; player_sprite
5692  mov    ax, word ptr [0xb058]             ; player_x
5695  sub    ax, 0x10
5698  push   ax
5699  mov    ax, word ptr [0xb05a]             ; player_y
569c  sub    ax, 8
569f  push   ax
56a0  mov    al, byte ptr [0xa3c0]             ; player_sprite
56a3  xor    ah, ah
56a5  mov    dx, 0x54
56a8  mul    dx
56aa  mov    di, ax
56ac  add    di, 0x69ec
56b0  push   ds
56b1  push   di
56b2  mov    ax, 1
56b5  push   ax
56b6  call   Graph_PutImage
56bb  mov    al, byte ptr [0xa3b7]             ; scan_code
56be  push   ax
56bf  mov    di, 0x39ea                        ; set cs:39ea = [75,77]
56c2  push   cs
56c3  push   di
56c4  call   Sys_SetIn
56c9  je     0x56d0
56cb  mov    byte ptr [0xa3c4], 0              ; standing
  loc_56d0:
56d0  jmp    0x5a30
  loc_56d3:
56d3  cmp    ax, 6
56d6  je     0x56db
56d8  jmp    0x5a30
  loc_56db:
56db  mov    al, byte ptr [0xa3bf]             ; facing_left
56de  xor    ah, ah
56e0  shl    ax, 1
56e2  dec    ax
56e3  mov    cx, 0x15
56e6  imul   cx
56e8  mov    dx, ax
56ea  mov    ax, word ptr [0xb058]             ; player_x
56ed  sub    ax, dx
56ef  cdq
56f0  mov    cx, 0x20
56f3  idiv   cx
56f5  mov    byte ptr [0xa3b5], al             ; probe_col
56f8  mov    ax, word ptr [0xb05a]             ; player_y
56fb  add    ax, 4
56fe  cdq
56ff  mov    cx, 8
5702  idiv   cx
5704  mov    byte ptr [0xa3b6], al             ; probe_row
5707  mov    al, byte ptr [0xa3b6]             ; probe_row
570a  xor    ah, ah
570c  mov    bx, ax
570e  mov    al, byte ptr [0xa3b5]             ; probe_col
5711  xor    ah, ah
5713  mov    dx, 0x19
5716  mul    dx
5718  mov    cx, ax
571a  mov    al, byte ptr [0xa3c5]             ; cur_room
571d  xor    ah, ah
571f  mov    dx, 0x226
5722  mul    dx
5724  mov    di, ax
5726  add    di, cx
5728  add    di, bx
572a  cmp    byte ptr [di - 0x4a70], 0x35      ; +rooms
572f  je     0x5734
5731  jmp    0x5a30
  loc_5734:
5734  mov    ax, word ptr [0xb05a]             ; player_y
5737  sub    ax, 4
573a  cdq
573b  mov    cx, 8
573e  idiv   cx
5740  mov    bx, ax
5742  mov    al, byte ptr [0xa3b5]             ; probe_col
5745  xor    ah, ah
5747  mov    dx, 0x19
574a  mul    dx
574c  mov    cx, ax
574e  mov    al, byte ptr [0xa3c5]             ; cur_room
5751  xor    ah, ah
5753  mov    dx, 0x226
5756  mul    dx
5758  mov    di, ax
575a  add    di, cx
575c  add    di, bx
575e  cmp    byte ptr [di - 0x4a70], 0x35      ; +rooms
5763  je     0x5768
5765  jmp    0x5a30
  loc_5768:
5768  mov    al, 8
576a  push   ax
576b  push   word ptr [0xb03e]
576f  push   word ptr [0xb03c]                 ; saved_int8
5773  call   Dos_SetIntVec
5778  mov    byte ptr [0xa3b1], 1              ; loop_j
577d  jmp    0x5783
  loc_577f:
577f  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_5783:
5783  mov    byte ptr [0xa3b2], 1              ; loop_k
5788  jmp    0x578e
  loc_578a:
578a  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_578e:
578e  mov    byte ptr [0xa3c1], 0              ; scratch
5793  jmp    0x5799
  loc_5795:
5795  inc    byte ptr [0xa3c1]                 ; scratch
  loc_5799:
5799  mov    al, byte ptr [0xa3c1]             ; scratch
579c  xor    ah, ah
579e  mov    dx, ax
57a0  mov    ax, 7
57a3  sub    ax, dx
57a5  mov    dx, ax
57a7  mov    al, byte ptr [0xa3b2]             ; loop_k
57aa  xor    ah, ah
57ac  mov    di, ax
57ae  mov    al, byte ptr [di + 0x2371]        ; +pcm_dig
57b2  xor    ah, ah
57b4  mov    cx, dx
57b6  shr    ax, cl
57b8  shl    ax, 1
57ba  and    ax, 2
57bd  mov    dx, ax
57bf  in     al, 0x61
57c1  and    al, 0xfc
57c3  xor    ah, ah
57c5  or     ax, dx
57c7  out    0x61, al
57c9  mov    al, byte ptr [0x2966]             ; machine_speed
57cc  mov    byte ptr [bp - 1], al
57cf  mov    al, 1
57d1  cmp    al, byte ptr [bp - 1]
57d4  ja     0x57e7
57d6  mov    byte ptr [0xa3b0], al             ; loop_i
57d9  jmp    0x57df
  loc_57db:
57db  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_57df:
57df  mov    al, byte ptr [0xa3b0]             ; loop_i
57e2  cmp    al, byte ptr [bp - 1]
57e5  jne    0x57db
  loc_57e7:
57e7  cmp    byte ptr [0xa3c1], 7              ; scratch
57ec  jne    0x5795
57ee  cmp    byte ptr [0xa3b2], 0x5a           ; loop_k
57f3  jne    0x578a
57f5  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
57fa  je     0x580c
57fc  call   move_dagger
5801  mov    ax, 1
5804  push   ax
5805  call   Crt_Delay
580a  jmp    0x5815
  loc_580c:
580c  mov    ax, 2
580f  push   ax
5810  call   Crt_Delay
  loc_5815:
5815  mov    ax, word ptr [0xb058]             ; player_x
5818  sub    ax, 0x10
581b  push   ax
581c  mov    ax, word ptr [0xb05a]             ; player_y
581f  sub    ax, 8
5822  push   ax
5823  mov    al, byte ptr [0xa3c0]             ; player_sprite
5826  xor    ah, ah
5828  mov    dx, 0x54
582b  mul    dx
582d  mov    di, ax
582f  add    di, 0x69ec
5833  push   ds
5834  push   di
5835  mov    ax, 1
5838  push   ax
5839  call   Graph_PutImage
583e  mov    al, byte ptr [0xa3b1]             ; loop_j
5841  xor    ah, ah
5843  cdq
5844  mov    cx, 2
5847  idiv   cx
5849  xchg   dx, ax
584a  mov    cx, 0x12
584d  imul   cx
584f  mov    dx, ax
5851  mov    al, byte ptr [0xa3bf]             ; facing_left
5854  xor    ah, ah
5856  add    ax, 6
5859  add    ax, dx
585b  mov    byte ptr [0xa3c0], al             ; player_sprite
585e  mov    al, byte ptr [0xa3bf]             ; facing_left
5861  xor    ah, ah
5863  shl    ax, 1
5865  dec    ax
5866  mov    dx, ax
5868  mov    ax, word ptr [0xb058]             ; player_x
586b  sub    ax, dx
586d  mov    word ptr [0xb058], ax             ; player_x
5870  mov    al, byte ptr [0xa3b5]             ; probe_col
5873  xor    ah, ah
5875  mov    cx, 5
5878  shl    ax, cl
587a  push   ax
587b  mov    al, byte ptr [0xa3b6]             ; probe_row
587e  xor    ah, ah
5880  mov    cx, 3
5883  shl    ax, cl
5885  sub    ax, 8
5888  push   ax
5889  mov    al, byte ptr [0xa3bf]             ; facing_left
588c  xor    ah, ah
588e  mov    cx, 2
5891  shl    ax, cl
5893  mov    bx, ax
5895  mov    al, byte ptr [0xa3b1]             ; loop_j
5898  xor    ah, ah
589a  cdq
589b  mov    cx, 4
589e  idiv   cx
58a0  add    ax, bx
58a2  add    ax, 0x67
58a5  mov    dx, 0x54
58a8  mul    dx
58aa  mov    di, ax
58ac  add    di, 0x69ec
58b0  push   ds
58b1  push   di
58b2  xor    ax, ax
58b4  push   ax
58b5  call   Graph_PutImage
58ba  mov    ax, word ptr [0xb058]             ; player_x
58bd  sub    ax, 0x10
58c0  push   ax
58c1  mov    ax, word ptr [0xb05a]             ; player_y
58c4  sub    ax, 8
58c7  push   ax
58c8  mov    al, byte ptr [0xa3c0]             ; player_sprite
58cb  xor    ah, ah
58cd  mov    dx, 0x54
58d0  mul    dx
58d2  mov    di, ax
58d4  add    di, 0x69ec
58d8  push   ds
58d9  push   di
58da  mov    ax, 1
58dd  push   ax
58de  call   Graph_PutImage
58e3  call   move_mummies
58e8  cmp    byte ptr [0xa3b1], 0xe            ; loop_j
58ed  je     0x58f2
58ef  jmp    0x577f
  loc_58f2:
58f2  mov    ax, 0x28
58f5  push   ax
58f6  call   Crt_Delay
58fb  mov    al, 8
58fd  push   ax
58fe  mov    di, 0xb03c                        ; &saved_int8
5901  push   ds
5902  push   di
5903  call   Dos_GetIntVec
5908  mov    al, 8
590a  push   ax
590b  mov    ax, 0x45
590e  mov    dx, 0x8e2                         ; seg GAMELIB
5911  push   dx
5912  push   ax
5913  call   Dos_SetIntVec
5918  mov    byte ptr [0xa3be], 0              ; held_item
591d  mov    byte ptr [0xa3c4], 1              ; standing
5922  mov    al, byte ptr [0xa3b5]             ; probe_col
5925  xor    ah, ah
5927  mov    cx, 5
592a  shl    ax, cl
592c  push   ax
592d  mov    al, byte ptr [0xa3b6]             ; probe_row
5930  xor    ah, ah
5932  mov    cx, 3
5935  shl    ax, cl
5937  sub    ax, 8
593a  push   ax
593b  mov    al, byte ptr [0xa3bf]             ; facing_left
593e  xor    ah, ah
5940  mov    cx, 2
5943  shl    ax, cl
5945  add    ax, 0x6a
5948  mov    dx, 0x54
594b  mul    dx
594d  mov    di, ax
594f  add    di, 0x69ec
5953  push   ds
5954  push   di
5955  mov    ax, 1
5958  push   ax
5959  call   Graph_PutImage
595e  mov    al, byte ptr [0xa3b6]             ; probe_row
5961  xor    ah, ah
5963  mov    bx, ax
5965  mov    al, byte ptr [0xa3b5]             ; probe_col
5968  xor    ah, ah
596a  mov    dx, 0x19
596d  mul    dx
596f  mov    cx, ax
5971  mov    al, byte ptr [0xa3c5]             ; cur_room
5974  xor    ah, ah
5976  mov    dx, 0x226
5979  mul    dx
597b  mov    di, ax
597d  add    di, cx
597f  add    di, bx
5981  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
5986  mov    al, byte ptr [0xa3b6]             ; probe_row
5989  xor    ah, ah
598b  dec    ax
598c  mov    bx, ax
598e  mov    al, byte ptr [0xa3b5]             ; probe_col
5991  xor    ah, ah
5993  mov    dx, 0x19
5996  mul    dx
5998  mov    cx, ax
599a  mov    al, byte ptr [0xa3c5]             ; cur_room
599d  xor    ah, ah
599f  mov    dx, 0x226
59a2  mul    dx
59a4  mov    di, ax
59a6  add    di, cx
59a8  add    di, bx
59aa  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
59af  mov    al, byte ptr [0xa3b7]             ; scan_code
59b2  push   ax
59b3  mov    di, 0x39ea                        ; set cs:39ea = [75,77]
59b6  push   cs
59b7  push   di
59b8  call   Sys_SetIn
59bd  je     0x59c4
59bf  mov    byte ptr [0xa3c4], 0              ; standing
  loc_59c4:
59c4  mov    ax, 0x28
59c7  push   ax
59c8  call   Crt_Delay
59cd  mov    ax, word ptr [0xb058]             ; player_x
59d0  sub    ax, 0x10
59d3  push   ax
59d4  mov    ax, word ptr [0xb05a]             ; player_y
59d7  sub    ax, 8
59da  push   ax
59db  mov    al, byte ptr [0xa3c0]             ; player_sprite
59de  xor    ah, ah
59e0  mov    dx, 0x54
59e3  mul    dx
59e5  mov    di, ax
59e7  add    di, 0x69ec
59eb  push   ds
59ec  push   di
59ed  mov    ax, 1
59f0  push   ax
59f1  call   Graph_PutImage
59f6  mov    al, byte ptr [0xa3bf]             ; facing_left
59f9  xor    ah, ah
59fb  mov    dx, ax
59fd  mov    al, byte ptr [0xa3be]             ; held_item
5a00  xor    ah, ah
5a02  add    ax, dx
5a04  mov    byte ptr [0xa3c0], al             ; player_sprite
5a07  mov    ax, word ptr [0xb058]             ; player_x
5a0a  sub    ax, 0x10
5a0d  push   ax
5a0e  mov    ax, word ptr [0xb05a]             ; player_y
5a11  sub    ax, 8
5a14  push   ax
5a15  mov    al, byte ptr [0xa3c0]             ; player_sprite
5a18  xor    ah, ah
5a1a  mov    dx, 0x54
5a1d  mul    dx
5a1f  mov    di, ax
5a21  add    di, 0x69ec
5a25  push   ds
5a26  push   di
5a27  mov    ax, 1
5a2a  push   ax
5a2b  call   Graph_PutImage
  loc_5a30:
5a30  jmp    0x5a3c
  loc_5a32:
5a32  mov    byte ptr [0xa3c4], 1              ; standing
5a37  call   check_pickup
  loc_5a3c:
5a3c  call   Crt_KeyPressed
5a41  or     al, al
5a43  je     0x5a4d
5a45  call   Crt_ReadKey
5a4a  mov    byte ptr [0xb08e], al             ; last_key
  loc_5a4d:
5a4d  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
5a52  je     0x5a59
5a54  call   move_dagger
  loc_5a59:
5a59  cmp    byte ptr [0xa3bd], 0              ; stones_left
5a5e  je     0x5a63
5a60  jmp    0x5cf6
  loc_5a63:
5a63  mov    al, byte ptr [0xa3c5]             ; cur_room
5a66  xor    ah, ah
5a68  cmp    ax, word ptr [0xb078]             ; exit_room
5a6c  je     0x5a71
5a6e  jmp    0x5cf6
  loc_5a71:
5a71  mov    ax, word ptr [0xb058]             ; player_x
5a74  sub    ax, word ptr [0xb074]             ; exit_x
5a78  or     ax, ax
5a7a  jns    0x5a7e
5a7c  neg    ax
  loc_5a7e:
5a7e  cmp    ax, 5
5a81  jl     0x5a86
5a83  jmp    0x5cf6
  loc_5a86:
5a86  mov    ax, word ptr [0xb05a]             ; player_y
5a89  cmp    ax, word ptr [0xb076]             ; exit_y
5a8d  je     0x5a92
5a8f  jmp    0x5cf6
  loc_5a92:
5a92  call   enter_exit
5a97  xor    ax, ax
5a99  push   ax
5a9a  mov    ax, 0xbe
5a9d  push   ax
5a9e  mov    ax, 0x27f
5aa1  push   ax
5aa2  mov    ax, 0xc7
5aa5  push   ax
5aa6  mov    al, 1
5aa8  push   ax
5aa9  call   Graph_SetViewPort
5aae  call   Graph_ClearViewPort
5ab3  xor    ax, ax
5ab5  push   ax
5ab6  xor    ax, ax
5ab8  push   ax
5ab9  mov    ax, 0x27f
5abc  push   ax
5abd  mov    ax, 0xc7
5ac0  push   ax
5ac1  mov    al, 1
5ac3  push   ax
5ac4  call   Graph_SetViewPort
5ac9  inc    byte ptr [0xa3bc]                 ; stage
5acd  cmp    byte ptr [0xa3bc], 0x3d           ; stage
5ad2  jne    0x5ad7
5ad4  jmp    0x5e3e
  loc_5ad7:
5ad7  mov    word ptr [0xb07e], 0x10ff         ; tune_pos
5add  mov    byte ptr [0xa3b0], 0x49           ; loop_i
5ae2  jmp    0x5ae8
  loc_5ae4:
5ae4  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_5ae8:
5ae8  mov    al, byte ptr [0xa3b0]             ; loop_i
5aeb  xor    ah, ah
5aed  mov    dx, 0x54
5af0  mul    dx
5af2  mov    di, ax
5af4  mov    word ptr [di + 0x69ec], 0x1f      ; +sprites
5afa  mov    al, byte ptr [0xa3b0]             ; loop_i
5afd  xor    ah, ah
5aff  mov    dx, 0x54
5b02  mul    dx
5b04  mov    di, ax
5b06  mov    word ptr [di + 0x69ee], 0xf
5b0c  mov    byte ptr [0xa3b1], 1              ; loop_j
5b11  jmp    0x5b17
  loc_5b13:
5b13  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_5b17:
5b17  inc    word ptr [0xb07e]                 ; tune_pos
5b1b  mov    di, word ptr [0xb07e]             ; tune_pos
5b1f  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
5b23  mov    al, byte ptr [0xa3b1]             ; loop_j
5b26  xor    ah, ah
5b28  mov    cx, ax
5b2a  mov    al, byte ptr [0xa3b0]             ; loop_i
5b2d  xor    ah, ah
5b2f  mov    dx, 0x54
5b32  mul    dx
5b34  mov    di, ax
5b36  add    di, cx
5b38  mov    byte ptr [di + 0x69ef], bl
5b3c  cmp    byte ptr [0xa3b1], 0x40           ; loop_j
5b41  jne    0x5b13
5b43  cmp    byte ptr [0xa3b0], 0x6e           ; loop_i
5b48  jne    0x5ae4
5b4a  mov    al, byte ptr [0xa3bc]             ; stage
5b4d  xor    ah, ah
5b4f  dec    ax
5b50  cdq
5b51  mov    cx, 0xa
5b54  idiv   cx
5b56  cdq
5b57  mov    cx, 7
5b5a  idiv   cx
5b5c  xchg   dx, ax
5b5d  mov    byte ptr [0xa3c1], al             ; scratch
5b60  mov    al, byte ptr [0xa3c1]             ; scratch
5b63  xor    ah, ah
5b65  mov    cx, 2
5b68  shl    ax, cl
5b6a  add    ax, 0x6f
5b6d  mov    dx, 0x54
5b70  mul    dx
5b72  mov    di, ax
5b74  add    di, 0x69ec
5b78  push   ds
5b79  push   di
5b7a  mov    di, 0x7aa8
5b7d  push   ds
5b7e  push   di
5b7f  mov    ax, 0x54
5b82  push   ax
5b83  call   Sys_MoveFwd
5b88  mov    byte ptr [0xa3b0], 1              ; loop_i
5b8d  jmp    0x5b93
  loc_5b8f:
5b8f  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_5b93:
5b93  mov    al, byte ptr [0xa3b0]             ; loop_i
5b96  xor    ah, ah
5b98  mov    dx, ax
5b9a  mov    al, byte ptr [0xa3c1]             ; scratch
5b9d  xor    ah, ah
5b9f  mov    cx, 2
5ba2  shl    ax, cl
5ba4  add    ax, 0x6f
5ba7  add    ax, dx
5ba9  mov    dx, 0x54
5bac  mul    dx
5bae  mov    di, ax
5bb0  add    di, 0x69ec
5bb4  push   ds
5bb5  push   di
5bb6  mov    al, byte ptr [0xa3b0]             ; loop_i
5bb9  xor    ah, ah
5bbb  add    ax, 0x34
5bbe  mov    dx, 0x54
5bc1  mul    dx
5bc3  mov    di, ax
5bc5  add    di, 0x69ec
5bc9  push   ds
5bca  push   di
5bcb  mov    ax, 0x54
5bce  push   ax
5bcf  call   Sys_MoveFwd
5bd4  cmp    byte ptr [0xa3b0], 3              ; loop_i
5bd9  jne    0x5b8f
5bdb  mov    byte ptr [0xa3b0], 1              ; loop_i
5be0  jmp    0x5be6
  loc_5be2:
5be2  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_5be6:
5be6  mov    byte ptr [0xa3b1], 0              ; loop_j
5beb  jmp    0x5bf1
  loc_5bed:
5bed  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_5bf1:
5bf1  mov    al, byte ptr [0xa3b1]             ; loop_j
5bf4  xor    ah, ah
5bf6  cdq
5bf7  mov    cx, 0x20
5bfa  idiv   cx
5bfc  xchg   dx, ax
5bfd  inc    ax
5bfe  mov    di, ax
5c00  mov    bl, byte ptr [di + 0x7b53]
5c04  mov    al, byte ptr [0xa3b1]             ; loop_j
5c07  xor    ah, ah
5c09  inc    ax
5c0a  mov    cx, ax
5c0c  mov    al, byte ptr [0xa3b0]             ; loop_i
5c0f  xor    ah, ah
5c11  add    ax, 0x66
5c14  mov    dx, 0x54
5c17  mul    dx
5c19  mov    di, ax
5c1b  add    di, cx
5c1d  mov    al, byte ptr [di + 0x69ef]
5c21  and    al, bl
5c23  mov    bl, al
5c25  mov    al, byte ptr [0xa3b1]             ; loop_j
5c28  xor    ah, ah
5c2a  inc    ax
5c2b  mov    cx, ax
5c2d  mov    al, byte ptr [0xa3b0]             ; loop_i
5c30  xor    ah, ah
5c32  add    ax, 0x66
5c35  mov    dx, 0x54
5c38  mul    dx
5c3a  mov    di, ax
5c3c  add    di, cx
5c3e  mov    byte ptr [di + 0x69ef], bl
5c42  cmp    byte ptr [0xa3b1], 0x3f           ; loop_j
5c47  jne    0x5bed
5c49  cmp    byte ptr [0xa3b0], 8              ; loop_i
5c4e  jne    0x5be2
5c50  inc    byte ptr [0xa3b9]                 ; lives
5c54  add    word ptr [0xb034], 0x3e8          ; score
5c5a  adc    word ptr [0xb036], 0              ; score+2
5c5f  mov    ax, 0xd
5c62  push   ax
5c63  mov    ax, 3
5c66  push   ax
5c67  mov    di, 0x3aaa                        ; cs:'nice'
5c6a  push   cs
5c6b  push   di
5c6c  call   draw_text
5c71  mov    ax, 4
5c74  push   ax
5c75  mov    ax, 5
5c78  push   ax
5c79  mov    di, 0x3aaf                        ; cs:'let s go to next stage'
5c7c  push   cs
5c7d  push   di
5c7e  call   draw_text
5c83  mov    byte ptr [0xa3b0], 0x32           ; loop_i
5c88  jmp    0x5c8e
  loc_5c8a:
5c8a  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_5c8e:
5c8e  mov    ax, 0x90
5c91  push   ax
5c92  mov    al, byte ptr [0xa3b0]             ; loop_i
5c95  xor    ah, ah
5c97  push   ax
5c98  mov    ax, 0x94
5c9b  push   ax
5c9c  mov    al, byte ptr [0xa3b0]             ; loop_i
5c9f  xor    ah, ah
5ca1  push   ax
5ca2  call   Graph_Line
5ca7  cmp    byte ptr [0xa3b0], 0x35           ; loop_i
5cac  jne    0x5c8a
5cae  mov    ax, 0x3e8
5cb1  push   ax
5cb2  call   Crt_Delay
5cb7  mov    byte ptr [0xcb10], 1              ; show_stage_intro
5cbc  mov    al, 9
5cbe  push   ax
5cbf  mov    di, 0xb040                        ; &saved_int9
5cc2  push   ds
5cc3  push   di
5cc4  call   Dos_GetIntVec
5cc9  mov    al, 9
5ccb  push   ax
5ccc  mov    ax, 0x16
5ccf  mov    dx, 0x8e2                         ; seg GAMELIB
5cd2  push   dx
5cd3  push   ax
5cd4  call   Dos_SetIntVec
  loc_5cd9:
5cd9  call   Crt_KeyPressed
5cde  or     al, al
5ce0  je     0x5cea
5ce2  call   Crt_ReadKey
5ce7  mov    byte ptr [0xb08e], al             ; last_key
  loc_5cea:
5cea  call   Crt_KeyPressed
5cef  or     al, al
5cf1  jne    0x5cd9
5cf3  jmp    0x3ef1
  loc_5cf6:
5cf6  cmp    byte ptr [0xcb0e], 0              ; player_caught
5cfb  jne    0x5d04
5cfd  cmp    byte ptr [0xa3b7], 0x3e           ; scan_code
5d02  jne    0x5d19
  loc_5d04:
5d04  push   cs
5d05  call   player_die
5d08  dec    byte ptr [0xa3b9]                 ; lives
5d0c  cmp    byte ptr [0xa3b9], 0xff           ; lives
5d11  jne    0x5d16
5d13  jmp    0x5e3e
  loc_5d16:
5d16  jmp    0x3ef1
  loc_5d19:
5d19  cmp    byte ptr [0xcb0f], 0              ; stone_falling
5d1e  jne    0x5d23
5d20  jmp    0x5e24
  loc_5d23:
5d23  mov    ax, word ptr [0xb08c]             ; stone_row
5d26  add    ax, 2
5d29  mov    bx, ax
5d2b  mov    ax, word ptr [0xb08a]             ; stone_col
5d2e  mov    dx, 0x19
5d31  mul    dx
5d33  mov    cx, ax
5d35  mov    al, byte ptr [0xa3c8]             ; stone_room
5d38  xor    ah, ah
5d3a  mov    dx, 0x226
5d3d  mul    dx
5d3f  mov    di, ax
5d41  add    di, cx
5d43  add    di, bx
5d45  mov    al, byte ptr [di - 0x4a70]        ; +rooms
5d49  push   ax
5d4a  mov    di, 0x3ac6                        ; set cs:3ac6 = [27,33,34,35,56,76,85,86,87,88,100,106,156,206]
5d4d  push   cs
5d4e  push   di
5d4f  call   Sys_SetIn
5d54  jne    0x5d59
5d56  jmp    0x5de9
  loc_5d59:
5d59  mov    al, byte ptr [0xa3c8]             ; stone_room
5d5c  cmp    al, byte ptr [0xa3c5]             ; cur_room
5d60  jne    0x5d82
5d62  mov    ax, word ptr [0xb08a]             ; stone_col
5d65  mov    cx, 5
5d68  shl    ax, cl
5d6a  push   ax
5d6b  mov    ax, word ptr [0xb08c]             ; stone_row
5d6e  mov    cx, 3
5d71  shl    ax, cl
5d73  push   ax
5d74  mov    di, 0x7a54
5d77  push   ds
5d78  push   di
5d79  mov    ax, 1
5d7c  push   ax
5d7d  call   Graph_PutImage
  loc_5d82:
5d82  inc    word ptr [0xb08c]                 ; stone_row
5d86  mov    ax, 0x3e8
5d89  push   ax
5d8a  call   Crt_Sound
5d8f  mov    ax, 2
5d92  push   ax
5d93  call   Crt_Delay
5d98  cmp    word ptr [0xb08c], 0x16           ; stone_row
5d9d  jle    0x5dbe
5d9f  mov    word ptr [0xb088], 0xc3           ; tmp_y
5da5  mov    di, 0xa3c8                        ; &stone_room
5da8  push   ds
5da9  push   di
5daa  mov    di, 0xb086                        ; &old_x
5dad  push   ds
5dae  push   di
5daf  mov    di, 0xb088                        ; &tmp_y
5db2  push   ds
5db3  push   di
5db4  call   move_to_next_room
5db9  xor    ax, ax
5dbb  mov    word ptr [0xb08c], ax             ; stone_row
  loc_5dbe:
5dbe  mov    al, byte ptr [0xa3c8]             ; stone_room
5dc1  cmp    al, byte ptr [0xa3c5]             ; cur_room
5dc5  jne    0x5de7
5dc7  mov    ax, word ptr [0xb08a]             ; stone_col
5dca  mov    cx, 5
5dcd  shl    ax, cl
5dcf  push   ax
5dd0  mov    ax, word ptr [0xb08c]             ; stone_row
5dd3  mov    cx, 3
5dd6  shl    ax, cl
5dd8  push   ax
5dd9  mov    di, 0x7a54
5ddc  push   ds
5ddd  push   di
5dde  mov    ax, 1
5de1  push   ax
5de2  call   Graph_PutImage
  loc_5de7:
5de7  jmp    0x5e24
  loc_5de9:
5de9  mov    ax, word ptr [0xb08c]             ; stone_row
5dec  mov    bx, ax
5dee  mov    ax, word ptr [0xb08a]             ; stone_col
5df1  mov    dx, 0x19
5df4  mul    dx
5df6  mov    cx, ax
5df8  mov    al, byte ptr [0xa3c8]             ; stone_room
5dfb  xor    ah, ah
5dfd  mov    dx, 0x226
5e00  mul    dx
5e02  mov    di, ax
5e04  add    di, cx
5e06  add    di, bx
5e08  mov    byte ptr [di - 0x4a70], 0x32      ; +rooms
5e0d  mov    byte ptr [0xcb0f], 0              ; stone_falling
5e12  mov    ax, 0x1e
5e15  push   ax
5e16  call   Crt_Sound
5e1b  mov    ax, 0x14
5e1e  push   ax
5e1f  call   Crt_Delay
  loc_5e24:
5e24  cmp    byte ptr [0x2966], 2              ; machine_speed
5e29  jbe    0x5e34
5e2b  mov    ax, 5
5e2e  push   ax
5e2f  call   Crt_Delay
  loc_5e34:
5e34  cmp    byte ptr [0xa3b7], 0x44           ; scan_code
5e39  je     0x5e3e
5e3b  jmp    0x489a
  loc_5e3e:
5e3e  mov    al, 9
5e40  push   ax
5e41  push   word ptr [0xb042]
5e45  push   word ptr [0xb040]                 ; saved_int9
5e49  call   Dos_SetIntVec
5e4e  mov    al, 8
5e50  push   ax
5e51  push   word ptr [0xb03e]
5e55  push   word ptr [0xb03c]                 ; saved_int8
5e59  call   Dos_SetIntVec
5e5e  call   Crt_NoSound
5e63  call   Graph_ClearViewPort
5e68  mov    ax, 9
5e6b  push   ax
5e6c  mov    ax, 0xa
5e6f  push   ax
5e70  mov    di, 0x3ae6                        ; cs:'1  game over'
5e73  push   cs
5e74  push   di
5e75  call   draw_text
5e7a  mov    ax, 9
5e7d  push   ax
5e7e  mov    ax, 0xc
5e81  push   ax
5e82  mov    di, 0x3af3                        ; cs:'2  continue'
5e85  push   cs
5e86  push   di
5e87  call   draw_text
  loc_5e8c:
5e8c  call   Crt_ReadKey
5e91  mov    byte ptr [0xb08e], al             ; last_key
5e94  mov    al, byte ptr [0xb08e]             ; last_key
5e97  push   ax
5e98  mov    di, 0x3aff                        ; set cs:3aff = [49,50]
5e9b  push   cs
5e9c  push   di
5e9d  call   Sys_SetIn
5ea2  je     0x5e8c
5ea4  cmp    byte ptr [0xb08e], 0x32           ; last_key
5ea9  jne    0x5ee2
5eab  xor    ax, ax
5ead  mov    word ptr [0xb034], ax             ; score
5eb0  mov    word ptr [0xb036], ax             ; score+2
5eb3  mov    byte ptr [0xa3b9], 2              ; lives
5eb8  mov    byte ptr [0xcb10], 1              ; show_stage_intro
5ebd  mov    al, 9
5ebf  push   ax
5ec0  mov    di, 0xb040                        ; &saved_int9
5ec3  push   ds
5ec4  push   di
5ec5  call   Dos_GetIntVec
5eca  mov    al, 9
5ecc  push   ax
5ecd  mov    ax, 0x16
5ed0  mov    dx, 0x8e2                         ; seg GAMELIB
5ed3  push   dx
5ed4  push   ax
5ed5  call   Dos_SetIntVec
5eda  call   Graph_ClearViewPort
5edf  jmp    0x3ef1
  loc_5ee2:
5ee2  call   sub_0c93_0a5d
5ee7  call   Graph_CloseGraph
5eec  mov    sp, bp
5eee  pop    bp
5eef  xor    ax, ax
5ef1  call   Sys_Halt
5ef6  jo     0x5f63
5ef8  or     byte ptr [bx + si], cl
5efa  inc    dx
5efb  inc    di
5efc  dec    cx
5efd  and    byte ptr [si + 0x65], al
5f00  jbe    0x5f6b
5f02  arpl   word ptr [di + 0x20], sp
5f05  inc    sp
5f06  jb     0x5f71
5f08  jbe    0x5f6f
5f0a  jb     0x5f2c
5f0c  sub    byte ptr [bp + di + 0x47], al
5f0f  inc    cx
5f10  sub    word ptr [bx + si], sp
5f12  xor    ch, byte ptr [0x3030]
5f16  and    byte ptr [di], ch
5f18  and    byte ptr [di + 0x61], cl
5f1b  jb     0x5f3d
5f1d  xor    dh, byte ptr [bx + di]
5f1f  and    byte ptr [bx + di], dh
5f21  cmp    word ptr [bx + si], di
5f23  cmp    byte ptr [di], cl
5f25  or     al, byte ptr [bp + di + 0x6f]
5f28  jo     0x5fa3
5f2a  jb     0x5f95
  loc_5f2c:
5f2c  push   0x2074
5f30  sub    byte ptr [bp + di + 0x29], ah
5f33  and    byte ptr [bx + di], dh
5f35  cmp    word ptr [bx + si], di
5f37  aaa
5f38  sub    al, 0x31
5f3a  cmp    word ptr [bx + si], di
5f3c  cmp    byte ptr [bx + si], ah
5f3e  inc    dx
5f3f  outsw  dx, word ptr [si]
5f40  jb     0x5fae
5f42  popaw
5f43  outsb  dx, byte ptr [si]
5f44  and    byte ptr fs:[bx + di + 0x6e], cl
5f48  je     0x5faf
5f4a  jb     0x5fba
5f4c  popaw
5f4d  je     0x5fb8
5f4f  outsw  dx, word ptr [si]
5f50  outsb  dx, byte ptr [si]
5f51  popaw
5f52  insb   byte ptr es:[di], dx
5f53  or     ax, 0xa
5f56  sbb    ah, byte ptr [bx + si]
5f5a  add    ch, cl
5f5c  pop    ss
5f5d  add    al, byte ptr [bx + si]
5f5f  add    word ptr [bx + di], ax
5f61  add    byte ptr [bx + si], al
  loc_5f63:
5f63  add    byte ptr [bx + si], al
5f65  add    byte ptr [bx + si], al
5f67  add    byte ptr [bx + si], al
5f69  add    byte ptr [bx + si], al
  loc_5f6b:
5f6b  add    byte ptr [bx + si], al
5f6d  add    byte ptr [bx + si], al
  loc_5f6f:
5f6f  add    byte ptr [bx + si], al
  loc_5f71:
5f71  add    byte ptr [bx + si], al
5f73  add    byte ptr [bx + si], al
5f75  add    byte ptr [bx + si], ah
5f79  add    ch, cl
5f7b  pop    ss
5f7c  add    al, byte ptr [bx + si]
5f7e  add    word ptr [bx + di], ax
5f80  add    ax, word ptr [bp + di + 0x47]
5f83  inc    cx
5f84  add    byte ptr [bx + si], al
5f86  add    byte ptr [bx + si], al
5f88  add    byte ptr [bx + si], al
5f8a  add    byte ptr [bx + si], al
5f8c  add    byte ptr [bx + si], al
5f8e  add    byte ptr [bx + si], al
5f90  add    byte ptr [bx + si], al
5f92  add    byte ptr [bx + si], al
5f94  add    byte ptr [bx + si], al
5f96  push   ds
5f97  push   cs
5f98  pop    ds
5f99  cld
5f9a  push   bp
5f9b  call   word ptr [si + 0x16]
5f9f  pop    bp
5fa0  pop    ds
5fa1  retf
5fa2  db 43
  loc_5fa3:
5fa3  inc    dx
5fa4  add    byte ptr [bx + si], al
5fa6  ret
5fa7  db 00,00,00,00,c3,73,02
  loc_5fae:
5fae  rol    byte ptr [bp + si], cl
5fb0  jmp    0x74b5
5fb3  add    byte ptr [bp + di + 3], dl
5fb6  pop    bx
5fb7  add    bp, word ptr [bx + 3]
  loc_5fba:
5fba  adc    byte ptr [bx + si], al
5fbc  adc    byte ptr [bx + si], al
5fbe  loop   0x5fc8
5fc0  adc    byte ptr [bx + si], al
5fc2  adc    byte ptr [bx + si], al
5fc4  adc    byte ptr [bx + si], al
5fc6  test   byte ptr [bx + si], 0x22
5fc9  add    word ptr [bx], sp
5fcb  add    sp, word ptr [bx]
5fcd  add    word ptr [bx + di + 0x5304], dx
5fd1  add    al, 0x17
5fd3  add    al, 0x41
5fd5  add    word ptr [bx + si], dx
5fd7  add    al, bl
5fd9  add    byte ptr [si - 0x2af0], bh
5fdd  adc    byte ptr [bp + si - 0x4300], dl
5fe1  add    dl, dl
5fe3  add    byte ptr [bp + si], dh
5fe6  pop    di
5fe7  add    word ptr [di], dx
5fe9  add    byte ptr [di], dl
5feb  add    byte ptr [di], dl
5fed  add    byte ptr [di], dl
5fef  add    byte ptr [di], dl
5ff1  add    byte ptr [di], dl
5ff3  add    byte ptr [di], dl
5ff5  add    byte ptr [di], dl
5ff7  add    byte ptr [di], dl
5ff9  add    byte ptr [di], dl
5ffb  add    byte ptr [di], dl
5ffd  add    byte ptr [di], dl
5fff  add    byte ptr [di], dl
6001  add    byte ptr [di], dl
6003  add    byte ptr [di], dl
6005  add    byte ptr [di], dl
6007  add    byte ptr [bp + di + 0x4bb], ah
600b  mov    word ptr [0x4bd], bx
600f  mov    word ptr [0x4bf], cx
6013  mov    word ptr [0x4c1], dx
6017  ret
6018  db 98,00,af,00,af,00,af,00,a0,00,b0,00,b1,00,b6,00
6028  db 0e,07,bb,82,00,c3,1e,0e,1f,e8,89,02,1f,cb,2e,80
6038  db 3e,7a,01,00,75,04,b8,02,00,cb,b8,01,00,cb,cb,b4
6048  db 05,cd,10,cb,24,01,2e,a2,7e,01,cb,e8,03,00,e9,32
6058  db 0e,8b,f1,8b,fa,26,03,0f,43,43,26,03,17,43,43,c3
6068  db e8,ee,ff,e9,d5,0e,8b,f0,8b,fb,b2,ff,a0,7a,03,3c
6078  db 02,73,0a,32,d2,22,c0,74,04,8a,16,7d,01,8a,f1,32
6088  db db,e9,35,11,8a,fb,8a,d8,22,e4,79,05,f6,c4,40,75
6098  db 01,c3,80,e7,0f,75,08,80,3e,7a,01,00,74,01,c3,80
60a8  db 3e,80,01,00,75,03,80,cf,10,88,3e,7f,01,e9,30,04
60b8  db 26,8a,3f,eb,dd,3c,ff,75,12,b9,08,00,bf,10,0b,26
60c8  db 8a,07,88,05,47,43,e2,f7,b8,0c,0c,e8,3e,02,c3,8b
60d8  db c1,f7,26,85,01,8b,d8,8b,0e,87,01,c3,10,00,01,02
60e8  db 03,04,05,06,07,08,09,0a,0b,0c,0d,0e,0f,3c,01,74
60f8  db 11,bb,01,00,b9,01,00,80,3e,7a,01,00,75,03,b9,03
6108  db 00,c3,0e,07,bb,4e,01,c3,00,00,00,00,00,00,00,00
6118  db 00,00,00,08,00,08,00,00,00,00,00,00,00,00,00,00
6128  db 00,00,00,00,00,00,00,00,00,3f,01,c7,00,3f,01,c7
6138  db 00,28,23,58,1b,8d,20,08,08,03,02,04,0e,90,00,00
6148  db 3f,01,c7,00,3f,01,c7,00,28,23,58,1b,8d,20,08,08
6158  db 03,03,05,07,90,00,00,7f,02,c7,00,7f,02,c7,00,28
6168  db 23,58,1b,47,10,08,08,01,07,90,00,00,7f,02,df,01
6178  db 7f,02,df,01,28,23,58,1b,10,27,08,08,01,07,90,99
6188  db 01,b0,01,c7,01,dc,01,06,00,12,33,32,30,20,78,20
6198  db 32,30,30,20,43,47,41,20,43,30,20,20,00,12,33,32
61a8  db 30,20,78,20,32,30,30,20,43,47,41,20,43,31,20,20
61b8  db 00,12,33,32,30,20,78,20,32,30,30,20,43,47,41,20
61c8  db 43,32,20,20,00,12,33,32,30,20,78,20,32,30,30,20
61d8  db 43,47,41,20,43,33,20,20,00,12,36,34,30,20,78,20
61e8  db 32,30,30,20,43,47,41,20,20,20,20,20,00,12,36,34
61f8  db 30,20,78,20,34,38,30,20,4d,43,47,41,20,20,20,20
6208  db 00,3c,01,75,05,8b,0e,f9,01,c3,0e,07,3c,02,75,0d
6218  db b0,14,f6,e1,8a,d8,32,ff,81,c3,fb,01,c3,8a,c5,32
6228  db e4,40,a3,f9,01,8a,c1,32,db,3c,04,73,06,3c,02,72
6238  db 04,fe,c3,2c,02,88,1e,80,01,8a,c8,a2,7b,01,c6,06
6248  db 7a,01,ff,3c,02,73,05,c6,06,7a,01,00,8a,d9,d0,e3
6258  db 32,ff,8b,9f,f1,01,89,1e,97,01,c6,06,7e,01,00,c3
6268  db 26,8a,07,24,0f,80,3e,80,01,00,75,02,0c,10,a2,7f
6278  db 01,a0,7b,01,e9,20,02,a0,b2,04,3c,03,72,18,3c,03
6288  db 74,23,ff,36,bf,04,ff,36,c1,04,e8,e4,ff,8f,06,c1
6298  db 04,8f,06,bf,04,c3,33,c9,b6,18,b2,4f,32,ff,32,c0
62a8  db b4,06,cd,10,c3,b8,00,a0,8e,c0,b9,00,4b,fc,33,c0
62b8  db 8b,f8,f3,ab,c3,80,3e,7a,01,00,74,13,33,db,22,e4
62c8  db 74,02,fe,c7,22,c0,74,02,fe,c3,89,1e,7c,01,c3,b3
62d8  db 03,3a,e3,76,02,8a,e3,3a,c3,76,02,8a,c3,a3,7c,01
62e8  db c3,a3,81,01,89,1e,83,01,c3,51,52,8b,c8,8b,d3,87
62f8  db 06,81,01,87,1e,83,01,e8,03,00,5a,59,c3,8b,36,7c
6308  db 01,8b,3e,85,04,e9,28,03,00,00,00,00,a3,7a,03,8a
6318  db 1e,7d,01,0e,07,fc,3c,02,72,55,2c,02,32,e4,b1,03
6328  db d3,e0,be,c0,0a,03,f0,bf,07,04,80,3e,7a,01,00,74
6338  db 0c,b9,04,00,f3,a5,c7,06,05,04,08,00,c3,c7,06,05
6348  db 04,10,00,8a,3e,7d,01,b9,08,00,ac,e8,0e,00,86,d0
6358  db aa,8a,c2,e8,06,00,8a,c2,aa,e2,ef,c3,32,d2,b3,04
6368  db d0,c2,d0,c2,d0,d0,73,02,0a,d7,fe,cb,75,f2,c3,80
6378  db 3e,7a,01,00,74,07,22,db,74,03,bb,03,00,3c,01,74
6388  db 02,33,db,83,e3,03,8a,87,33,0a,bf,07,04,b9,10,00
6398  db f3,aa,c3,08,00,00,00,00,00,00,00,00,00,00,00,00
63a8  db 00,00,00,00,00,80,3e,8a,01,01,75,03,03,d9,4b,26
63b8  db 8a,07,22,c0,74,2a,06,53,51,8b,1e,81,01,8b,0e,83
63c8  db 01,e8,2c,07,59,5b,07,8b,16,85,01,80,3e,8a,01,01
63d8  db 75,07,01,16,83,01,4b,eb,05,01,16,81,01,43,e2,cf
63e8  db c3,22,e4,78,2d,a2,89,01,88,26,8a,01,81,e3,f8,00
63f8  db 89,1e,85,01,81,e1,f8,00,89,0e,87,01,53,51,a0,7c
6408  db 01,d0,eb,d0,eb,d0,eb,d0,e9,d0,e9,d0,e9,e8,a8,06
6418  db 59,5b,c3,ff,ff,01,00,ff,ff,cc,cc,78,fc,f8,f8,3c
6428  db 04,74,0a,32,e4,d0,e0,8b,d8,8b,9f,89,04,89,1e,85
6438  db 04,89,0e,87,04,c3,00,00,00,00,00,00,00,00,00,b8
6448  db 00,00,00,00,00,00,00,00,00,00,00,00,00,7f,02,c7
6458  db 00,3f,01,c7,00,28,00,00,b8,3d,05,3f,01,c7,00,28
6468  db 00,00,b8,41,05,7f,02,c7,00,28,00,00,b8,67,05,7f
6478  db 02,df,01,50,00,00,a0,6d,05,cf,02,5b,01,5a,00,00
6488  db b0,9b,05,7f,02,8f,01,50,00,00,b8,73,05,cf,02,5d
6498  db 01,5a,00,00,b8,79,05,3c,07,72,02,b0,02,a2,b2,04
64a8  db b4,0a,f6,e4,8b,d8,81,c3,c3,04,8b,07,a3,b7,04,a3
64b8  db bf,04,8b,47,02,a3,b9,04,a3,c1,04,8b,47,04,a3,b3
64c8  db 04,8b,47,06,a3,b0,04,ff,57,08,c3,32,c0,eb,02,b0
64d8  db 01,50,b8,04,00,cd,10,58,b7,01,8a,d8,b4,0b,cd,10
64e8  db 80,3e,b2,04,04,74,0d,a0,7f,01,b4,0b,32,ff,24,1f
64f8  db 8a,d8,cd,10,c3,b8,06,00,cd,10,c3,b8,11,00,cd,10
6508  db c3,b8,40,00,cd,10,c3,fc,b8,30,00,cd,10,b8,00,b8
6518  db 8e,c0,33,c0,33,ff,fc,b9,00,40,f3,ab,c3,35,2d,2e
6528  db 07,5b,02,57,57,02,03,00,00,b0,03,ba,bf,03,ee,b0
6538  db 02,be,8f,05,33,db,b9,00,80,50,53,51,ba,b8,03,ee
6548  db 8c,d8,8e,c0,ba,b4,03,b9,0c,00,32,e4,8a,c4,ee,42
6558  db ac,ee,fe,c4,4a,e2,f5,59,a1,b0,04,fc,8e,c0,33,ff
6568  db 58,f3,ab,ba,b8,03,58,0c,08,ee,bb,40,00,8e,c3,bb
6578  db 65,00,26,88,07,c3,02,06,02,06,12,06,02,06,12,06
6588  db 02,06,12,06,22,06,28,06,36,06,56,06,70,06,90,06
6598  db 34,01,a8,01,74,05,81,c3,00,20,c3,81,eb,b0,1f,c3
65a8  db 34,01,a8,01,74,05,81,c3,b0,1f,c3,81,eb,00,20,c3
65b8  db 2e,03,1e,b3,04,c3,2e,2b,1e,b3,04,c3,00,b0,00,b2
65c8  db 00,b4,00,b6,51,8a,c8,fe,c1,80,e1,03,75,03,83,c3
65d8  db 5a,53,24,fc,0a,c1,8a,d9,d0,e3,32,ff,2e,8e,87,2e
65e8  db 06,5b,59,c3,51,8a,c8,fe,c9,80,e1,03,80,f9,03,75
65f8  db e0,83,eb,5a,eb,db,00,b8,00,ba,00,bc,00,be,51,8a
6608  db c8,fe,c1,80,e1,03,75,03,83,c3,50,53,24,fc,0a,c1
6618  db 8a,d9,d0,e3,32,ff,2e,8e,87,68,06,5b,59,c3,51,8a
6628  db c8,fe,c9,80,e1,03,80,f9,03,75,e0,83,eb,50,eb,db
6638  db 3b,06,b7,04,77,12,3b,0e,b7,04,77,0c,3b,1e,b9,04
6648  db 77,06,3b,16,b9,04,76,01,c3,8b,ec,83,ec,14,89,76
6658  db fe,89,3e,b5,04,3b,c1,72,03,91,87,da,89,46,fc,89
6668  db 5e,fa,c6,46,ec,00,3b,da,72,06,87,da,c6,46,ec,80
6678  db 91,2b,c1,89,46,f4,87,da,2b,da,89,5e,f2,e8,2f,01
6688  db 8b,46,f4,8b,5e,f2,3b,c3,72,18,89,46,f6,d1,e3,89
6698  db 5e,f2,2b,d8,89,5e,f8,2b,d8,89,5e,f4,e8,1b,00,e9
66a8  db 87,00,89,5e,f6,d1,e0,89,46,f4,2b,c3,89,46,f8,2b
66b8  db c3,89,46,f2,e8,03,00,e9,b2,00,8b,5e,f0,8b,56,f8
66c8  db 8b,7e,f4,8b,76,f2,8b,46,fa,24,03,80,3e,7b,01,04
66d8  db 73,02,24,01,0a,46,ec,80,3e,7a,01,00,74,02,0c,40
66e8  db 80,3e,7e,01,00,74,02,0c,20,8a,66,fe,8a,6e,ee,8b
66f8  db 6e,f6,45,d1,06,b5,04,73,13,a8,20,74,05,26,30,27
6708  db eb,0a,26,8a,0f,22,cd,0a,cc,26,88,0f,53,8a,1e,7b
6718  db 01,d0,e3,d0,e3,32,ff,81,c3,ea,05,22,c0,79,02,43
6728  db 43,8b,1f,89,1e,e8,05,5b,c3,4d,75,04,83,c4,14,c3
6738  db f6,c6,80,75,08,03,d7,ff,16,e8,05,eb,02,03,d6,a8
6748  db 40,75,04,d0,cc,d0,cd,d0,cc,d0,cd,f6,c5,80,75,01
6758  db 43,d1,06,b5,04,73,13,a8,20,74,05,26,30,27,eb,0a
6768  db 26,8a,0f,22,cd,0a,cc,26,88,0f,eb,bd,4d,75,04,83
6778  db c4,14,c3,f6,c6,80,75,16,03,d6,a8,40,75,04,d0,cc
6788  db d0,cd,d0,cc,d0,cd,f6,c5,80,75,01,43,eb,02,03,d7
6798  db ff,16,e8,05,d1,06,b5,04,73,13,a8,20,74,05,26,30
67a8  db 27,eb,0a,26,8a,0f,22,cd,0a,cc,26,88,0f,eb,bd,8b
67b8  db 4e,fc,8b,56,fa,a0,7b,01,3c,03,73,04,81,e2,fe,00
67c8  db 3c,04,72,04,d1,ea,d1,ea,a1,b3,04,f7,e2,8b,f0,8b
67d8  db d1,80,3e,7a,01,00,74,07,b9,03,07,b0,fe,eb,05,b9
67e8  db 02,03,b0,fc,22,ea,d3,ea,03,f2,fe,c5,8a,66,fe,8a
67f8  db f0,a0,7a,01,d0,cc,d0,ce,22,c0,75,04,d0,cc,d0,ce
6808  db fe,cd,75,f0,a0,7b,01,88,66,fe,88,76,ee,8b,de,3c
6818  db 03,73,0b,f7,46,fa,01,00,74,04,81,c3,00,20,89,5e
6828  db f0,8e,06,b0,04,3c,04,72,14,8b,5e,fa,83,e3,03,d1
6838  db e3,8e,87,2e,06,3c,05,75,04,8e,87,68,06,c3,00,00
6848  db 00,d5,08,00,00,c1,08,c5,08,c9,08,d5,08,d1,08,26
6858  db 08,05,c3,26,30,05,c3,f6,d3,0a,c3,26,20,05,c3,f6
6868  db d0,eb,00,22,c3,f6,d3,26,22,1d,0a,c3,26,88,05,c3
6878  db 3b,c1,72,01,91,3b,da,72,02,87,da,8b,f0,a2,b6,08
6888  db 8b,fb,b0,03,0e,07,83,e3,07,80,3e,7a,01,00,75,02
6898  db d1,e3,81,c3,07,04,2b,d7,42,89,16,b0,08,53,32,ff
68a8  db 8a,d8,d0,e3,81,c3,b7,08,8b,1f,89,1e,b3,08,8b,de
68b8  db 8b,c1,2b,c3,a2,b5,08,d1,e8,d1,e8,80,3e,7a,01,00
68c8  db 74,02,d1,e8,40,5b,50,56,51,06,53,e8,f7,00,88,1e
68d8  db b2,08,fc,5e,1f,8a,c8,5b,e8,c3,00,2e,80,3e,7a,01
68e8  db 00,75,02,fe,c3,2e,8a,af,2b,0a,5b,e8,b0,00,2e,8a
68f8  db bf,23,0a,8a,dd,5d,2e,a0,b2,08,50,53,55,57,2e,80
6908  db 3e,7a,01,00,74,05,ac,8a,e0,eb,0b,ad,2e,f6,06,b6
6918  db 08,04,75,02,86,e0,56,8b,d0,e8,2f,00,5e,b8,10,00
6928  db 2e,80,3e,7a,01,00,74,03,b8,08,00,05,07,04,3b,f0
6938  db 72,03,be,07,04,5f,5d,5b,58,87,df,ff,16,e8,05,87
6948  db df,2e,ff,0e,b0,08,75,b2,0e,1f,c3,53,8a,c2,4d,8a
6958  db df,23,ed,74,0f,2e,ff,16,b3,08,b3,ff,47,86,f2,8a
6968  db c2,4d,75,f1,8a,e6,b6,03,2e,80,3e,7a,01,00,74,02
6978  db b6,07,2e,8a,16,b5,08,22,d6,2a,f2,8a,d1,2e,80,3e
6988  db 7a,01,00,75,02,d0,ea,3a,f2,5a,7d,0a,2e,ff,16,b3
6998  db 08,47,8a,c4,b3,ff,22,da,2e,ff,16,b3,08,c3,83,e3
69a8  db 07,2e,80,3e,7a,01,00,75,05,80,e3,03,d0,e3,8a,c3
69b8  db c3,ff,7f,3f,1f,0f,07,03,01,80,c0,e0,f0,f8,fc,fe
69c8  db ff,00,55,aa,ff,32,c0,e8,42,fd,8b,d7,57,a0,7b,01
69d8  db 3c,03,73,04,81,e2,fe,00,3c,04,72,04,d1,ea,d1,ea
69e8  db a1,b3,04,f7,e2,8b,d8,8b,d6,b9,02,03,b0,3f,8a,26
69f8  db 7a,01,22,e4,74,05,b9,03,07,b0,7f,22,ea,d3,ea,03
6a08  db da,22,e4,75,02,d0,e5,8a,cd,d2,c8,86,c1,8b,fb,8e
6a18  db 06,b0,04,5b,8a,26,7b,01,80,fc,03,73,0a,80,e3,01
6a28  db 74,04,81,c7,00,20,c3,80,fc,04,72,14,83,e3,03,d0
6a38  db e3,8e,87,2e,06,80,fc,05,75,04,8e,87,68,06,d0,eb
6a48  db c3,00,00,00,00,00,00,00,00,00,00,00,00,00,ff,ff
6a58  db 00,00,ff,ff,00,00,01,02,04,08,10,20,40,80,e0,c1
6a68  db 83,07,0e,1c,38,70,f0,78,3c,1e,0f,87,c3,e1,a5,d2
6a78  db 69,b4,5a,2d,96,4b,ff,88,88,88,ff,88,88,88,81,42
6a88  db 24,18,18,24,42,81,cc,33,cc,33,cc,33,cc,33,80,00
6a98  db 08,00,80,00,08,00,88,00,22,00,88,00,22,00,ff,ff
6aa8  db ff,ff,ff,ff,ff,ff,00,00,00,00,00,00,00,00,00,01
6ab8  db 01,00,00,00,00,00,00,00,88,26,25,0b,8a,e0,80,e4
6ac8  db 80,88,26,20,0b,24,03,22,db,75,02,fe,c3,88,1e,21
6ad8  db 0b,22,c9,75,02,fe,c1,88,0e,22,0b,b0,08,f6,e3,2d
6ae8  db 02,00,a3,26,0b,b0,08,f6,e1,2d,02,00,a3,28,0b,c3
6af8  db 23,db,78,fb,8b,3e,bf,04,2b,3e,26,0b,3b,df,73,ef
6b08  db 23,c9,78,eb,8b,3e,c1,04,2b,3e,28,0b,3b,cf,73,df
6b18  db 1e,53,51,e8,92,00,5f,5e,06,e8,24,01,07,2e,c6,06
6b28  db 24,0b,08,2e,8a,2e,22,0b,50,53,26,8a,56,00,bf,08
6b38  db 00,2e,8a,0e,21,0b,e8,18,00,d0,c2,4f,75,f3,5b,e8
6b48  db 38,00,58,fe,cd,75,e1,45,2e,fe,0e,24,0b,75,d4,1f
6b58  db c3,f6,c2,80,75,02,eb,08,8a,37,22,f4,0a,f0,88,37
6b68  db d0,c8,d0,cc,2e,80,3e,7a,01,00,75,04,d0,c8,d0,cc
6b78  db 22,e4,78,01,43,fe,c9,75,d8,c3,2e,a0,23,0b,2e,80
6b88  db 3e,7b,01,04,73,0a,2e,ff,16,e8,05,2e,a2,23,0b,c3
6b98  db 06,2e,ff,16,e8,05,2e,a2,23,0b,8c,c0,8e,d8,07,c3
6ba8  db 00,00,00,00,00,00,00,00,3c,30,75,02,b0,4f,32,e4
6bb8  db 8b,e8,d1,e5,d1,e5,d1,e5,3c,41,72,04,3c,7b,72,31
6bc8  db 3c,80,72,22,b8,00,00,8e,c0,bb,7c,00,81,ed,00,04
6bd8  db 26,8b,07,23,c0,74,0c,03,e8,26,8b,47,02,8e,c0,23
6be8  db c0,75,14,bd,00,01,81,c5,6e,fa,b8,00,f0,8e,c0,eb
6bf8  db 06,0e,07,81,c5,d9,0a,80,3e,25,0b,00,74,41,26,8b
6c08  db 46,00,26,8b,5e,02,26,8b,4e,04,26,8b,56,06,0e,07
6c18  db bf,12,0c,bd,08,00,d0,e8,d1,d6,d0,ec,d1,d6,d0,eb
6c28  db d1,d6,d0,ef,d1,d6,d0,e9,d1,d6,d0,ed,d1,d6,d0,ea
6c38  db d1,d6,d0,ee,d1,d6,96,aa,96,4d,75,da,bd,12,0c,c3
6c48  db e8,82,fd,88,1e,23,0b,b0,ff,8a,1e,7c,01,81,e3,03
6c58  db 00,80,3e,7a,01,00,74,06,22,db,74,02,b3,03,8a,87
6c68  db 33,0a,8a,e1,f6,d4,22,c4,06,1f,8a,e1,8b,df,c3,38
6c78  db 6c,c6,c6,fe,c6,c6,00,fc,c6,c6,fc,c6,c6,fc,00,7c
6c88  db c6,c6,c0,c0,c6,7c,00,f8,cc,c6,c6,c6,cc,f8,00,fe
6c98  db c0,c0,fc,c0,c0,fe,00,fe,c0,c0,fc,c0,c0,c0,00,7c
6ca8  db c6,c0,ce,c6,c6,7e,00,c6,c6,c6,fe,c6,c6,c6,00,78
6cb8  db 30,30,30,30,30,78,00,1e,06,06,06,c6,c6,7c,00,c6
6cc8  db cc,d8,f0,d8,cc,c6,00,c0,c0,c0,c0,c0,c0,fe,00,c6
6cd8  db ee,fe,d6,c6,c6,c6,00,c6,e6,f6,de,ce,c6,c6,00,7c
6ce8  db c6,c6,c6,c6,c6,7c,00,fc,c6,c6,fc,c0,c0,c0,00,7c
6cf8  db c6,c6,c6,c6,c6,7c,06,fc,c6,c6,fc,c6,c6,c6,00,78
6d08  db cc,60,30,18,cc,78,00,fc,30,30,30,30,30,30,00,c6
6d18  db c6,c6,c6,c6,c6,7c,00,c6,c6,c6,c6,c6,6c,38,00,c6
6d28  db c6,c6,d6,fe,ee,c6,00,c6,c6,6c,38,6c,c6,c6,00,c3
6d38  db c3,66,3c,18,18,18,00,fe,0c,18,30,60,c0,fe,00,3c
6d48  db 30,30,30,30,30,3c,00,c0,60,30,18,0c,06,03,00,3c
6d58  db 0c,0c,0c,0c,0c,3c,00,00,38,6c,c6,00,00,00,00,00
6d68  db 00,00,00,00,00,00,ff,30,30,18,00,00,00,00,00,00
6d78  db 00,7c,06,7e,c6,7e,00,c0,c0,fc,c6,c6,e6,dc,00,00
6d88  db 00,7c,c6,c0,c0,7e,00,06,06,7e,c6,c6,ce,76,00,00
6d98  db 00,7c,c6,fe,c0,7e,00,1e,30,7c,30,30,30,30,00,00
6da8  db 00,7e,c6,ce,76,06,7c,c0,c0,fc,c6,c6,c6,c6,00,18
6db8  db 00,38,18,18,18,3c,00,18,00,38,18,18,18,18,f0,c0
6dc8  db c0,cc,d8,f0,d8,cc,00,38,18,18,18,18,18,3c,00,00
6dd8  db 00,cc,fe,d6,c6,c6,00,00,00,fc,c6,c6,c6,c6,00,00
6de8  db 00,7c,c6,c6,c6,7c,00,00,00,fc,c6,c6,e6,dc,c0,00
6df8  db 00,7e,c6,c6,ce,76,06,00,00,6e,70,60,60,60,00,00
6e08  db 00,7c,c0,7c,06,fc,00,30,30,7c,30,30,30,1c,00,00
6e18  db 00,c6,c6,c6,c6,7e,00,00,00,c6,c6,c6,6c,38,00,00
6e28  db 00,c6,c6,d6,fe,6c,00,00,00,c6,6c,38,6c,c6,00,00
6e38  db 00,c6,c6,ce,76,06,7c,00,00,fc,18,30,60,fc,00,00
6e48  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
6e58  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
6e68  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
6e78  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
6e88  db 00,00,00,2b,ce,2b,d7,42,89,16,f2,0e,51,06,53,e8
6e98  db 33,fb,88,1e,f4,0e,fc,06,1f,8b,f7,5f,07,8a,c8,5b
6ea8  db 8b,d3,e8,75,01,fe,c3,d1,ea,d1,ea,2e,80,3e,7a,01
6eb8  db 00,74,04,fe,cb,d1,ea,2e,8a,9f,2b,0a,2e,a0,f4,0e
6ec8  db 50,52,56,e8,2b,00,5e,5a,58,87,de,2e,80,3e,7b,01
6ed8  db 04,72,0b,06,2e,ff,16,e8,05,06,1f,07,eb,05,2e,ff
6ee8  db 16,e8,05,87,de,2e,ff,0e,f2,0e,75,d4,8b,df,0e,1f
6ef8  db c3,ac,8a,e0,ac,8a,e8,d3,e0,23,d2,74,09,26,88,25
6f08  db 47,8a,e5,4a,eb,ee,22,e3,26,88,25,47,c3,00,00,00
6f18  db 9c,0f,8c,0f,90,0f,94,0f,a9,0f,26,30,05,c3,26,08
6f28  db 05,c3,f6,d3,0a,c3,26,20,05,c3,22,c3,f6,d3,26,22
6f38  db 1d,0a,c3,26,88,05,c3,f6,d0,eb,ef,2b,d7,42,89,16
6f48  db f2,0e,53,32,ff,8a,d8,d0,e3,81,c3,82,0f,8b,1f,89
6f58  db 1e,7f,0f,8b,de,8b,c1,2b,c3,a2,81,0f,d1,e8,d1,e8
6f68  db 80,3e,7a,01,00,74,02,d1,e8,40,5b,50,56,51,06,53
6f78  db e8,52,fa,88,1e,f4,0e,fc,5e,1f,8a,c8,5b,e8,9a,00
6f88  db 2e,80,3e,7a,01,00,75,02,fe,c3,2e,8a,af,2b,0a,5b
6f98  db e8,87,00,2e,8a,bf,23,0a,8a,dd,5a,2e,a0,f4,0e,50
6fa8  db 53,52,57,e8,19,00,5f,5a,5b,58,87,df,2e,ff,16,e8
6fb8  db 05,87,df,2e,ff,0e,f2,0e,75,e5,8b,de,0e,1f,c3,53
6fc8  db ac,4a,32,e4,8a,e8,8a,df,d3,e8,23,d2,74,10,2e,ff
6fd8  db 16,7f,0f,b3,ff,47,8a,e5,ac,8a,e8,4a,eb,ea,b6,03
6fe8  db 2e,80,3e,7a,01,00,74,02,b6,07,2e,8a,16,81,0f,22
6ff8  db d6,2a,f2,8a,d1,2e,80,3e,7a,01,00,75,02,d0,ea,3a
7008  db f2,5a,7d,0e,2e,ff,16,7f,0f,47,8a,e5,32,c0,d3,e8
7018  db b3,ff,22,da,2e,ff,16,7f,0f,c3,81,e3,07,00,2e,80
7028  db 3e,7a,01,00,75,05,80,e3,03,d0,e3,8a,c3,c3,f7,10
7038  db f7,10,7c,11,71,11,32,11,1b,11,6c,11,a0,11,a0,11
7048  db 11,12,06,12,d1,11,bc,11,01,12,8b,f0,8b,fb,8e,06
7058  db b0,04,8a,1e,b2,04,32,ff,d0,e3,ff,97,ae,10,8a,d0
7068  db 32,f6,c3,81,e2,03,00,80,3e,7a,01,00,74,03,80,e2
7078  db 01,8b,f0,8b,fb,8e,06,b0,04,8a,1e,b2,04,32,ff,d0
7088  db e3,ff,a7,a0,10,e8,1c,01,8b,c6,d1,e8,d1,e8,03,f8
7098  db 81,e6,03,00,d1,e6,d1,e6,03,f2,d1,e6,8b,84,8d,17
70a8  db 26,22,05,0a,c4,26,88,05,c3,8b,da,8b,c7,81,e7,03
70b8  db 00,d1,e7,8e,85,68,06,d1,e8,d1,e8,bf,50,00,eb,15
70c8  db 8b,da,8b,c7,81,e7,03,00,d1,e7,8e,85,2e,06,d1,e8
70d8  db d1,e8,bf,5a,00,f7,e7,8b,f8,8b,c6,d1,e8,d1,e8,d1
70e8  db e8,03,f8,81,e6,07,00,d1,e6,03,f3,d1,e6,8b,84,ad
70f8  db 17,26,22,05,0a,c4,26,88,05,c3,b8,5a,00,eb,03,b8
7108  db 50,00,52,f7,e7,5a,8b,f8,eb,03,e8,97,00,8b,c6,d1
7118  db e8,d1,e8,d1,e8,03,f8,81,e6,07,00,d1,e6,03,f2,d1
7128  db e6,8b,84,ad,17,26,22,05,0a,c4,26,88,05,c3,e8,73
7138  db 00,8b,c6,d1,e8,d1,e8,03,f8,8b,ce,81,e1,03,00,41
7148  db d1,e1,26,8a,05,d2,c0,24,03,c3,8b,c7,81,e7,03,00
7158  db d1,e7,8e,85,68,06,d1,e8,d1,e8,bf,50,00,eb,13,8b
7168  db c7,81,e7,03,00,d1,e7,8e,85,2e,06,d1,e8,d1,e8,bf
7178  db 5a,00,f7,e7,8b,f8,8b,c6,d1,e8,d1,e8,d1,e8,03,f8
7188  db 8b,ce,80,e1,07,fe,c1,26,8a,05,d2,c0,24,01,c3,b8
7198  db 5a,00,eb,03,b8,50,00,52,f7,e7,5a,8b,f8,eb,d7,e8
71a8  db 02,00,eb,d2,52,8b,c7,d1,e8,9c,bf,50,00,f7,e7,9d
71b8  db 73,03,05,00,20,8b,f8,5a,c3,0e,1f,e8,a3,04,e8,20
71c8  db 04,80,fa,ff,74,15,80,fa,04,72,02,b2,03,80,3e,7a
71d8  db 01,00,74,07,80,fa,02,72,02,b2,01,88,16,e2,0e,8a
71e8  db f8,89,1e,e3,0e,89,26,ce,0e,c6,06,ea,0e,00,8b,ec
71f8  db 81,ed,80,00,8a,de,81,e3,03,00,8a,b7,33,0a,80,3e
7208  db 7a,01,00,74,06,22,f6,74,02,b6,ff,52,b8,ff,ff,4d
7218  db 4d,89,46,00,a1,b9,04,2b,c7,4d,4d,89,46,00,a3,d6
7228  db 0e,c7,06,da,0e,00,00,a1,bf,04,a3,de,0e,4d,4d,89
7238  db 76,00,c6,06,e6,0e,00,e8,c9,03,4d,4d,89,7e,00,f6
7248  db d1,5a,e8,6c,03,e8,f4,02,26,8a,05,22,c1,8a,e6,22
7258  db e1,3a,c4,74,1f,32,ed,eb,25,5b,89,1e,d6,0e,a1,d2
7268  db 0e,a3,da,0e,a1,d0,0e,a3,de,0e,8b,4e,00,45,45,83
7278  db f9,ff,75,0a,8b,26,ce,0e,a0,ea,0e,d0,c8,c3,8b,7e
7288  db 00,45,45,8b,76,00,45,45,8b,5e,00,45,45,e8,23,04
7298  db 53,8a,c5,50,e8,24,01,e8,78,00,58,a8,02,74,06,a8
72a8  db 80,75,0e,eb,19,80,3e,e6,0e,00,75,0f,e8,14,00,73
72b8  db 05,e8,35,00,eb,a3,e8,25,00,72,03,e8,2b,00,e8,3b
72c8  db 00,eb,96,a1,d6,0e,40,3b,c3,75,1b,a1,da,0e,48,39
72d8  db 06,d2,0e,7e,11,a1,de,0e,40,39,06,d0,0e,c3,a1,d6
72e8  db 0e,48,3b,c3,74,e5,32,c0,c3,3b,1e,ca,0e,73,0c,ff
72f8  db 16,c2,0e,e8,46,02,b5,80,e8,34,01,c3,e8,98,02,3b
7308  db 1e,c8,0e,74,0c,ff,16,c0,0e,e8,30,02,32,ed,e8,1e
7318  db 01,c3,26,8a,2d,3b,36,bb,04,74,19,4e,d0,c1,80,3e
7328  db 7a,01,00,75,02,d0,c1,f6,c1,01,74,08,4f,86,16,e7
7338  db 0e,26,8a,2d,8a,c5,22,c1,8a,e6,22,e1,3a,c4,74,38
7348  db 8a,c2,22,c1,8a,e1,f6,d4,22,ec,0a,e8,3b,36,bb,04
7358  db 74,26,4e,d0,c1,80,3e,7a,01,00,75,02,d0,c1,f6,c1
7368  db 01,74,0b,26,88,2d,4f,86,16,e7,0e,26,8a,2d,f6,c1
7378  db 01,74,c1,e8,26,00,eb,bc,26,88,2d,46,d0,c9,80,3e
7388  db 7a,01,00,75,02,d0,c9,f6,c1,80,74,08,47,86,16,e7
7398  db 0e,26,8a,2d,89,36,d2,0e,e8,84,01,c3,a0,e5,0e,26
73a8  db 8a,2d,3a,e8,75,14,26,88,15,3b,36,c4,0e,7c,0b,2b
73b8  db 36,cc,0e,4f,86,16,e7,0e,eb,e5,c3,e8,61,01,26,8a
73c8  db 2d,8a,c5,22,c1,8a,e6,22,e1,3a,c4,74,38,8a,c2,22
73d8  db c1,8a,e1,f6,d4,22,ec,0a,e8,3b,36,bf,04,7d,26,46
73e8  db d0,c9,80,3e,7a,01,00,75,02,d0,c9,f6,c1,80,74,0b
73f8  db 26,88,2d,47,86,16,e7,0e,26,8a,2d,f6,c1,80,74,c1
7408  db e8,0d,00,eb,bc,26,88,2d,4e,89,36,d0,0e,e9,87,01
7418  db a0,e5,0e,26,8a,2d,3a,e8,75,14,26,88,15,3b,36,c6
7428  db 0e,73,0b,03,36,cc,0e,47,86,16,e7,0e,eb,e5,c3,80
7438  db e5,80,eb,19
  loc_743c:
743c  inc    si
743d  ror    cl, 1
743f  cmp    byte ptr [0x17a], 0
7444  jne    0x7448
7446  ror    cl, 1
  loc_7448:
7448  test   cl, 0x80
744b  je     0x7455
744d  xchg   byte ptr [0xee7], dl
7451  inc    di
7452  call   sub_0000_7500
  loc_7455:
7455  mov    al, byte ptr es:[di]
7458  and    al, cl
745a  mov    ah, dh
745c  and    ah, cl
745e  cmp    al, ah
7460  jne    0x7467
7462  and    ch, 0xfe
7465  jmp    0x74c5
  loc_7467:
7467  cmp    byte ptr [0xee2], 0xff
746c  jne    0x7476
746e  mov    ah, dl
7470  or     ah, byte ptr [0xee7]
7474  je     0x7483
  loc_7476:
7476  cmp    byte ptr [0xee3], 0
747b  je     0x748d
747d  cmp    dl, byte ptr [0xee4]
7481  jne    0x748d
  loc_7483:
7483  or     ch, 2
7486  mov    byte ptr [0xee6], 0xff
748b  jmp    0x74a4
  loc_748d:
748d  test   cl, 0x80
7490  je     0x749c
7492  call   sub_0000_74d4
7495  jne    0x749c
7497  and    ch, 0xfe
749a  jmp    0x74c5
  loc_749c:
749c  mov    ah, dl
749e  and    ah, cl
74a0  cmp    ah, al
74a2  je     0x74c5
  loc_74a4:
74a4  test   ch, 1
74a7  jne    0x74c5
74a9  or     ch, 1
74ac  cmp    bp, 0xe
74af  jb     0x74ce
74b1  dec    bp
74b2  dec    bp
74b3  mov    word ptr [bp], bx
74b6  dec    bp
74b7  dec    bp
74b8  mov    word ptr [bp], si
74bb  dec    bp
74bc  dec    bp
74bd  mov    word ptr [bp], di
74c0  dec    bp
74c1  dec    bp
74c2  mov    word ptr [bp], cx
  loc_74c5:
74c5  cmp    si, word ptr [0xed0]
74c9  jae    0x74d3
74cb  jmp    0x743c
  loc_74ce:
74ce  mov    byte ptr [0xeea], 0xff
  loc_74d3:
74d3  ret

; ------------------------------------------------------------
sub_0000_74d4:
74d4  cmp    dl, byte ptr es:[di]
74d7  jne    0x74ff
74d9  mov    ax, word ptr [0xed0]
74dc  sub    ax, word ptr [0xecc]
  loc_74e0:
74e0  cmp    dl, byte ptr es:[di]
74e3  jne    0x74f4
74e5  cmp    si, ax
74e7  jg     0x74f4
74e9  add    si, word ptr [0xecc]
74ed  inc    di
74ee  xchg   byte ptr [0xee7], dl
74f2  jmp    0x74e0
  loc_74f4:
74f4  mov    al, byte ptr es:[di]
74f7  and    al, cl
74f9  mov    ah, dh
74fb  and    ah, cl
74fd  cmp    ah, al
  loc_74ff:
74ff  ret

; ------------------------------------------------------------
sub_0000_7500:
7500  test   ch, 1
7503  je     0x7526
7505  mov    ax, word ptr [0xed0]
7508  sub    ax, word ptr [0xecc]
750c  push   cx
750d  mov    ch, byte ptr [0xee5]
  loc_7511:
7511  cmp    ch, byte ptr es:[di]
7514  jne    0x7525
7516  cmp    si, ax
7518  jae    0x7525
751a  add    si, word ptr [0xecc]
751e  inc    di
751f  xchg   byte ptr [0xee7], dl
7523  jmp    0x7511
  loc_7525:
7525  pop    cx
  loc_7526:
7526  ret
7527  db 89,36,eb,0e,89,1e,ed,0e,89,3e,ef,0e,88,0e,f1,0e
7537  db e8,0a,00,8a,c2,8a,26,e7,0e,a3,e8,0e,c3,8b,c3,8a
7547  db 1e,e2,0e,80,fb,ff,74,1c,81,e3,03,00,8a,97,33,0a
7557  db 8b,d8,80,3e,7a,01,00,74,06,22,d2,74,02,b2,ff,88
7567  db 16,e7,0e,c3,50,52,f7,d8,03,06,b9,04,25,07,00,80
7577  db 3e,7a,01,00,75,02,d1,e0,8b,d8,5a,8b,87,07,04,8a
7587  db d0,80,3e,7a,01,00,74,02,8a,e0,f7,c6,04,00,75,02
7597  db 86,e2,88,26,e7,0e,5b,c3,8b,36,eb,0e,8b,1e,ed,0e
75a7  db 8b,3e,ef,0e,8a,0e,f1,0e,a1,e8,0e,88,26,e7,0e,8a
75b7  db d0,c3,26,8a,05,80,3e,7a,01,00,75,18,a2,e5,0e,32
75c7  db c6,b4,03,84,c4,74,11,d0,e4,d0,e4,73,f6,c3,c6,06
75d7  db e5,0e,00,c3,22,c0,74,f6,22,f6,75,f2,c6,06,e5,0e
75e7  db ff,c3,80,fa,ff,75,1c,53,51,50,bb,07,04,8b,0e,05
75f7  db 04,e3,0b,32,c0,0a,07,43,e2,fb,22,c0,75,02,32,d2
7607  db 58,59,5b,c3,e8,c1,f3,50,c7,06,cc,0e,04,00,80,3e
7617  db 7a,01,00,74,06,c7,06,cc,0e,08,00,a1,bb,04,03,06
7627  db cc,0e,a3,c4,0e,a1,bf,04,2b,06,cc,0e,40,a3,c6,0e
7637  db a1,b9,04,2b,06,c1,04,a3,c8,0e,a1,b9,04,2b,06,bd
7647  db 04,a3,ca,0e,58,c3,f1,16,01,17,f1,16,01,17,f1,16
7657  db 01,17,11,17,16,17,3d,17,53,17,65,17,7b,17,1b,17
7667  db 20,17,50,53,8a,1e,b2,04,d0,e3,d0,e3,32,ff,81,c3
7677  db b7,16,8b,07,a3,c0,0e,8b,47,02,a3,c2,0e,5b,58,c3
7687  db 4b,f6,c3,01,75,05,81,c7,00,20,c3,81,ef,b0,1f,c3
7697  db 43,f6,c3,01,75,05,81,c7,b0,1f,c3,81,ef,00,20,c3
76a7  db 4b,83,c7,50,c3,43,83,ef,50,c3,4b,83,c7,5a,c3,43
76b7  db 83,ef,5a,c3,a0,b2,04,3c,04,72,26,3c,06,73,22,53
76c7  db f6,d3,81,e3,03,00,3c,05,74,37,eb,0d,4b,53,f6,d3
76d7  db 81,e3,03,00,75,03,83,c7,5a,d0,e3,2e,8e,87,2e,06
76e7  db 5b,c3,43,53,f6,d3,81,e3,03,00,80,fb,03,75,ea,83
76f7  db ef,5a,eb,e5,4b,53,f6,d3,81,e3,03,00,75,03,83,c7
7707  db 50,d0,e3,2e,8e,87,68,06,5b,c3,43,53,f6,d3,81,e3
7717  db 03,00,80,fb,03,75,ea,83,ef,50,eb,e5,3f,00,3f,40
7727  db 3f,80,3f,c0,cf,00,cf,10,cf,20,cf,30,f3,00,f3,04
7737  db f3,08,f3,0c,fc,00,fc,01,fc,02,fc,03,7f,00,7f,80
7747  db bf,00,bf,40,df,00,df,20,ef,00,ef,10,f7,00,f7,08
7757  db fb,00,fb,04,fd,00,fd,02,fe,00,fe,01,00,00,00,00
7767  db 00,00,00,00,00,00,00,00,00

;==============================================================================
; SEGMENT 0777  EDITOR   (linear 07770..08e20)
;==============================================================================
0000  db 11,'kings-v.dat'
000c  db 00,10,69,6e,73,65,72,74,20,64,61,74,61,20,64,69
001c  db 73,6b,10,61,6e,64,20,70,72,65,73,73,20,72,65,74
002c  db 75,72,6e,0b,65,73,63,20,74,6f,20,71,75,69,74,05
003c  db 73,74,61,67,65,00,00,00,00,00,00,ff,03,00,00,00
004c  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
005c  db 00,00,00,00,00,fe,03,00,00,00,00,00,00,00,00,00
006c  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
007c  db 00,00,00,00,00,0f,6e,75,6d,62,65,72,20,6f,66,20
008c  db 72,6f,6f,6d,73,0c,73,65,6c,65,63,74,20,72,6f,6f
009c  db 6d,73,18,69,66,20,61,6c,6c,20,72,69,67,68,74,20
00ac  db 70,72,65,73,73,20,79,20,6b,65,79,00,00,00,00,00
00bc  db 00,00,00,00,40,00,00,00,40,00,00,00,00,00,00,00
00cc  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
00dc  db 00,00,00,00,00,00,02,00,00,00,02,00,00,00,00,00
00ec  db 00,00,00,00,00,00,00,00,00,00,00,06,73,74,61,67
00fc  db 65,20,09,20,20,20,20,72,6f,6f,6d,20,ff,ff,ff,ff
010c  db ff,ff,ff,ff,ff,ff,ff,01,00,00,00,00,00,00,00,00
011c  db 00,80,00,00,00,00,00,00,00,00,00,00,00,00,00,00
012c  db 00,00,00,00,00,29,01,00,00,00,00,00,00,00,00,00
013c  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,09
014c  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
015c  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
016c  db 00,00,78,00,00,00,00,00,00,00,00,00,00,00,00,00
017c  db 00,80,00,00,00,00,00,00,00,00,00,00,0c,31,20,20
018c  db 65,64,69,74,20,6d,6f,72,65,11,32,20,20,65,78,69
019c  db 74,20,65,64,69,74,20,6d,6f,64,65

; ------------------------------------------------------------
stage_editor:
01a7  push   bp
01a8  mov    bp, sp
01aa  sub    sp, 0x322
01ae  mov    word ptr [0xb07e], 0xffff         ; tune_pos
01b4  xor    ax, ax
01b6  mov    word ptr [bp - 2], ax
01b9  jmp    0x1be
  loc_01bb:
01bb  inc    word ptr [bp - 2]
  loc_01be:
01be  mov    ax, word ptr [bp - 2]
01c1  mov    dx, 0x54
01c4  mul    dx
01c6  mov    di, ax
01c8  mov    word ptr [di + 0x69ec], 0x1f      ; +sprites
01ce  mov    ax, word ptr [bp - 2]
01d1  mov    dx, 0x54
01d4  mul    dx
01d6  mov    di, ax
01d8  mov    word ptr [di + 0x69ee], 0xf
01de  mov    word ptr [bp - 4], 1
01e3  jmp    0x1e8
  loc_01e5:
01e5  inc    word ptr [bp - 4]
  loc_01e8:
01e8  inc    word ptr [0xb07e]                 ; tune_pos
01ec  mov    di, word ptr [0xb07e]             ; tune_pos
01f0  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
01f4  mov    ax, word ptr [bp - 4]
01f7  mov    cx, ax
01f9  mov    ax, word ptr [bp - 2]
01fc  mov    dx, 0x54
01ff  mul    dx
0201  mov    di, ax
0203  add    di, cx
0205  mov    byte ptr [di + 0x69ef], bl
0209  cmp    word ptr [bp - 4], 0x40
020d  jne    0x1e5
020f  cmp    word ptr [bp - 2], 0x32
0213  jne    0x1bb
0215  mov    word ptr [bp - 2], 0x33
021a  jmp    0x21f
  loc_021c:
021c  inc    word ptr [bp - 2]
  loc_021f:
021f  mov    ax, word ptr [bp - 2]
0222  mov    dx, 0x54
0225  mul    dx
0227  mov    di, ax
0229  mov    word ptr [di + 0x69ec], 0x1f      ; +sprites
022f  mov    ax, word ptr [bp - 2]
0232  mov    dx, 0x54
0235  mul    dx
0237  mov    di, ax
0239  mov    word ptr [di + 0x69ee], 7
023f  mov    word ptr [bp - 4], 1
0244  jmp    0x249
  loc_0246:
0246  inc    word ptr [bp - 4]
  loc_0249:
0249  inc    word ptr [0xb07e]                 ; tune_pos
024d  mov    di, word ptr [0xb07e]             ; tune_pos
0251  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
0255  mov    ax, word ptr [bp - 4]
0258  mov    cx, ax
025a  mov    ax, word ptr [bp - 2]
025d  mov    dx, 0x54
0260  mul    dx
0262  mov    di, ax
0264  add    di, cx
0266  mov    byte ptr [di + 0x69ef], bl
026a  cmp    word ptr [bp - 4], 0x20
026e  jne    0x246
0270  cmp    word ptr [bp - 2], 0x40
0274  jne    0x21c
0276  mov    word ptr [bp - 2], 0x41
027b  jmp    0x280
  loc_027d:
027d  inc    word ptr [bp - 2]
  loc_0280:
0280  mov    ax, word ptr [bp - 2]
0283  mov    dx, 0x54
0286  mul    dx
0288  mov    di, ax
028a  mov    word ptr [di + 0x69ec], 0x27      ; +sprites
0290  mov    ax, word ptr [bp - 2]
0293  mov    dx, 0x54
0296  mul    dx
0298  mov    di, ax
029a  mov    word ptr [di + 0x69ee], 0xf
02a0  mov    word ptr [bp - 4], 1
02a5  jmp    0x2aa
  loc_02a7:
02a7  inc    word ptr [bp - 4]
  loc_02aa:
02aa  inc    word ptr [0xb07e]                 ; tune_pos
02ae  mov    di, word ptr [0xb07e]             ; tune_pos
02b2  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
02b6  mov    ax, word ptr [bp - 4]
02b9  mov    cx, ax
02bb  mov    ax, word ptr [bp - 2]
02be  mov    dx, 0x54
02c1  mul    dx
02c3  mov    di, ax
02c5  add    di, cx
02c7  mov    byte ptr [di + 0x69ef], bl
02cb  cmp    word ptr [bp - 4], 0x50
02cf  jne    0x2a7
02d1  cmp    word ptr [bp - 2], 0x48
02d5  jne    0x27d
02d7  mov    word ptr [bp - 2], 0x49
02dc  jmp    0x2e1
  loc_02de:
02de  inc    word ptr [bp - 2]
  loc_02e1:
02e1  mov    ax, word ptr [bp - 2]
02e4  mov    dx, 0x54
02e7  mul    dx
02e9  mov    di, ax
02eb  mov    word ptr [di + 0x69ec], 0x1f      ; +sprites
02f1  mov    ax, word ptr [bp - 2]
02f4  mov    dx, 0x54
02f7  mul    dx
02f9  mov    di, ax
02fb  mov    word ptr [di + 0x69ee], 0xf
0301  mov    word ptr [bp - 4], 1
0306  jmp    0x30b
  loc_0308:
0308  inc    word ptr [bp - 4]
  loc_030b:
030b  inc    word ptr [0xb07e]                 ; tune_pos
030f  mov    di, word ptr [0xb07e]             ; tune_pos
0313  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
0317  mov    ax, word ptr [bp - 4]
031a  mov    cx, ax
031c  mov    ax, word ptr [bp - 2]
031f  mov    dx, 0x54
0322  mul    dx
0324  mov    di, ax
0326  add    di, cx
0328  mov    byte ptr [di + 0x69ef], bl
032c  cmp    word ptr [bp - 4], 0x40
0330  jne    0x308
0332  cmp    word ptr [bp - 2], 0x6e
0336  jne    0x2de
0338  mov    word ptr [bp - 2], 0x6f
033d  jmp    0x342
  loc_033f:
033f  inc    word ptr [bp - 2]
  loc_0342:
0342  mov    ax, word ptr [bp - 2]
0345  mov    dx, 0x54
0348  mul    dx
034a  mov    di, ax
034c  mov    word ptr [di + 0x69ec], 0x1f      ; +sprites
0352  mov    ax, word ptr [bp - 2]
0355  mov    dx, 0x54
0358  mul    dx
035a  mov    di, ax
035c  mov    word ptr [di + 0x69ee], 7
0362  mov    word ptr [bp - 4], 1
0367  jmp    0x36c
  loc_0369:
0369  inc    word ptr [bp - 4]
  loc_036c:
036c  inc    word ptr [0xb07e]                 ; tune_pos
0370  mov    di, word ptr [0xb07e]             ; tune_pos
0374  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
0378  mov    ax, word ptr [bp - 4]
037b  mov    cx, ax
037d  mov    ax, word ptr [bp - 2]
0380  mov    dx, 0x54
0383  mul    dx
0385  mov    di, ax
0387  add    di, cx
0389  mov    byte ptr [di + 0x69ef], bl
038d  cmp    word ptr [bp - 4], 0x20
0391  jne    0x369
0393  cmp    word ptr [bp - 2], 0x8a
0398  jne    0x33f
039a  mov    word ptr [bp - 2], 0x8b
039f  jmp    0x3a4
  loc_03a1:
03a1  inc    word ptr [bp - 2]
  loc_03a4:
03a4  mov    ax, word ptr [bp - 2]
03a7  mov    dx, 0x54
03aa  mul    dx
03ac  mov    di, ax
03ae  mov    word ptr [di + 0x69ec], 0x12      ; +sprites
03b4  mov    ax, word ptr [bp - 2]
03b7  mov    dx, 0x54
03ba  mul    dx
03bc  mov    di, ax
03be  mov    word ptr [di + 0x69ee], 6
03c4  mov    word ptr [bp - 4], 1
03c9  jmp    0x3ce
  loc_03cb:
03cb  inc    word ptr [bp - 4]
  loc_03ce:
03ce  inc    word ptr [0xb07e]                 ; tune_pos
03d2  mov    di, word ptr [0xb07e]             ; tune_pos
03d6  mov    bl, byte ptr [di + 0x27e]         ; +sprite_bits
03da  mov    ax, word ptr [bp - 4]
03dd  mov    cx, ax
03df  mov    ax, word ptr [bp - 2]
03e2  mov    dx, 0x54
03e5  mul    dx
03e7  mov    di, ax
03e9  add    di, cx
03eb  mov    byte ptr [di + 0x69ef], bl
03ef  cmp    word ptr [bp - 4], 0x15
03f3  jne    0x3cb
03f5  cmp    word ptr [bp - 2], 0xae
03fa  jne    0x3a1
03fc  mov    di, 0x7aa8
03ff  push   ds
0400  push   di
0401  mov    di, 0xa358
0404  push   ds
0405  push   di
0406  mov    ax, 0x54
0409  push   ax
040a  call   Sys_MoveFwd
040f  mov    di, 0x8e58
0412  push   ds
0413  push   di
0414  mov    di, 0x7aa8
0417  push   ds
0418  push   di
0419  mov    ax, 0x54
041c  push   ax
041d  call   Sys_MoveFwd
0422  xor    ax, ax
0424  mov    word ptr [bp - 0xa], ax
0427  xor    ax, ax
0429  mov    word ptr [bp - 4], ax
042c  jmp    0x431
  loc_042e:
042e  inc    word ptr [bp - 4]
  loc_0431:
0431  xor    ax, ax
0433  mov    word ptr [bp - 6], ax
0436  jmp    0x43b
  loc_0438:
0438  inc    word ptr [bp - 6]
  loc_043b:
043b  mov    ax, word ptr [bp - 6]
043e  mov    cx, ax
0440  mov    ax, word ptr [bp - 4]
0443  mov    dx, 0x19
0446  mul    dx
0448  mov    di, ax
044a  add    di, cx
044c  mov    byte ptr [di - 0x4a70], 0         ; +rooms
0451  cmp    word ptr [bp - 6], 0x18
0455  jne    0x438
0457  cmp    word ptr [bp - 4], 0x15
045b  jne    0x42e
045d  lea    di, [bp - 0x122]
0461  push   ss
0462  push   di
0463  mov    di, 0                             ; cs:'kings-v.dat'
0466  push   cs
0467  push   di
0468  call   Sys_Assign
046d  lea    di, [bp - 0x122]
0471  push   ss
0472  push   di
0473  mov    ax, 0x226
0476  push   ax
0477  call   Sys_ResetFile
047c  call   Sys_IOResult
0481  or     ax, ax
0483  jle    0x49b
0485  lea    di, [bp - 0x122]
0489  push   ss
048a  push   di
048b  mov    ax, 0x226
048e  push   ax
048f  call   Sys_RewriteFile
0494  call   Sys_IOCheck
0499  jmp    0x4b3
  loc_049b:
049b  lea    di, [bp - 0x122]
049f  push   ss
04a0  push   di
04a1  mov    di, 0xb590                        ; &rooms
04a4  push   ds
04a5  push   di
04a6  call   Sys_ReadRec
04ab  add    sp, 4
04ae  call   Sys_IOCheck
  loc_04b3:
04b3  lea    di, [bp - 0x122]
04b7  push   ss
04b8  push   di
04b9  call   Sys_Close
04be  call   Sys_IOCheck
04c3  xor    ax, ax
04c5  mov    word ptr [bp - 0xa], ax
04c8  lea    di, [bp - 0xa]
04cb  push   ss
04cc  push   di
04cd  lea    di, [bp - 0xc]
04d0  push   ss
04d1  push   di
04d2  mov    di, 0xc
04d5  push   cs
04d6  push   di
04d7  call   Graph_InitGraph
04dc  call   Graph_ClearDevice
04e1  mov    ax, 0xf
04e4  push   ax
04e5  call   Graph_SetColor
04ea  xor    ax, ax
04ec  push   ax
04ed  xor    ax, ax
04ef  push   ax
04f0  mov    ax, 0x27f
04f3  push   ax
04f4  mov    ax, 0xc7
04f7  push   ax
04f8  call   Graph_Rectangle
04fd  mov    ax, 7
0500  push   ax
0501  mov    ax, 8
0504  push   ax
0505  mov    di, 0xd                           ; cs:'insert data disk'
0508  push   cs
0509  push   di
050a  call   draw_text
050f  mov    ax, 7
0512  push   ax
0513  mov    ax, 0xa
0516  push   ax
0517  mov    di, 0x1e                          ; cs:'and press return'
051a  push   cs
051b  push   di
051c  call   draw_text
0521  mov    ax, 0xa
0524  push   ax
0525  mov    ax, 0xd
0528  push   ax
0529  mov    di, 0x2f                          ; cs:'esc to quit'
052c  push   cs
052d  push   di
052e  call   draw_text
0533  call   Crt_ReadKey
0538  mov    byte ptr [bp - 0x1b], al
053b  cmp    byte ptr [bp - 0x1b], 0x1b
053f  jne    0x544
0541  jmp    0x1653
  loc_0544:
0544  call   Graph_ClearDevice
0549  mov    ax, 0xf
054c  push   ax
054d  call   Graph_SetColor
0552  xor    ax, ax
0554  push   ax
0555  xor    ax, ax
0557  push   ax
0558  mov    ax, 0x27f
055b  push   ax
055c  mov    ax, 0xc7
055f  push   ax
0560  call   Graph_Rectangle
0565  mov    ax, 5
0568  push   ax
0569  mov    ax, 2
056c  push   ax
056d  mov    di, 0x3b                          ; cs:'stage'
0570  push   cs
0571  push   di
0572  call   draw_text
0577  xor    ax, ax
0579  push   ax
057a  xor    ax, ax
057c  push   ax
057d  mov    ax, 0x27f
0580  push   ax
0581  mov    ax, 0xc7
0584  push   ax
0585  call   Graph_Rectangle
  loc_058a:
058a  mov    word ptr [bp - 8], 0xb
058f  mov    byte ptr [0xa3bc], 0              ; stage
  loc_0594:
0594  call   Crt_ReadKey
0599  mov    byte ptr [bp - 0x1b], al
059c  mov    al, byte ptr [bp - 0x1b]
059f  push   ax
05a0  mov    di, 0x41                          ; set cs:0041 = [48,49,50,51,52,53,54,55,56,57]
05a3  push   cs
05a4  push   di
05a5  call   Sys_SetIn
05aa  je     0x5e3
05ac  push   word ptr [bp - 8]
05af  mov    ax, 2
05b2  push   ax
05b3  lea    di, [bp - 0x222]
05b7  push   ss
05b8  push   di
05b9  mov    al, byte ptr [bp - 0x1b]
05bc  push   ax
05bd  call   Sys_CharToStr
05c2  call   draw_text
05c7  inc    word ptr [bp - 8]
05ca  mov    al, byte ptr [bp - 0x1b]
05cd  xor    ah, ah
05cf  mov    bx, ax
05d1  mov    al, byte ptr [0xa3bc]             ; stage
05d4  xor    ah, ah
05d6  mov    cx, 0xa
05d9  imul   cx
05db  add    ax, bx
05dd  sub    ax, 0x30
05e0  mov    byte ptr [0xa3bc], al             ; stage
  loc_05e3:
05e3  cmp    byte ptr [bp - 0x1b], 8
05e7  jne    0x652
05e9  cmp    word ptr [bp - 8], 0xb
05ed  jle    0x652
05ef  dec    word ptr [bp - 8]
05f2  xor    ax, ax
05f4  push   ax
05f5  call   Graph_SetColor
05fa  mov    ax, word ptr [bp - 8]
05fd  mov    cx, 0x14
0600  imul   cx
0602  add    ax, 0x14
0605  mov    word ptr [bp - 0x124], ax
0609  mov    ax, word ptr [bp - 8]
060c  mov    cx, 0x14
060f  imul   cx
0611  cmp    ax, word ptr [bp - 0x124]
0615  jg     0x63b
0617  mov    word ptr [bp - 4], ax
061a  jmp    0x61f
  loc_061c:
061c  inc    word ptr [bp - 4]
  loc_061f:
061f  push   word ptr [bp - 4]
0622  mov    ax, 0x14
0625  push   ax
0626  push   word ptr [bp - 4]
0629  mov    ax, 0x1e
062c  push   ax
062d  call   Graph_Line
0632  mov    ax, word ptr [bp - 4]
0635  cmp    ax, word ptr [bp - 0x124]
0639  jne    0x61c
  loc_063b:
063b  mov    ax, 0xf
063e  push   ax
063f  call   Graph_SetColor
0644  mov    al, byte ptr [0xa3bc]             ; stage
0647  xor    ah, ah
0649  cdq
064a  mov    cx, 0xa
064d  idiv   cx
064f  mov    byte ptr [0xa3bc], al             ; stage
  loc_0652:
0652  cmp    byte ptr [bp - 0x1b], 0xd
0656  je     0x65b
0658  jmp    0x594
  loc_065b:
065b  mov    byte ptr [bp - 0x1b], 0x20
065f  cmp    byte ptr [0xa3bc], 1              ; stage
0664  jbe    0x6d3
0666  mov    al, byte ptr [0xa3bc]             ; stage
0669  xor    ah, ah
066b  dec    ax
066c  cdq
066d  mov    cx, 0x14
0670  idiv   cx
0672  xchg   dx, ax
0673  mov    bx, ax
0675  mov    al, byte ptr [0xa3bc]             ; stage
0678  xor    ah, ah
067a  dec    ax
067b  cdq
067c  mov    cx, 0x14
067f  idiv   cx
0681  mov    dx, 0x19
0684  mul    dx
0686  mov    di, ax
0688  add    di, bx
068a  mov    al, byte ptr [di - 0x4a70]        ; +rooms
068e  push   ax
068f  mov    di, 0x61                          ; set cs:0061 = [1,2,3,4,5,6,7,8,9]
0692  push   cs
0693  push   di
0694  call   Sys_SetIn
0699  jne    0x6d3
069b  xor    ax, ax
069d  push   ax
069e  call   Graph_SetColor
06a3  mov    word ptr [bp - 4], 0xdc
06a8  jmp    0x6ad
  loc_06aa:
06aa  inc    word ptr [bp - 4]
  loc_06ad:
06ad  push   word ptr [bp - 4]
06b0  mov    ax, 0x14
06b3  push   ax
06b4  push   word ptr [bp - 4]
06b7  mov    ax, 0x1e
06ba  push   ax
06bb  call   Graph_Line
06c0  cmp    word ptr [bp - 4], 0x1f4
06c5  jne    0x6aa
06c7  mov    ax, 0xf
06ca  push   ax
06cb  call   Graph_SetColor
06d0  jmp    0x58a
  loc_06d3:
06d3  mov    al, byte ptr [0xa3bc]             ; stage
06d6  xor    ah, ah
06d8  dec    ax
06d9  cdq
06da  mov    cx, 0xa
06dd  idiv   cx
06df  cdq
06e0  mov    cx, 7
06e3  idiv   cx
06e5  xchg   dx, ax
06e6  mov    word ptr [bp - 8], ax
06e9  mov    ax, word ptr [bp - 8]
06ec  mov    cx, 2
06ef  shl    ax, cl
06f1  add    ax, 0x6f
06f4  mov    dx, 0x54
06f7  mul    dx
06f9  mov    di, ax
06fb  add    di, 0x69ec
06ff  push   ds
0700  push   di
0701  mov    di, 0x7aa8
0704  push   ds
0705  push   di
0706  mov    ax, 0x54
0709  push   ax
070a  call   Sys_MoveFwd
070f  mov    word ptr [bp - 2], 1
0714  jmp    0x719
  loc_0716:
0716  inc    word ptr [bp - 2]
  loc_0719:
0719  mov    ax, word ptr [bp - 8]
071c  mov    cx, 2
071f  shl    ax, cl
0721  add    ax, 0x6f
0724  add    ax, word ptr [bp - 2]
0727  mov    dx, 0x54
072a  mul    dx
072c  mov    di, ax
072e  add    di, 0x69ec
0732  push   ds
0733  push   di
0734  mov    ax, word ptr [bp - 2]
0737  add    ax, 0x34
073a  mov    dx, 0x54
073d  mul    dx
073f  mov    di, ax
0741  add    di, 0x69ec
0745  push   ds
0746  push   di
0747  mov    ax, 0x54
074a  push   ax
074b  call   Sys_MoveFwd
0750  cmp    word ptr [bp - 2], 3
0754  jne    0x716
0756  mov    word ptr [bp - 8], 1
075b  mov    al, byte ptr [0xa3bc]             ; stage
075e  xor    ah, ah
0760  cdq
0761  mov    cx, 0x14
0764  idiv   cx
0766  xchg   dx, ax
0767  mov    bx, ax
0769  mov    al, byte ptr [0xa3bc]             ; stage
076c  xor    ah, ah
076e  cdq
076f  mov    cx, 0x14
0772  idiv   cx
0774  mov    dx, 0x19
0777  mul    dx
0779  mov    di, ax
077b  add    di, bx
077d  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0781  push   ax
0782  mov    di, 0x61                          ; set cs:0061 = [1,2,3,4,5,6,7,8,9]
0785  push   cs
0786  push   di
0787  call   Sys_SetIn
078c  jne    0x791
078e  jmp    0x889
  loc_0791:
0791  cmp    byte ptr [0xa3bc], 1              ; stage
0796  jbe    0x7e3
0798  mov    al, byte ptr [0xa3bc]             ; stage
079b  xor    ah, ah
079d  dec    ax
079e  mov    word ptr [bp - 0x124], ax
07a2  mov    ax, 1
07a5  cmp    ax, word ptr [bp - 0x124]
07a9  jg     0x7e3
07ab  mov    word ptr [bp - 2], ax
07ae  jmp    0x7b3
  loc_07b0:
07b0  inc    word ptr [bp - 2]
  loc_07b3:
07b3  mov    ax, word ptr [bp - 2]
07b6  cdq
07b7  mov    cx, 0x14
07ba  idiv   cx
07bc  xchg   dx, ax
07bd  mov    bx, ax
07bf  mov    ax, word ptr [bp - 2]
07c2  cdq
07c3  mov    cx, 0x14
07c6  idiv   cx
07c8  mov    dx, 0x19
07cb  mul    dx
07cd  mov    di, ax
07cf  add    di, bx
07d1  mov    al, byte ptr [di - 0x4a70]        ; +rooms
07d5  xor    ah, ah
07d7  add    word ptr [bp - 8], ax
07da  mov    ax, word ptr [bp - 2]
07dd  cmp    ax, word ptr [bp - 0x124]
07e1  jne    0x7b0
  loc_07e3:
07e3  lea    di, [bp - 0x122]
07e7  push   ss
07e8  push   di
07e9  mov    ax, 0x226
07ec  push   ax
07ed  call   Sys_ResetFile
07f2  call   Sys_IOCheck
07f7  lea    di, [bp - 0x122]
07fb  push   ss
07fc  push   di
07fd  mov    ax, word ptr [bp - 8]
0800  cdq
0801  push   dx
0802  push   ax
0803  call   Sys_Seek
0808  call   Sys_IOCheck
080d  mov    al, byte ptr [0xa3bc]             ; stage
0810  xor    ah, ah
0812  cdq
0813  mov    cx, 0x14
0816  idiv   cx
0818  xchg   dx, ax
0819  mov    bx, ax
081b  mov    al, byte ptr [0xa3bc]             ; stage
081e  xor    ah, ah
0820  cdq
0821  mov    cx, 0x14
0824  idiv   cx
0826  mov    dx, 0x19
0829  mul    dx
082b  mov    di, ax
082d  add    di, bx
082f  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0833  xor    ah, ah
0835  mov    word ptr [bp - 0x124], ax
0839  mov    ax, 1
083c  cmp    ax, word ptr [bp - 0x124]
0840  jg     0x876
0842  mov    word ptr [bp - 2], ax
0845  jmp    0x84a
  loc_0847:
0847  inc    word ptr [bp - 2]
  loc_084a:
084a  lea    di, [bp - 0x122]
084e  push   ss
084f  push   di
0850  mov    ax, word ptr [bp - 2]
0853  mov    dx, 0x226
0856  mul    dx
0858  mov    di, ax
085a  add    di, 0xb590
085e  push   ds
085f  push   di
0860  call   Sys_ReadRec
0865  add    sp, 4
0868  call   Sys_IOCheck
086d  mov    ax, word ptr [bp - 2]
0870  cmp    ax, word ptr [bp - 0x124]
0874  jne    0x847
  loc_0876:
0876  lea    di, [bp - 0x122]
087a  push   ss
087b  push   di
087c  call   Sys_Close
0881  call   Sys_IOCheck
0886  jmp    0xb78
  loc_0889:
0889  mov    ax, 5
088c  push   ax
088d  mov    ax, 4
0890  push   ax
0891  mov    di, 0x81                          ; cs:'number of rooms'
0894  push   cs
0895  push   di
0896  call   draw_text
  loc_089b:
089b  call   Crt_ReadKey
08a0  mov    byte ptr [bp - 0x1b], al
08a3  mov    al, byte ptr [bp - 0x1b]
08a6  push   ax
08a7  mov    di, 0x5b                          ; set cs:005b = [49,50,51,52,53,54,55,56,57]
08aa  push   cs
08ab  push   di
08ac  call   Sys_SetIn
08b1  je     0x8cf
08b3  mov    ax, 0x16
08b6  push   ax
08b7  mov    ax, 4
08ba  push   ax
08bb  lea    di, [bp - 0x222]
08bf  push   ss
08c0  push   di
08c1  mov    al, byte ptr [bp - 0x1b]
08c4  push   ax
08c5  call   Sys_CharToStr
08ca  call   draw_text
  loc_08cf:
08cf  mov    al, byte ptr [bp - 0x1b]
08d2  push   ax
08d3  mov    di, 0x5b                          ; set cs:005b = [49,50,51,52,53,54,55,56,57]
08d6  push   cs
08d7  push   di
08d8  call   Sys_SetIn
08dd  je     0x89b
08df  mov    al, byte ptr [bp - 0x1b]
08e2  xor    ah, ah
08e4  sub    ax, 0x30
08e7  push   ax
08e8  mov    al, byte ptr [0xa3bc]             ; stage
08eb  xor    ah, ah
08ed  cdq
08ee  mov    cx, 0x14
08f1  idiv   cx
08f3  xchg   dx, ax
08f4  mov    bx, ax
08f6  mov    al, byte ptr [0xa3bc]             ; stage
08f9  xor    ah, ah
08fb  cdq
08fc  mov    cx, 0x14
08ff  idiv   cx
0901  mov    dx, 0x19
0904  mul    dx
0906  mov    di, ax
0908  add    di, bx
090a  pop    ax
090b  mov    byte ptr [di - 0x4a70], al        ; +rooms
090f  mov    al, byte ptr [0xa3bc]             ; stage
0912  xor    ah, ah
0914  cdq
0915  mov    cx, 0x14
0918  idiv   cx
091a  xchg   dx, ax
091b  mov    bx, ax
091d  mov    al, byte ptr [0xa3bc]             ; stage
0920  xor    ah, ah
0922  cdq
0923  mov    cx, 0x14
0926  idiv   cx
0928  mov    dx, 0x19
092b  mul    dx
092d  mov    di, ax
092f  add    di, bx
0931  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0935  xor    ah, ah
0937  mov    word ptr [bp - 0x124], ax
093b  mov    ax, 1
093e  cmp    ax, word ptr [bp - 0x124]
0942  jg     0x997
0944  mov    word ptr [bp - 2], ax
0947  jmp    0x94c
  loc_0949:
0949  inc    word ptr [bp - 2]
  loc_094c:
094c  xor    ax, ax
094e  mov    word ptr [bp - 4], ax
0951  jmp    0x956
  loc_0953:
0953  inc    word ptr [bp - 4]
  loc_0956:
0956  xor    ax, ax
0958  mov    word ptr [bp - 6], ax
095b  jmp    0x960
  loc_095d:
095d  inc    word ptr [bp - 6]
  loc_0960:
0960  mov    ax, word ptr [bp - 6]
0963  mov    bx, ax
0965  mov    ax, word ptr [bp - 4]
0968  mov    dx, 0x19
096b  mul    dx
096d  mov    cx, ax
096f  mov    ax, word ptr [bp - 2]
0972  mov    dx, 0x226
0975  mul    dx
0977  mov    di, ax
0979  add    di, cx
097b  add    di, bx
097d  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
0982  cmp    word ptr [bp - 6], 0x17
0986  jne    0x95d
0988  cmp    word ptr [bp - 4], 0x15
098c  jne    0x953
098e  mov    ax, word ptr [bp - 2]
0991  cmp    ax, word ptr [bp - 0x124]
0995  jne    0x949
  loc_0997:
0997  xor    ax, ax
0999  mov    word ptr [bp - 8], ax
099c  jmp    0x9a1
  loc_099e:
099e  inc    word ptr [bp - 8]
  loc_09a1:
09a1  mov    ax, word ptr [bp - 8]
09a4  cdq
09a5  mov    cx, 3
09a8  idiv   cx
09aa  xchg   dx, ax
09ab  mov    cx, 0x73
09ae  imul   cx
09b0  add    ax, 0x64
09b3  push   ax
09b4  mov    ax, word ptr [bp - 8]
09b7  cdq
09b8  mov    cx, 3
09bb  idiv   cx
09bd  mov    cx, 0x1e
09c0  imul   cx
09c2  add    ax, 0x3c
09c5  push   ax
09c6  mov    ax, word ptr [bp - 8]
09c9  cdq
09ca  mov    cx, 3
09cd  idiv   cx
09cf  xchg   dx, ax
09d0  mov    cx, 0x73
09d3  imul   cx
09d5  add    ax, 0xd7
09d8  push   ax
09d9  mov    ax, word ptr [bp - 8]
09dc  cdq
09dd  mov    cx, 3
09e0  idiv   cx
09e2  mov    cx, 0x1e
09e5  imul   cx
09e7  add    ax, 0x5a
09ea  push   ax
09eb  call   Graph_Rectangle
09f0  mov    ax, word ptr [bp - 8]
09f3  cdq
09f4  mov    cx, 3
09f7  idiv   cx
09f9  xchg   dx, ax
09fa  mov    cx, 6
09fd  imul   cx
09ff  add    ax, 7
0a02  push   ax
0a03  mov    ax, word ptr [bp - 8]
0a06  cdq
0a07  mov    cx, 3
0a0a  idiv   cx
0a0c  mov    cx, 3
0a0f  imul   cx
0a11  add    ax, 7
0a14  push   ax
0a15  lea    di, [bp - 0x222]
0a19  push   ss
0a1a  push   di
0a1b  mov    ax, word ptr [bp - 8]
0a1e  add    ax, 0x61
0a21  push   ax
0a22  call   Sys_CharToStr
0a27  call   draw_text
0a2c  cmp    word ptr [bp - 8], 8
0a30  je     0xa35
0a32  jmp    0x99e
  loc_0a35:
0a35  mov    ax, 5
0a38  push   ax
0a39  mov    ax, 0x10
0a3c  push   ax
0a3d  mov    di, 0x91                          ; cs:'select rooms'
0a40  push   cs
0a41  push   di
0a42  call   draw_text
0a47  mov    word ptr [bp - 8], 3
0a4c  mov    byte ptr [bp - 0x1b], 0x20
0a50  mov    al, byte ptr [0xa3bc]             ; stage
0a53  xor    ah, ah
0a55  cdq
0a56  mov    cx, 0x14
0a59  idiv   cx
0a5b  xchg   dx, ax
0a5c  mov    bx, ax
0a5e  mov    al, byte ptr [0xa3bc]             ; stage
0a61  xor    ah, ah
0a63  cdq
0a64  mov    cx, 0x14
0a67  idiv   cx
0a69  mov    dx, 0x19
0a6c  mul    dx
0a6e  mov    di, ax
0a70  add    di, bx
0a72  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0a76  xor    ah, ah
0a78  mov    word ptr [bp - 0x124], ax
0a7c  mov    ax, 1
0a7f  cmp    ax, word ptr [bp - 0x124]
0a83  jg     0xade
0a85  mov    word ptr [bp - 6], ax
0a88  jmp    0xa8d
  loc_0a8a:
0a8a  inc    word ptr [bp - 6]
  loc_0a8d:
0a8d  call   Crt_ReadKey
0a92  mov    byte ptr [bp - 0x1b], al
0a95  mov    al, byte ptr [bp - 0x1b]
0a98  push   ax
0a99  mov    di, 0x55                          ; set cs:0055 = [97,98,99,100,101,102,103,104,105]
0a9c  push   cs
0a9d  push   di
0a9e  call   Sys_SetIn
0aa3  je     0xad5
0aa5  add    word ptr [bp - 8], 2
0aa9  push   word ptr [bp - 8]
0aac  mov    ax, 0x11
0aaf  push   ax
0ab0  lea    di, [bp - 0x224]
0ab4  push   ss
0ab5  push   di
0ab6  mov    al, byte ptr [bp - 0x1b]
0ab9  push   ax
0aba  call   Sys_CharToStr
0abf  call   draw_text
0ac4  mov    dl, byte ptr [bp - 6]
0ac7  mov    al, byte ptr [bp - 0x1b]
0aca  xor    ah, ah
0acc  sub    ax, 0x60
0acf  mov    di, ax
0ad1  mov    byte ptr [di - 0x463d], dl        ; +room_grid
  loc_0ad5:
0ad5  mov    ax, word ptr [bp - 6]
0ad8  cmp    ax, word ptr [bp - 0x124]
0adc  jne    0xa8a
  loc_0ade:
0ade  mov    ax, 5
0ae1  push   ax
0ae2  mov    ax, 0x13
0ae5  push   ax
0ae6  mov    di, 0x9e                          ; cs:'if all right press y key'
0ae9  push   cs
0aea  push   di
0aeb  call   draw_text
0af0  call   Crt_ReadKey
0af5  mov    byte ptr [bp - 0x1b], al
0af8  mov    al, byte ptr [bp - 0x1b]
0afb  push   ax
0afc  mov    di, 0xb7                          ; set cs:00b7 = [78,110]
0aff  push   cs
0b00  push   di
0b01  call   Sys_SetIn
0b06  je     0xb65
0b08  call   Graph_ClearDevice
0b0d  mov    ax, 0xf
0b10  push   ax
0b11  call   Graph_SetColor
0b16  mov    ax, 5
0b19  push   ax
0b1a  mov    ax, 2
0b1d  push   ax
0b1e  mov    di, 0x3b                          ; cs:'stage'
0b21  push   cs
0b22  push   di
0b23  call   draw_text
0b28  xor    ax, ax
0b2a  push   ax
0b2b  xor    ax, ax
0b2d  push   ax
0b2e  mov    ax, 0x27f
0b31  push   ax
0b32  mov    ax, 0xc7
0b35  push   ax
0b36  call   Graph_Rectangle
0b3b  mov    al, byte ptr [0xa3bc]             ; stage
0b3e  xor    ah, ah
0b40  cdq
0b41  mov    cx, 0x14
0b44  idiv   cx
0b46  xchg   dx, ax
0b47  mov    bx, ax
0b49  mov    al, byte ptr [0xa3bc]             ; stage
0b4c  xor    ah, ah
0b4e  cdq
0b4f  mov    cx, 0x14
0b52  idiv   cx
0b54  mov    dx, 0x19
0b57  mul    dx
0b59  mov    di, ax
0b5b  add    di, bx
0b5d  mov    byte ptr [di - 0x4a70], 0         ; +rooms
0b62  jmp    0x58a
  loc_0b65:
0b65  mov    al, byte ptr [bp - 0x1b]
0b68  push   ax
0b69  mov    di, 0xd7                          ; set cs:00d7 = [89,121]
0b6c  push   cs
0b6d  push   di
0b6e  call   Sys_SetIn
0b73  jne    0xb78
0b75  jmp    0x889
  loc_0b78:
0b78  lea    di, [bp - 0x122]
0b7c  push   ss
0b7d  push   di
0b7e  mov    ax, 0x226
0b81  push   ax
0b82  call   Sys_ResetFile
0b87  call   Sys_IOCheck
0b8c  lea    di, [bp - 0x122]
0b90  push   ss
0b91  push   di
0b92  mov    di, 0xb590                        ; &rooms
0b95  push   ds
0b96  push   di
0b97  call   Sys_WriteRec
0b9c  add    sp, 4
0b9f  call   Sys_IOCheck
0ba4  lea    di, [bp - 0x122]
0ba8  push   ss
0ba9  push   di
0baa  call   Sys_Close
0baf  call   Sys_IOCheck
0bb4  call   Graph_ClearDevice
0bb9  mov    word ptr [bp - 0x1a], 1
0bbe  xor    ax, ax
0bc0  mov    word ptr [bp - 0x16], ax
0bc3  xor    ax, ax
0bc5  mov    word ptr [bp - 0x18], ax
0bc8  xor    ax, ax
0bca  push   ax
0bcb  xor    ax, ax
0bcd  push   ax
0bce  mov    ax, 1
0bd1  push   ax
0bd2  call   sub_0c93_0f92
0bd7  mov    byte ptr [bp - 0x21], 0
0bdb  mov    byte ptr [bp - 0x22], 0
0bdf  xor    ax, ax
0be1  mov    word ptr [bp - 2], ax
  loc_0be4:
0be4  inc    word ptr [bp - 2]
0be7  mov    di, word ptr [bp - 2]
0bea  mov    al, byte ptr [di - 0x463d]        ; +room_grid
0bee  push   ax
0bef  mov    di, 0x61                          ; set cs:0061 = [1,2,3,4,5,6,7,8,9]
0bf2  push   cs
0bf3  push   di
0bf4  call   Sys_SetIn
0bf9  je     0xbe4
0bfb  mov    al, byte ptr [bp - 2]
0bfe  mov    byte ptr [0xa3c5], al             ; cur_room
0c01  mov    al, byte ptr [bp - 2]
0c04  mov    byte ptr [0xa3c9], al             ; start_room
0c07  mov    al, byte ptr [0xa3bc]             ; stage
0c0a  xor    ah, ah
0c0c  xor    dx, dx
0c0e  push   dx
0c0f  push   ax
0c10  xor    ax, ax
0c12  push   ax
0c13  mov    di, 0xb090                        ; &text_buf
0c16  push   ds
0c17  push   di
0c18  mov    ax, 0xff
0c1b  push   ax
0c1c  call   Sys_StrLong
0c21  mov    ax, 5
0c24  push   ax
0c25  mov    ax, 0x14
0c28  push   ax
0c29  lea    di, [bp - 0x222]
0c2d  push   ss
0c2e  push   di
0c2f  mov    di, 0xf7                          ; cs:'stage '
0c32  push   cs
0c33  push   di
0c34  call   Sys_StrAssign
0c39  mov    di, 0xb090                        ; &text_buf
0c3c  push   ds
0c3d  push   di
0c3e  call   Sys_StrConcat
0c43  mov    di, 0xfe                          ; cs:'    room '
0c46  push   cs
0c47  push   di
0c48  call   Sys_StrConcat
0c4d  lea    di, [bp - 0x322]
0c51  push   ss
0c52  push   di
0c53  mov    ax, word ptr [bp - 2]
0c56  add    ax, 0x60
0c59  push   ax
0c5a  call   Sys_CharToStr
0c5f  call   Sys_StrConcat
0c64  call   draw_text
0c69  xor    ax, ax
0c6b  mov    word ptr [bp - 2], ax
0c6e  jmp    0xc73
  loc_0c70:
0c70  inc    word ptr [bp - 2]
  loc_0c73:
0c73  xor    ax, ax
0c75  mov    word ptr [bp - 4], ax
0c78  jmp    0xc7d
  loc_0c7a:
0c7a  inc    word ptr [bp - 4]
  loc_0c7d:
0c7d  mov    ax, word ptr [bp - 4]
0c80  mov    bx, ax
0c82  mov    ax, word ptr [bp - 2]
0c85  mov    dx, 0x19
0c88  mul    dx
0c8a  mov    cx, ax
0c8c  mov    al, byte ptr [0xa3c5]             ; cur_room
0c8f  xor    ah, ah
0c91  mov    dx, 0x226
0c94  mul    dx
0c96  mov    di, ax
0c98  add    di, cx
0c9a  add    di, bx
0c9c  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0ca0  push   ax
0ca1  mov    di, 0x108                         ; set cs:0108 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,175]
0ca4  push   cs
0ca5  push   di
0ca6  call   Sys_SetIn
0cab  je     0xcf9
0cad  mov    ax, word ptr [bp - 2]
0cb0  mov    cx, 5
0cb3  shl    ax, cl
0cb5  push   ax
0cb6  mov    ax, word ptr [bp - 4]
0cb9  mov    cx, 3
0cbc  shl    ax, cl
0cbe  push   ax
0cbf  mov    ax, word ptr [bp - 4]
0cc2  mov    bx, ax
0cc4  mov    ax, word ptr [bp - 2]
0cc7  mov    dx, 0x19
0cca  mul    dx
0ccc  mov    cx, ax
0cce  mov    al, byte ptr [0xa3c5]             ; cur_room
0cd1  xor    ah, ah
0cd3  mov    dx, 0x226
0cd6  mul    dx
0cd8  mov    di, ax
0cda  add    di, cx
0cdc  add    di, bx
0cde  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0ce2  xor    ah, ah
0ce4  mov    dx, 0x54
0ce7  mul    dx
0ce9  mov    di, ax
0ceb  add    di, 0x69ec
0cef  push   ds
0cf0  push   di
0cf1  xor    ax, ax
0cf3  push   ax
0cf4  call   Graph_PutImage
  loc_0cf9:
0cf9  cmp    word ptr [bp - 4], 0x17
0cfd  je     0xd02
0cff  jmp    0xc7a
  loc_0d02:
0d02  cmp    word ptr [bp - 2], 0x13
0d06  je     0xd0b
0d08  jmp    0xc70
  loc_0d0b:
0d0b  mov    ax, word ptr [bp - 0x16]
0d0e  mov    cx, 5
0d11  shl    ax, cl
0d13  push   ax
0d14  mov    ax, word ptr [bp - 0x18]
0d17  mov    cx, 3
0d1a  shl    ax, cl
0d1c  push   ax
0d1d  mov    di, word ptr [bp - 0x1a]
0d20  mov    al, byte ptr [di + 0x267]
0d24  xor    ah, ah
0d26  mov    dx, 0x54
0d29  mul    dx
0d2b  mov    di, ax
0d2d  add    di, 0x69ec
0d31  push   ds
0d32  push   di
0d33  mov    ax, 1
0d36  push   ax
0d37  call   Graph_PutImage
  loc_0d3c:
0d3c  call   Crt_ReadKey
0d41  mov    byte ptr [bp - 0x1b], al
0d44  mov    al, byte ptr [bp - 0x1b]
0d47  cmp    al, 0
0d49  je     0xd4e
0d4b  jmp    0x11b6
  loc_0d4e:
0d4e  call   Crt_ReadKey
0d53  mov    byte ptr [bp - 0x1b], al
0d56  mov    ax, 0x64
0d59  push   ax
0d5a  call   Crt_Sound
0d5f  mov    ax, 0xa
0d62  push   ax
0d63  call   Crt_Delay
0d68  call   Crt_NoSound
0d6d  mov    al, byte ptr [bp - 0x1b]
0d70  push   ax
0d71  mov    di, 0x128                         ; set cs:0128 = [72,75,77,80]
0d74  push   cs
0d75  push   di
0d76  call   Sys_SetIn
0d7b  jne    0xd80
0d7d  jmp    0xf9c
  loc_0d80:
0d80  mov    ax, word ptr [bp - 0x16]
0d83  mov    cx, 5
0d86  shl    ax, cl
0d88  push   ax
0d89  mov    ax, word ptr [bp - 0x18]
0d8c  mov    cx, 3
0d8f  shl    ax, cl
0d91  push   ax
0d92  mov    di, word ptr [bp - 0x1a]
0d95  mov    al, byte ptr [di + 0x267]
0d99  xor    ah, ah
0d9b  mov    dx, 0x54
0d9e  mul    dx
0da0  mov    di, ax
0da2  add    di, 0x69ec
0da6  push   ds
0da7  push   di
0da8  mov    ax, 1
0dab  push   ax
0dac  call   Graph_PutImage
0db1  cmp    byte ptr [bp - 0x21], 0
0db5  jne    0xdba
0db7  jmp    0xe9a
  loc_0dba:
0dba  xor    ax, ax
0dbc  push   ax
0dbd  call   Graph_SetColor
0dc2  mov    ax, word ptr [bp - 0x18]
0dc5  mov    bx, ax
0dc7  mov    ax, word ptr [bp - 0x16]
0dca  mov    dx, 0x19
0dcd  mul    dx
0dcf  mov    cx, ax
0dd1  mov    al, byte ptr [0xa3c5]             ; cur_room
0dd4  xor    ah, ah
0dd6  mov    dx, 0x226
0dd9  mul    dx
0ddb  mov    di, ax
0ddd  add    di, cx
0ddf  add    di, bx
0de1  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0de5  push   ax
0de6  mov    di, 0x148                         ; set cs:0148 = [24,27]
0de9  push   cs
0dea  push   di
0deb  call   Sys_SetIn
0df0  jne    0xe34
0df2  xor    ax, ax
0df4  mov    word ptr [bp - 2], ax
0df7  jmp    0xdfc
  loc_0df9:
0df9  inc    word ptr [bp - 2]
  loc_0dfc:
0dfc  mov    ax, word ptr [bp - 0x16]
0dff  mov    cx, 5
0e02  shl    ax, cl
0e04  push   ax
0e05  mov    ax, word ptr [bp - 0x18]
0e08  mov    cx, 3
0e0b  shl    ax, cl
0e0d  add    ax, word ptr [bp - 2]
0e10  push   ax
0e11  mov    ax, word ptr [bp - 0x16]
0e14  mov    cx, 5
0e17  shl    ax, cl
0e19  add    ax, 0x1f
0e1c  push   ax
0e1d  mov    ax, word ptr [bp - 0x18]
0e20  mov    cx, 3
0e23  shl    ax, cl
0e25  add    ax, word ptr [bp - 2]
0e28  push   ax
0e29  call   Graph_Line
0e2e  cmp    word ptr [bp - 2], 7
0e32  jne    0xdf9
  loc_0e34:
0e34  mov    ax, 0xf
0e37  push   ax
0e38  call   Graph_SetColor
0e3d  mov    ax, word ptr [bp - 0x16]
0e40  mov    cx, 5
0e43  shl    ax, cl
0e45  push   ax
0e46  mov    ax, word ptr [bp - 0x18]
0e49  mov    cx, 3
0e4c  shl    ax, cl
0e4e  push   ax
0e4f  mov    di, word ptr [bp - 0x1a]
0e52  mov    al, byte ptr [di + 0x267]
0e56  xor    ah, ah
0e58  mov    dx, 0x54
0e5b  mul    dx
0e5d  mov    di, ax
0e5f  add    di, 0x69ec
0e63  push   ds
0e64  push   di
0e65  mov    ax, 1
0e68  push   ax
0e69  call   Graph_PutImage
0e6e  mov    di, word ptr [bp - 0x1a]
0e71  mov    al, byte ptr [di + 0x267]
0e75  push   ax
0e76  mov    ax, word ptr [bp - 0x18]
0e79  mov    bx, ax
0e7b  mov    ax, word ptr [bp - 0x16]
0e7e  mov    dx, 0x19
0e81  mul    dx
0e83  mov    cx, ax
0e85  mov    al, byte ptr [0xa3c5]             ; cur_room
0e88  xor    ah, ah
0e8a  mov    dx, 0x226
0e8d  mul    dx
0e8f  mov    di, ax
0e91  add    di, cx
0e93  add    di, bx
0e95  pop    ax
0e96  mov    byte ptr [di - 0x4a70], al        ; +rooms
  loc_0e9a:
0e9a  cmp    byte ptr [bp - 0x22], 0
0e9e  je     0xf17
0ea0  xor    ax, ax
0ea2  push   ax
0ea3  call   Graph_SetColor
0ea8  xor    ax, ax
0eaa  mov    word ptr [bp - 2], ax
0ead  jmp    0xeb2
  loc_0eaf:
0eaf  inc    word ptr [bp - 2]
  loc_0eb2:
0eb2  mov    ax, word ptr [bp - 0x16]
0eb5  mov    cx, 5
0eb8  shl    ax, cl
0eba  push   ax
0ebb  mov    ax, word ptr [bp - 0x18]
0ebe  mov    cx, 3
0ec1  shl    ax, cl
0ec3  add    ax, word ptr [bp - 2]
0ec6  push   ax
0ec7  mov    ax, word ptr [bp - 0x16]
0eca  mov    cx, 5
0ecd  shl    ax, cl
0ecf  add    ax, 0x1f
0ed2  push   ax
0ed3  mov    ax, word ptr [bp - 0x18]
0ed6  mov    cx, 3
0ed9  shl    ax, cl
0edb  add    ax, word ptr [bp - 2]
0ede  push   ax
0edf  call   Graph_Line
0ee4  cmp    word ptr [bp - 2], 7
0ee8  jne    0xeaf
0eea  mov    ax, 0xf
0eed  push   ax
0eee  call   Graph_SetColor
0ef3  mov    ax, word ptr [bp - 0x18]
0ef6  mov    bx, ax
0ef8  mov    ax, word ptr [bp - 0x16]
0efb  mov    dx, 0x19
0efe  mul    dx
0f00  mov    cx, ax
0f02  mov    al, byte ptr [0xa3c5]             ; cur_room
0f05  xor    ah, ah
0f07  mov    dx, 0x226
0f0a  mul    dx
0f0c  mov    di, ax
0f0e  add    di, cx
0f10  add    di, bx
0f12  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
  loc_0f17:
0f17  mov    al, byte ptr [bp - 0x1b]
0f1a  cmp    al, 0x48
0f1c  jne    0xf2e
0f1e  dec    word ptr [bp - 0x18]
0f21  cmp    word ptr [bp - 0x18], 0
0f25  jge    0xf2c
0f27  mov    word ptr [bp - 0x18], 0x17
  loc_0f2c:
0f2c  jmp    0xf68
  loc_0f2e:
0f2e  cmp    al, 0x4b
0f30  jne    0xf42
0f32  dec    word ptr [bp - 0x16]
0f35  cmp    word ptr [bp - 0x16], 0
0f39  jge    0xf40
0f3b  mov    word ptr [bp - 0x16], 0x13
  loc_0f40:
0f40  jmp    0xf68
  loc_0f42:
0f42  cmp    al, 0x4d
0f44  jne    0xf56
0f46  inc    word ptr [bp - 0x16]
0f49  cmp    word ptr [bp - 0x16], 0x13
0f4d  jle    0xf54
0f4f  xor    ax, ax
0f51  mov    word ptr [bp - 0x16], ax
  loc_0f54:
0f54  jmp    0xf68
  loc_0f56:
0f56  cmp    al, 0x50
0f58  jne    0xf68
0f5a  inc    word ptr [bp - 0x18]
0f5d  cmp    word ptr [bp - 0x18], 0x17
0f61  jle    0xf68
0f63  xor    ax, ax
0f65  mov    word ptr [bp - 0x18], ax
  loc_0f68:
0f68  mov    ax, word ptr [bp - 0x16]
0f6b  mov    cx, 5
0f6e  shl    ax, cl
0f70  push   ax
0f71  mov    ax, word ptr [bp - 0x18]
0f74  mov    cx, 3
0f77  shl    ax, cl
0f79  push   ax
0f7a  mov    di, word ptr [bp - 0x1a]
0f7d  mov    al, byte ptr [di + 0x267]
0f81  xor    ah, ah
0f83  mov    dx, 0x54
0f86  mul    dx
0f88  mov    di, ax
0f8a  add    di, 0x69ec
0f8e  push   ds
0f8f  push   di
0f90  mov    ax, 1
0f93  push   ax
0f94  call   Graph_PutImage
0f99  jmp    0x11b3
  loc_0f9c:
0f9c  mov    al, byte ptr [bp - 0x1b]
0f9f  cmp    al, 0x3b
0fa1  je     0xfa6
0fa3  jmp    0x1036
  loc_0fa6:
0fa6  mov    ax, word ptr [bp - 0x16]
0fa9  mov    cx, 5
0fac  shl    ax, cl
0fae  push   ax
0faf  mov    ax, word ptr [bp - 0x18]
0fb2  mov    cx, 3
0fb5  shl    ax, cl
0fb7  push   ax
0fb8  mov    di, word ptr [bp - 0x1a]
0fbb  mov    al, byte ptr [di + 0x267]
0fbf  xor    ah, ah
0fc1  mov    dx, 0x54
0fc4  mul    dx
0fc6  mov    di, ax
0fc8  add    di, 0x69ec
0fcc  push   ds
0fcd  push   di
0fce  xor    ax, ax
0fd0  push   ax
0fd1  call   Graph_PutImage
0fd6  mov    ax, word ptr [bp - 0x16]
0fd9  mov    cx, 5
0fdc  shl    ax, cl
0fde  push   ax
0fdf  mov    ax, word ptr [bp - 0x18]
0fe2  mov    cx, 3
0fe5  shl    ax, cl
0fe7  push   ax
0fe8  mov    di, word ptr [bp - 0x1a]
0feb  mov    al, byte ptr [di + 0x267]
0fef  xor    ah, ah
0ff1  mov    dx, 0x54
0ff4  mul    dx
0ff6  mov    di, ax
0ff8  add    di, 0x69ec
0ffc  push   ds
0ffd  push   di
0ffe  mov    ax, 1
1001  push   ax
1002  call   Graph_PutImage
1007  mov    di, word ptr [bp - 0x1a]
100a  mov    al, byte ptr [di + 0x267]
100e  push   ax
100f  mov    ax, word ptr [bp - 0x18]
1012  mov    bx, ax
1014  mov    ax, word ptr [bp - 0x16]
1017  mov    dx, 0x19
101a  mul    dx
101c  mov    cx, ax
101e  mov    al, byte ptr [0xa3c5]             ; cur_room
1021  xor    ah, ah
1023  mov    dx, 0x226
1026  mul    dx
1028  mov    di, ax
102a  add    di, cx
102c  add    di, bx
102e  pop    ax
102f  mov    byte ptr [di - 0x4a70], al        ; +rooms
1033  jmp    0x11b3
  loc_1036:
1036  cmp    al, 0x3c
1038  jne    0x104d
103a  cmp    byte ptr [bp - 0x21], 0
103e  je     0x1046
1040  mov    byte ptr [bp - 0x21], 0
1044  jmp    0x104a
  loc_1046:
1046  mov    byte ptr [bp - 0x21], 1
  loc_104a:
104a  jmp    0x11b3
  loc_104d:
104d  cmp    al, 0x3d
104f  jne    0x10c4
1051  mov    ax, word ptr [bp - 0x16]
1054  mov    cx, 5
1057  shl    ax, cl
1059  push   ax
105a  mov    ax, word ptr [bp - 0x18]
105d  mov    cx, 3
1060  shl    ax, cl
1062  push   ax
1063  mov    di, word ptr [bp - 0x1a]
1066  mov    al, byte ptr [di + 0x267]
106a  xor    ah, ah
106c  mov    dx, 0x54
106f  mul    dx
1071  mov    di, ax
1073  add    di, 0x69ec
1077  push   ds
1078  push   di
1079  mov    ax, 1
107c  push   ax
107d  call   Graph_PutImage
1082  inc    word ptr [bp - 0x1a]
1085  cmp    word ptr [bp - 0x1a], 0x15
1089  jle    0x1090
108b  mov    word ptr [bp - 0x1a], 1
  loc_1090:
1090  mov    ax, word ptr [bp - 0x16]
1093  mov    cx, 5
1096  shl    ax, cl
1098  push   ax
1099  mov    ax, word ptr [bp - 0x18]
109c  mov    cx, 3
109f  shl    ax, cl
10a1  push   ax
10a2  mov    di, word ptr [bp - 0x1a]
10a5  mov    al, byte ptr [di + 0x267]
10a9  xor    ah, ah
10ab  mov    dx, 0x54
10ae  mul    dx
10b0  mov    di, ax
10b2  add    di, 0x69ec
10b6  push   ds
10b7  push   di
10b8  mov    ax, 1
10bb  push   ax
10bc  call   Graph_PutImage
10c1  jmp    0x11b3
  loc_10c4:
10c4  cmp    al, 0x3e
10c6  jne    0x113a
10c8  mov    ax, word ptr [bp - 0x16]
10cb  mov    cx, 5
10ce  shl    ax, cl
10d0  push   ax
10d1  mov    ax, word ptr [bp - 0x18]
10d4  mov    cx, 3
10d7  shl    ax, cl
10d9  push   ax
10da  mov    di, word ptr [bp - 0x1a]
10dd  mov    al, byte ptr [di + 0x267]
10e1  xor    ah, ah
10e3  mov    dx, 0x54
10e6  mul    dx
10e8  mov    di, ax
10ea  add    di, 0x69ec
10ee  push   ds
10ef  push   di
10f0  mov    ax, 1
10f3  push   ax
10f4  call   Graph_PutImage
10f9  dec    word ptr [bp - 0x1a]
10fc  cmp    word ptr [bp - 0x1a], 1
1100  jge    0x1107
1102  mov    word ptr [bp - 0x1a], 0x15
  loc_1107:
1107  mov    ax, word ptr [bp - 0x16]
110a  mov    cx, 5
110d  shl    ax, cl
110f  push   ax
1110  mov    ax, word ptr [bp - 0x18]
1113  mov    cx, 3
1116  shl    ax, cl
1118  push   ax
1119  mov    di, word ptr [bp - 0x1a]
111c  mov    al, byte ptr [di + 0x267]
1120  xor    ah, ah
1122  mov    dx, 0x54
1125  mul    dx
1127  mov    di, ax
1129  add    di, 0x69ec
112d  push   ds
112e  push   di
112f  mov    ax, 1
1132  push   ax
1133  call   Graph_PutImage
1138  jmp    0x11b3
  loc_113a:
113a  cmp    al, 0x3f
113c  jne    0x1150
113e  cmp    byte ptr [bp - 0x22], 0
1142  je     0x114a
1144  mov    byte ptr [bp - 0x22], 0
1148  jmp    0x114e
  loc_114a:
114a  mov    byte ptr [bp - 0x22], 1
  loc_114e:
114e  jmp    0x11b3
  loc_1150:
1150  cmp    al, 0x43
1152  jne    0x11b3
1154  xor    ax, ax
1156  push   ax
1157  xor    ax, ax
1159  push   ax
115a  mov    ax, 0x27f
115d  push   ax
115e  mov    ax, 0xc0
1161  push   ax
1162  mov    al, 1
1164  push   ax
1165  call   Graph_SetViewPort
116a  call   Graph_ClearViewPort
116f  xor    ax, ax
1171  mov    word ptr [bp - 2], ax
1174  jmp    0x1179
  loc_1176:
1176  inc    word ptr [bp - 2]
  loc_1179:
1179  xor    ax, ax
117b  mov    word ptr [bp - 4], ax
117e  jmp    0x1183
  loc_1180:
1180  inc    word ptr [bp - 4]
  loc_1183:
1183  mov    ax, word ptr [bp - 4]
1186  mov    bx, ax
1188  mov    ax, word ptr [bp - 2]
118b  mov    dx, 0x19
118e  mul    dx
1190  mov    cx, ax
1192  mov    al, byte ptr [0xa3c5]             ; cur_room
1195  xor    ah, ah
1197  mov    dx, 0x226
119a  mul    dx
119c  mov    di, ax
119e  add    di, cx
11a0  add    di, bx
11a2  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
11a7  cmp    word ptr [bp - 4], 0x17
11ab  jne    0x1180
11ad  cmp    word ptr [bp - 2], 0x13
11b1  jne    0x1176
  loc_11b3:
11b3  jmp    0x1505
  loc_11b6:
11b6  cmp    al, 0x20
11b8  je     0x11bd
11ba  jmp    0x134f
  loc_11bd:
11bd  mov    di, word ptr [bp - 0x1a]
11c0  mov    al, byte ptr [di + 0x267]
11c4  push   ax
11c5  mov    di, 0x168                         ; set cs:0168 = [51,52,53,54,175]
11c8  push   cs
11c9  push   di
11ca  call   Sys_SetIn
11cf  jne    0x11d4
11d1  jmp    0x127f
  loc_11d4:
11d4  xor    ax, ax
11d6  push   ax
11d7  call   Graph_SetColor
11dc  xor    ax, ax
11de  mov    word ptr [bp - 2], ax
11e1  jmp    0x11e6
  loc_11e3:
11e3  inc    word ptr [bp - 2]
  loc_11e6:
11e6  mov    ax, word ptr [bp - 0x16]
11e9  mov    cx, 5
11ec  shl    ax, cl
11ee  push   ax
11ef  mov    ax, word ptr [bp - 0x18]
11f2  mov    cx, 3
11f5  shl    ax, cl
11f7  add    ax, word ptr [bp - 2]
11fa  push   ax
11fb  mov    ax, word ptr [bp - 0x16]
11fe  mov    cx, 5
1201  shl    ax, cl
1203  add    ax, 0x1f
1206  push   ax
1207  mov    ax, word ptr [bp - 0x18]
120a  mov    cx, 3
120d  shl    ax, cl
120f  add    ax, word ptr [bp - 2]
1212  push   ax
1213  call   Graph_Line
1218  cmp    word ptr [bp - 2], 7
121c  jne    0x11e3
121e  mov    ax, 0xf
1221  push   ax
1222  call   Graph_SetColor
1227  mov    ax, word ptr [bp - 0x18]
122a  mov    bx, ax
122c  mov    ax, word ptr [bp - 0x16]
122f  mov    dx, 0x19
1232  mul    dx
1234  mov    cx, ax
1236  mov    al, byte ptr [0xa3c5]             ; cur_room
1239  xor    ah, ah
123b  mov    dx, 0x226
123e  mul    dx
1240  mov    di, ax
1242  add    di, cx
1244  add    di, bx
1246  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
124b  mov    ax, word ptr [bp - 0x16]
124e  mov    cx, 5
1251  shl    ax, cl
1253  push   ax
1254  mov    ax, word ptr [bp - 0x18]
1257  mov    cx, 3
125a  shl    ax, cl
125c  push   ax
125d  mov    di, word ptr [bp - 0x1a]
1260  mov    al, byte ptr [di + 0x267]
1264  xor    ah, ah
1266  mov    dx, 0x54
1269  mul    dx
126b  mov    di, ax
126d  add    di, 0x69ec
1271  push   ds
1272  push   di
1273  mov    ax, 1
1276  push   ax
1277  call   Graph_PutImage
127c  jmp    0x134c
  loc_127f:
127f  xor    ax, ax
1281  push   ax
1282  call   Graph_SetColor
1287  xor    ax, ax
1289  mov    word ptr [bp - 2], ax
128c  jmp    0x1291
  loc_128e:
128e  inc    word ptr [bp - 2]
  loc_1291:
1291  mov    ax, word ptr [bp - 0x16]
1294  mov    cx, 5
1297  shl    ax, cl
1299  push   ax
129a  mov    ax, word ptr [bp - 0x18]
129d  mov    cx, 3
12a0  shl    ax, cl
12a2  add    ax, word ptr [bp - 2]
12a5  push   ax
12a6  mov    ax, word ptr [bp - 0x16]
12a9  mov    cx, 5
12ac  shl    ax, cl
12ae  add    ax, 0x1f
12b1  push   ax
12b2  mov    ax, word ptr [bp - 0x18]
12b5  mov    cx, 3
12b8  shl    ax, cl
12ba  add    ax, word ptr [bp - 2]
12bd  push   ax
12be  call   Graph_Line
12c3  cmp    word ptr [bp - 2], 0xf
12c7  jne    0x128e
12c9  mov    ax, 0xf
12cc  push   ax
12cd  call   Graph_SetColor
12d2  mov    ax, word ptr [bp - 0x18]
12d5  mov    bx, ax
12d7  mov    ax, word ptr [bp - 0x16]
12da  mov    dx, 0x19
12dd  mul    dx
12df  mov    cx, ax
12e1  mov    al, byte ptr [0xa3c5]             ; cur_room
12e4  xor    ah, ah
12e6  mov    dx, 0x226
12e9  mul    dx
12eb  mov    di, ax
12ed  add    di, cx
12ef  add    di, bx
12f1  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
12f6  mov    ax, word ptr [bp - 0x18]
12f9  inc    ax
12fa  mov    bx, ax
12fc  mov    ax, word ptr [bp - 0x16]
12ff  mov    dx, 0x19
1302  mul    dx
1304  mov    cx, ax
1306  mov    al, byte ptr [0xa3c5]             ; cur_room
1309  xor    ah, ah
130b  mov    dx, 0x226
130e  mul    dx
1310  mov    di, ax
1312  add    di, cx
1314  add    di, bx
1316  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
131b  mov    ax, word ptr [bp - 0x16]
131e  mov    cx, 5
1321  shl    ax, cl
1323  push   ax
1324  mov    ax, word ptr [bp - 0x18]
1327  mov    cx, 3
132a  shl    ax, cl
132c  push   ax
132d  mov    di, word ptr [bp - 0x1a]
1330  mov    al, byte ptr [di + 0x267]
1334  xor    ah, ah
1336  mov    dx, 0x54
1339  mul    dx
133b  mov    di, ax
133d  add    di, 0x69ec
1341  push   ds
1342  push   di
1343  mov    ax, 1
1346  push   ax
1347  call   Graph_PutImage
  loc_134c:
134c  jmp    0x1505
  loc_134f:
134f  cmp    al, 0x61
1351  jae    0x1356
1353  jmp    0x1505
  loc_1356:
1356  cmp    al, 0x69
1358  jbe    0x135d
135a  jmp    0x1505
  loc_135d:
135d  mov    al, byte ptr [bp - 0x1b]
1360  xor    ah, ah
1362  sub    ax, 0x60
1365  mov    di, ax
1367  mov    al, byte ptr [di - 0x463d]        ; +room_grid
136b  push   ax
136c  mov    di, 0x61                          ; set cs:0061 = [1,2,3,4,5,6,7,8,9]
136f  push   cs
1370  push   di
1371  call   Sys_SetIn
1376  jne    0x137b
1378  jmp    0x1503
  loc_137b:
137b  call   Graph_ClearDevice
1380  mov    al, byte ptr [bp - 0x1b]
1383  xor    ah, ah
1385  sub    ax, 0x60
1388  mov    byte ptr [0xa3c9], al             ; start_room
138b  mov    al, byte ptr [bp - 0x1b]
138e  xor    ah, ah
1390  sub    ax, 0x60
1393  mov    di, ax
1395  mov    al, byte ptr [di - 0x463d]        ; +room_grid
1399  mov    byte ptr [0xa3c5], al             ; cur_room
139c  xor    ax, ax
139e  mov    word ptr [bp - 2], ax
13a1  jmp    0x13a6
  loc_13a3:
13a3  inc    word ptr [bp - 2]
  loc_13a6:
13a6  xor    ax, ax
13a8  mov    word ptr [bp - 4], ax
13ab  jmp    0x13b0
  loc_13ad:
13ad  inc    word ptr [bp - 4]
  loc_13b0:
13b0  mov    ax, word ptr [bp - 4]
13b3  mov    bx, ax
13b5  mov    ax, word ptr [bp - 2]
13b8  mov    dx, 0x19
13bb  mul    dx
13bd  mov    cx, ax
13bf  mov    al, byte ptr [0xa3c5]             ; cur_room
13c2  xor    ah, ah
13c4  mov    dx, 0x226
13c7  mul    dx
13c9  mov    di, ax
13cb  add    di, cx
13cd  add    di, bx
13cf  mov    al, byte ptr [di - 0x4a70]        ; +rooms
13d3  push   ax
13d4  mov    di, 0x108                         ; set cs:0108 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,175]
13d7  push   cs
13d8  push   di
13d9  call   Sys_SetIn
13de  je     0x142c
13e0  mov    ax, word ptr [bp - 2]
13e3  mov    cx, 5
13e6  shl    ax, cl
13e8  push   ax
13e9  mov    ax, word ptr [bp - 4]
13ec  mov    cx, 3
13ef  shl    ax, cl
13f1  push   ax
13f2  mov    ax, word ptr [bp - 4]
13f5  mov    bx, ax
13f7  mov    ax, word ptr [bp - 2]
13fa  mov    dx, 0x19
13fd  mul    dx
13ff  mov    cx, ax
1401  mov    al, byte ptr [0xa3c5]             ; cur_room
1404  xor    ah, ah
1406  mov    dx, 0x226
1409  mul    dx
140b  mov    di, ax
140d  add    di, cx
140f  add    di, bx
1411  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1415  xor    ah, ah
1417  mov    dx, 0x54
141a  mul    dx
141c  mov    di, ax
141e  add    di, 0x69ec
1422  push   ds
1423  push   di
1424  xor    ax, ax
1426  push   ax
1427  call   Graph_PutImage
  loc_142c:
142c  cmp    word ptr [bp - 4], 0x17
1430  je     0x1435
1432  jmp    0x13ad
  loc_1435:
1435  cmp    word ptr [bp - 2], 0x13
1439  je     0x143e
143b  jmp    0x13a3
  loc_143e:
143e  mov    ax, word ptr [bp - 0x16]
1441  mov    cx, 5
1444  shl    ax, cl
1446  push   ax
1447  mov    ax, word ptr [bp - 0x18]
144a  mov    cx, 3
144d  shl    ax, cl
144f  push   ax
1450  mov    di, word ptr [bp - 0x1a]
1453  mov    al, byte ptr [di + 0x267]
1457  xor    ah, ah
1459  mov    dx, 0x54
145c  mul    dx
145e  mov    di, ax
1460  add    di, 0x69ec
1464  push   ds
1465  push   di
1466  mov    ax, 1
1469  push   ax
146a  call   Graph_PutImage
146f  xor    ax, ax
1471  push   ax
1472  call   Graph_SetColor
1477  mov    word ptr [bp - 2], 0xc1
147c  jmp    0x1481
  loc_147e:
147e  inc    word ptr [bp - 2]
  loc_1481:
1481  mov    ax, 0x1e
1484  push   ax
1485  push   word ptr [bp - 2]
1488  mov    ax, 0x3c
148b  push   ax
148c  push   word ptr [bp - 2]
148f  call   Graph_Line
1494  cmp    word ptr [bp - 2], 0xc7
1499  jne    0x147e
149b  mov    ax, 0xf
149e  push   ax
149f  call   Graph_SetColor
14a4  mov    al, byte ptr [0xa3bc]             ; stage
14a7  xor    ah, ah
14a9  xor    dx, dx
14ab  push   dx
14ac  push   ax
14ad  xor    ax, ax
14af  push   ax
14b0  mov    di, 0xb090                        ; &text_buf
14b3  push   ds
14b4  push   di
14b5  mov    ax, 0xff
14b8  push   ax
14b9  call   Sys_StrLong
14be  mov    ax, 5
14c1  push   ax
14c2  mov    ax, 0x14
14c5  push   ax
14c6  lea    di, [bp - 0x222]
14ca  push   ss
14cb  push   di
14cc  mov    di, 0xf7                          ; cs:'stage '
14cf  push   cs
14d0  push   di
14d1  call   Sys_StrAssign
14d6  mov    di, 0xb090                        ; &text_buf
14d9  push   ds
14da  push   di
14db  call   Sys_StrConcat
14e0  mov    di, 0xfe                          ; cs:'    room '
14e3  push   cs
14e4  push   di
14e5  call   Sys_StrConcat
14ea  lea    di, [bp - 0x322]
14ee  push   ss
14ef  push   di
14f0  mov    al, byte ptr [bp - 0x1b]
14f3  push   ax
14f4  call   Sys_CharToStr
14f9  call   Sys_StrConcat
14fe  call   draw_text
  loc_1503:
1503  jmp    0x1505
  loc_1505:
1505  cmp    byte ptr [bp - 0x1b], 0x1b
1509  je     0x150e
150b  jmp    0xd3c
  loc_150e:
150e  lea    di, [bp - 0x122]
1512  push   ss
1513  push   di
1514  mov    ax, 0x226
1517  push   ax
1518  call   Sys_ResetFile
151d  call   Sys_IOCheck
1522  lea    di, [bp - 0x122]
1526  push   ss
1527  push   di
1528  mov    di, 0xb590                        ; &rooms
152b  push   ds
152c  push   di
152d  call   Sys_ReadRec
1532  add    sp, 4
1535  call   Sys_IOCheck
153a  mov    word ptr [bp - 8], 1
153f  mov    al, byte ptr [0xa3bc]             ; stage
1542  xor    ah, ah
1544  cdq
1545  mov    cx, 0x14
1548  idiv   cx
154a  xchg   dx, ax
154b  mov    bx, ax
154d  mov    al, byte ptr [0xa3bc]             ; stage
1550  xor    ah, ah
1552  cdq
1553  mov    cx, 0x14
1556  idiv   cx
1558  mov    dx, 0x19
155b  mul    dx
155d  mov    di, ax
155f  add    di, bx
1561  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1565  push   ax
1566  mov    di, 0x61                          ; set cs:0061 = [1,2,3,4,5,6,7,8,9]
1569  push   cs
156a  push   di
156b  call   Sys_SetIn
1570  je     0x15c4
1572  cmp    byte ptr [0xa3bc], 1              ; stage
1577  jbe    0x15c4
1579  mov    al, byte ptr [0xa3bc]             ; stage
157c  xor    ah, ah
157e  dec    ax
157f  mov    word ptr [bp - 0x124], ax
1583  mov    ax, 1
1586  cmp    ax, word ptr [bp - 0x124]
158a  jg     0x15c4
158c  mov    word ptr [bp - 2], ax
158f  jmp    0x1594
  loc_1591:
1591  inc    word ptr [bp - 2]
  loc_1594:
1594  mov    ax, word ptr [bp - 2]
1597  cdq
1598  mov    cx, 0x14
159b  idiv   cx
159d  xchg   dx, ax
159e  mov    bx, ax
15a0  mov    ax, word ptr [bp - 2]
15a3  cdq
15a4  mov    cx, 0x14
15a7  idiv   cx
15a9  mov    dx, 0x19
15ac  mul    dx
15ae  mov    di, ax
15b0  add    di, bx
15b2  mov    al, byte ptr [di - 0x4a70]        ; +rooms
15b6  xor    ah, ah
15b8  add    word ptr [bp - 8], ax
15bb  mov    ax, word ptr [bp - 2]
15be  cmp    ax, word ptr [bp - 0x124]
15c2  jne    0x1591
  loc_15c4:
15c4  lea    di, [bp - 0x122]
15c8  push   ss
15c9  push   di
15ca  mov    ax, word ptr [bp - 8]
15cd  cdq
15ce  push   dx
15cf  push   ax
15d0  call   Sys_Seek
15d5  call   Sys_IOCheck
15da  mov    al, byte ptr [0xa3bc]             ; stage
15dd  xor    ah, ah
15df  cdq
15e0  mov    cx, 0x14
15e3  idiv   cx
15e5  xchg   dx, ax
15e6  mov    bx, ax
15e8  mov    al, byte ptr [0xa3bc]             ; stage
15eb  xor    ah, ah
15ed  cdq
15ee  mov    cx, 0x14
15f1  idiv   cx
15f3  mov    dx, 0x19
15f6  mul    dx
15f8  mov    di, ax
15fa  add    di, bx
15fc  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1600  xor    ah, ah
1602  mov    word ptr [bp - 0x124], ax
1606  mov    ax, 1
1609  cmp    ax, word ptr [bp - 0x124]
160d  jg     0x1643
160f  mov    word ptr [bp - 2], ax
1612  jmp    0x1617
  loc_1614:
1614  inc    word ptr [bp - 2]
  loc_1617:
1617  lea    di, [bp - 0x122]
161b  push   ss
161c  push   di
161d  mov    ax, word ptr [bp - 2]
1620  mov    dx, 0x226
1623  mul    dx
1625  mov    di, ax
1627  add    di, 0xb590
162b  push   ds
162c  push   di
162d  call   Sys_WriteRec
1632  add    sp, 4
1635  call   Sys_IOCheck
163a  mov    ax, word ptr [bp - 2]
163d  cmp    ax, word ptr [bp - 0x124]
1641  jne    0x1614
  loc_1643:
1643  lea    di, [bp - 0x122]
1647  push   ss
1648  push   di
1649  call   Sys_Close
164e  call   Sys_IOCheck
  loc_1653:
1653  call   Graph_ClearDevice
1658  mov    ax, 0xf
165b  push   ax
165c  call   Graph_SetColor
1661  xor    ax, ax
1663  push   ax
1664  xor    ax, ax
1666  push   ax
1667  mov    ax, 0x27f
166a  push   ax
166b  mov    ax, 0xc7
166e  push   ax
166f  call   Graph_Rectangle
1674  mov    ax, 5
1677  push   ax
1678  mov    ax, 5
167b  push   ax
167c  mov    di, 0x188                         ; cs:'1  edit more'
167f  push   cs
1680  push   di
1681  call   draw_text
1686  mov    ax, 5
1689  push   ax
168a  mov    ax, 8
168d  push   ax
168e  mov    di, 0x195                         ; cs:'2  exit edit mode'
1691  push   cs
1692  push   di
1693  call   draw_text
1698  call   Crt_ReadKey
169d  mov    byte ptr [bp - 0x1b], al
16a0  cmp    byte ptr [bp - 0x1b], 0x31
16a4  jne    0x16a9
16a6  jmp    0x544
  loc_16a9:
16a9  mov    sp, bp
16ab  pop    bp
16ac  retf
16ad  db 00,00,00

;==============================================================================
; SEGMENT 08e2  GAMELIB   (linear 08e20..0c930)
;==============================================================================

; ------------------------------------------------------------
chain_old_isr:
0000  push   bp
0001  mov    bp, sp
0003  pop    bp
0004  pop    ax
0005  pop    bx
0006  pop    cx
0007  pop    dx
0008  sti
0009  pushf
000a  cli
000b  push   bx
000c  push   ax
000d  push   dx
000e  push   cx
000f  retf
0010  db 89,ec,5d,ca,04,00

; ------------------------------------------------------------
keyboard_isr:
0016  push   ax
0017  push   bx
0018  push   cx
0019  push   dx
001a  push   si
001b  push   di
001c  push   ds
001d  push   es
001e  push   bp
001f  mov    bp, sp
0021  mov    ax, 0x1161                        ; seg DATA
0024  mov    ds, ax
0026  cli
0027  in     al, 0x60
0029  mov    byte ptr [0xa3b7], al             ; scan_code
002c  push   word ptr [0x69e6]
0030  push   word ptr [0x69e4]
0034  push   cs
0035  call   chain_old_isr
0038  sti
0039  mov    sp, bp
003b  pop    bp
003c  pop    es
003d  pop    ds
003e  pop    di
003f  pop    si
0040  pop    dx
0041  pop    cx
0042  pop    bx
0043  pop    ax
0044  iret

; ------------------------------------------------------------
timer_isr:
0045  push   ax
0046  push   bx
0047  push   cx
0048  push   dx
0049  push   si
004a  push   di
004b  push   ds
004c  push   es
004d  push   bp
004e  mov    bp, sp
0050  mov    ax, 0x1161                        ; seg DATA
0053  mov    ds, ax
0055  cli
0056  inc    word ptr [0xb07e]                 ; tune_pos
005a  mov    ax, word ptr [0xb07e]             ; tune_pos
005d  cmp    ax, word ptr [0xb066]             ; tune_len
0061  jne    0x68
0063  xor    ax, ax
0065  mov    word ptr [0xb07e], ax             ; tune_pos
  loc_0068:
0068  mov    di, word ptr [0xb07e]             ; tune_pos
006c  shl    di, 1
006e  mov    ax, word ptr [di - 0x5c34]        ; +tune
0072  sub    ax, 0xa
0075  push   ax
0076  call   Crt_Sound
007b  mov    di, word ptr [0xb07e]             ; tune_pos
007f  shl    di, 1
0081  push   word ptr [di - 0x5c34]            ; +tune
0085  call   Crt_Sound
008a  mov    di, word ptr [0xb07e]             ; tune_pos
008e  shl    di, 1
0090  mov    ax, word ptr [di - 0x5c34]        ; +tune
0094  add    ax, 0xa
0097  push   ax
0098  call   Crt_Sound
009d  mov    di, word ptr [0xb07e]             ; tune_pos
00a1  shl    di, 1
00a3  push   word ptr [di - 0x5c34]            ; +tune
00a7  call   Crt_Sound
00ac  push   word ptr [0x69ea]
00b0  push   word ptr [0x69e8]
00b4  push   cs
00b5  call   chain_old_isr
00b8  sti
00b9  mov    sp, bp
00bb  pop    bp
00bc  pop    es
00bd  pop    ds
00be  pop    di
00bf  pop    si
00c0  pop    dx
00c1  pop    cx
00c2  pop    bx
00c3  pop    ax
00c4  iret
00c5  db 7,'0000000'

; ------------------------------------------------------------
zero_pad:
00cd  push   bp
00ce  mov    bp, sp
00d0  sub    sp, 0x100
00d4  lea    di, [bp - 0x100]
00d8  push   ss
00d9  push   di
00da  mov    di, 0xc5                          ; cs:'0000000'
00dd  push   cs
00de  push   di
00df  mov    ax, 1
00e2  push   ax
00e3  les    di, ptr [bp + 0xa]
00e6  mov    al, byte ptr es:[di]
00e9  xor    ah, ah
00eb  mov    dx, ax
00ed  mov    al, byte ptr [bp + 8]
00f0  xor    ah, ah
00f2  sub    ax, dx
00f4  push   ax
00f5  call   Sys_Copy
00fa  les    di, ptr [bp + 0xa]
00fd  push   es
00fe  push   di
00ff  call   Sys_StrConcat
0104  les    di, ptr [bp + 0xa]
0107  push   es
0108  push   di
0109  mov    ax, 0xff
010c  push   ax
010d  call   Sys_StrStore
0112  mov    sp, bp
0114  pop    bp
0115  retf   8

; ------------------------------------------------------------
draw_status_number:
0118  push   bp
0119  mov    bp, sp
011b  mov    al, byte ptr [bp + 6]
011e  xor    ah, ah
0120  cmp    ax, 1
0123  jne    0x17f
0125  mov    ax, 0x78
0128  push   ax
0129  mov    ax, 0xc1
012c  push   ax
012d  mov    al, byte ptr [0xa3bc]             ; stage
0130  xor    ah, ah
0132  cdq
0133  mov    cx, 0xa
0136  idiv   cx
0138  add    ax, 0x8b
013b  mov    dx, 0x54
013e  mul    dx
0140  mov    di, ax
0142  add    di, 0x69ec
0146  push   ds
0147  push   di
0148  xor    ax, ax
014a  push   ax
014b  call   Graph_PutImage
0150  mov    ax, 0x8c
0153  push   ax
0154  mov    ax, 0xc1
0157  push   ax
0158  mov    al, byte ptr [0xa3bc]             ; stage
015b  xor    ah, ah
015d  cdq
015e  mov    cx, 0xa
0161  idiv   cx
0163  xchg   dx, ax
0164  add    ax, 0x8b
0167  mov    dx, 0x54
016a  mul    dx
016c  mov    di, ax
016e  add    di, 0x69ec
0172  push   ds
0173  push   di
0174  xor    ax, ax
0176  push   ax
0177  call   Graph_PutImage
017c  jmp    0x275
  loc_017f:
017f  cmp    ax, 2
0182  je     0x187
0184  jmp    0x219
  loc_0187:
0187  push   word ptr [0xb036]                 ; score+2
018b  push   word ptr [0xb034]                 ; score
018f  xor    ax, ax
0191  push   ax
0192  mov    di, 0xb090                        ; &text_buf
0195  push   ds
0196  push   di
0197  mov    ax, 0xff
019a  push   ax
019b  call   Sys_StrLong
01a0  mov    di, 0xb090                        ; &text_buf
01a3  push   ds
01a4  push   di
01a5  mov    al, 8
01a7  push   ax
01a8  push   bp
01a9  push   cs
01aa  call   zero_pad
01ad  les    ax, ptr [0xb034]                  ; score
01b1  mov    dx, es
01b3  cmp    dx, word ptr [0xb03a]             ; hi_score+2
01b7  jg     0x1c1
01b9  jl     0x1ce
01bb  cmp    ax, word ptr [0xb038]             ; hi_score
01bf  jbe    0x1ce
  loc_01c1:
01c1  les    ax, ptr [0xb034]                  ; score
01c5  mov    dx, es
01c7  mov    word ptr [0xb038], ax             ; hi_score
01ca  mov    word ptr [0xb03a], dx             ; hi_score+2
  loc_01ce:
01ce  mov    byte ptr [0xa3c1], 1              ; scratch
01d3  jmp    0x1d9
  loc_01d5:
01d5  inc    byte ptr [0xa3c1]                 ; scratch
  loc_01d9:
01d9  mov    al, byte ptr [0xa3c1]             ; scratch
01dc  xor    ah, ah
01de  mov    cx, 0x14
01e1  imul   cx
01e3  add    ax, 0x12c
01e6  push   ax
01e7  mov    ax, 0xc1
01ea  push   ax
01eb  mov    al, byte ptr [0xa3c1]             ; scratch
01ee  xor    ah, ah
01f0  mov    di, ax
01f2  mov    al, byte ptr [di - 0x4f70]        ; +text_buf
01f6  xor    ah, ah
01f8  add    ax, 0x5b
01fb  mov    dx, 0x54
01fe  mul    dx
0200  mov    di, ax
0202  add    di, 0x69ec
0206  push   ds
0207  push   di
0208  xor    ax, ax
020a  push   ax
020b  call   Graph_PutImage
0210  cmp    byte ptr [0xa3c1], 8              ; scratch
0215  jne    0x1d5
0217  jmp    0x275
  loc_0219:
0219  cmp    ax, 3
021c  jne    0x275
021e  mov    ax, 0x258
0221  push   ax
0222  mov    ax, 0xc1
0225  push   ax
0226  mov    al, byte ptr [0xa3b9]             ; lives
0229  xor    ah, ah
022b  cdq
022c  mov    cx, 0xa
022f  idiv   cx
0231  add    ax, 0x8b
0234  mov    dx, 0x54
0237  mul    dx
0239  mov    di, ax
023b  add    di, 0x69ec
023f  push   ds
0240  push   di
0241  xor    ax, ax
0243  push   ax
0244  call   Graph_PutImage
0249  mov    ax, 0x26c
024c  push   ax
024d  mov    ax, 0xc1
0250  push   ax
0251  mov    al, byte ptr [0xa3b9]             ; lives
0254  xor    ah, ah
0256  cdq
0257  mov    cx, 0xa
025a  idiv   cx
025c  xchg   dx, ax
025d  add    ax, 0x8b
0260  mov    dx, 0x54
0263  mul    dx
0265  mov    di, ax
0267  add    di, 0x69ec
026b  push   ds
026c  push   di
026d  xor    ax, ax
026f  push   ax
0270  call   Graph_PutImage
  loc_0275:
0275  mov    sp, bp
0277  pop    bp
0278  retf   2
027b  db fe,03,00,00,00,00,00,00,00,00,00,00,00,00,00,00
028b  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00

; ------------------------------------------------------------
move_to_next_room:
029b  push   bp
029c  mov    bp, sp
029e  sub    sp, 0xa
02a1  mov    byte ptr [bp - 9], 1
02a5  jmp    0x2aa
  loc_02a7:
02a7  inc    byte ptr [bp - 9]
  loc_02aa:
02aa  mov    al, byte ptr [bp - 9]
02ad  xor    ah, ah
02af  mov    di, ax
02b1  mov    al, byte ptr [di - 0x463d]        ; +room_grid
02b5  les    di, ptr [bp + 0xe]
02b8  cmp    al, byte ptr es:[di]
02bb  jne    0x2c3
02bd  mov    al, byte ptr [bp - 9]
02c0  mov    byte ptr [bp - 1], al
  loc_02c3:
02c3  cmp    byte ptr [bp - 9], 9
02c7  jne    0x2a7
02c9  les    di, ptr [bp + 0xa]
02cc  cmp    word ptr es:[di], 0x14
02d0  jl     0x2d5
02d2  jmp    0x398
  loc_02d5:
02d5  mov    byte ptr [bp - 9], 1
02d9  jmp    0x2de
  loc_02db:
02db  inc    byte ptr [bp - 9]
  loc_02de:
02de  mov    al, byte ptr [bp - 9]
02e1  xor    ah, ah
02e3  mov    bx, ax
02e5  mov    al, byte ptr [bp - 1]
02e8  xor    ah, ah
02ea  dec    ax
02eb  cdq
02ec  mov    cx, 3
02ef  idiv   cx
02f1  mov    cx, 3
02f4  imul   cx
02f6  add    ax, bx
02f8  mov    byte ptr [bp - 0xa], al
02fb  mov    al, byte ptr [bp - 0xa]
02fe  xor    ah, ah
0300  mov    di, ax
0302  mov    dl, byte ptr [di - 0x463d]        ; +room_grid
0306  mov    al, byte ptr [bp - 9]
0309  xor    ah, ah
030b  mov    di, ax
030d  mov    byte ptr [bp + di - 9], dl
0310  mov    al, byte ptr [bp - 0xa]
0313  xor    ah, ah
0315  mov    di, ax
0317  mov    dl, byte ptr [di - 0x463d]        ; +room_grid
031b  mov    al, byte ptr [bp - 9]
031e  xor    ah, ah
0320  add    ax, 3
0323  mov    di, ax
0325  mov    byte ptr [bp + di - 9], dl
0328  cmp    byte ptr [bp - 9], 3
032c  jne    0x2db
032e  les    di, ptr [bp + 0xa]
0331  mov    word ptr es:[di], 0x26c
0336  mov    al, byte ptr [bp - 1]
0339  xor    ah, ah
033b  dec    ax
033c  cdq
033d  mov    cx, 3
0340  idiv   cx
0342  xchg   dx, ax
0343  add    ax, 3
0346  cmp    al, 1
0348  jb     0x398
034a  mov    byte ptr [bp - 9], al
034d  jmp    0x352
  loc_034f:
034f  dec    byte ptr [bp - 9]
  loc_0352:
0352  mov    al, byte ptr [bp - 9]
0355  xor    ah, ah
0357  mov    di, ax
0359  mov    al, byte ptr [bp + di - 9]
035c  push   ax
035d  mov    di, 0x27b                         ; set cs:027b = [1,2,3,4,5,6,7,8,9]
0360  push   cs
0361  push   di
0362  call   Sys_SetIn
0367  je     0x392
0369  mov    al, byte ptr [bp - 1]
036c  xor    ah, ah
036e  dec    ax
036f  cdq
0370  mov    cx, 3
0373  idiv   cx
0375  mov    cx, 3
0378  imul   cx
037a  mov    bx, ax
037c  mov    al, byte ptr [bp - 9]
037f  xor    ah, ah
0381  dec    ax
0382  cdq
0383  mov    cx, 3
0386  idiv   cx
0388  xchg   dx, ax
0389  add    ax, bx
038b  inc    ax
038c  mov    byte ptr [bp - 1], al
038f  jmp    0x60c
  loc_0392:
0392  cmp    byte ptr [bp - 9], 1
0396  jne    0x34f
  loc_0398:
0398  les    di, ptr [bp + 0xa]
039b  cmp    word ptr es:[di], 0x26c
03a0  jg     0x3a5
03a2  jmp    0x468
  loc_03a5:
03a5  mov    byte ptr [bp - 9], 1
03a9  jmp    0x3ae
  loc_03ab:
03ab  inc    byte ptr [bp - 9]
  loc_03ae:
03ae  mov    al, byte ptr [bp - 9]
03b1  xor    ah, ah
03b3  mov    bx, ax
03b5  mov    al, byte ptr [bp - 1]
03b8  xor    ah, ah
03ba  dec    ax
03bb  cdq
03bc  mov    cx, 3
03bf  idiv   cx
03c1  mov    cx, 3
03c4  imul   cx
03c6  add    ax, bx
03c8  mov    byte ptr [bp - 0xa], al
03cb  mov    al, byte ptr [bp - 0xa]
03ce  xor    ah, ah
03d0  mov    di, ax
03d2  mov    dl, byte ptr [di - 0x463d]        ; +room_grid
03d6  mov    al, byte ptr [bp - 9]
03d9  xor    ah, ah
03db  mov    di, ax
03dd  mov    byte ptr [bp + di - 9], dl
03e0  mov    al, byte ptr [bp - 0xa]
03e3  xor    ah, ah
03e5  mov    di, ax
03e7  mov    dl, byte ptr [di - 0x463d]        ; +room_grid
03eb  mov    al, byte ptr [bp - 9]
03ee  xor    ah, ah
03f0  add    ax, 3
03f3  mov    di, ax
03f5  mov    byte ptr [bp + di - 9], dl
03f8  cmp    byte ptr [bp - 9], 3
03fc  jne    0x3ab
03fe  les    di, ptr [bp + 0xa]
0401  mov    word ptr es:[di], 0x14
0406  mov    al, byte ptr [bp - 1]
0409  xor    ah, ah
040b  dec    ax
040c  cdq
040d  mov    cx, 3
0410  idiv   cx
0412  xchg   dx, ax
0413  add    ax, 2
0416  cmp    al, 6
0418  ja     0x468
041a  mov    byte ptr [bp - 9], al
041d  jmp    0x422
  loc_041f:
041f  inc    byte ptr [bp - 9]
  loc_0422:
0422  mov    al, byte ptr [bp - 9]
0425  xor    ah, ah
0427  mov    di, ax
0429  mov    al, byte ptr [bp + di - 9]
042c  push   ax
042d  mov    di, 0x27b                         ; set cs:027b = [1,2,3,4,5,6,7,8,9]
0430  push   cs
0431  push   di
0432  call   Sys_SetIn
0437  je     0x462
0439  mov    al, byte ptr [bp - 1]
043c  xor    ah, ah
043e  dec    ax
043f  cdq
0440  mov    cx, 3
0443  idiv   cx
0445  mov    cx, 3
0448  imul   cx
044a  mov    bx, ax
044c  mov    al, byte ptr [bp - 9]
044f  xor    ah, ah
0451  dec    ax
0452  cdq
0453  mov    cx, 3
0456  idiv   cx
0458  xchg   dx, ax
0459  add    ax, bx
045b  inc    ax
045c  mov    byte ptr [bp - 1], al
045f  jmp    0x60c
  loc_0462:
0462  cmp    byte ptr [bp - 9], 6
0466  jne    0x41f
  loc_0468:
0468  les    di, ptr [bp + 6]
046b  cmp    word ptr es:[di], 0xa
046f  jl     0x474
0471  jmp    0x53a
  loc_0474:
0474  mov    byte ptr [bp - 9], 1
0478  jmp    0x47d
  loc_047a:
047a  inc    byte ptr [bp - 9]
  loc_047d:
047d  mov    al, byte ptr [bp - 9]
0480  xor    ah, ah
0482  dec    ax
0483  mov    cx, 3
0486  imul   cx
0488  mov    bx, ax
048a  mov    al, byte ptr [bp - 1]
048d  xor    ah, ah
048f  dec    ax
0490  cdq
0491  mov    cx, 3
0494  idiv   cx
0496  xchg   dx, ax
0497  add    ax, bx
0499  inc    ax
049a  mov    byte ptr [bp - 0xa], al
049d  mov    al, byte ptr [bp - 0xa]
04a0  xor    ah, ah
04a2  mov    di, ax
04a4  mov    dl, byte ptr [di - 0x463d]        ; +room_grid
04a8  mov    al, byte ptr [bp - 9]
04ab  xor    ah, ah
04ad  mov    di, ax
04af  mov    byte ptr [bp + di - 9], dl
04b2  mov    al, byte ptr [bp - 0xa]
04b5  xor    ah, ah
04b7  mov    di, ax
04b9  mov    dl, byte ptr [di - 0x463d]        ; +room_grid
04bd  mov    al, byte ptr [bp - 9]
04c0  xor    ah, ah
04c2  add    ax, 3
04c5  mov    di, ax
04c7  mov    byte ptr [bp + di - 9], dl
04ca  cmp    byte ptr [bp - 9], 3
04ce  jne    0x47a
04d0  les    di, ptr [bp + 6]
04d3  mov    word ptr es:[di], 0xb4
04d8  mov    al, byte ptr [bp - 1]
04db  xor    ah, ah
04dd  dec    ax
04de  cdq
04df  mov    cx, 3
04e2  idiv   cx
04e4  add    ax, 3
04e7  cmp    al, 1
04e9  jb     0x53a
04eb  mov    byte ptr [bp - 9], al
04ee  jmp    0x4f3
  loc_04f0:
04f0  dec    byte ptr [bp - 9]
  loc_04f3:
04f3  mov    al, byte ptr [bp - 9]
04f6  xor    ah, ah
04f8  mov    di, ax
04fa  mov    al, byte ptr [bp + di - 9]
04fd  push   ax
04fe  mov    di, 0x27b                         ; set cs:027b = [1,2,3,4,5,6,7,8,9]
0501  push   cs
0502  push   di
0503  call   Sys_SetIn
0508  je     0x534
050a  mov    al, byte ptr [bp - 1]
050d  xor    ah, ah
050f  dec    ax
0510  cdq
0511  mov    cx, 3
0514  idiv   cx
0516  xchg   dx, ax
0517  mov    bx, ax
0519  mov    al, byte ptr [bp - 9]
051c  xor    ah, ah
051e  dec    ax
051f  cdq
0520  mov    cx, 3
0523  idiv   cx
0525  xchg   dx, ax
0526  mov    cx, 3
0529  imul   cx
052b  add    ax, bx
052d  inc    ax
052e  mov    byte ptr [bp - 1], al
0531  jmp    0x60c
  loc_0534:
0534  cmp    byte ptr [bp - 9], 1
0538  jne    0x4f0
  loc_053a:
053a  les    di, ptr [bp + 6]
053d  cmp    word ptr es:[di], 0xb4
0542  jg     0x547
0544  jmp    0x60c
  loc_0547:
0547  mov    byte ptr [bp - 9], 1
054b  jmp    0x550
  loc_054d:
054d  inc    byte ptr [bp - 9]
  loc_0550:
0550  mov    al, byte ptr [bp - 9]
0553  xor    ah, ah
0555  dec    ax
0556  mov    cx, 3
0559  imul   cx
055b  mov    bx, ax
055d  mov    al, byte ptr [bp - 1]
0560  xor    ah, ah
0562  dec    ax
0563  cdq
0564  mov    cx, 3
0567  idiv   cx
0569  xchg   dx, ax
056a  add    ax, bx
056c  inc    ax
056d  mov    byte ptr [bp - 0xa], al
0570  mov    al, byte ptr [bp - 0xa]
0573  xor    ah, ah
0575  mov    di, ax
0577  mov    dl, byte ptr [di - 0x463d]        ; +room_grid
057b  mov    al, byte ptr [bp - 9]
057e  xor    ah, ah
0580  mov    di, ax
0582  mov    byte ptr [bp + di - 9], dl
0585  mov    al, byte ptr [bp - 0xa]
0588  xor    ah, ah
058a  mov    di, ax
058c  mov    dl, byte ptr [di - 0x463d]        ; +room_grid
0590  mov    al, byte ptr [bp - 9]
0593  xor    ah, ah
0595  add    ax, 3
0598  mov    di, ax
059a  mov    byte ptr [bp + di - 9], dl
059d  cmp    byte ptr [bp - 9], 3
05a1  jne    0x54d
05a3  les    di, ptr [bp + 6]
05a6  mov    word ptr es:[di], 0xa
05ab  mov    al, byte ptr [bp - 1]
05ae  xor    ah, ah
05b0  dec    ax
05b1  cdq
05b2  mov    cx, 3
05b5  idiv   cx
05b7  add    ax, 2
05ba  cmp    al, 6
05bc  ja     0x60c
05be  mov    byte ptr [bp - 9], al
05c1  jmp    0x5c6
  loc_05c3:
05c3  inc    byte ptr [bp - 9]
  loc_05c6:
05c6  mov    al, byte ptr [bp - 9]
05c9  xor    ah, ah
05cb  mov    di, ax
05cd  mov    al, byte ptr [bp + di - 9]
05d0  push   ax
05d1  mov    di, 0x27b                         ; set cs:027b = [1,2,3,4,5,6,7,8,9]
05d4  push   cs
05d5  push   di
05d6  call   Sys_SetIn
05db  je     0x606
05dd  mov    al, byte ptr [bp - 1]
05e0  xor    ah, ah
05e2  dec    ax
05e3  cdq
05e4  mov    cx, 3
05e7  idiv   cx
05e9  xchg   dx, ax
05ea  mov    bx, ax
05ec  mov    al, byte ptr [bp - 9]
05ef  xor    ah, ah
05f1  dec    ax
05f2  cdq
05f3  mov    cx, 3
05f6  idiv   cx
05f8  xchg   dx, ax
05f9  mov    cx, 3
05fc  imul   cx
05fe  add    ax, bx
0600  inc    ax
0601  mov    byte ptr [bp - 1], al
0604  jmp    0x60c
  loc_0606:
0606  cmp    byte ptr [bp - 9], 6
060a  jne    0x5c3
  loc_060c:
060c  mov    al, byte ptr [bp - 1]
060f  xor    ah, ah
0611  mov    di, ax
0613  mov    al, byte ptr [di - 0x463d]        ; +room_grid
0617  les    di, ptr [bp + 0xe]
061a  mov    byte ptr es:[di], al
061d  mov    sp, bp
061f  pop    bp
0620  retf   0xc
0623  db 00,00,00,00,00,cc,64,00,00,00,00,00,00,00,00,00
0633  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
0643  db 00,00,00,00,00,cc,7c,00,00,00,00,00,60,80,00,00
0653  db 00,00,80,01,02,80,00,00,00,06,00,40,00,00,00,18
0663  db 00,00,00,00,00,00,18,01,00,00,00,00,60,84,00,00
0673  db 00,00,80,11,02,00,00,00,00,06,00,00,00,00,00,00
0683  db 00,00,00,00,00,00,00,01,00,00,00,00,00,04,00,00
0693  db 00,00,00,10,00,00,00,00,00,40,00,00,00,00,00,00
06a3  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
06b3  db 00,00,00,00,02,00,00,00,00,00,08,00,00,00,00,00

; ------------------------------------------------------------
move_dagger:
06c3  push   bp
06c4  mov    bp, sp
06c6  sub    sp, 4
06c9  mov    ax, word ptr [0xb05e]             ; dagger_y
06cc  sub    ax, 2
06cf  cdq
06d0  mov    cx, 8
06d3  idiv   cx
06d5  mov    bx, ax
06d7  mov    ax, word ptr [0xb060]             ; dagger_dx
06da  mov    cx, 0x15
06dd  imul   cx
06df  mov    dx, ax
06e1  mov    ax, word ptr [0xb05c]             ; dagger_x
06e4  add    ax, 0x10
06e7  sub    ax, dx
06e9  cdq
06ea  mov    cx, 0x20
06ed  idiv   cx
06ef  mov    dx, 0x19
06f2  mul    dx
06f4  mov    cx, ax
06f6  mov    al, byte ptr [0xa3c6]             ; dagger_room
06f9  xor    ah, ah
06fb  mov    dx, 0x226
06fe  mul    dx
0700  mov    di, ax
0702  add    di, cx
0704  add    di, bx
0706  mov    al, byte ptr [di - 0x4a70]        ; +rooms
070a  push   ax
070b  mov    di, 0x623                         ; set cs:0623 = [42,43,46,47,50,53,54,175,222]
070e  push   cs
070f  push   di
0710  call   Sys_SetIn
0715  je     0x71c
0717  xor    ax, ax
0719  mov    word ptr [0xb060], ax             ; dagger_dx
  loc_071c:
071c  cmp    word ptr [0xb060], 0              ; dagger_dx
0721  jne    0x734
0723  inc    word ptr [0xb06a]                 ; dagger_stopped
0727  cmp    word ptr [0xb06a], 0x14           ; dagger_stopped
072c  jle    0x734
072e  mov    word ptr [0xb062], 1              ; dagger_dy
  loc_0734:
0734  mov    al, byte ptr [0xa3c5]             ; cur_room
0737  cmp    al, byte ptr [0xa3c6]             ; dagger_room
073b  je     0x740
073d  jmp    0x7c8
  loc_0740:
0740  push   word ptr [0xb05c]                 ; dagger_x
0744  push   word ptr [0xb05e]                 ; dagger_y
0748  mov    ax, word ptr [0xb064]             ; dagger_spin
074b  cdq
074c  mov    cx, 8
074f  idiv   cx
0751  xchg   dx, ax
0752  add    ax, 0x39
0755  mov    dx, 0x54
0758  mul    dx
075a  mov    di, ax
075c  add    di, 0x69ec
0760  push   ds
0761  push   di
0762  mov    ax, 1
0765  push   ax
0766  call   Graph_PutImage
076b  mov    ax, word ptr [0xb05c]             ; dagger_x
076e  add    ax, 0x10
0771  sub    ax, word ptr [0xb058]             ; player_x
0775  or     ax, ax
0777  jns    0x77b
0779  neg    ax
  loc_077b:
077b  cmp    ax, 6
077e  jge    0x7c8
0780  mov    ax, word ptr [0xb05e]             ; dagger_y
0783  add    ax, 2
0786  sub    ax, word ptr [0xb05a]             ; player_y
078a  or     ax, ax
078c  jns    0x790
078e  neg    ax
  loc_0790:
0790  cmp    ax, 8
0793  jge    0x7c8
0795  cmp    byte ptr [0xa3be], 0              ; held_item
079a  jne    0x7c8
079c  mov    byte ptr [0xcb0c], 0              ; dagger_flying
07a1  mov    byte ptr [0xcb0d], 0              ; dagger_hit
07a6  mov    byte ptr [0xa3be], 2              ; held_item
07ab  xor    ax, ax
07ad  mov    word ptr [0xb062], ax             ; dagger_dy
07b0  xor    ax, ax
07b2  mov    word ptr [0xb06c], ax             ; dagger_hit_step
07b5  xor    ax, ax
07b7  mov    word ptr [0xb06a], ax             ; dagger_stopped
07ba  jmp    0xda4
07bd  db a0,bf,a3,30,e4,d1,e0,48,a3,60,b0
  loc_07c8:
07c8  inc    word ptr [0xb064]                 ; dagger_spin
07cc  mov    ax, word ptr [0xb05e]             ; dagger_y
07cf  sub    ax, 2
07d2  cdq
07d3  mov    cx, 8
07d6  idiv   cx
07d8  mov    bx, ax
07da  mov    ax, word ptr [0xb05c]             ; dagger_x
07dd  add    ax, 0x10
07e0  cdq
07e1  mov    cx, 0x20
07e4  idiv   cx
07e6  mov    dx, 0x19
07e9  mul    dx
07eb  mov    cx, ax
07ed  mov    al, byte ptr [0xa3c6]             ; dagger_room
07f0  xor    ah, ah
07f2  mov    dx, 0x226
07f5  mul    dx
07f7  mov    di, ax
07f9  add    di, cx
07fb  add    di, bx
07fd  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0801  push   ax
0802  mov    di, 0x623                         ; set cs:0623 = [42,43,46,47,50,53,54,175,222]
0805  push   cs
0806  push   di
0807  call   Sys_SetIn
080c  je     0x814
080e  mov    word ptr [0xb062], 1              ; dagger_dy
  loc_0814:
0814  mov    ax, word ptr [0xb060]             ; dagger_dx
0817  mov    cx, 2
081a  shl    ax, cl
081c  sub    word ptr [0xb05c], ax             ; dagger_x
0820  mov    ax, word ptr [0xb062]             ; dagger_dy
0823  add    word ptr [0xb05e], ax             ; dagger_y
0827  cmp    byte ptr [0xcb0d], 0              ; dagger_hit
082c  je     0x83a
082e  mov    ax, word ptr [0xb060]             ; dagger_dx
0831  mov    cx, 3
0834  imul   cx
0836  add    word ptr [0xb05c], ax             ; dagger_x
  loc_083a:
083a  cmp    word ptr [0xb05c], -1             ; dagger_x
083f  jl     0x849
0841  cmp    word ptr [0xb05e], 0xb4           ; dagger_y
0847  jle    0x85c
  loc_0849:
0849  mov    di, 0xa3c6                        ; &dagger_room
084c  push   ds
084d  push   di
084e  mov    di, 0xb05c                        ; &dagger_x
0851  push   ds
0852  push   di
0853  mov    di, 0xb05e                        ; &dagger_y
0856  push   ds
0857  push   di
0858  push   cs
0859  call   move_to_next_room
  loc_085c:
085c  cmp    word ptr [0xb05c], 0x270          ; dagger_x
0862  jle    0x883
0864  mov    word ptr [0xb05c], 0x281          ; dagger_x
086a  mov    di, 0xa3c6                        ; &dagger_room
086d  push   ds
086e  push   di
086f  mov    di, 0xb05c                        ; &dagger_x
0872  push   ds
0873  push   di
0874  mov    di, 0xb05e                        ; &dagger_y
0877  push   ds
0878  push   di
0879  push   cs
087a  call   move_to_next_room
087d  mov    word ptr [0xb05c], 1              ; dagger_x
  loc_0883:
0883  mov    al, byte ptr [0xa3c5]             ; cur_room
0886  cmp    al, byte ptr [0xa3c6]             ; dagger_room
088a  jne    0x8b7
088c  push   word ptr [0xb05c]                 ; dagger_x
0890  push   word ptr [0xb05e]                 ; dagger_y
0894  mov    ax, word ptr [0xb064]             ; dagger_spin
0897  cdq
0898  mov    cx, 8
089b  idiv   cx
089d  xchg   dx, ax
089e  add    ax, 0x39
08a1  mov    dx, 0x54
08a4  mul    dx
08a6  mov    di, ax
08a8  add    di, 0x69ec
08ac  push   ds
08ad  push   di
08ae  mov    ax, 1
08b1  push   ax
08b2  call   Graph_PutImage
  loc_08b7:
08b7  mov    al, byte ptr [0xa3c5]             ; cur_room
08ba  cmp    al, byte ptr [0xa3c6]             ; dagger_room
08be  jne    0x8d8
08c0  mov    ax, word ptr [0xb064]             ; dagger_spin
08c3  cdq
08c4  mov    cx, 8
08c7  idiv   cx
08c9  xchg   dx, ax
08ca  mov    cx, 0x64
08cd  imul   cx
08cf  add    ax, 0x1388
08d2  push   ax
08d3  call   Crt_Sound
  loc_08d8:
08d8  cmp    byte ptr [0xcb0d], 0              ; dagger_hit
08dd  jne    0x8e2
08df  jmp    0xa48
  loc_08e2:
08e2  inc    word ptr [0xb06c]                 ; dagger_hit_step
08e6  mov    ax, word ptr [0xb06c]             ; dagger_hit_step
08e9  cmp    ax, 2
08ec  je     0x8f1
08ee  jmp    0x9bc
  loc_08f1:
08f1  mov    al, 9
08f3  push   ax
08f4  push   word ptr [0xb042]
08f8  push   word ptr [0xb040]                 ; saved_int9
08fc  call   Dos_SetIntVec
0901  mov    al, 8
0903  push   ax
0904  push   word ptr [0xb03e]
0908  push   word ptr [0xb03c]                 ; saved_int8
090c  call   Dos_SetIntVec
0911  mov    word ptr [bp - 2], 1
0916  jmp    0x91b
  loc_0918:
0918  inc    word ptr [bp - 2]
  loc_091b:
091b  xor    ax, ax
091d  mov    word ptr [bp - 4], ax
0920  jmp    0x925
  loc_0922:
0922  inc    word ptr [bp - 4]
  loc_0925:
0925  mov    ax, 7
0928  sub    ax, word ptr [bp - 4]
092b  mov    dx, ax
092d  mov    di, word ptr [bp - 2]
0930  mov    al, byte ptr [di + 0x2555]        ; +pcm_scream
0934  xor    ah, ah
0936  mov    cx, dx
0938  shr    ax, cl
093a  shl    ax, 1
093c  and    ax, 2
093f  mov    dx, ax
0941  in     al, 0x61
0943  and    al, 0xfc
0945  xor    ah, ah
0947  or     ax, dx
0949  out    0x61, al
094b  cmp    word ptr [bp - 4], 7
094f  jne    0x922
0951  cmp    word ptr [bp - 2], 0x187
0956  jne    0x918
0958  mov    al, 9
095a  push   ax
095b  mov    di, 0xb040                        ; &saved_int9
095e  push   ds
095f  push   di
0960  call   Dos_GetIntVec
0965  mov    al, 9
0967  push   ax
0968  mov    ax, 0x16
096b  mov    dx, 0x8e2                         ; seg GAMELIB
096e  push   dx
096f  push   ax
0970  call   Dos_SetIntVec
0975  mov    al, 8
0977  push   ax
0978  mov    di, 0xb03c                        ; &saved_int8
097b  push   ds
097c  push   di
097d  call   Dos_GetIntVec
0982  mov    al, 8
0984  push   ax
0985  mov    ax, 0x45
0988  mov    dx, 0x8e2                         ; seg GAMELIB
098b  push   dx
098c  push   ax
098d  call   Dos_SetIntVec
0992  cmp    byte ptr [0xcb0e], 0              ; player_caught
0997  je     0x9b9
0999  mov    al, 9
099b  push   ax
099c  push   word ptr [0xb042]
09a0  push   word ptr [0xb040]                 ; saved_int9
09a4  call   Dos_SetIntVec
09a9  mov    al, 8
09ab  push   ax
09ac  push   word ptr [0xb03e]
09b0  push   word ptr [0xb03c]                 ; saved_int8
09b4  call   Dos_SetIntVec
  loc_09b9:
09b9  jmp    0xa48
  loc_09bc:
09bc  cmp    ax, 3
09bf  jne    0x9d4
09c1  add    word ptr [0xb034], 0x64           ; score
09c6  adc    word ptr [0xb036], 0              ; score+2
09cb  mov    al, 3
09cd  push   ax
09ce  push   cs
09cf  call   draw_status_number
09d2  jmp    0xa48
  loc_09d4:
09d4  cmp    ax, 4
09d7  jne    0x9e3
09d9  mov    ax, word ptr [0xb060]             ; dagger_dx
09dc  neg    ax
09de  mov    word ptr [0xb060], ax             ; dagger_dx
09e1  jmp    0xa48
  loc_09e3:
09e3  cmp    ax, 5
09e6  jne    0x9f0
09e8  mov    word ptr [0xb062], 0xffff         ; dagger_dy
09ee  jmp    0xa48
  loc_09f0:
09f0  cmp    ax, 6
09f3  jl     0x9fc
09f5  cmp    ax, 0xe
09f8  jg     0x9fc
09fa  jmp    0xa48
  loc_09fc:
09fc  cmp    ax, 0xf
09ff  jne    0xa08
0a01  xor    ax, ax
0a03  mov    word ptr [0xb062], ax             ; dagger_dy
0a06  jmp    0xa48
  loc_0a08:
0a08  cmp    ax, 0x10
0a0b  jl     0xa14
0a0d  cmp    ax, 0x13
0a10  jg     0xa14
0a12  jmp    0xa48
  loc_0a14:
0a14  cmp    ax, 0x14
0a17  jne    0xa21
0a19  mov    word ptr [0xb062], 1              ; dagger_dy
0a1f  jmp    0xa48
  loc_0a21:
0a21  cmp    ax, 0x15
0a24  jl     0xa2d
0a26  cmp    ax, 0x1a
0a29  jg     0xa2d
0a2b  jmp    0xa48
  loc_0a2d:
0a2d  cmp    ax, 0x1b
0a30  jne    0xa39
0a32  xor    ax, ax
0a34  mov    word ptr [0xb060], ax             ; dagger_dx
0a37  jmp    0xa48
  loc_0a39:
0a39  cmp    ax, 0x1c
0a3c  jne    0xa48
0a3e  xor    ax, ax
0a40  mov    word ptr [0xb06c], ax             ; dagger_hit_step
0a43  mov    byte ptr [0xcb0d], 0              ; dagger_hit
  loc_0a48:
0a48  mov    ax, word ptr [0xb05e]             ; dagger_y
0a4b  add    ax, 8
0a4e  cdq
0a4f  mov    cx, 8
0a52  idiv   cx
0a54  mov    bx, ax
0a56  mov    ax, word ptr [0xb05c]             ; dagger_x
0a59  add    ax, 0x10
0a5c  cdq
0a5d  mov    cx, 0x20
0a60  idiv   cx
0a62  mov    dx, 0x19
0a65  mul    dx
0a67  mov    cx, ax
0a69  mov    al, byte ptr [0xa3c6]             ; dagger_room
0a6c  xor    ah, ah
0a6e  mov    dx, 0x226
0a71  mul    dx
0a73  mov    di, ax
0a75  add    di, cx
0a77  add    di, bx
0a79  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0a7d  push   ax
0a7e  mov    di, 0x643                         ; set cs:0643 = [42,43,46,47,50,51,52,53,54,101,102,111,151,152,161,175,201,202,222,251,252]
0a81  push   cs
0a82  push   di
0a83  call   Sys_SetIn
0a88  jne    0xa8d
0a8a  jmp    0xd81
  loc_0a8d:
0a8d  cmp    word ptr [0xb060], 0              ; dagger_dx
0a92  je     0xa97
0a94  jmp    0xd81
  loc_0a97:
0a97  cmp    word ptr [0xb062], 1              ; dagger_dy
0a9c  je     0xaa1
0a9e  jmp    0xd81
  loc_0aa1:
0aa1  mov    al, byte ptr [0xa3c5]             ; cur_room
0aa4  cmp    al, byte ptr [0xa3c6]             ; dagger_room
0aa8  jne    0xad5
0aaa  push   word ptr [0xb05c]                 ; dagger_x
0aae  push   word ptr [0xb05e]                 ; dagger_y
0ab2  mov    ax, word ptr [0xb064]             ; dagger_spin
0ab5  cdq
0ab6  mov    cx, 8
0ab9  idiv   cx
0abb  xchg   dx, ax
0abc  add    ax, 0x39
0abf  mov    dx, 0x54
0ac2  mul    dx
0ac4  mov    di, ax
0ac6  add    di, 0x69ec
0aca  push   ds
0acb  push   di
0acc  mov    ax, 1
0acf  push   ax
0ad0  call   Graph_PutImage
  loc_0ad5:
0ad5  mov    byte ptr [0xcb0c], 0              ; dagger_flying
0ada  cmp    word ptr [0xb06c], 0              ; dagger_hit_step
0adf  jle    0xaeb
0ae1  mov    byte ptr [0xcb0d], 0              ; dagger_hit
0ae6  xor    ax, ax
0ae8  mov    word ptr [0xb06c], ax             ; dagger_hit_step
  loc_0aeb:
0aeb  mov    ax, word ptr [0xb05e]             ; dagger_y
0aee  cdq
0aef  mov    cx, 8
0af2  idiv   cx
0af4  mov    bx, ax
0af6  mov    ax, word ptr [0xb05c]             ; dagger_x
0af9  add    ax, 0x10
0afc  cdq
0afd  mov    cx, 0x20
0b00  idiv   cx
0b02  mov    dx, 0x19
0b05  mul    dx
0b07  mov    cx, ax
0b09  mov    al, byte ptr [0xa3c6]             ; dagger_room
0b0c  xor    ah, ah
0b0e  mov    dx, 0x226
0b11  mul    dx
0b13  mov    di, ax
0b15  add    di, cx
0b17  add    di, bx
0b19  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0b1d  push   ax
0b1e  mov    di, 0x663                         ; set cs:0663 = [51,52,56,101,102,106,111,151,152,156,161,201,202]
0b21  push   cs
0b22  push   di
0b23  call   Sys_SetIn
0b28  je     0xb5f
0b2a  mov    ax, word ptr [0xb05e]             ; dagger_y
0b2d  cdq
0b2e  mov    cx, 8
0b31  idiv   cx
0b33  mov    bx, ax
0b35  mov    ax, word ptr [0xb05c]             ; dagger_x
0b38  add    ax, 0x10
0b3b  cdq
0b3c  mov    cx, 0x20
0b3f  idiv   cx
0b41  mov    dx, 0x19
0b44  mul    dx
0b46  mov    cx, ax
0b48  mov    al, byte ptr [0xa3c6]             ; dagger_room
0b4b  xor    ah, ah
0b4d  mov    dx, 0x226
0b50  mul    dx
0b52  mov    di, ax
0b54  add    di, cx
0b56  add    di, bx
0b58  add    byte ptr [di - 0x4a70], 0x32      ; +rooms
0b5d  jmp    0xb92
  loc_0b5f:
0b5f  mov    ax, word ptr [0xb05e]             ; dagger_y
0b62  cdq
0b63  mov    cx, 8
0b66  idiv   cx
0b68  mov    bx, ax
0b6a  mov    ax, word ptr [0xb05c]             ; dagger_x
0b6d  add    ax, 0x10
0b70  cdq
0b71  mov    cx, 0x20
0b74  idiv   cx
0b76  mov    dx, 0x19
0b79  mul    dx
0b7b  mov    cx, ax
0b7d  mov    al, byte ptr [0xa3c6]             ; dagger_room
0b80  xor    ah, ah
0b82  mov    dx, 0x226
0b85  mul    dx
0b87  mov    di, ax
0b89  add    di, cx
0b8b  add    di, bx
0b8d  mov    byte ptr [di - 0x4a70], 0x38      ; +rooms
  loc_0b92:
0b92  mov    ax, 0x1e
0b95  push   ax
0b96  call   Crt_Sound
0b9b  mov    ax, 0x14
0b9e  push   ax
0b9f  call   Crt_Delay
0ba4  mov    al, byte ptr [0xa3c5]             ; cur_room
0ba7  cmp    al, byte ptr [0xa3c6]             ; dagger_room
0bab  je     0xbb0
0bad  jmp    0xd81
  loc_0bb0:
0bb0  mov    ax, word ptr [0xb05e]             ; dagger_y
0bb3  cdq
0bb4  mov    cx, 8
0bb7  idiv   cx
0bb9  mov    bx, ax
0bbb  mov    ax, word ptr [0xb05c]             ; dagger_x
0bbe  add    ax, 0x10
0bc1  cdq
0bc2  mov    cx, 0x20
0bc5  idiv   cx
0bc7  mov    dx, 0x19
0bca  mul    dx
0bcc  mov    cx, ax
0bce  mov    al, byte ptr [0xa3c6]             ; dagger_room
0bd1  xor    ah, ah
0bd3  mov    dx, 0x226
0bd6  mul    dx
0bd8  mov    di, ax
0bda  add    di, cx
0bdc  add    di, bx
0bde  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0be2  push   ax
0be3  mov    di, 0x683                         ; set cs:0683 = [56,106,156,206]
0be6  push   cs
0be7  push   di
0be8  call   Sys_SetIn
0bed  je     0xc60
0bef  mov    ax, word ptr [0xb05e]             ; dagger_y
0bf2  cdq
0bf3  mov    cx, 8
0bf6  idiv   cx
0bf8  mov    bx, ax
0bfa  mov    ax, word ptr [0xb05c]             ; dagger_x
0bfd  add    ax, 0x10
0c00  cdq
0c01  mov    cx, 0x20
0c04  idiv   cx
0c06  mov    dx, 0x19
0c09  mul    dx
0c0b  mov    cx, ax
0c0d  mov    al, byte ptr [0xa3c6]             ; dagger_room
0c10  xor    ah, ah
0c12  mov    dx, 0x226
0c15  mul    dx
0c17  mov    di, ax
0c19  add    di, cx
0c1b  add    di, bx
0c1d  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0c21  xor    ah, ah
0c23  cdq
0c24  mov    cx, 0x32
0c27  idiv   cx
0c29  mov    bx, ax
0c2b  mov    ax, word ptr [0xb05c]             ; dagger_x
0c2e  add    ax, 0x10
0c31  cdq
0c32  mov    cx, 0x20
0c35  idiv   cx
0c37  mov    cx, 5
0c3a  shl    ax, cl
0c3c  add    ax, bx
0c3e  dec    ax
0c3f  push   ax
0c40  mov    ax, word ptr [0xb05e]             ; dagger_y
0c43  cdq
0c44  mov    cx, 8
0c47  idiv   cx
0c49  mov    cx, 3
0c4c  shl    ax, cl
0c4e  push   ax
0c4f  mov    di, 0x7c4c
0c52  push   ds
0c53  push   di
0c54  mov    ax, 1
0c57  push   ax
0c58  call   Graph_PutImage
0c5d  jmp    0xd81
  loc_0c60:
0c60  mov    ax, word ptr [0xb05e]             ; dagger_y
0c63  cdq
0c64  mov    cx, 8
0c67  idiv   cx
0c69  mov    bx, ax
0c6b  mov    ax, word ptr [0xb05c]             ; dagger_x
0c6e  add    ax, 0x10
0c71  cdq
0c72  mov    cx, 0x20
0c75  idiv   cx
0c77  mov    dx, 0x19
0c7a  mul    dx
0c7c  mov    cx, ax
0c7e  mov    al, byte ptr [0xa3c6]             ; dagger_room
0c81  xor    ah, ah
0c83  mov    dx, 0x226
0c86  mul    dx
0c88  mov    di, ax
0c8a  add    di, cx
0c8c  add    di, bx
0c8e  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0c92  push   ax
0c93  mov    di, 0x6a3                         ; set cs:06a3 = [161,211]
0c96  push   cs
0c97  push   di
0c98  call   Sys_SetIn
0c9d  je     0xd11
0c9f  mov    ax, word ptr [0xb05e]             ; dagger_y
0ca2  cdq
0ca3  mov    cx, 8
0ca6  idiv   cx
0ca8  mov    bx, ax
0caa  mov    ax, word ptr [0xb05c]             ; dagger_x
0cad  add    ax, 0x10
0cb0  cdq
0cb1  mov    cx, 0x20
0cb4  idiv   cx
0cb6  mov    dx, 0x19
0cb9  mul    dx
0cbb  mov    cx, ax
0cbd  mov    al, byte ptr [0xa3c6]             ; dagger_room
0cc0  xor    ah, ah
0cc2  mov    dx, 0x226
0cc5  mul    dx
0cc7  mov    di, ax
0cc9  add    di, cx
0ccb  add    di, bx
0ccd  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0cd1  xor    ah, ah
0cd3  cdq
0cd4  mov    cx, 0x32
0cd7  idiv   cx
0cd9  mov    bx, ax
0cdb  mov    ax, word ptr [0xb05c]             ; dagger_x
0cde  add    ax, 0x10
0ce1  cdq
0ce2  mov    cx, 0x20
0ce5  idiv   cx
0ce7  mov    cx, 5
0cea  shl    ax, cl
0cec  add    ax, bx
0cee  sub    ax, 3
0cf1  push   ax
0cf2  mov    ax, word ptr [0xb05e]             ; dagger_y
0cf5  cdq
0cf6  mov    cx, 8
0cf9  idiv   cx
0cfb  mov    cx, 3
0cfe  shl    ax, cl
0d00  push   ax
0d01  mov    di, 0x7c4c
0d04  push   ds
0d05  push   di
0d06  mov    ax, 1
0d09  push   ax
0d0a  call   Graph_PutImage
0d0f  jmp    0xd81
  loc_0d11:
0d11  mov    ax, word ptr [0xb05e]             ; dagger_y
0d14  cdq
0d15  mov    cx, 8
0d18  idiv   cx
0d1a  mov    bx, ax
0d1c  mov    ax, word ptr [0xb05c]             ; dagger_x
0d1f  add    ax, 0x10
0d22  cdq
0d23  mov    cx, 0x20
0d26  idiv   cx
0d28  mov    dx, 0x19
0d2b  mul    dx
0d2d  mov    cx, ax
0d2f  mov    al, byte ptr [0xa3c6]             ; dagger_room
0d32  xor    ah, ah
0d34  mov    dx, 0x226
0d37  mul    dx
0d39  mov    di, ax
0d3b  add    di, cx
0d3d  add    di, bx
0d3f  mov    al, byte ptr [di - 0x4a70]        ; +rooms
0d43  xor    ah, ah
0d45  cdq
0d46  mov    cx, 0x32
0d49  idiv   cx
0d4b  mov    bx, ax
0d4d  mov    ax, word ptr [0xb05c]             ; dagger_x
0d50  add    ax, 0x10
0d53  cdq
0d54  mov    cx, 0x20
0d57  idiv   cx
0d59  mov    cx, 5
0d5c  shl    ax, cl
0d5e  add    ax, bx
0d60  sub    ax, 2
0d63  push   ax
0d64  mov    ax, word ptr [0xb05e]             ; dagger_y
0d67  cdq
0d68  mov    cx, 8
0d6b  idiv   cx
0d6d  mov    cx, 3
0d70  shl    ax, cl
0d72  push   ax
0d73  mov    di, 0x7c4c
0d76  push   ds
0d77  push   di
0d78  mov    ax, 1
0d7b  push   ax
0d7c  call   Graph_PutImage
  loc_0d81:
0d81  mov    al, byte ptr [0xa3c5]             ; cur_room
0d84  cmp    al, byte ptr [0xa3c6]             ; dagger_room
0d88  je     0xd93
0d8a  mov    ax, 2
0d8d  push   ax
0d8e  call   Crt_Delay
  loc_0d93:
0d93  call   Crt_KeyPressed
0d98  or     al, al
0d9a  je     0xda4
0d9c  call   Crt_ReadKey
0da1  mov    byte ptr [0xb08e], al             ; last_key
  loc_0da4:
0da4  mov    sp, bp
0da6  pop    bp
0da7  retf
0da8  db 00,00,00,00,00,cc,64,00,00,00,00,00,00,00,00,00
0db8  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
0dc8  db 00,00,00,40,0e,00,00,01,00,10,e0,01,10,04,00,00
0dd8  db 00,00,00,10,00,00,00,00,00,40,00,00,00,00,00,00
0de8  db 00,00,00,00,00,00,18,00,00,00,00,00,60,80,00,00
0df8  db 00,00,80,01,02,00,00,00,00,06,08,00,00,00,00,18
0e08  db 00,00,00,00,00,00,64,00,00,00,00,00,00,00,00,00
0e18  db 00,00,00,00,00,80,00,00,00,00,00,40,00,00,00,00
0e28  db 00,00,00,00,00,00,18,00,00,00,00,00,70,80,00,00
0e38  db 00,00,80,01,02,00,00,00,00,06,08,00,00,00,00,18

; ------------------------------------------------------------
move_mummies:
0e48  push   bp
0e49  mov    bp, sp
0e4b  sub    sp, 6
0e4e  mov    ax, 0xf
0e51  push   ax
0e52  call   Graph_SetColor
0e57  mov    byte ptr [0xa3b8], 1              ; mummy_i
0e5c  jmp    0xe62
  loc_0e5e:
0e5e  inc    byte ptr [0xa3b8]                 ; mummy_i
  loc_0e62:
0e62  mov    al, byte ptr [0xa3b8]             ; mummy_i
0e65  xor    ah, ah
0e67  mov    dx, 0x1e
0e6a  mul    dx
0e6c  mov    di, ax
0e6e  cmp    byte ptr [di - 0x502b], 0
0e73  jne    0xe78
0e75  jmp    0x28bb
  loc_0e78:
0e78  mov    al, byte ptr [0xa3b8]             ; mummy_i
0e7b  xor    ah, ah
0e7d  mov    dx, 0x1e
0e80  mul    dx
0e82  mov    di, ax
0e84  inc    word ptr [di - 0x5044]
0e88  mov    al, byte ptr [0xa3b8]             ; mummy_i
0e8b  xor    ah, ah
0e8d  mov    dx, 0x1e
0e90  mul    dx
0e92  mov    di, ax
0e94  mov    al, byte ptr [di - 0x503a]
0e98  cmp    al, byte ptr [0xa3c6]             ; dagger_room
0e9c  je     0xea1
0e9e  jmp    0xf1e
  loc_0ea1:
0ea1  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
0ea6  je     0xf1e
0ea8  mov    al, byte ptr [0xa3b8]             ; mummy_i
0eab  xor    ah, ah
0ead  mov    dx, 0x1e
0eb0  mul    dx
0eb2  mov    di, ax
0eb4  cmp    word ptr [di - 0x5044], 0x2710
0eba  jge    0xf1e
0ebc  mov    al, byte ptr [0xa3b8]             ; mummy_i
0ebf  xor    ah, ah
0ec1  mov    dx, 0x1e
0ec4  mul    dx
0ec6  mov    di, ax
0ec8  mov    dx, word ptr [di - 0x5048]        ; +mummies
0ecc  mov    ax, word ptr [0xb05c]             ; dagger_x
0ecf  add    ax, 0x10
0ed2  sub    ax, dx
0ed4  or     ax, ax
0ed6  jns    0xeda
0ed8  neg    ax
  loc_0eda:
0eda  cmp    ax, 0x14
0edd  jge    0xf1c
0edf  mov    al, byte ptr [0xa3b8]             ; mummy_i
0ee2  xor    ah, ah
0ee4  mov    dx, 0x1e
0ee7  mul    dx
0ee9  mov    di, ax
0eeb  mov    dx, word ptr [di - 0x5046]
0eef  mov    ax, word ptr [0xb05e]             ; dagger_y
0ef2  add    ax, 6
0ef5  sub    ax, dx
0ef7  or     ax, ax
0ef9  jns    0xefd
0efb  neg    ax
  loc_0efd:
0efd  cmp    ax, 0xa
0f00  jge    0xf1c
0f02  mov    al, byte ptr [0xa3b8]             ; mummy_i
0f05  xor    ah, ah
0f07  mov    dx, 0x1e
0f0a  mul    dx
0f0c  mov    di, ax
0f0e  mov    word ptr [di - 0x5044], 0x2710
0f14  mov    byte ptr [0xcb0d], 1              ; dagger_hit
0f19  jmp    0x28b9
  loc_0f1c:
0f1c  jmp    0xf29
  loc_0f1e:
0f1e  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
0f23  je     0xf29
0f25  push   cs
0f26  call   move_dagger
  loc_0f29:
0f29  mov    al, byte ptr [0xa3b8]             ; mummy_i
0f2c  xor    ah, ah
0f2e  mov    dx, 0x1e
0f31  mul    dx
0f33  mov    di, ax
0f35  mov    al, byte ptr [di - 0x503a]
0f39  cmp    al, byte ptr [0xa3c5]             ; cur_room
0f3d  jne    0xfb5
0f3f  mov    al, byte ptr [0xa3b8]             ; mummy_i
0f42  xor    ah, ah
0f44  mov    dx, 0x1e
0f47  mul    dx
0f49  mov    di, ax
0f4b  cmp    word ptr [di - 0x5044], 0x1f
0f50  jle    0xfb5
0f52  mov    al, byte ptr [0xa3b8]             ; mummy_i
0f55  xor    ah, ah
0f57  mov    dx, 0x1e
0f5a  mul    dx
0f5c  mov    di, ax
0f5e  cmp    word ptr [di - 0x5044], 0x2711
0f64  jge    0xfb5
0f66  mov    al, byte ptr [0xa3b8]             ; mummy_i
0f69  xor    ah, ah
0f6b  mov    dx, 0x1e
0f6e  mul    dx
0f70  mov    di, ax
0f72  mov    dx, word ptr [di - 0x5048]        ; +mummies
0f76  mov    ax, word ptr [0xb058]             ; player_x
0f79  sub    ax, dx
0f7b  or     ax, ax
0f7d  jns    0xf81
0f7f  neg    ax
  loc_0f81:
0f81  cmp    ax, 0x14
0f84  jge    0xfb5
0f86  mov    al, byte ptr [0xa3b8]             ; mummy_i
0f89  xor    ah, ah
0f8b  mov    dx, 0x1e
0f8e  mul    dx
0f90  mov    di, ax
0f92  mov    dx, word ptr [di - 0x5046]
0f96  mov    ax, word ptr [0xb05a]             ; player_y
0f99  sub    ax, dx
0f9b  or     ax, ax
0f9d  jns    0xfa1
0f9f  neg    ax
  loc_0fa1:
0fa1  cmp    ax, 0xc
0fa4  jge    0xfb5
0fa6  cmp    byte ptr [0xcb0e], 0              ; player_caught
0fab  jne    0xfb5
0fad  mov    byte ptr [0xcb0e], 1              ; player_caught
0fb2  jmp    0x28b9
  loc_0fb5:
0fb5  mov    al, byte ptr [0xa3b8]             ; mummy_i
0fb8  xor    ah, ah
0fba  mov    dx, 0x1e
0fbd  mul    dx
0fbf  mov    di, ax
0fc1  mov    ax, word ptr [di - 0x5044]
0fc5  cmp    ax, 0xb
0fc8  je     0xfd7
0fca  cmp    ax, 0x15
0fcd  je     0xfd7
0fcf  cmp    ax, 0x1f
0fd2  je     0xfd7
0fd4  jmp    0x1074
  loc_0fd7:
0fd7  mov    al, byte ptr [0xa3b8]             ; mummy_i
0fda  xor    ah, ah
0fdc  mov    dx, 0x1e
0fdf  mul    dx
0fe1  mov    di, ax
0fe3  mov    al, byte ptr [di - 0x5039]
0fe7  cmp    al, byte ptr [0xa3c5]             ; cur_room
0feb  je     0xff0
0fed  jmp    0x1071
  loc_0ff0:
0ff0  mov    al, byte ptr [0xa3b8]             ; mummy_i
0ff3  xor    ah, ah
0ff5  mov    dx, 0x1e
0ff8  mul    dx
0ffa  mov    di, ax
0ffc  mov    ax, word ptr [di - 0x5042]
1000  sub    ax, 0x10
1003  push   ax
1004  mov    al, byte ptr [0xa3b8]             ; mummy_i
1007  xor    ah, ah
1009  mov    dx, 0x1e
100c  mul    dx
100e  mov    di, ax
1010  mov    ax, word ptr [di - 0x5040]
1014  sub    ax, 8
1017  push   ax
1018  mov    al, byte ptr [0xa3b8]             ; mummy_i
101b  xor    ah, ah
101d  mov    dx, 0x1e
1020  mul    dx
1022  mov    di, ax
1024  mov    ax, word ptr [di - 0x5044]
1028  cdq
1029  mov    cx, 0xa
102c  idiv   cx
102e  add    ax, 0x49
1031  mov    dx, 0x54
1034  mul    dx
1036  mov    di, ax
1038  add    di, 0x69ec
103c  push   ds
103d  push   di
103e  xor    ax, ax
1040  push   ax
1041  call   Graph_PutImage
1046  mov    al, byte ptr [0xa3b8]             ; mummy_i
1049  xor    ah, ah
104b  mov    dx, 0x1e
104e  mul    dx
1050  mov    di, ax
1052  mov    ax, word ptr [di - 0x5044]
1056  cdq
1057  mov    cx, 0xa
105a  idiv   cx
105c  add    ax, 0x49
105f  mov    cl, al
1061  mov    al, byte ptr [0xa3b8]             ; mummy_i
1064  xor    ah, ah
1066  mov    dx, 0x1e
1069  mul    dx
106b  mov    di, ax
106d  mov    byte ptr [di - 0x5038], cl
  loc_1071:
1071  jmp    0x28b9
  loc_1074:
1074  cmp    ax, 1
1077  jl     0x108a
1079  cmp    ax, 0x1e
107c  jg     0x108a
107e  mov    ax, 0xc
1081  push   ax
1082  call   Crt_Delay
1087  jmp    0x28b9
  loc_108a:
108a  cmp    ax, 0x20
108d  jge    0x1092
108f  jmp    0x1159
  loc_1092:
1092  cmp    ax, 0x41
1095  jle    0x109a
1097  jmp    0x1159
  loc_109a:
109a  mov    al, byte ptr [0xa3b8]             ; mummy_i
109d  xor    ah, ah
109f  mov    dx, 0x1e
10a2  mul    dx
10a4  mov    di, ax
10a6  mov    al, byte ptr [di - 0x5039]
10aa  cmp    al, byte ptr [0xa3c5]             ; cur_room
10ae  je     0x10b3
10b0  jmp    0x114d
  loc_10b3:
10b3  mov    al, byte ptr [0xa3b8]             ; mummy_i
10b6  xor    ah, ah
10b8  mov    dx, 0x1e
10bb  mul    dx
10bd  mov    di, ax
10bf  mov    ax, word ptr [di - 0x5042]
10c3  sub    ax, 0x10
10c6  push   ax
10c7  mov    al, byte ptr [0xa3b8]             ; mummy_i
10ca  xor    ah, ah
10cc  mov    dx, 0x1e
10cf  mul    dx
10d1  mov    di, ax
10d3  mov    ax, word ptr [di - 0x5040]
10d7  sub    ax, 8
10da  push   ax
10db  mov    al, byte ptr [0xa3b8]             ; mummy_i
10de  xor    ah, ah
10e0  mov    dx, 0x1e
10e3  mul    dx
10e5  mov    di, ax
10e7  mov    ax, word ptr [di - 0x5044]
10eb  cdq
10ec  mov    cx, 0xa
10ef  idiv   cx
10f1  cdq
10f2  mov    cx, 2
10f5  idiv   cx
10f7  xchg   dx, ax
10f8  add    ax, 0x53
10fb  mov    dx, 0x54
10fe  mul    dx
1100  mov    di, ax
1102  add    di, 0x69ec
1106  push   ds
1107  push   di
1108  xor    ax, ax
110a  push   ax
110b  call   Graph_PutImage
1110  mov    al, byte ptr [0xa3b8]             ; mummy_i
1113  xor    ah, ah
1115  mov    dx, 0x1e
1118  mul    dx
111a  mov    di, ax
111c  mov    ax, word ptr [di - 0x5044]
1120  cdq
1121  mov    cx, 0xa
1124  idiv   cx
1126  cdq
1127  mov    cx, 2
112a  idiv   cx
112c  xchg   dx, ax
112d  add    ax, 0x53
1130  mov    cl, al
1132  mov    al, byte ptr [0xa3b8]             ; mummy_i
1135  xor    ah, ah
1137  mov    dx, 0x1e
113a  mul    dx
113c  mov    di, ax
113e  mov    byte ptr [di - 0x5038], cl
1142  mov    ax, 0xa
1145  push   ax
1146  call   Crt_Delay
114b  jmp    0x1156
  loc_114d:
114d  mov    ax, 0xf
1150  push   ax
1151  call   Crt_Delay
  loc_1156:
1156  jmp    0x28b9
  loc_1159:
1159  cmp    ax, 0x42
115c  je     0x1161
115e  jmp    0x1227
  loc_1161:
1161  mov    al, byte ptr [0xa3b8]             ; mummy_i
1164  xor    ah, ah
1166  mov    dx, 0x1e
1169  mul    dx
116b  mov    di, ax
116d  mov    al, byte ptr [di - 0x5039]
1171  cmp    al, byte ptr [0xa3c5]             ; cur_room
1175  je     0x117a
1177  jmp    0x121b
  loc_117a:
117a  mov    al, byte ptr [0xa3b8]             ; mummy_i
117d  xor    ah, ah
117f  mov    dx, 0x1e
1182  mul    dx
1184  mov    di, ax
1186  mov    ax, word ptr [di - 0x5042]
118a  sub    ax, 0x10
118d  push   ax
118e  mov    al, byte ptr [0xa3b8]             ; mummy_i
1191  xor    ah, ah
1193  mov    dx, 0x1e
1196  mul    dx
1198  mov    di, ax
119a  mov    ax, word ptr [di - 0x5040]
119e  sub    ax, 8
11a1  push   ax
11a2  mov    di, 0x81e0
11a5  push   ds
11a6  push   di
11a7  xor    ax, ax
11a9  push   ax
11aa  call   Graph_PutImage
11af  mov    al, byte ptr [0xa3b8]             ; mummy_i
11b2  xor    ah, ah
11b4  mov    dx, 0x1e
11b7  mul    dx
11b9  mov    di, ax
11bb  mov    ax, word ptr [di - 0x5042]
11bf  sub    ax, 0x10
11c2  push   ax
11c3  mov    al, byte ptr [0xa3b8]             ; mummy_i
11c6  xor    ah, ah
11c8  mov    dx, 0x1e
11cb  mul    dx
11cd  mov    di, ax
11cf  mov    ax, word ptr [di - 0x5040]
11d3  sub    ax, 8
11d6  push   ax
11d7  mov    al, byte ptr [0xa3b8]             ; mummy_i
11da  xor    ah, ah
11dc  mov    dx, 0x1e
11df  mul    dx
11e1  mov    di, ax
11e3  mov    al, byte ptr [di - 0x5038]
11e7  xor    ah, ah
11e9  mov    dx, 0x54
11ec  mul    dx
11ee  mov    di, ax
11f0  add    di, 0x69ec
11f4  push   ds
11f5  push   di
11f6  mov    ax, 1
11f9  push   ax
11fa  call   Graph_PutImage
11ff  mov    ax, 0x14
1202  push   ax
1203  call   Crt_Delay
1208  mov    al, byte ptr [0xa3b8]             ; mummy_i
120b  xor    ah, ah
120d  mov    dx, 0x1e
1210  mul    dx
1212  mov    di, ax
1214  mov    byte ptr [di - 0x5037], 0
1219  jmp    0x1224
  loc_121b:
121b  mov    ax, 0x19
121e  push   ax
121f  call   Crt_Delay
  loc_1224:
1224  jmp    0x28b9
  loc_1227:
1227  cmp    ax, 0x43
122a  jge    0x122f
122c  jmp    0x24f7
  loc_122f:
122f  cmp    ax, 0x2710
1232  jle    0x1237
1234  jmp    0x24f7
  loc_1237:
1237  mov    al, byte ptr [0xa3b8]             ; mummy_i
123a  xor    ah, ah
123c  mov    dx, 0x1e
123f  mul    dx
1241  mov    di, ax
1243  mov    ax, word ptr [di - 0x5048]        ; +mummies
1247  mov    word ptr [bp - 2], ax
124a  mov    al, byte ptr [0xa3b8]             ; mummy_i
124d  xor    ah, ah
124f  mov    dx, 0x1e
1252  mul    dx
1254  mov    di, ax
1256  mov    ax, word ptr [di - 0x5046]
125a  mov    word ptr [bp - 4], ax
125d  mov    al, byte ptr [0xa3b8]             ; mummy_i
1260  xor    ah, ah
1262  mov    dx, 0x1e
1265  mul    dx
1267  mov    di, ax
1269  cmp    byte ptr [di - 0x5037], 0x63
126e  ja     0x1273
1270  jmp    0x1431
  loc_1273:
1273  mov    al, byte ptr [0xa3b8]             ; mummy_i
1276  xor    ah, ah
1278  mov    dx, 0x1e
127b  mul    dx
127d  mov    di, ax
127f  cmp    byte ptr [di - 0x5037], 0x64
1284  jne    0x12ff
1286  mov    al, byte ptr [0xa3b8]             ; mummy_i
1289  xor    ah, ah
128b  mov    dx, 0x1e
128e  mul    dx
1290  mov    di, ax
1292  mov    al, byte ptr [di - 0x503a]
1296  cmp    al, byte ptr [0xa3c5]             ; cur_room
129a  jne    0x12ff
129c  mov    ax, word ptr [bp - 2]
129f  sub    ax, 0x10
12a2  push   ax
12a3  mov    ax, word ptr [bp - 4]
12a6  sub    ax, 8
12a9  push   ax
12aa  mov    al, byte ptr [0xa3b8]             ; mummy_i
12ad  xor    ah, ah
12af  mov    dx, 0x1e
12b2  mul    dx
12b4  mov    di, ax
12b6  mov    al, byte ptr [di - 0x5038]
12ba  xor    ah, ah
12bc  mov    dx, 0x54
12bf  mul    dx
12c1  mov    di, ax
12c3  add    di, 0x69ec
12c7  push   ds
12c8  push   di
12c9  mov    ax, 1
12cc  push   ax
12cd  call   Graph_PutImage
12d2  mov    ax, word ptr [bp - 2]
12d5  sub    ax, 0x10
12d8  push   ax
12d9  mov    ax, word ptr [bp - 4]
12dc  sub    ax, 8
12df  push   ax
12e0  mov    di, 0x8528
12e3  push   ds
12e4  push   di
12e5  mov    ax, 1
12e8  push   ax
12e9  call   Graph_PutImage
12ee  mov    al, byte ptr [0xa3b8]             ; mummy_i
12f1  xor    ah, ah
12f3  mov    dx, 0x1e
12f6  mul    dx
12f8  mov    di, ax
12fa  mov    byte ptr [di - 0x5038], 0x53
  loc_12ff:
12ff  mov    al, byte ptr [0xa3b8]             ; mummy_i
1302  xor    ah, ah
1304  mov    dx, 0x1e
1307  mul    dx
1309  mov    di, ax
130b  inc    byte ptr [di - 0x5037]
130f  mov    ax, 0xa
1312  push   ax
1313  call   Crt_Delay
1318  mov    al, byte ptr [0xa3b8]             ; mummy_i
131b  xor    ah, ah
131d  mov    dx, 0x1e
1320  mul    dx
1322  mov    di, ax
1324  mov    al, byte ptr [di - 0x503a]
1328  cmp    al, byte ptr [0xa3c5]             ; cur_room
132c  je     0x1331
132e  jmp    0x1401
  loc_1331:
1331  mov    al, byte ptr [0xa3b8]             ; mummy_i
1334  xor    ah, ah
1336  mov    dx, 0x1e
1339  mul    dx
133b  mov    di, ax
133d  mov    al, byte ptr [di - 0x5037]
1341  xor    ah, ah
1343  cdq
1344  mov    cx, 5
1347  idiv   cx
1349  xchg   dx, ax
134a  or     ax, ax
134c  je     0x1351
134e  jmp    0x1401
  loc_1351:
1351  mov    ax, word ptr [bp - 2]
1354  sub    ax, 0x10
1357  push   ax
1358  mov    ax, word ptr [bp - 4]
135b  sub    ax, 8
135e  push   ax
135f  mov    al, byte ptr [0xa3b8]             ; mummy_i
1362  xor    ah, ah
1364  mov    dx, 0x1e
1367  mul    dx
1369  mov    di, ax
136b  mov    al, byte ptr [di - 0x5038]
136f  xor    ah, ah
1371  mov    dx, 0x54
1374  mul    dx
1376  mov    di, ax
1378  add    di, 0x69ec
137c  push   ds
137d  push   di
137e  mov    ax, 1
1381  push   ax
1382  call   Graph_PutImage
1387  mov    ax, word ptr [bp - 2]
138a  sub    ax, 0x10
138d  push   ax
138e  mov    ax, word ptr [bp - 4]
1391  sub    ax, 8
1394  push   ax
1395  mov    al, byte ptr [0xa3b8]             ; mummy_i
1398  xor    ah, ah
139a  mov    dx, 0x1e
139d  mul    dx
139f  mov    di, ax
13a1  mov    al, byte ptr [di - 0x5037]
13a5  xor    ah, ah
13a7  cdq
13a8  mov    cx, 0xa
13ab  idiv   cx
13ad  cdq
13ae  mov    cx, 2
13b1  idiv   cx
13b3  xchg   dx, ax
13b4  add    ax, 0x53
13b7  mov    dx, 0x54
13ba  mul    dx
13bc  mov    di, ax
13be  add    di, 0x69ec
13c2  push   ds
13c3  push   di
13c4  mov    ax, 1
13c7  push   ax
13c8  call   Graph_PutImage
13cd  mov    al, byte ptr [0xa3b8]             ; mummy_i
13d0  xor    ah, ah
13d2  mov    dx, 0x1e
13d5  mul    dx
13d7  mov    di, ax
13d9  mov    al, byte ptr [di - 0x5037]
13dd  xor    ah, ah
13df  cdq
13e0  mov    cx, 0xa
13e3  idiv   cx
13e5  cdq
13e6  mov    cx, 2
13e9  idiv   cx
13eb  xchg   dx, ax
13ec  add    ax, 0x53
13ef  mov    cl, al
13f1  mov    al, byte ptr [0xa3b8]             ; mummy_i
13f4  xor    ah, ah
13f6  mov    dx, 0x1e
13f9  mul    dx
13fb  mov    di, ax
13fd  mov    byte ptr [di - 0x5038], cl
  loc_1401:
1401  mov    al, byte ptr [0xa3b8]             ; mummy_i
1404  xor    ah, ah
1406  mov    dx, 0x1e
1409  mul    dx
140b  mov    di, ax
140d  cmp    byte ptr [di - 0x5037], 0x78
1412  jne    0x1425
1414  mov    al, byte ptr [0xa3b8]             ; mummy_i
1417  xor    ah, ah
1419  mov    dx, 0x1e
141c  mul    dx
141e  mov    di, ax
1420  mov    byte ptr [di - 0x5037], 0
  loc_1425:
1425  mov    ax, 0xa
1428  push   ax
1429  call   Crt_Delay
142e  jmp    0x28b9
  loc_1431:
1431  mov    al, byte ptr [0xa3b8]             ; mummy_i
1434  xor    ah, ah
1436  mov    dx, 0x1e
1439  mul    dx
143b  mov    di, ax
143d  mov    ax, word ptr [di - 0x503e]
1441  mov    cx, 6
1444  imul   cx
1446  mov    cx, ax
1448  mov    al, byte ptr [0xa3b8]             ; mummy_i
144b  xor    ah, ah
144d  mov    dx, 0x1e
1450  mul    dx
1452  mov    di, ax
1454  add    word ptr [di - 0x5048], cx        ; +mummies
1458  mov    al, byte ptr [0xa3b8]             ; mummy_i
145b  xor    ah, ah
145d  mov    dx, 0x1e
1460  mul    dx
1462  mov    di, ax
1464  cmp    word ptr [di - 0x5048], -1        ; +mummies
1469  jl     0x1482
146b  mov    al, byte ptr [0xa3b8]             ; mummy_i
146e  xor    ah, ah
1470  mov    dx, 0x1e
1473  mul    dx
1475  mov    di, ax
1477  cmp    word ptr [di - 0x5048], 0x280     ; +mummies
147d  jg     0x1482
147f  jmp    0x151e
  loc_1482:
1482  mov    al, byte ptr [0xa3b8]             ; mummy_i
1485  xor    ah, ah
1487  mov    dx, 0x1e
148a  mul    dx
148c  mov    di, ax
148e  mov    al, byte ptr [di - 0x503a]
1492  xor    ah, ah
1494  mov    word ptr [bp - 6], ax
1497  mov    al, byte ptr [0xa3b8]             ; mummy_i
149a  xor    ah, ah
149c  mov    dx, 0x1e
149f  mul    dx
14a1  mov    di, ax
14a3  add    di, 0xafc6
14a7  push   ds
14a8  push   di
14a9  mov    al, byte ptr [0xa3b8]             ; mummy_i
14ac  xor    ah, ah
14ae  mov    dx, 0x1e
14b1  mul    dx
14b3  mov    di, ax
14b5  add    di, 0xafb8
14b9  push   ds
14ba  push   di
14bb  mov    al, byte ptr [0xa3b8]             ; mummy_i
14be  xor    ah, ah
14c0  mov    dx, 0x1e
14c3  mul    dx
14c5  mov    di, ax
14c7  add    di, 0xafba
14cb  push   ds
14cc  push   di
14cd  push   cs
14ce  call   move_to_next_room
14d1  mov    al, byte ptr [0xa3b8]             ; mummy_i
14d4  xor    ah, ah
14d6  mov    dx, 0x1e
14d9  mul    dx
14db  mov    di, ax
14dd  mov    al, byte ptr [di - 0x503a]
14e1  xor    ah, ah
14e3  cmp    ax, word ptr [bp - 6]
14e6  je     0x151e
14e8  mov    ax, word ptr [bp - 2]
14eb  sub    ax, 0x10
14ee  push   ax
14ef  mov    ax, word ptr [bp - 4]
14f2  sub    ax, 8
14f5  push   ax
14f6  mov    al, byte ptr [0xa3b8]             ; mummy_i
14f9  xor    ah, ah
14fb  mov    dx, 0x1e
14fe  mul    dx
1500  mov    di, ax
1502  mov    al, byte ptr [di - 0x5038]
1506  xor    ah, ah
1508  mov    dx, 0x54
150b  mul    dx
150d  mov    di, ax
150f  add    di, 0x69ec
1513  push   ds
1514  push   di
1515  mov    ax, 1
1518  push   ax
1519  call   Graph_PutImage
  loc_151e:
151e  mov    al, byte ptr [0xa3b8]             ; mummy_i
1521  xor    ah, ah
1523  mov    dx, 0x1e
1526  mul    dx
1528  mov    di, ax
152a  mov    ax, word ptr [di - 0x503e]
152e  mov    cx, 0xd
1531  imul   cx
1533  mov    cx, ax
1535  mov    al, byte ptr [0xa3b8]             ; mummy_i
1538  xor    ah, ah
153a  mov    dx, 0x1e
153d  mul    dx
153f  mov    di, ax
1541  mov    ax, word ptr [di - 0x5048]        ; +mummies
1545  add    ax, cx
1547  cdq
1548  mov    cx, 0x20
154b  idiv   cx
154d  mov    word ptr [0xb070], ax             ; probe_x
1550  mov    al, byte ptr [0xa3b8]             ; mummy_i
1553  xor    ah, ah
1555  mov    dx, 0x1e
1558  mul    dx
155a  mov    di, ax
155c  mov    ax, word ptr [di - 0x5046]
1560  sub    ax, 4
1563  cdq
1564  mov    cx, 8
1567  idiv   cx
1569  mov    word ptr [0xb072], ax             ; probe_y
156c  mov    ax, word ptr [0xb072]             ; probe_y
156f  mov    bx, ax
1571  mov    ax, word ptr [0xb070]             ; probe_x
1574  mov    dx, 0x19
1577  mul    dx
1579  mov    cx, ax
157b  mov    al, byte ptr [0xa3b8]             ; mummy_i
157e  xor    ah, ah
1580  mov    dx, 0x1e
1583  mul    dx
1585  mov    di, ax
1587  mov    al, byte ptr [di - 0x503a]
158b  xor    ah, ah
158d  mov    dx, 0x226
1590  mul    dx
1592  mov    di, ax
1594  add    di, cx
1596  add    di, bx
1598  mov    al, byte ptr [di - 0x4a70]        ; +rooms
159c  push   ax
159d  mov    di, 0xda8                         ; set cs:0da8 = [42,43,46,47,50,53,54,175,222]
15a0  push   cs
15a1  push   di
15a2  call   Sys_SetIn
15a7  jne    0x15ff
15a9  mov    al, byte ptr [0xa3b8]             ; mummy_i
15ac  xor    ah, ah
15ae  mov    dx, 0x1e
15b1  mul    dx
15b3  mov    di, ax
15b5  mov    ax, word ptr [di - 0x5046]
15b9  add    ax, 6
15bc  cdq
15bd  mov    cx, 8
15c0  idiv   cx
15c2  mov    bx, ax
15c4  mov    ax, word ptr [0xb070]             ; probe_x
15c7  mov    dx, 0x19
15ca  mul    dx
15cc  mov    cx, ax
15ce  mov    al, byte ptr [0xa3b8]             ; mummy_i
15d1  xor    ah, ah
15d3  mov    dx, 0x1e
15d6  mul    dx
15d8  mov    di, ax
15da  mov    al, byte ptr [di - 0x503a]
15de  xor    ah, ah
15e0  mov    dx, 0x226
15e3  mul    dx
15e5  mov    di, ax
15e7  add    di, cx
15e9  add    di, bx
15eb  mov    al, byte ptr [di - 0x4a70]        ; +rooms
15ef  push   ax
15f0  mov    di, 0xda8                         ; set cs:0da8 = [42,43,46,47,50,53,54,175,222]
15f3  push   cs
15f4  push   di
15f5  call   Sys_SetIn
15fa  jne    0x15ff
15fc  jmp    0x1718
  loc_15ff:
15ff  mov    al, byte ptr [0xa3b8]             ; mummy_i
1602  xor    ah, ah
1604  mov    dx, 0x1e
1607  mul    dx
1609  mov    di, ax
160b  mov    ax, word ptr [di - 0x503e]
160f  mov    cx, 6
1612  imul   cx
1614  mov    cx, ax
1616  mov    al, byte ptr [0xa3b8]             ; mummy_i
1619  xor    ah, ah
161b  mov    dx, 0x1e
161e  mul    dx
1620  mov    di, ax
1622  sub    word ptr [di - 0x5048], cx        ; +mummies
1626  mov    al, byte ptr [0xa3b8]             ; mummy_i
1629  xor    ah, ah
162b  mov    dx, 0x1e
162e  mul    dx
1630  mov    di, ax
1632  inc    byte ptr [di - 0x5037]
1636  mov    ax, 0xa
1639  push   ax
163a  call   Crt_Delay
163f  mov    al, byte ptr [0xa3b8]             ; mummy_i
1642  xor    ah, ah
1644  mov    dx, 0x1e
1647  mul    dx
1649  mov    di, ax
164b  cmp    byte ptr [di - 0x5037], 0xf
1650  ja     0x1655
1652  jmp    0x1718
  loc_1655:
1655  mov    al, byte ptr [0xa3b8]             ; mummy_i
1658  xor    ah, ah
165a  mov    dx, 0x1e
165d  mul    dx
165f  mov    di, ax
1661  mov    byte ptr [di - 0x5037], 0
1666  mov    al, byte ptr [0xa3b8]             ; mummy_i
1669  xor    ah, ah
166b  mov    dx, 0x1e
166e  mul    dx
1670  mov    di, ax
1672  mov    ax, word ptr [di - 0x503e]
1676  neg    ax
1678  mov    cx, ax
167a  mov    al, byte ptr [0xa3b8]             ; mummy_i
167d  xor    ah, ah
167f  mov    dx, 0x1e
1682  mul    dx
1684  mov    di, ax
1686  mov    word ptr [di - 0x503e], cx
168a  mov    al, byte ptr [0xa3b8]             ; mummy_i
168d  xor    ah, ah
168f  mov    dx, 0x1e
1692  mul    dx
1694  mov    di, ax
1696  cmp    word ptr [di - 0x503e], 0
169b  jle    0x16d3
169d  mov    al, byte ptr [0xa3b8]             ; mummy_i
16a0  xor    ah, ah
16a2  mov    dx, 0x1e
16a5  mul    dx
16a7  mov    di, ax
16a9  inc    byte ptr [di - 0x5036]
16ad  mov    al, byte ptr [0xa3b8]             ; mummy_i
16b0  xor    ah, ah
16b2  mov    dx, 0x1e
16b5  mul    dx
16b7  mov    di, ax
16b9  cmp    byte ptr [di - 0x5036], 1
16be  jbe    0x16d1
16c0  mov    al, byte ptr [0xa3b8]             ; mummy_i
16c3  xor    ah, ah
16c5  mov    dx, 0x1e
16c8  mul    dx
16ca  mov    di, ax
16cc  mov    byte ptr [di - 0x5032], 1
  loc_16d1:
16d1  jmp    0x1707
  loc_16d3:
16d3  mov    al, byte ptr [0xa3b8]             ; mummy_i
16d6  xor    ah, ah
16d8  mov    dx, 0x1e
16db  mul    dx
16dd  mov    di, ax
16df  inc    byte ptr [di - 0x5035]
16e3  mov    al, byte ptr [0xa3b8]             ; mummy_i
16e6  xor    ah, ah
16e8  mov    dx, 0x1e
16eb  mul    dx
16ed  mov    di, ax
16ef  cmp    byte ptr [di - 0x5035], 1
16f4  jbe    0x1707
16f6  mov    al, byte ptr [0xa3b8]             ; mummy_i
16f9  xor    ah, ah
16fb  mov    dx, 0x1e
16fe  mul    dx
1700  mov    di, ax
1702  mov    byte ptr [di - 0x5031], 1
  loc_1707:
1707  mov    al, byte ptr [0xa3b8]             ; mummy_i
170a  xor    ah, ah
170c  mov    dx, 0x1e
170f  mul    dx
1711  mov    di, ax
1713  add    word ptr [di - 0x5044], 0x64
  loc_1718:
1718  mov    al, byte ptr [0xa3b8]             ; mummy_i
171b  xor    ah, ah
171d  mov    dx, 0x1e
1720  mul    dx
1722  mov    di, ax
1724  mov    al, byte ptr [di - 0x503a]
1728  cmp    al, byte ptr [0xa3c5]             ; cur_room
172c  jne    0x1766
172e  mov    ax, word ptr [bp - 2]
1731  sub    ax, 0x10
1734  push   ax
1735  mov    ax, word ptr [bp - 4]
1738  sub    ax, 8
173b  push   ax
173c  mov    al, byte ptr [0xa3b8]             ; mummy_i
173f  xor    ah, ah
1741  mov    dx, 0x1e
1744  mul    dx
1746  mov    di, ax
1748  mov    al, byte ptr [di - 0x5038]
174c  xor    ah, ah
174e  mov    dx, 0x54
1751  mul    dx
1753  mov    di, ax
1755  add    di, 0x69ec
1759  push   ds
175a  push   di
175b  mov    ax, 1
175e  push   ax
175f  call   Graph_PutImage
1764  jmp    0x176f
  loc_1766:
1766  mov    ax, 5
1769  push   ax
176a  call   Crt_Delay
  loc_176f:
176f  mov    al, byte ptr [0xa3b8]             ; mummy_i
1772  xor    ah, ah
1774  mov    dx, 0x1e
1777  mul    dx
1779  mov    di, ax
177b  mov    ax, word ptr [di - 0x503e]
177f  inc    ax
1780  cdq
1781  mov    cx, 2
1784  idiv   cx
1786  mov    bx, ax
1788  mov    al, byte ptr [0xa3b8]             ; mummy_i
178b  xor    ah, ah
178d  mov    dx, 0x1e
1790  mul    dx
1792  mov    di, ax
1794  mov    ax, word ptr [di - 0x5044]
1798  cdq
1799  mov    cx, 3
179c  idiv   cx
179e  cdq
179f  mov    cx, 2
17a2  idiv   cx
17a4  xchg   dx, ax
17a5  shl    ax, 1
17a7  add    ax, 0x4d
17aa  sub    ax, bx
17ac  mov    cl, al
17ae  mov    al, byte ptr [0xa3b8]             ; mummy_i
17b1  xor    ah, ah
17b3  mov    dx, 0x1e
17b6  mul    dx
17b8  mov    di, ax
17ba  mov    byte ptr [di - 0x5038], cl
17be  mov    al, byte ptr [0xa3b8]             ; mummy_i
17c1  xor    ah, ah
17c3  mov    dx, 0x1e
17c6  mul    dx
17c8  mov    di, ax
17ca  mov    ax, word ptr [di - 0x5046]
17ce  add    ax, 9
17d1  cdq
17d2  mov    cx, 8
17d5  idiv   cx
17d7  mov    bx, ax
17d9  mov    al, byte ptr [0xa3b8]             ; mummy_i
17dc  xor    ah, ah
17de  mov    dx, 0x1e
17e1  mul    dx
17e3  mov    di, ax
17e5  mov    ax, word ptr [di - 0x5048]        ; +mummies
17e9  add    ax, 0xb
17ec  cdq
17ed  mov    cx, 0x20
17f0  idiv   cx
17f2  mov    dx, 0x19
17f5  mul    dx
17f7  mov    cx, ax
17f9  mov    al, byte ptr [0xa3b8]             ; mummy_i
17fc  xor    ah, ah
17fe  mov    dx, 0x1e
1801  mul    dx
1803  mov    di, ax
1805  mov    al, byte ptr [di - 0x503a]
1809  xor    ah, ah
180b  mov    dx, 0x226
180e  mul    dx
1810  mov    di, ax
1812  add    di, cx
1814  add    di, bx
1816  mov    al, byte ptr [di - 0x4a70]        ; +rooms
181a  push   ax
181b  mov    di, 0xdc8                         ; set cs:0dc8 = [30,33,34,35,56,76,85,86,87,88,100,106,156,206]
181e  push   cs
181f  push   di
1820  call   Sys_SetIn
1825  jne    0x182a
1827  jmp    0x1b9a
  loc_182a:
182a  mov    al, byte ptr [0xa3b8]             ; mummy_i
182d  xor    ah, ah
182f  mov    dx, 0x1e
1832  mul    dx
1834  mov    di, ax
1836  mov    ax, word ptr [di - 0x5046]
183a  add    ax, 9
183d  cdq
183e  mov    cx, 8
1841  idiv   cx
1843  mov    bx, ax
1845  mov    al, byte ptr [0xa3b8]             ; mummy_i
1848  xor    ah, ah
184a  mov    dx, 0x1e
184d  mul    dx
184f  mov    di, ax
1851  mov    ax, word ptr [di - 0x5048]        ; +mummies
1855  sub    ax, 0xc
1858  cdq
1859  mov    cx, 0x20
185c  idiv   cx
185e  mov    dx, 0x19
1861  mul    dx
1863  mov    cx, ax
1865  mov    al, byte ptr [0xa3b8]             ; mummy_i
1868  xor    ah, ah
186a  mov    dx, 0x1e
186d  mul    dx
186f  mov    di, ax
1871  mov    al, byte ptr [di - 0x503a]
1875  xor    ah, ah
1877  mov    dx, 0x226
187a  mul    dx
187c  mov    di, ax
187e  add    di, cx
1880  add    di, bx
1882  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1886  push   ax
1887  mov    di, 0xdc8                         ; set cs:0dc8 = [30,33,34,35,56,76,85,86,87,88,100,106,156,206]
188a  push   cs
188b  push   di
188c  call   Sys_SetIn
1891  jne    0x1896
1893  jmp    0x1b9a
  loc_1896:
1896  mov    al, byte ptr [0xa3b8]             ; mummy_i
1899  xor    ah, ah
189b  mov    dx, 0x1e
189e  mul    dx
18a0  mov    di, ax
18a2  mov    ax, word ptr [di - 0x5046]
18a6  cdq
18a7  mov    cx, 8
18aa  idiv   cx
18ac  mov    bx, ax
18ae  mov    al, byte ptr [0xa3b8]             ; mummy_i
18b1  xor    ah, ah
18b3  mov    dx, 0x1e
18b6  mul    dx
18b8  mov    di, ax
18ba  mov    ax, word ptr [di - 0x5048]        ; +mummies
18be  add    ax, 0xb
18c1  cdq
18c2  mov    cx, 0x20
18c5  idiv   cx
18c7  mov    dx, 0x19
18ca  mul    dx
18cc  mov    cx, ax
18ce  mov    al, byte ptr [0xa3b8]             ; mummy_i
18d1  xor    ah, ah
18d3  mov    dx, 0x1e
18d6  mul    dx
18d8  mov    di, ax
18da  mov    al, byte ptr [di - 0x503a]
18de  xor    ah, ah
18e0  mov    dx, 0x226
18e3  mul    dx
18e5  mov    di, ax
18e7  add    di, cx
18e9  add    di, bx
18eb  mov    al, byte ptr [di - 0x4a70]        ; +rooms
18ef  push   ax
18f0  mov    di, 0xdc8                         ; set cs:0dc8 = [30,33,34,35,56,76,85,86,87,88,100,106,156,206]
18f3  push   cs
18f4  push   di
18f5  call   Sys_SetIn
18fa  jne    0x18ff
18fc  jmp    0x1b9a
  loc_18ff:
18ff  mov    al, byte ptr [0xa3b8]             ; mummy_i
1902  xor    ah, ah
1904  mov    dx, 0x1e
1907  mul    dx
1909  mov    di, ax
190b  mov    ax, word ptr [di - 0x5046]
190f  cdq
1910  mov    cx, 8
1913  idiv   cx
1915  mov    bx, ax
1917  mov    al, byte ptr [0xa3b8]             ; mummy_i
191a  xor    ah, ah
191c  mov    dx, 0x1e
191f  mul    dx
1921  mov    di, ax
1923  mov    ax, word ptr [di - 0x5048]        ; +mummies
1927  sub    ax, 0xc
192a  cdq
192b  mov    cx, 0x20
192e  idiv   cx
1930  mov    dx, 0x19
1933  mul    dx
1935  mov    cx, ax
1937  mov    al, byte ptr [0xa3b8]             ; mummy_i
193a  xor    ah, ah
193c  mov    dx, 0x1e
193f  mul    dx
1941  mov    di, ax
1943  mov    al, byte ptr [di - 0x503a]
1947  xor    ah, ah
1949  mov    dx, 0x226
194c  mul    dx
194e  mov    di, ax
1950  add    di, cx
1952  add    di, bx
1954  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1958  push   ax
1959  mov    di, 0xdc8                         ; set cs:0dc8 = [30,33,34,35,56,76,85,86,87,88,100,106,156,206]
195c  push   cs
195d  push   di
195e  call   Sys_SetIn
1963  jne    0x1968
1965  jmp    0x1b9a
  loc_1968:
1968  mov    al, byte ptr [0xa3b8]             ; mummy_i
196b  xor    ah, ah
196d  mov    dx, 0x1e
1970  mul    dx
1972  mov    di, ax
1974  mov    word ptr [di - 0x503c], 0xffff
197a  mov    al, byte ptr [0xa3b8]             ; mummy_i
197d  xor    ah, ah
197f  mov    dx, 0x1e
1982  mul    dx
1984  mov    di, ax
1986  xor    ax, ax
1988  mov    word ptr [di - 0x503e], ax
198c  mov    al, byte ptr [0xa3b8]             ; mummy_i
198f  xor    ah, ah
1991  mov    dx, 0x1e
1994  mul    dx
1996  mov    di, ax
1998  add    word ptr [di - 0x5046], 6
199d  mov    al, byte ptr [0xa3b8]             ; mummy_i
19a0  xor    ah, ah
19a2  mov    dx, 0x1e
19a5  mul    dx
19a7  mov    di, ax
19a9  mov    ax, word ptr [di - 0x503e]
19ad  inc    ax
19ae  cdq
19af  mov    cx, 2
19b2  idiv   cx
19b4  add    ax, 0x4c
19b7  mov    cl, al
19b9  mov    al, byte ptr [0xa3b8]             ; mummy_i
19bc  xor    ah, ah
19be  mov    dx, 0x1e
19c1  mul    dx
19c3  mov    di, ax
19c5  mov    byte ptr [di - 0x5038], cl
19c9  mov    al, byte ptr [0xa3b8]             ; mummy_i
19cc  xor    ah, ah
19ce  mov    dx, 0x1e
19d1  mul    dx
19d3  mov    di, ax
19d5  cmp    word ptr [di - 0x5046], 0xb4
19db  jle    0x1a17
19dd  mov    al, byte ptr [0xa3b8]             ; mummy_i
19e0  xor    ah, ah
19e2  mov    dx, 0x1e
19e5  mul    dx
19e7  mov    di, ax
19e9  add    di, 0xafc6
19ed  push   ds
19ee  push   di
19ef  mov    al, byte ptr [0xa3b8]             ; mummy_i
19f2  xor    ah, ah
19f4  mov    dx, 0x1e
19f7  mul    dx
19f9  mov    di, ax
19fb  add    di, 0xafb8
19ff  push   ds
1a00  push   di
1a01  mov    al, byte ptr [0xa3b8]             ; mummy_i
1a04  xor    ah, ah
1a06  mov    dx, 0x1e
1a09  mul    dx
1a0b  mov    di, ax
1a0d  add    di, 0xafba
1a11  push   ds
1a12  push   di
1a13  push   cs
1a14  call   move_to_next_room
  loc_1a17:
1a17  mov    al, byte ptr [0xa3b8]             ; mummy_i
1a1a  xor    ah, ah
1a1c  mov    dx, 0x1e
1a1f  mul    dx
1a21  mov    di, ax
1a23  mov    ax, word ptr [di - 0x5046]
1a27  add    ax, 9
1a2a  cdq
1a2b  mov    cx, 8
1a2e  idiv   cx
1a30  mov    bx, ax
1a32  mov    al, byte ptr [0xa3b8]             ; mummy_i
1a35  xor    ah, ah
1a37  mov    dx, 0x1e
1a3a  mul    dx
1a3c  mov    di, ax
1a3e  mov    ax, word ptr [di - 0x5048]        ; +mummies
1a42  cdq
1a43  mov    cx, 0x20
1a46  idiv   cx
1a48  mov    dx, 0x19
1a4b  mul    dx
1a4d  mov    cx, ax
1a4f  mov    al, byte ptr [0xa3b8]             ; mummy_i
1a52  xor    ah, ah
1a54  mov    dx, 0x1e
1a57  mul    dx
1a59  mov    di, ax
1a5b  mov    al, byte ptr [di - 0x503a]
1a5f  xor    ah, ah
1a61  mov    dx, 0x226
1a64  mul    dx
1a66  mov    di, ax
1a68  add    di, cx
1a6a  add    di, bx
1a6c  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1a70  push   ax
1a71  mov    di, 0xdc8                         ; set cs:0dc8 = [30,33,34,35,56,76,85,86,87,88,100,106,156,206]
1a74  push   cs
1a75  push   di
1a76  call   Sys_SetIn
1a7b  je     0x1a80
1a7d  jmp    0x1b9a
  loc_1a80:
1a80  mov    al, byte ptr [0xa3b8]             ; mummy_i
1a83  xor    ah, ah
1a85  mov    dx, 0x1e
1a88  mul    dx
1a8a  mov    di, ax
1a8c  sub    word ptr [di - 0x5046], 6
1a91  mov    al, byte ptr [0xa3b8]             ; mummy_i
1a94  xor    ah, ah
1a96  mov    dx, 0x1e
1a99  mul    dx
1a9b  mov    di, ax
1a9d  mov    byte ptr [di - 0x5032], 0
1aa2  mov    al, byte ptr [0xa3b8]             ; mummy_i
1aa5  xor    ah, ah
1aa7  mov    dx, 0x1e
1aaa  mul    dx
1aac  mov    di, ax
1aae  mov    byte ptr [di - 0x5031], 0
1ab3  mov    al, byte ptr [0xa3b8]             ; mummy_i
1ab6  xor    ah, ah
1ab8  mov    dx, 0x1e
1abb  mul    dx
1abd  mov    di, ax
1abf  mov    byte ptr [di - 0x5030], 0
1ac4  mov    ax, 2
1ac7  push   ax
1ac8  call   Sys_Random
1acd  shl    ax, 1
1acf  dec    ax
1ad0  mov    cx, ax
1ad2  mov    al, byte ptr [0xa3b8]             ; mummy_i
1ad5  xor    ah, ah
1ad7  mov    dx, 0x1e
1ada  mul    dx
1adc  mov    di, ax
1ade  mov    word ptr [di - 0x503e], cx
1ae2  mov    al, byte ptr [0xa3b8]             ; mummy_i
1ae5  xor    ah, ah
1ae7  mov    dx, 0x1e
1aea  mul    dx
1aec  mov    di, ax
1aee  mov    al, byte ptr [di - 0x503a]
1af2  cmp    al, byte ptr [0xa3c5]             ; cur_room
1af6  jne    0x1b47
1af8  mov    al, byte ptr [0xa3b8]             ; mummy_i
1afb  xor    ah, ah
1afd  mov    dx, 0x1e
1b00  mul    dx
1b02  mov    di, ax
1b04  mov    cx, word ptr [di - 0x503e]
1b08  mov    al, byte ptr [0xa3b8]             ; mummy_i
1b0b  xor    ah, ah
1b0d  mov    dx, 0x1e
1b10  mul    dx
1b12  mov    di, ax
1b14  mov    dx, word ptr [di - 0x5048]        ; +mummies
1b18  mov    ax, word ptr [0xb058]             ; player_x
1b1b  sub    ax, dx
1b1d  imul   cx
1b1f  or     ax, ax
1b21  jge    0x1b47
1b23  mov    al, byte ptr [0xa3b8]             ; mummy_i
1b26  xor    ah, ah
1b28  mov    dx, 0x1e
1b2b  mul    dx
1b2d  mov    di, ax
1b2f  mov    ax, word ptr [di - 0x503e]
1b33  neg    ax
1b35  mov    cx, ax
1b37  mov    al, byte ptr [0xa3b8]             ; mummy_i
1b3a  xor    ah, ah
1b3c  mov    dx, 0x1e
1b3f  mul    dx
1b41  mov    di, ax
1b43  mov    word ptr [di - 0x503e], cx
  loc_1b47:
1b47  mov    al, byte ptr [0xa3b8]             ; mummy_i
1b4a  xor    ah, ah
1b4c  mov    dx, 0x1e
1b4f  mul    dx
1b51  mov    di, ax
1b53  mov    ax, word ptr [di - 0x5046]
1b57  cdq
1b58  mov    cx, 8
1b5b  idiv   cx
1b5d  mov    cx, 3
1b60  shl    ax, cl
1b62  add    ax, 8
1b65  mov    cx, ax
1b67  mov    al, byte ptr [0xa3b8]             ; mummy_i
1b6a  xor    ah, ah
1b6c  mov    dx, 0x1e
1b6f  mul    dx
1b71  mov    di, ax
1b73  mov    word ptr [di - 0x5046], cx
1b77  mov    al, byte ptr [0xa3b8]             ; mummy_i
1b7a  xor    ah, ah
1b7c  mov    dx, 0x1e
1b7f  mul    dx
1b81  mov    di, ax
1b83  mov    byte ptr [di - 0x5037], 0x64
1b88  mov    al, byte ptr [0xa3b8]             ; mummy_i
1b8b  xor    ah, ah
1b8d  mov    dx, 0x1e
1b90  mul    dx
1b92  mov    di, ax
1b94  mov    word ptr [di - 0x503c], 0xffff
  loc_1b9a:
1b9a  mov    al, byte ptr [0xa3b8]             ; mummy_i
1b9d  xor    ah, ah
1b9f  mov    dx, 0x1e
1ba2  mul    dx
1ba4  mov    di, ax
1ba6  cmp    byte ptr [di - 0x502d], 0
1bab  je     0x1bb0
1bad  jmp    0x1f81
  loc_1bb0:
1bb0  mov    al, byte ptr [0xa3b8]             ; mummy_i
1bb3  xor    ah, ah
1bb5  mov    dx, 0x1e
1bb8  mul    dx
1bba  mov    di, ax
1bbc  mov    ax, word ptr [di - 0x5046]
1bc0  add    ax, 7
1bc3  cdq
1bc4  mov    cx, 8
1bc7  idiv   cx
1bc9  mov    bx, ax
1bcb  mov    al, byte ptr [0xa3b8]             ; mummy_i
1bce  xor    ah, ah
1bd0  mov    dx, 0x1e
1bd3  mul    dx
1bd5  mov    di, ax
1bd7  mov    ax, word ptr [di - 0x5048]        ; +mummies
1bdb  add    ax, 0xc
1bde  cdq
1bdf  mov    cx, 0x20
1be2  idiv   cx
1be4  mov    dx, 0x19
1be7  mul    dx
1be9  mov    cx, ax
1beb  mov    al, byte ptr [0xa3b8]             ; mummy_i
1bee  xor    ah, ah
1bf0  mov    dx, 0x1e
1bf3  mul    dx
1bf5  mov    di, ax
1bf7  mov    al, byte ptr [di - 0x503a]
1bfb  xor    ah, ah
1bfd  mov    dx, 0x226
1c00  mul    dx
1c02  mov    di, ax
1c04  add    di, cx
1c06  add    di, bx
1c08  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1c0c  push   ax
1c0d  mov    di, 0xde8                         ; set cs:0de8 = [51,52,101,102,111,151,152,161,201,202,211,251,252]
1c10  push   cs
1c11  push   di
1c12  call   Sys_SetIn
1c17  je     0x1c85
1c19  mov    al, byte ptr [0xa3b8]             ; mummy_i
1c1c  xor    ah, ah
1c1e  mov    dx, 0x1e
1c21  mul    dx
1c23  mov    di, ax
1c25  mov    ax, word ptr [di - 0x5046]
1c29  add    ax, 7
1c2c  cdq
1c2d  mov    cx, 8
1c30  idiv   cx
1c32  mov    bx, ax
1c34  mov    al, byte ptr [0xa3b8]             ; mummy_i
1c37  xor    ah, ah
1c39  mov    dx, 0x1e
1c3c  mul    dx
1c3e  mov    di, ax
1c40  mov    ax, word ptr [di - 0x5048]        ; +mummies
1c44  sub    ax, 0xd
1c47  cdq
1c48  mov    cx, 0x20
1c4b  idiv   cx
1c4d  mov    dx, 0x19
1c50  mul    dx
1c52  mov    cx, ax
1c54  mov    al, byte ptr [0xa3b8]             ; mummy_i
1c57  xor    ah, ah
1c59  mov    dx, 0x1e
1c5c  mul    dx
1c5e  mov    di, ax
1c60  mov    al, byte ptr [di - 0x503a]
1c64  xor    ah, ah
1c66  mov    dx, 0x226
1c69  mul    dx
1c6b  mov    di, ax
1c6d  add    di, cx
1c6f  add    di, bx
1c71  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1c75  push   ax
1c76  mov    di, 0xde8                         ; set cs:0de8 = [51,52,101,102,111,151,152,161,201,202,211,251,252]
1c79  push   cs
1c7a  push   di
1c7b  call   Sys_SetIn
1c80  je     0x1c85
1c82  jmp    0x1d57
  loc_1c85:
1c85  mov    al, byte ptr [0xa3b8]             ; mummy_i
1c88  xor    ah, ah
1c8a  mov    dx, 0x1e
1c8d  mul    dx
1c8f  mov    di, ax
1c91  mov    ax, word ptr [di - 0x5046]
1c95  cdq
1c96  mov    cx, 8
1c99  idiv   cx
1c9b  mov    bx, ax
1c9d  mov    al, byte ptr [0xa3b8]             ; mummy_i
1ca0  xor    ah, ah
1ca2  mov    dx, 0x1e
1ca5  mul    dx
1ca7  mov    di, ax
1ca9  mov    ax, word ptr [di - 0x5048]        ; +mummies
1cad  add    ax, 0xc
1cb0  cdq
1cb1  mov    cx, 0x20
1cb4  idiv   cx
1cb6  mov    dx, 0x19
1cb9  mul    dx
1cbb  mov    cx, ax
1cbd  mov    al, byte ptr [0xa3b8]             ; mummy_i
1cc0  xor    ah, ah
1cc2  mov    dx, 0x1e
1cc5  mul    dx
1cc7  mov    di, ax
1cc9  mov    al, byte ptr [di - 0x503a]
1ccd  xor    ah, ah
1ccf  mov    dx, 0x226
1cd2  mul    dx
1cd4  mov    di, ax
1cd6  add    di, cx
1cd8  add    di, bx
1cda  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1cde  push   ax
1cdf  mov    di, 0xde8                         ; set cs:0de8 = [51,52,101,102,111,151,152,161,201,202,211,251,252]
1ce2  push   cs
1ce3  push   di
1ce4  call   Sys_SetIn
1ce9  jne    0x1cee
1ceb  jmp    0x1f81
  loc_1cee:
1cee  mov    al, byte ptr [0xa3b8]             ; mummy_i
1cf1  xor    ah, ah
1cf3  mov    dx, 0x1e
1cf6  mul    dx
1cf8  mov    di, ax
1cfa  mov    ax, word ptr [di - 0x5046]
1cfe  cdq
1cff  mov    cx, 8
1d02  idiv   cx
1d04  mov    bx, ax
1d06  mov    al, byte ptr [0xa3b8]             ; mummy_i
1d09  xor    ah, ah
1d0b  mov    dx, 0x1e
1d0e  mul    dx
1d10  mov    di, ax
1d12  mov    ax, word ptr [di - 0x5048]        ; +mummies
1d16  sub    ax, 0xd
1d19  cdq
1d1a  mov    cx, 0x20
1d1d  idiv   cx
1d1f  mov    dx, 0x19
1d22  mul    dx
1d24  mov    cx, ax
1d26  mov    al, byte ptr [0xa3b8]             ; mummy_i
1d29  xor    ah, ah
1d2b  mov    dx, 0x1e
1d2e  mul    dx
1d30  mov    di, ax
1d32  mov    al, byte ptr [di - 0x503a]
1d36  xor    ah, ah
1d38  mov    dx, 0x226
1d3b  mul    dx
1d3d  mov    di, ax
1d3f  add    di, cx
1d41  add    di, bx
1d43  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1d47  push   ax
1d48  mov    di, 0xde8                         ; set cs:0de8 = [51,52,101,102,111,151,152,161,201,202,211,251,252]
1d4b  push   cs
1d4c  push   di
1d4d  call   Sys_SetIn
1d52  jne    0x1d57
1d54  jmp    0x1f81
  loc_1d57:
1d57  mov    al, byte ptr [0xa3b8]             ; mummy_i
1d5a  xor    ah, ah
1d5c  mov    dx, 0x1e
1d5f  mul    dx
1d61  mov    di, ax
1d63  cmp    byte ptr [di - 0x5036], 0
1d68  ja     0x1d6d
1d6a  jmp    0x1f5b
  loc_1d6d:
1d6d  mov    al, byte ptr [0xa3b8]             ; mummy_i
1d70  xor    ah, ah
1d72  mov    dx, 0x1e
1d75  mul    dx
1d77  mov    di, ax
1d79  cmp    byte ptr [di - 0x5035], 0
1d7e  ja     0x1d83
1d80  jmp    0x1f5b
  loc_1d83:
1d83  mov    al, byte ptr [0xa3b8]             ; mummy_i
1d86  xor    ah, ah
1d88  mov    dx, 0x1e
1d8b  mul    dx
1d8d  mov    di, ax
1d8f  sub    word ptr [di - 0x5046], 2
1d94  mov    al, byte ptr [0xa3b8]             ; mummy_i
1d97  xor    ah, ah
1d99  mov    dx, 0x1e
1d9c  mul    dx
1d9e  mov    di, ax
1da0  mov    word ptr [di - 0x503c], 0xffff
1da6  mov    al, byte ptr [0xa3b8]             ; mummy_i
1da9  xor    ah, ah
1dab  mov    dx, 0x1e
1dae  mul    dx
1db0  mov    di, ax
1db2  mov    byte ptr [di - 0x5030], 0
1db7  mov    al, byte ptr [0xa3b8]             ; mummy_i
1dba  xor    ah, ah
1dbc  mov    dx, 0x1e
1dbf  mul    dx
1dc1  mov    di, ax
1dc3  xor    ax, ax
1dc5  mov    word ptr [di - 0x503e], ax
1dc9  mov    al, byte ptr [0xa3b8]             ; mummy_i
1dcc  xor    ah, ah
1dce  mov    dx, 0x1e
1dd1  mul    dx
1dd3  mov    di, ax
1dd5  mov    byte ptr [di - 0x502e], 1
1dda  mov    al, byte ptr [0xa3b8]             ; mummy_i
1ddd  xor    ah, ah
1ddf  mov    dx, 0x1e
1de2  mul    dx
1de4  mov    di, ax
1de6  cmp    word ptr [di - 0x5046], 5
1deb  jge    0x1e27
1ded  mov    al, byte ptr [0xa3b8]             ; mummy_i
1df0  xor    ah, ah
1df2  mov    dx, 0x1e
1df5  mul    dx
1df7  mov    di, ax
1df9  add    di, 0xafc6
1dfd  push   ds
1dfe  push   di
1dff  mov    al, byte ptr [0xa3b8]             ; mummy_i
1e02  xor    ah, ah
1e04  mov    dx, 0x1e
1e07  mul    dx
1e09  mov    di, ax
1e0b  add    di, 0xafb8
1e0f  push   ds
1e10  push   di
1e11  mov    al, byte ptr [0xa3b8]             ; mummy_i
1e14  xor    ah, ah
1e16  mov    dx, 0x1e
1e19  mul    dx
1e1b  mov    di, ax
1e1d  add    di, 0xafba
1e21  push   ds
1e22  push   di
1e23  push   cs
1e24  call   move_to_next_room
  loc_1e27:
1e27  mov    al, byte ptr [0xa3b8]             ; mummy_i
1e2a  xor    ah, ah
1e2c  mov    dx, 0x1e
1e2f  mul    dx
1e31  mov    di, ax
1e33  mov    ax, word ptr [di - 0x5044]
1e37  cdq
1e38  mov    cx, 5
1e3b  idiv   cx
1e3d  cdq
1e3e  mov    cx, 2
1e41  idiv   cx
1e43  xchg   dx, ax
1e44  add    ax, 0x50
1e47  mov    cl, al
1e49  mov    al, byte ptr [0xa3b8]             ; mummy_i
1e4c  xor    ah, ah
1e4e  mov    dx, 0x1e
1e51  mul    dx
1e53  mov    di, ax
1e55  mov    byte ptr [di - 0x5038], cl
1e59  mov    al, byte ptr [0xa3b8]             ; mummy_i
1e5c  xor    ah, ah
1e5e  mov    dx, 0x1e
1e61  mul    dx
1e63  mov    di, ax
1e65  mov    ax, word ptr [di - 0x5048]        ; +mummies
1e69  sub    ax, 0xb
1e6c  cdq
1e6d  mov    cx, 0x20
1e70  idiv   cx
1e72  mov    word ptr [0xb070], ax             ; probe_x
1e75  mov    al, byte ptr [0xa3b8]             ; mummy_i
1e78  xor    ah, ah
1e7a  mov    dx, 0x1e
1e7d  mul    dx
1e7f  mov    di, ax
1e81  mov    ax, word ptr [di - 0x5046]
1e85  sub    ax, 7
1e88  cdq
1e89  mov    cx, 8
1e8c  idiv   cx
1e8e  mov    word ptr [0xb072], ax             ; probe_y
1e91  mov    ax, word ptr [0xb072]             ; probe_y
1e94  mov    bx, ax
1e96  mov    ax, word ptr [0xb070]             ; probe_x
1e99  mov    dx, 0x19
1e9c  mul    dx
1e9e  mov    cx, ax
1ea0  mov    al, byte ptr [0xa3b8]             ; mummy_i
1ea3  xor    ah, ah
1ea5  mov    dx, 0x1e
1ea8  mul    dx
1eaa  mov    di, ax
1eac  mov    al, byte ptr [di - 0x503a]
1eb0  xor    ah, ah
1eb2  mov    dx, 0x226
1eb5  mul    dx
1eb7  mov    di, ax
1eb9  add    di, cx
1ebb  add    di, bx
1ebd  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1ec1  push   ax
1ec2  mov    di, 0xe08                         ; set cs:0e08 = [50,53,54,175,222]
1ec5  push   cs
1ec6  push   di
1ec7  call   Sys_SetIn
1ecc  jne    0x1f21
1ece  mov    ax, word ptr [0xb072]             ; probe_y
1ed1  mov    bx, ax
1ed3  mov    al, byte ptr [0xa3b8]             ; mummy_i
1ed6  xor    ah, ah
1ed8  mov    dx, 0x1e
1edb  mul    dx
1edd  mov    di, ax
1edf  mov    ax, word ptr [di - 0x5048]        ; +mummies
1ee3  add    ax, 0xa
1ee6  cdq
1ee7  mov    cx, 0x20
1eea  idiv   cx
1eec  mov    dx, 0x19
1eef  mul    dx
1ef1  mov    cx, ax
1ef3  mov    al, byte ptr [0xa3b8]             ; mummy_i
1ef6  xor    ah, ah
1ef8  mov    dx, 0x1e
1efb  mul    dx
1efd  mov    di, ax
1eff  mov    al, byte ptr [di - 0x503a]
1f03  xor    ah, ah
1f05  mov    dx, 0x226
1f08  mul    dx
1f0a  mov    di, ax
1f0c  add    di, cx
1f0e  add    di, bx
1f10  mov    al, byte ptr [di - 0x4a70]        ; +rooms
1f14  push   ax
1f15  mov    di, 0xe08                         ; set cs:0e08 = [50,53,54,175,222]
1f18  push   cs
1f19  push   di
1f1a  call   Sys_SetIn
1f1f  je     0x1f48
  loc_1f21:
1f21  mov    al, byte ptr [0xa3b8]             ; mummy_i
1f24  xor    ah, ah
1f26  mov    dx, 0x1e
1f29  mul    dx
1f2b  mov    di, ax
1f2d  add    word ptr [di - 0x5046], 2
1f32  mov    al, byte ptr [0xa3b8]             ; mummy_i
1f35  xor    ah, ah
1f37  mov    dx, 0x1e
1f3a  mul    dx
1f3c  mov    di, ax
1f3e  mov    byte ptr [di - 0x502c], 1
1f43  jmp    0x2365
1f46  db eb,11
  loc_1f48:
1f48  mov    al, byte ptr [0xa3b8]             ; mummy_i
1f4b  xor    ah, ah
1f4d  mov    dx, 0x1e
1f50  mul    dx
1f52  mov    di, ax
1f54  mov    byte ptr [di - 0x5030], 0
1f59  jmp    0x1f7f
  loc_1f5b:
1f5b  mov    al, byte ptr [0xa3b8]             ; mummy_i
1f5e  xor    ah, ah
1f60  mov    dx, 0x1e
1f63  mul    dx
1f65  mov    di, ax
1f67  cmp    byte ptr [di - 0x502d], 0
1f6c  jne    0x1f7f
1f6e  mov    al, byte ptr [0xa3b8]             ; mummy_i
1f71  xor    ah, ah
1f73  mov    dx, 0x1e
1f76  mul    dx
1f78  mov    di, ax
1f7a  mov    byte ptr [di - 0x5030], 0
  loc_1f7f:
1f7f  jmp    0x1fef
  loc_1f81:
1f81  mov    al, byte ptr [0xa3b8]             ; mummy_i
1f84  xor    ah, ah
1f86  mov    dx, 0x1e
1f89  mul    dx
1f8b  mov    di, ax
1f8d  cmp    byte ptr [di - 0x502e], 0
1f92  je     0x1fb8
1f94  mov    al, byte ptr [0xa3b8]             ; mummy_i
1f97  xor    ah, ah
1f99  mov    dx, 0x1e
1f9c  mul    dx
1f9e  mov    di, ax
1fa0  mov    byte ptr [di - 0x502c], 1
1fa5  mov    al, byte ptr [0xa3b8]             ; mummy_i
1fa8  xor    ah, ah
1faa  mov    dx, 0x1e
1fad  mul    dx
1faf  mov    di, ax
1fb1  mov    byte ptr [di - 0x502e], 0
1fb6  jmp    0x1fef
  loc_1fb8:
1fb8  mov    al, byte ptr [0xa3b8]             ; mummy_i
1fbb  xor    ah, ah
1fbd  mov    dx, 0x1e
1fc0  mul    dx
1fc2  mov    di, ax
1fc4  cmp    byte ptr [di - 0x5036], 0
1fc9  jbe    0x1fef
1fcb  mov    al, byte ptr [0xa3b8]             ; mummy_i
1fce  xor    ah, ah
1fd0  mov    dx, 0x1e
1fd3  mul    dx
1fd5  mov    di, ax
1fd7  cmp    byte ptr [di - 0x5035], 0
1fdc  jbe    0x1fef
1fde  mov    al, byte ptr [0xa3b8]             ; mummy_i
1fe1  xor    ah, ah
1fe3  mov    dx, 0x1e
1fe6  mul    dx
1fe8  mov    di, ax
1fea  mov    byte ptr [di - 0x5030], 1
  loc_1fef:
1fef  mov    al, byte ptr [0xa3b8]             ; mummy_i
1ff2  xor    ah, ah
1ff4  mov    dx, 0x1e
1ff7  mul    dx
1ff9  mov    di, ax
1ffb  cmp    byte ptr [di - 0x5030], 0
2000  jne    0x2005
2002  jmp    0x2365
  loc_2005:
2005  mov    al, byte ptr [0xa3b8]             ; mummy_i
2008  xor    ah, ah
200a  mov    dx, 0x1e
200d  mul    dx
200f  mov    di, ax
2011  mov    ax, word ptr [di - 0x5046]
2015  add    ax, 8
2018  cdq
2019  mov    cx, 8
201c  idiv   cx
201e  mov    bx, ax
2020  mov    al, byte ptr [0xa3b8]             ; mummy_i
2023  xor    ah, ah
2025  mov    dx, 0x1e
2028  mul    dx
202a  mov    di, ax
202c  mov    ax, word ptr [di - 0x5048]        ; +mummies
2030  add    ax, 0xc
2033  cdq
2034  mov    cx, 0x20
2037  idiv   cx
2039  mov    dx, 0x19
203c  mul    dx
203e  mov    cx, ax
2040  mov    al, byte ptr [0xa3b8]             ; mummy_i
2043  xor    ah, ah
2045  mov    dx, 0x1e
2048  mul    dx
204a  mov    di, ax
204c  mov    al, byte ptr [di - 0x503a]
2050  xor    ah, ah
2052  mov    dx, 0x226
2055  mul    dx
2057  mov    di, ax
2059  add    di, cx
205b  add    di, bx
205d  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2061  push   ax
2062  mov    di, 0xe28                         ; set cs:0e28 = [51,52,100,101,102,111,151,152,161,201,202,211,251,252]
2065  push   cs
2066  push   di
2067  call   Sys_SetIn
206c  jne    0x2071
206e  jmp    0x22e6
  loc_2071:
2071  mov    al, byte ptr [0xa3b8]             ; mummy_i
2074  xor    ah, ah
2076  mov    dx, 0x1e
2079  mul    dx
207b  mov    di, ax
207d  mov    ax, word ptr [di - 0x5046]
2081  add    ax, 8
2084  cdq
2085  mov    cx, 8
2088  idiv   cx
208a  mov    bx, ax
208c  mov    al, byte ptr [0xa3b8]             ; mummy_i
208f  xor    ah, ah
2091  mov    dx, 0x1e
2094  mul    dx
2096  mov    di, ax
2098  mov    ax, word ptr [di - 0x5048]        ; +mummies
209c  sub    ax, 0xd
209f  cdq
20a0  mov    cx, 0x20
20a3  idiv   cx
20a5  mov    dx, 0x19
20a8  mul    dx
20aa  mov    cx, ax
20ac  mov    al, byte ptr [0xa3b8]             ; mummy_i
20af  xor    ah, ah
20b1  mov    dx, 0x1e
20b4  mul    dx
20b6  mov    di, ax
20b8  mov    al, byte ptr [di - 0x503a]
20bc  xor    ah, ah
20be  mov    dx, 0x226
20c1  mul    dx
20c3  mov    di, ax
20c5  add    di, cx
20c7  add    di, bx
20c9  mov    al, byte ptr [di - 0x4a70]        ; +rooms
20cd  push   ax
20ce  mov    di, 0xe28                         ; set cs:0e28 = [51,52,100,101,102,111,151,152,161,201,202,211,251,252]
20d1  push   cs
20d2  push   di
20d3  call   Sys_SetIn
20d8  jne    0x20dd
20da  jmp    0x22e6
  loc_20dd:
20dd  mov    al, byte ptr [0xa3b8]             ; mummy_i
20e0  xor    ah, ah
20e2  mov    dx, 0x1e
20e5  mul    dx
20e7  mov    di, ax
20e9  add    word ptr [di - 0x5046], 2
20ee  mov    al, byte ptr [0xa3b8]             ; mummy_i
20f1  xor    ah, ah
20f3  mov    dx, 0x1e
20f6  mul    dx
20f8  mov    di, ax
20fa  mov    byte ptr [di - 0x502f], 0
20ff  mov    al, byte ptr [0xa3b8]             ; mummy_i
2102  xor    ah, ah
2104  mov    dx, 0x1e
2107  mul    dx
2109  mov    di, ax
210b  xor    ax, ax
210d  mov    word ptr [di - 0x503e], ax
2111  mov    al, byte ptr [0xa3b8]             ; mummy_i
2114  xor    ah, ah
2116  mov    dx, 0x1e
2119  mul    dx
211b  mov    di, ax
211d  mov    byte ptr [di - 0x5030], 1
2122  mov    al, byte ptr [0xa3b8]             ; mummy_i
2125  xor    ah, ah
2127  mov    dx, 0x1e
212a  mul    dx
212c  mov    di, ax
212e  mov    byte ptr [di - 0x502d], 1
2133  mov    al, byte ptr [0xa3b8]             ; mummy_i
2136  xor    ah, ah
2138  mov    dx, 0x1e
213b  mul    dx
213d  mov    di, ax
213f  mov    byte ptr [di - 0x502c], 0
2144  mov    al, byte ptr [0xa3b8]             ; mummy_i
2147  xor    ah, ah
2149  mov    dx, 0x1e
214c  mul    dx
214e  mov    di, ax
2150  mov    byte ptr [di - 0x502e], 0
2155  mov    al, byte ptr [0xa3b8]             ; mummy_i
2158  xor    ah, ah
215a  mov    dx, 0x1e
215d  mul    dx
215f  mov    di, ax
2161  cmp    word ptr [di - 0x5046], 0xb4
2167  jle    0x21a3
2169  mov    al, byte ptr [0xa3b8]             ; mummy_i
216c  xor    ah, ah
216e  mov    dx, 0x1e
2171  mul    dx
2173  mov    di, ax
2175  add    di, 0xafc6
2179  push   ds
217a  push   di
217b  mov    al, byte ptr [0xa3b8]             ; mummy_i
217e  xor    ah, ah
2180  mov    dx, 0x1e
2183  mul    dx
2185  mov    di, ax
2187  add    di, 0xafb8
218b  push   ds
218c  push   di
218d  mov    al, byte ptr [0xa3b8]             ; mummy_i
2190  xor    ah, ah
2192  mov    dx, 0x1e
2195  mul    dx
2197  mov    di, ax
2199  add    di, 0xafba
219d  push   ds
219e  push   di
219f  push   cs
21a0  call   move_to_next_room
  loc_21a3:
21a3  mov    al, byte ptr [0xa3b8]             ; mummy_i
21a6  xor    ah, ah
21a8  mov    dx, 0x1e
21ab  mul    dx
21ad  mov    di, ax
21af  mov    ax, word ptr [di - 0x5044]
21b3  cdq
21b4  mov    cx, 5
21b7  idiv   cx
21b9  cdq
21ba  mov    cx, 2
21bd  idiv   cx
21bf  xchg   dx, ax
21c0  add    ax, 0x50
21c3  mov    cl, al
21c5  mov    al, byte ptr [0xa3b8]             ; mummy_i
21c8  xor    ah, ah
21ca  mov    dx, 0x1e
21cd  mul    dx
21cf  mov    di, ax
21d1  mov    byte ptr [di - 0x5038], cl
21d5  mov    al, byte ptr [0xa3b8]             ; mummy_i
21d8  xor    ah, ah
21da  mov    dx, 0x1e
21dd  mul    dx
21df  mov    di, ax
21e1  mov    ax, word ptr [di - 0x5048]        ; +mummies
21e5  sub    ax, 0xa
21e8  cdq
21e9  mov    cx, 0x20
21ec  idiv   cx
21ee  mov    word ptr [0xb070], ax             ; probe_x
21f1  mov    al, byte ptr [0xa3b8]             ; mummy_i
21f4  xor    ah, ah
21f6  mov    dx, 0x1e
21f9  mul    dx
21fb  mov    di, ax
21fd  mov    ax, word ptr [di - 0x5046]
2201  add    ax, 7
2204  cdq
2205  mov    cx, 8
2208  idiv   cx
220a  mov    word ptr [0xb072], ax             ; probe_y
220d  mov    ax, word ptr [0xb072]             ; probe_y
2210  mov    bx, ax
2212  mov    ax, word ptr [0xb070]             ; probe_x
2215  mov    dx, 0x19
2218  mul    dx
221a  mov    cx, ax
221c  mov    al, byte ptr [0xa3b8]             ; mummy_i
221f  xor    ah, ah
2221  mov    dx, 0x1e
2224  mul    dx
2226  mov    di, ax
2228  mov    al, byte ptr [di - 0x503a]
222c  xor    ah, ah
222e  mov    dx, 0x226
2231  mul    dx
2233  mov    di, ax
2235  add    di, cx
2237  add    di, bx
2239  mov    al, byte ptr [di - 0x4a70]        ; +rooms
223d  push   ax
223e  mov    di, 0xda8                         ; set cs:0da8 = [42,43,46,47,50,53,54,175,222]
2241  push   cs
2242  push   di
2243  call   Sys_SetIn
2248  jne    0x229d
224a  mov    ax, word ptr [0xb072]             ; probe_y
224d  mov    bx, ax
224f  mov    al, byte ptr [0xa3b8]             ; mummy_i
2252  xor    ah, ah
2254  mov    dx, 0x1e
2257  mul    dx
2259  mov    di, ax
225b  mov    ax, word ptr [di - 0x5048]        ; +mummies
225f  add    ax, 9
2262  cdq
2263  mov    cx, 0x20
2266  idiv   cx
2268  mov    dx, 0x19
226b  mul    dx
226d  mov    cx, ax
226f  mov    al, byte ptr [0xa3b8]             ; mummy_i
2272  xor    ah, ah
2274  mov    dx, 0x1e
2277  mul    dx
2279  mov    di, ax
227b  mov    al, byte ptr [di - 0x503a]
227f  xor    ah, ah
2281  mov    dx, 0x226
2284  mul    dx
2286  mov    di, ax
2288  add    di, cx
228a  add    di, bx
228c  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2290  push   ax
2291  mov    di, 0xda8                         ; set cs:0da8 = [42,43,46,47,50,53,54,175,222]
2294  push   cs
2295  push   di
2296  call   Sys_SetIn
229b  je     0x22d2
  loc_229d:
229d  mov    al, byte ptr [0xa3b8]             ; mummy_i
22a0  xor    ah, ah
22a2  mov    dx, 0x1e
22a5  mul    dx
22a7  mov    di, ax
22a9  sub    word ptr [di - 0x5046], 2
22ae  mov    al, byte ptr [0xa3b8]             ; mummy_i
22b1  xor    ah, ah
22b3  mov    dx, 0x1e
22b6  mul    dx
22b8  mov    di, ax
22ba  mov    byte ptr [di - 0x502c], 1
22bf  mov    al, byte ptr [0xa3b8]             ; mummy_i
22c2  xor    ah, ah
22c4  mov    dx, 0x1e
22c7  mul    dx
22c9  mov    di, ax
22cb  mov    byte ptr [di - 0x5030], 0
22d0  jmp    0x22e3
  loc_22d2:
22d2  mov    al, byte ptr [0xa3b8]             ; mummy_i
22d5  xor    ah, ah
22d7  mov    dx, 0x1e
22da  mul    dx
22dc  mov    di, ax
22de  mov    byte ptr [di - 0x502f], 0
  loc_22e3:
22e3  jmp    0x2365
  loc_22e6:
22e6  mov    al, byte ptr [0xa3b8]             ; mummy_i
22e9  xor    ah, ah
22eb  mov    dx, 0x1e
22ee  mul    dx
22f0  mov    di, ax
22f2  cmp    byte ptr [di - 0x502d], 0
22f7  je     0x232e
22f9  mov    al, byte ptr [0xa3b8]             ; mummy_i
22fc  xor    ah, ah
22fe  mov    dx, 0x1e
2301  mul    dx
2303  mov    di, ax
2305  mov    byte ptr [di - 0x502c], 1
230a  mov    al, byte ptr [0xa3b8]             ; mummy_i
230d  xor    ah, ah
230f  mov    dx, 0x1e
2312  mul    dx
2314  mov    di, ax
2316  mov    byte ptr [di - 0x502d], 0
231b  mov    al, byte ptr [0xa3b8]             ; mummy_i
231e  xor    ah, ah
2320  mov    dx, 0x1e
2323  mul    dx
2325  mov    di, ax
2327  mov    byte ptr [di - 0x5030], 0
232c  jmp    0x2365
  loc_232e:
232e  mov    al, byte ptr [0xa3b8]             ; mummy_i
2331  xor    ah, ah
2333  mov    dx, 0x1e
2336  mul    dx
2338  mov    di, ax
233a  cmp    byte ptr [di - 0x5036], 0
233f  jbe    0x2365
2341  mov    al, byte ptr [0xa3b8]             ; mummy_i
2344  xor    ah, ah
2346  mov    dx, 0x1e
2349  mul    dx
234b  mov    di, ax
234d  cmp    byte ptr [di - 0x5035], 0
2352  jbe    0x2365
2354  mov    al, byte ptr [0xa3b8]             ; mummy_i
2357  xor    ah, ah
2359  mov    dx, 0x1e
235c  mul    dx
235e  mov    di, ax
2360  mov    byte ptr [di - 0x502f], 1
  loc_2365:
2365  mov    al, byte ptr [0xa3b8]             ; mummy_i
2368  xor    ah, ah
236a  mov    dx, 0x1e
236d  mul    dx
236f  mov    di, ax
2371  cmp    byte ptr [di - 0x502c], 0
2376  jne    0x237b
2378  jmp    0x23ff
  loc_237b:
237b  mov    al, byte ptr [0xa3b8]             ; mummy_i
237e  xor    ah, ah
2380  mov    dx, 0x1e
2383  mul    dx
2385  mov    di, ax
2387  mov    byte ptr [di - 0x5032], 0
238c  mov    al, byte ptr [0xa3b8]             ; mummy_i
238f  xor    ah, ah
2391  mov    dx, 0x1e
2394  mul    dx
2396  mov    di, ax
2398  mov    byte ptr [di - 0x5036], 0
239d  mov    al, byte ptr [0xa3b8]             ; mummy_i
23a0  xor    ah, ah
23a2  mov    dx, 0x1e
23a5  mul    dx
23a7  mov    di, ax
23a9  mov    byte ptr [di - 0x5031], 0
23ae  mov    al, byte ptr [0xa3b8]             ; mummy_i
23b1  xor    ah, ah
23b3  mov    dx, 0x1e
23b6  mul    dx
23b8  mov    di, ax
23ba  mov    byte ptr [di - 0x5035], 0
23bf  mov    ax, 2
23c2  push   ax
23c3  call   Sys_Random
23c8  shl    ax, 1
23ca  dec    ax
23cb  mov    cx, ax
23cd  mov    al, byte ptr [0xa3b8]             ; mummy_i
23d0  xor    ah, ah
23d2  mov    dx, 0x1e
23d5  mul    dx
23d7  mov    di, ax
23d9  mov    word ptr [di - 0x503e], cx
23dd  mov    al, byte ptr [0xa3b8]             ; mummy_i
23e0  xor    ah, ah
23e2  mov    dx, 0x1e
23e5  mul    dx
23e7  mov    di, ax
23e9  mov    byte ptr [di - 0x5037], 0x64
23ee  mov    al, byte ptr [0xa3b8]             ; mummy_i
23f1  xor    ah, ah
23f3  mov    dx, 0x1e
23f6  mul    dx
23f8  mov    di, ax
23fa  mov    byte ptr [di - 0x502c], 0
  loc_23ff:
23ff  mov    al, byte ptr [0xa3b8]             ; mummy_i
2402  xor    ah, ah
2404  mov    dx, 0x1e
2407  mul    dx
2409  mov    di, ax
240b  mov    al, byte ptr [di - 0x503a]
240f  cmp    al, byte ptr [0xa3c5]             ; cur_room
2413  jne    0x2467
2415  mov    al, byte ptr [0xa3b8]             ; mummy_i
2418  xor    ah, ah
241a  mov    dx, 0x1e
241d  mul    dx
241f  mov    di, ax
2421  mov    ax, word ptr [di - 0x5048]        ; +mummies
2425  sub    ax, 0x10
2428  push   ax
2429  mov    al, byte ptr [0xa3b8]             ; mummy_i
242c  xor    ah, ah
242e  mov    dx, 0x1e
2431  mul    dx
2433  mov    di, ax
2435  mov    ax, word ptr [di - 0x5046]
2439  sub    ax, 8
243c  push   ax
243d  mov    al, byte ptr [0xa3b8]             ; mummy_i
2440  xor    ah, ah
2442  mov    dx, 0x1e
2445  mul    dx
2447  mov    di, ax
2449  mov    al, byte ptr [di - 0x5038]
244d  xor    ah, ah
244f  mov    dx, 0x54
2452  mul    dx
2454  mov    di, ax
2456  add    di, 0x69ec
245a  push   ds
245b  push   di
245c  mov    ax, 1
245f  push   ax
2460  call   Graph_PutImage
2465  jmp    0x2470
  loc_2467:
2467  mov    ax, 5
246a  push   ax
246b  call   Crt_Delay
  loc_2470:
2470  mov    al, byte ptr [0xa3b8]             ; mummy_i
2473  xor    ah, ah
2475  mov    dx, 0x1e
2478  mul    dx
247a  mov    di, ax
247c  cmp    word ptr [di - 0x5044], 0x2706
2482  jle    0x2496
2484  mov    al, byte ptr [0xa3b8]             ; mummy_i
2487  xor    ah, ah
2489  mov    dx, 0x1e
248c  mul    dx
248e  mov    di, ax
2490  mov    word ptr [di - 0x5044], 0x2710
  loc_2496:
2496  mov    al, byte ptr [0xa3b8]             ; mummy_i
2499  xor    ah, ah
249b  mov    dx, 0x1e
249e  mul    dx
24a0  mov    di, ax
24a2  cmp    byte ptr [di - 0x5032], 0
24a7  je     0x24f4
24a9  mov    al, byte ptr [0xa3b8]             ; mummy_i
24ac  xor    ah, ah
24ae  mov    dx, 0x1e
24b1  mul    dx
24b3  mov    di, ax
24b5  cmp    byte ptr [di - 0x5031], 0
24ba  je     0x24f4
24bc  mov    al, byte ptr [0xa3b8]             ; mummy_i
24bf  xor    ah, ah
24c1  mov    dx, 0x1e
24c4  mul    dx
24c6  mov    di, ax
24c8  cmp    byte ptr [di - 0x5030], 0
24cd  je     0x24f4
24cf  mov    al, byte ptr [0xa3b8]             ; mummy_i
24d2  xor    ah, ah
24d4  mov    dx, 0x1e
24d7  mul    dx
24d9  mov    di, ax
24db  cmp    byte ptr [di - 0x502f], 0
24e0  je     0x24f4
24e2  mov    al, byte ptr [0xa3b8]             ; mummy_i
24e5  xor    ah, ah
24e7  mov    dx, 0x1e
24ea  mul    dx
24ec  mov    di, ax
24ee  mov    word ptr [di - 0x5044], 0x2710
  loc_24f4:
24f4  jmp    0x28b9
  loc_24f7:
24f7  cmp    ax, 0x2711
24fa  je     0x24ff
24fc  jmp    0x2620
  loc_24ff:
24ff  mov    al, byte ptr [0xa3b8]             ; mummy_i
2502  xor    ah, ah
2504  mov    dx, 0x1e
2507  mul    dx
2509  mov    di, ax
250b  mov    al, byte ptr [di - 0x503a]
250f  cmp    al, byte ptr [0xa3c5]             ; cur_room
2513  jne    0x2567
2515  mov    al, byte ptr [0xa3b8]             ; mummy_i
2518  xor    ah, ah
251a  mov    dx, 0x1e
251d  mul    dx
251f  mov    di, ax
2521  mov    ax, word ptr [di - 0x5048]        ; +mummies
2525  sub    ax, 0x10
2528  push   ax
2529  mov    al, byte ptr [0xa3b8]             ; mummy_i
252c  xor    ah, ah
252e  mov    dx, 0x1e
2531  mul    dx
2533  mov    di, ax
2535  mov    ax, word ptr [di - 0x5046]
2539  sub    ax, 8
253c  push   ax
253d  mov    al, byte ptr [0xa3b8]             ; mummy_i
2540  xor    ah, ah
2542  mov    dx, 0x1e
2545  mul    dx
2547  mov    di, ax
2549  mov    al, byte ptr [di - 0x5038]
254d  xor    ah, ah
254f  mov    dx, 0x54
2552  mul    dx
2554  mov    di, ax
2556  add    di, 0x69ec
255a  push   ds
255b  push   di
255c  mov    ax, 1
255f  push   ax
2560  call   Graph_PutImage
2565  jmp    0x2570
  loc_2567:
2567  mov    ax, 5
256a  push   ax
256b  call   Crt_Delay
  loc_2570:
2570  mov    al, byte ptr [0xa3b8]             ; mummy_i
2573  xor    ah, ah
2575  mov    dx, 0x1e
2578  mul    dx
257a  mov    di, ax
257c  mov    al, byte ptr [di - 0x5039]
2580  cmp    al, byte ptr [0xa3c5]             ; cur_room
2584  jne    0x25bd
2586  mov    al, byte ptr [0xa3b8]             ; mummy_i
2589  xor    ah, ah
258b  mov    dx, 0x1e
258e  mul    dx
2590  mov    di, ax
2592  mov    ax, word ptr [di - 0x5042]
2596  sub    ax, 0x10
2599  push   ax
259a  mov    al, byte ptr [0xa3b8]             ; mummy_i
259d  xor    ah, ah
259f  mov    dx, 0x1e
25a2  mul    dx
25a4  mov    di, ax
25a6  mov    ax, word ptr [di - 0x5040]
25aa  sub    ax, 8
25ad  push   ax
25ae  mov    di, 0x81e0
25b1  push   ds
25b2  push   di
25b3  xor    ax, ax
25b5  push   ax
25b6  call   Graph_PutImage
25bb  jmp    0x25c6
  loc_25bd:
25bd  mov    ax, 5
25c0  push   ax
25c1  call   Crt_Delay
  loc_25c6:
25c6  mov    al, byte ptr [0xa3b8]             ; mummy_i
25c9  xor    ah, ah
25cb  mov    dx, 0x1e
25ce  mul    dx
25d0  mov    di, ax
25d2  mov    al, byte ptr [di - 0x503a]
25d6  cmp    al, byte ptr [0xa3c5]             ; cur_room
25da  jne    0x2614
25dc  mov    al, byte ptr [0xa3b8]             ; mummy_i
25df  xor    ah, ah
25e1  mov    dx, 0x1e
25e4  mul    dx
25e6  mov    di, ax
25e8  mov    ax, word ptr [di - 0x5048]        ; +mummies
25ec  sub    ax, 0x10
25ef  push   ax
25f0  mov    al, byte ptr [0xa3b8]             ; mummy_i
25f3  xor    ah, ah
25f5  mov    dx, 0x1e
25f8  mul    dx
25fa  mov    di, ax
25fc  mov    ax, word ptr [di - 0x5046]
2600  sub    ax, 8
2603  push   ax
2604  mov    di, 0x84d4
2607  push   ds
2608  push   di
2609  mov    ax, 1
260c  push   ax
260d  call   Graph_PutImage
2612  jmp    0x261d
  loc_2614:
2614  mov    ax, 5
2617  push   ax
2618  call   Crt_Delay
  loc_261d:
261d  jmp    0x28b9
  loc_2620:
2620  cmp    ax, 0x2713
2623  jl     0x2658
2625  cmp    ax, 0x2724
2628  jg     0x2658
262a  mov    al, byte ptr [0xa3b8]             ; mummy_i
262d  xor    ah, ah
262f  mov    dx, 0x1e
2632  mul    dx
2634  mov    di, ax
2636  mov    ax, word ptr [di - 0x5044]
263a  cdq
263b  mov    cx, 0x64
263e  idiv   cx
2640  xchg   dx, ax
2641  mov    cx, 0x14
2644  imul   cx
2646  push   ax
2647  call   Crt_Sound
264c  mov    ax, 0xa
264f  push   ax
2650  call   Crt_Delay
2655  jmp    0x28b9
  loc_2658:
2658  cmp    ax, 0x2725
265b  jne    0x26b7
265d  mov    al, byte ptr [0xa3b8]             ; mummy_i
2660  xor    ah, ah
2662  mov    dx, 0x1e
2665  mul    dx
2667  mov    di, ax
2669  mov    al, byte ptr [di - 0x503a]
266d  cmp    al, byte ptr [0xa3c5]             ; cur_room
2671  jne    0x26ab
2673  mov    al, byte ptr [0xa3b8]             ; mummy_i
2676  xor    ah, ah
2678  mov    dx, 0x1e
267b  mul    dx
267d  mov    di, ax
267f  mov    ax, word ptr [di - 0x5048]        ; +mummies
2683  sub    ax, 0x10
2686  push   ax
2687  mov    al, byte ptr [0xa3b8]             ; mummy_i
268a  xor    ah, ah
268c  mov    dx, 0x1e
268f  mul    dx
2691  mov    di, ax
2693  mov    ax, word ptr [di - 0x5046]
2697  sub    ax, 8
269a  push   ax
269b  mov    di, 0x84d4
269e  push   ds
269f  push   di
26a0  mov    ax, 1
26a3  push   ax
26a4  call   Graph_PutImage
26a9  jmp    0x26b4
  loc_26ab:
26ab  mov    ax, 5
26ae  push   ax
26af  call   Crt_Delay
  loc_26b4:
26b4  jmp    0x28b9
  loc_26b7:
26b7  cmp    ax, 0x2726
26ba  jl     0x26cd
26bc  cmp    ax, 0x27d8
26bf  jg     0x26cd
26c1  mov    ax, 0x12
26c4  push   ax
26c5  call   Crt_Delay
26ca  jmp    0x28b9
  loc_26cd:
26cd  cmp    ax, 0x27d9
26d0  je     0x26d5
26d2  jmp    0x28b9
  loc_26d5:
26d5  mov    al, byte ptr [0xa3b8]             ; mummy_i
26d8  xor    ah, ah
26da  mov    dx, 0x1e
26dd  mul    dx
26df  mov    di, ax
26e1  mov    word ptr [di - 0x5044], 1
26e7  mov    al, byte ptr [0xa3b8]             ; mummy_i
26ea  xor    ah, ah
26ec  mov    dx, 0x1e
26ef  mul    dx
26f1  mov    di, ax
26f3  mov    byte ptr [di - 0x502c], 0
26f8  mov    al, byte ptr [0xa3b8]             ; mummy_i
26fb  xor    ah, ah
26fd  mov    dx, 0x1e
2700  mul    dx
2702  mov    di, ax
2704  mov    cl, byte ptr [di - 0x5039]
2708  mov    al, byte ptr [0xa3b8]             ; mummy_i
270b  xor    ah, ah
270d  mov    dx, 0x1e
2710  mul    dx
2712  mov    di, ax
2714  mov    byte ptr [di - 0x503a], cl
2718  mov    al, byte ptr [0xa3b8]             ; mummy_i
271b  xor    ah, ah
271d  mov    dx, 0x1e
2720  mul    dx
2722  mov    di, ax
2724  mov    cx, word ptr [di - 0x5042]
2728  mov    al, byte ptr [0xa3b8]             ; mummy_i
272b  xor    ah, ah
272d  mov    dx, 0x1e
2730  mul    dx
2732  mov    di, ax
2734  mov    word ptr [di - 0x5048], cx        ; +mummies
2738  mov    al, byte ptr [0xa3b8]             ; mummy_i
273b  xor    ah, ah
273d  mov    dx, 0x1e
2740  mul    dx
2742  mov    di, ax
2744  mov    cx, word ptr [di - 0x5040]
2748  mov    al, byte ptr [0xa3b8]             ; mummy_i
274b  xor    ah, ah
274d  mov    dx, 0x1e
2750  mul    dx
2752  mov    di, ax
2754  mov    word ptr [di - 0x5046], cx
2758  mov    al, byte ptr [0xa3b8]             ; mummy_i
275b  xor    ah, ah
275d  mov    dx, 0x1e
2760  mul    dx
2762  mov    di, ax
2764  mov    byte ptr [di - 0x5032], 0
2769  mov    al, byte ptr [0xa3b8]             ; mummy_i
276c  xor    ah, ah
276e  mov    dx, 0x1e
2771  mul    dx
2773  mov    di, ax
2775  mov    byte ptr [di - 0x5036], 0
277a  mov    al, byte ptr [0xa3b8]             ; mummy_i
277d  xor    ah, ah
277f  mov    dx, 0x1e
2782  mul    dx
2784  mov    di, ax
2786  mov    byte ptr [di - 0x5031], 0
278b  mov    al, byte ptr [0xa3b8]             ; mummy_i
278e  xor    ah, ah
2790  mov    dx, 0x1e
2793  mul    dx
2795  mov    di, ax
2797  mov    byte ptr [di - 0x5035], 0
279c  mov    al, byte ptr [0xa3b8]             ; mummy_i
279f  xor    ah, ah
27a1  mov    dx, 0x1e
27a4  mul    dx
27a6  mov    di, ax
27a8  mov    byte ptr [di - 0x5030], 0
27ad  mov    al, byte ptr [0xa3b8]             ; mummy_i
27b0  xor    ah, ah
27b2  mov    dx, 0x1e
27b5  mul    dx
27b7  mov    di, ax
27b9  mov    byte ptr [di - 0x5034], 0
27be  mov    al, byte ptr [0xa3b8]             ; mummy_i
27c1  xor    ah, ah
27c3  mov    dx, 0x1e
27c6  mul    dx
27c8  mov    di, ax
27ca  mov    byte ptr [di - 0x502f], 0
27cf  mov    al, byte ptr [0xa3b8]             ; mummy_i
27d2  xor    ah, ah
27d4  mov    dx, 0x1e
27d7  mul    dx
27d9  mov    di, ax
27db  mov    byte ptr [di - 0x5033], 0
27e0  mov    al, byte ptr [0xa3b8]             ; mummy_i
27e3  xor    ah, ah
27e5  mov    dx, 0x1e
27e8  mul    dx
27ea  mov    di, ax
27ec  mov    byte ptr [di - 0x502e], 0
27f1  mov    al, byte ptr [0xa3b8]             ; mummy_i
27f4  xor    ah, ah
27f6  mov    dx, 0x1e
27f9  mul    dx
27fb  mov    di, ax
27fd  mov    byte ptr [di - 0x502d], 0
2802  mov    al, byte ptr [0xa3b8]             ; mummy_i
2805  xor    ah, ah
2807  mov    dx, 0x1e
280a  mul    dx
280c  mov    di, ax
280e  mov    byte ptr [di - 0x5037], 0
2813  mov    al, byte ptr [0xa3b8]             ; mummy_i
2816  xor    ah, ah
2818  mov    dx, 0x1e
281b  mul    dx
281d  mov    di, ax
281f  mov    word ptr [di - 0x503c], 0xffff
2825  mov    al, byte ptr [0xa3b8]             ; mummy_i
2828  xor    ah, ah
282a  mov    dx, 0x1e
282d  mul    dx
282f  mov    di, ax
2831  mov    byte ptr [di - 0x5038], 0x4d
2836  mov    ax, 2
2839  push   ax
283a  call   Sys_Random
283f  shl    ax, 1
2841  dec    ax
2842  mov    cx, ax
2844  mov    al, byte ptr [0xa3b8]             ; mummy_i
2847  xor    ah, ah
2849  mov    dx, 0x1e
284c  mul    dx
284e  mov    di, ax
2850  mov    word ptr [di - 0x503e], cx
2854  mov    al, byte ptr [0xa3b8]             ; mummy_i
2857  xor    ah, ah
2859  mov    dx, 0x1e
285c  mul    dx
285e  mov    di, ax
2860  mov    al, byte ptr [di - 0x503a]
2864  cmp    al, byte ptr [0xa3c5]             ; cur_room
2868  jne    0x28b9
286a  mov    al, byte ptr [0xa3b8]             ; mummy_i
286d  xor    ah, ah
286f  mov    dx, 0x1e
2872  mul    dx
2874  mov    di, ax
2876  mov    cx, word ptr [di - 0x503e]
287a  mov    al, byte ptr [0xa3b8]             ; mummy_i
287d  xor    ah, ah
287f  mov    dx, 0x1e
2882  mul    dx
2884  mov    di, ax
2886  mov    dx, word ptr [di - 0x5048]        ; +mummies
288a  mov    ax, word ptr [0xb058]             ; player_x
288d  sub    ax, dx
288f  imul   cx
2891  or     ax, ax
2893  jge    0x28b9
2895  mov    al, byte ptr [0xa3b8]             ; mummy_i
2898  xor    ah, ah
289a  mov    dx, 0x1e
289d  mul    dx
289f  mov    di, ax
28a1  mov    ax, word ptr [di - 0x503e]
28a5  neg    ax
28a7  mov    cx, ax
28a9  mov    al, byte ptr [0xa3b8]             ; mummy_i
28ac  xor    ah, ah
28ae  mov    dx, 0x1e
28b1  mul    dx
28b3  mov    di, ax
28b5  mov    word ptr [di - 0x503e], cx
  loc_28b9:
28b9  jmp    0x28c4
  loc_28bb:
28bb  mov    ax, 0xa
28be  push   ax
28bf  call   Crt_Delay
  loc_28c4:
28c4  cmp    byte ptr [0xa3b8], 3              ; mummy_i
28c9  je     0x28ce
28cb  jmp    0xe5e
  loc_28ce:
28ce  mov    sp, bp
28d0  pop    bp
28d1  retf
28d2  db 30,'stage     score           rest'

; ------------------------------------------------------------
check_room_change:
28f1  push   bp
28f2  mov    bp, sp
28f4  sub    sp, 2
28f7  mov    al, byte ptr [0xa3c5]             ; cur_room
28fa  mov    byte ptr [bp - 1], al
28fd  mov    di, 0xa3c5                        ; &cur_room
2900  push   ds
2901  push   di
2902  mov    di, 0xb058                        ; &player_x
2905  push   ds
2906  push   di
2907  mov    di, 0xb05a                        ; &player_y
290a  push   ds
290b  push   di
290c  push   cs
290d  call   move_to_next_room
2910  mov    al, byte ptr [0xa3c5]             ; cur_room
2913  cmp    al, byte ptr [bp - 1]
2916  jne    0x291b
2918  jmp    0x2de7
  loc_291b:
291b  call   Graph_ClearDevice
2920  mov    di, 0x28d2                        ; cs:'stage     score           rest'
2923  push   cs
2924  push   di
2925  mov    di, 0xb090                        ; &text_buf
2928  push   ds
2929  push   di
292a  mov    ax, 0xff
292d  push   ax
292e  call   Sys_StrStore
2933  mov    al, byte ptr [0xb090]             ; text_buf
2936  mov    byte ptr [bp - 2], al
2939  mov    al, 1
293b  cmp    al, byte ptr [bp - 2]
293e  ja     0x2996
2940  mov    byte ptr [0xa3b0], al             ; loop_i
2943  jmp    0x2949
  loc_2945:
2945  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_2949:
2949  mov    al, byte ptr [0xa3b0]             ; loop_i
294c  xor    ah, ah
294e  mov    di, ax
2950  cmp    byte ptr [di - 0x4f70], 0x20      ; +text_buf
2955  je     0x298e
2957  mov    al, byte ptr [0xa3b0]             ; loop_i
295a  xor    ah, ah
295c  mov    cx, 0x14
295f  imul   cx
2961  sub    ax, 0x14
2964  push   ax
2965  mov    ax, 0xc1
2968  push   ax
2969  mov    al, byte ptr [0xa3b0]             ; loop_i
296c  xor    ah, ah
296e  mov    di, ax
2970  mov    al, byte ptr [di - 0x4f70]        ; +text_buf
2974  xor    ah, ah
2976  add    ax, 0x34
2979  mov    dx, 0x54
297c  mul    dx
297e  mov    di, ax
2980  add    di, 0x69ec
2984  push   ds
2985  push   di
2986  xor    ax, ax
2988  push   ax
2989  call   Graph_PutImage
  loc_298e:
298e  mov    al, byte ptr [0xa3b0]             ; loop_i
2991  cmp    al, byte ptr [bp - 2]
2994  jne    0x2945
  loc_2996:
2996  mov    al, 1
2998  push   ax
2999  push   cs
299a  call   draw_status_number
299d  mov    al, 2
299f  push   ax
29a0  push   cs
29a1  call   draw_status_number
29a4  mov    al, 3
29a6  push   ax
29a7  push   cs
29a8  call   draw_status_number
29ab  mov    byte ptr [0xa3b0], 0              ; loop_i
29b0  jmp    0x29b6
  loc_29b2:
29b2  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_29b6:
29b6  mov    byte ptr [0xa3b1], 0              ; loop_j
29bb  jmp    0x29c1
  loc_29bd:
29bd  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_29c1:
29c1  mov    al, byte ptr [0xa3b1]             ; loop_j
29c4  xor    ah, ah
29c6  mov    bx, ax
29c8  mov    al, byte ptr [0xa3b0]             ; loop_i
29cb  xor    ah, ah
29cd  mov    dx, 0x19
29d0  mul    dx
29d2  mov    cx, ax
29d4  mov    al, byte ptr [0xa3c5]             ; cur_room
29d7  xor    ah, ah
29d9  mov    dx, 0x226
29dc  mul    dx
29de  mov    di, ax
29e0  add    di, cx
29e2  add    di, bx
29e4  mov    al, byte ptr [di - 0x4a70]        ; +rooms
29e8  mov    byte ptr [0xa3b2], al             ; loop_k
29eb  call   Crt_KeyPressed
29f0  or     al, al
29f2  je     0x29fc
29f4  call   Crt_ReadKey
29f9  mov    byte ptr [0xb08e], al             ; last_key
  loc_29fc:
29fc  cmp    byte ptr [0xa3b2], 0x64           ; loop_k
2a01  jae    0x2a37
2a03  mov    al, byte ptr [0xa3b0]             ; loop_i
2a06  xor    ah, ah
2a08  mov    cx, 5
2a0b  shl    ax, cl
2a0d  push   ax
2a0e  mov    al, byte ptr [0xa3b1]             ; loop_j
2a11  xor    ah, ah
2a13  mov    cx, 3
2a16  shl    ax, cl
2a18  push   ax
2a19  mov    al, byte ptr [0xa3b2]             ; loop_k
2a1c  xor    ah, ah
2a1e  mov    dx, 0x54
2a21  mul    dx
2a23  mov    di, ax
2a25  add    di, 0x69ec
2a29  push   ds
2a2a  push   di
2a2b  mov    ax, 1
2a2e  push   ax
2a2f  call   Graph_PutImage
2a34  jmp    0x2c7f
  loc_2a37:
2a37  mov    al, byte ptr [0xa3b2]             ; loop_k
2a3a  xor    ah, ah
2a3c  cmp    ax, 0x6f
2a3f  jne    0x2a68
2a41  mov    al, byte ptr [0xa3b0]             ; loop_i
2a44  xor    ah, ah
2a46  mov    cx, 5
2a49  shl    ax, cl
2a4b  push   ax
2a4c  mov    al, byte ptr [0xa3b1]             ; loop_j
2a4f  xor    ah, ah
2a51  mov    cx, 3
2a54  shl    ax, cl
2a56  push   ax
2a57  mov    di, 0x7afc
2a5a  push   ds
2a5b  push   di
2a5c  mov    ax, 1
2a5f  push   ax
2a60  call   Graph_PutImage
2a65  jmp    0x2c7f
  loc_2a68:
2a68  cmp    ax, 0xa1
2a6b  jne    0x2ab8
2a6d  mov    al, byte ptr [0xa3b0]             ; loop_i
2a70  xor    ah, ah
2a72  mov    cx, 5
2a75  shl    ax, cl
2a77  push   ax
2a78  mov    al, byte ptr [0xa3b1]             ; loop_j
2a7b  xor    ah, ah
2a7d  mov    cx, 3
2a80  shl    ax, cl
2a82  push   ax
2a83  mov    di, 0x7afc
2a86  push   ds
2a87  push   di
2a88  mov    ax, 1
2a8b  push   ax
2a8c  call   Graph_PutImage
2a91  mov    al, byte ptr [0xa3b0]             ; loop_i
2a94  xor    ah, ah
2a96  mov    cx, 5
2a99  shl    ax, cl
2a9b  push   ax
2a9c  mov    al, byte ptr [0xa3b1]             ; loop_j
2a9f  xor    ah, ah
2aa1  mov    cx, 3
2aa4  shl    ax, cl
2aa6  push   ax
2aa7  mov    di, 0x7c4c
2aaa  push   ds
2aab  push   di
2aac  mov    ax, 1
2aaf  push   ax
2ab0  call   Graph_PutImage
2ab5  jmp    0x2c7f
  loc_2ab8:
2ab8  cmp    ax, 0xd3
2abb  jne    0x2b2d
2abd  mov    al, byte ptr [0xa3b0]             ; loop_i
2ac0  xor    ah, ah
2ac2  mov    cx, 5
2ac5  shl    ax, cl
2ac7  push   ax
2ac8  mov    al, byte ptr [0xa3b1]             ; loop_j
2acb  xor    ah, ah
2acd  mov    cx, 3
2ad0  shl    ax, cl
2ad2  push   ax
2ad3  mov    di, 0x7afc
2ad6  push   ds
2ad7  push   di
2ad8  mov    ax, 1
2adb  push   ax
2adc  call   Graph_PutImage
2ae1  mov    al, byte ptr [0xa3b0]             ; loop_i
2ae4  xor    ah, ah
2ae6  mov    cx, 5
2ae9  shl    ax, cl
2aeb  push   ax
2aec  mov    al, byte ptr [0xa3b1]             ; loop_j
2aef  xor    ah, ah
2af1  mov    cx, 3
2af4  shl    ax, cl
2af6  push   ax
2af7  mov    di, 0x7c4c
2afa  push   ds
2afb  push   di
2afc  mov    ax, 1
2aff  push   ax
2b00  call   Graph_PutImage
2b05  mov    al, byte ptr [0xa3b0]             ; loop_i
2b08  xor    ah, ah
2b0a  mov    cx, 5
2b0d  shl    ax, cl
2b0f  inc    ax
2b10  push   ax
2b11  mov    al, byte ptr [0xa3b1]             ; loop_j
2b14  xor    ah, ah
2b16  mov    cx, 3
2b19  shl    ax, cl
2b1b  push   ax
2b1c  mov    di, 0x7c4c
2b1f  push   ds
2b20  push   di
2b21  mov    ax, 1
2b24  push   ax
2b25  call   Graph_PutImage
2b2a  jmp    0x2c7f
  loc_2b2d:
2b2d  cmp    ax, 0x65
2b30  je     0x2b58
2b32  cmp    ax, 0x66
2b35  je     0x2b58
2b37  cmp    ax, 0x97
2b3a  je     0x2b58
2b3c  cmp    ax, 0x98
2b3f  je     0x2b58
2b41  cmp    ax, 0xc9
2b44  je     0x2b58
2b46  cmp    ax, 0xca
2b49  je     0x2b58
2b4b  cmp    ax, 0xfb
2b4e  je     0x2b58
2b50  cmp    ax, 0xfc
2b53  je     0x2b58
2b55  jmp    0x2bec
  loc_2b58:
2b58  mov    al, byte ptr [0xa3b0]             ; loop_i
2b5b  xor    ah, ah
2b5d  mov    cx, 5
2b60  shl    ax, cl
2b62  push   ax
2b63  mov    al, byte ptr [0xa3b1]             ; loop_j
2b66  xor    ah, ah
2b68  mov    cx, 3
2b6b  shl    ax, cl
2b6d  push   ax
2b6e  mov    al, byte ptr [0xa3b2]             ; loop_k
2b71  xor    ah, ah
2b73  cdq
2b74  mov    cx, 0x32
2b77  idiv   cx
2b79  xchg   dx, ax
2b7a  add    ax, 0x32
2b7d  mov    dx, 0x54
2b80  mul    dx
2b82  mov    di, ax
2b84  add    di, 0x69ec
2b88  push   ds
2b89  push   di
2b8a  mov    ax, 1
2b8d  push   ax
2b8e  call   Graph_PutImage
2b93  mov    al, byte ptr [0xa3b2]             ; loop_k
2b96  xor    ah, ah
2b98  cdq
2b99  mov    cx, 0x32
2b9c  idiv   cx
2b9e  mov    byte ptr [bp - 2], al
2ba1  mov    al, 2
2ba3  cmp    al, byte ptr [bp - 2]
2ba6  ja     0x2be9
2ba8  mov    byte ptr [0xa3c1], al             ; scratch
2bab  jmp    0x2bb1
  loc_2bad:
2bad  inc    byte ptr [0xa3c1]                 ; scratch
  loc_2bb1:
2bb1  mov    al, byte ptr [0xa3c1]             ; scratch
2bb4  xor    ah, ah
2bb6  mov    dx, ax
2bb8  mov    al, byte ptr [0xa3b0]             ; loop_i
2bbb  xor    ah, ah
2bbd  mov    cx, 5
2bc0  shl    ax, cl
2bc2  add    ax, dx
2bc4  sub    ax, 2
2bc7  push   ax
2bc8  mov    al, byte ptr [0xa3b1]             ; loop_j
2bcb  xor    ah, ah
2bcd  mov    cx, 3
2bd0  shl    ax, cl
2bd2  push   ax
2bd3  mov    di, 0x7c4c
2bd6  push   ds
2bd7  push   di
2bd8  mov    ax, 1
2bdb  push   ax
2bdc  call   Graph_PutImage
2be1  mov    al, byte ptr [0xa3c1]             ; scratch
2be4  cmp    al, byte ptr [bp - 2]
2be7  jne    0x2bad
  loc_2be9:
2be9  jmp    0x2c7f
  loc_2bec:
2bec  cmp    ax, 0x6a
2bef  je     0x2bfb
2bf1  cmp    ax, 0x9c
2bf4  je     0x2bfb
2bf6  cmp    ax, 0xce
2bf9  jne    0x2c51
  loc_2bfb:
2bfb  mov    al, byte ptr [0xa3b2]             ; loop_k
2bfe  xor    ah, ah
2c00  cdq
2c01  mov    cx, 0x32
2c04  idiv   cx
2c06  mov    byte ptr [bp - 2], al
2c09  mov    al, 1
2c0b  cmp    al, byte ptr [bp - 2]
2c0e  ja     0x2c4f
2c10  mov    byte ptr [0xa3c1], al             ; scratch
2c13  jmp    0x2c19
  loc_2c15:
2c15  inc    byte ptr [0xa3c1]                 ; scratch
  loc_2c19:
2c19  mov    al, byte ptr [0xa3c1]             ; scratch
2c1c  xor    ah, ah
2c1e  mov    dx, ax
2c20  mov    al, byte ptr [0xa3b0]             ; loop_i
2c23  xor    ah, ah
2c25  mov    cx, 5
2c28  shl    ax, cl
2c2a  add    ax, dx
2c2c  dec    ax
2c2d  push   ax
2c2e  mov    al, byte ptr [0xa3b1]             ; loop_j
2c31  xor    ah, ah
2c33  mov    cx, 3
2c36  shl    ax, cl
2c38  push   ax
2c39  mov    di, 0x7c4c
2c3c  push   ds
2c3d  push   di
2c3e  mov    ax, 1
2c41  push   ax
2c42  call   Graph_PutImage
2c47  mov    al, byte ptr [0xa3c1]             ; scratch
2c4a  cmp    al, byte ptr [bp - 2]
2c4d  jne    0x2c15
  loc_2c4f:
2c4f  jmp    0x2c7f
  loc_2c51:
2c51  cmp    ax, 0xaf
2c54  je     0x2c5b
2c56  cmp    ax, 0xde
2c59  jne    0x2c7f
  loc_2c5b:
2c5b  mov    al, byte ptr [0xa3b0]             ; loop_i
2c5e  xor    ah, ah
2c60  mov    cx, 5
2c63  shl    ax, cl
2c65  push   ax
2c66  mov    al, byte ptr [0xa3b1]             ; loop_j
2c69  xor    ah, ah
2c6b  mov    cx, 3
2c6e  shl    ax, cl
2c70  push   ax
2c71  mov    di, 0xa358
2c74  push   ds
2c75  push   di
2c76  mov    ax, 1
2c79  push   ax
2c7a  call   Graph_PutImage
  loc_2c7f:
2c7f  cmp    byte ptr [0xa3b1], 0x17           ; loop_j
2c84  je     0x2c89
2c86  jmp    0x29bd
  loc_2c89:
2c89  cmp    byte ptr [0xa3b0], 0x13           ; loop_i
2c8e  je     0x2c93
2c90  jmp    0x29b2
  loc_2c93:
2c93  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2c98  je     0x2cce
2c9a  mov    al, byte ptr [0xa3c5]             ; cur_room
2c9d  cmp    al, byte ptr [0xa3c6]             ; dagger_room
2ca1  jne    0x2cce
2ca3  push   word ptr [0xb05c]                 ; dagger_x
2ca7  push   word ptr [0xb05e]                 ; dagger_y
2cab  mov    ax, word ptr [0xb064]             ; dagger_spin
2cae  cdq
2caf  mov    cx, 8
2cb2  idiv   cx
2cb4  xchg   dx, ax
2cb5  add    ax, 0x39
2cb8  mov    dx, 0x54
2cbb  mul    dx
2cbd  mov    di, ax
2cbf  add    di, 0x69ec
2cc3  push   ds
2cc4  push   di
2cc5  mov    ax, 1
2cc8  push   ax
2cc9  call   Graph_PutImage
  loc_2cce:
2cce  mov    byte ptr [0xa3b0], 1              ; loop_i
2cd3  jmp    0x2cd9
  loc_2cd5:
2cd5  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_2cd9:
2cd9  mov    al, byte ptr [0xa3b0]             ; loop_i
2cdc  xor    ah, ah
2cde  mov    dx, 0x1e
2ce1  mul    dx
2ce3  mov    di, ax
2ce5  cmp    byte ptr [di - 0x502b], 0
2cea  jne    0x2cef
2cec  jmp    0x2ddd
  loc_2cef:
2cef  mov    al, byte ptr [0xa3b0]             ; loop_i
2cf2  xor    ah, ah
2cf4  mov    dx, 0x1e
2cf7  mul    dx
2cf9  mov    di, ax
2cfb  mov    al, byte ptr [di - 0x503a]
2cff  cmp    al, byte ptr [0xa3c5]             ; cur_room
2d03  je     0x2d08
2d05  jmp    0x2ddd
  loc_2d08:
2d08  mov    al, byte ptr [0xa3b0]             ; loop_i
2d0b  xor    ah, ah
2d0d  mov    dx, 0x1e
2d10  mul    dx
2d12  mov    di, ax
2d14  cmp    word ptr [di - 0x5044], 0x2711
2d1a  jle    0x2d66
2d1c  mov    al, byte ptr [0xa3b0]             ; loop_i
2d1f  xor    ah, ah
2d21  mov    dx, 0x1e
2d24  mul    dx
2d26  mov    di, ax
2d28  cmp    word ptr [di - 0x5044], 0x2727
2d2e  jge    0x2d66
2d30  mov    al, byte ptr [0xa3b0]             ; loop_i
2d33  xor    ah, ah
2d35  mov    dx, 0x1e
2d38  mul    dx
2d3a  mov    di, ax
2d3c  mov    ax, word ptr [di - 0x5048]        ; +mummies
2d40  sub    ax, 0x10
2d43  push   ax
2d44  mov    al, byte ptr [0xa3b0]             ; loop_i
2d47  xor    ah, ah
2d49  mov    dx, 0x1e
2d4c  mul    dx
2d4e  mov    di, ax
2d50  mov    ax, word ptr [di - 0x5046]
2d54  sub    ax, 8
2d57  push   ax
2d58  mov    di, 0x84d4
2d5b  push   ds
2d5c  push   di
2d5d  mov    ax, 1
2d60  push   ax
2d61  call   Graph_PutImage
  loc_2d66:
2d66  mov    al, byte ptr [0xa3b0]             ; loop_i
2d69  xor    ah, ah
2d6b  mov    dx, 0x1e
2d6e  mul    dx
2d70  mov    di, ax
2d72  cmp    word ptr [di - 0x5044], 0x41
2d77  jle    0x2ddd
2d79  mov    al, byte ptr [0xa3b0]             ; loop_i
2d7c  xor    ah, ah
2d7e  mov    dx, 0x1e
2d81  mul    dx
2d83  mov    di, ax
2d85  cmp    word ptr [di - 0x5044], 0x2711
2d8b  jge    0x2ddd
2d8d  mov    al, byte ptr [0xa3b0]             ; loop_i
2d90  xor    ah, ah
2d92  mov    dx, 0x1e
2d95  mul    dx
2d97  mov    di, ax
2d99  mov    ax, word ptr [di - 0x5048]        ; +mummies
2d9d  sub    ax, 0x10
2da0  push   ax
2da1  mov    al, byte ptr [0xa3b0]             ; loop_i
2da4  xor    ah, ah
2da6  mov    dx, 0x1e
2da9  mul    dx
2dab  mov    di, ax
2dad  mov    ax, word ptr [di - 0x5046]
2db1  sub    ax, 8
2db4  push   ax
2db5  mov    al, byte ptr [0xa3b0]             ; loop_i
2db8  xor    ah, ah
2dba  mov    dx, 0x1e
2dbd  mul    dx
2dbf  mov    di, ax
2dc1  mov    al, byte ptr [di - 0x5038]
2dc5  xor    ah, ah
2dc7  mov    dx, 0x54
2dca  mul    dx
2dcc  mov    di, ax
2dce  add    di, 0x69ec
2dd2  push   ds
2dd3  push   di
2dd4  mov    ax, 1
2dd7  push   ax
2dd8  call   Graph_PutImage
  loc_2ddd:
2ddd  cmp    byte ptr [0xa3b0], 3              ; loop_i
2de2  je     0x2de7
2de4  jmp    0x2cd5
  loc_2de7:
2de7  mov    sp, bp
2de9  pop    bp
2dea  retf

; ------------------------------------------------------------
pick_up_item:
2deb  push   bp
2dec  mov    bp, sp
2dee  sub    sp, 4
2df1  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2df6  je     0x2dfc
2df8  push   cs
2df9  call   move_dagger
  loc_2dfc:
2dfc  mov    di, word ptr [bp + 6]
2dff  mov    al, byte ptr ss:[di - 2]
2e03  xor    ah, ah
2e05  mov    bx, ax
2e07  mov    di, word ptr [bp + 6]
2e0a  mov    al, byte ptr ss:[di - 1]
2e0e  xor    ah, ah
2e10  mov    dx, 0x19
2e13  mul    dx
2e15  mov    cx, ax
2e17  mov    al, byte ptr [0xa3c5]             ; cur_room
2e1a  xor    ah, ah
2e1c  mov    dx, 0x226
2e1f  mul    dx
2e21  mov    di, ax
2e23  add    di, cx
2e25  add    di, bx
2e27  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2e2b  xor    ah, ah
2e2d  cmp    ax, 0x1e
2e30  je     0x2e3f
2e32  cmp    ax, 0x22
2e35  je     0x2e3f
2e37  cmp    ax, 0x23
2e3a  je     0x2e3f
2e3c  jmp    0x2fb5
  loc_2e3f:
2e3f  cmp    byte ptr [0xa3be], 0              ; held_item
2e44  je     0x2e49
2e46  jmp    0x2fb2
  loc_2e49:
2e49  mov    di, word ptr [bp + 6]
2e4c  mov    al, byte ptr ss:[di - 1]
2e50  xor    ah, ah
2e52  mov    cx, 5
2e55  shl    ax, cl
2e57  push   ax
2e58  mov    di, word ptr [bp + 6]
2e5b  mov    al, byte ptr ss:[di - 2]
2e5f  xor    ah, ah
2e61  mov    cx, 3
2e64  shl    ax, cl
2e66  push   ax
2e67  mov    di, word ptr [bp + 6]
2e6a  mov    al, byte ptr ss:[di - 2]
2e6e  xor    ah, ah
2e70  mov    bx, ax
2e72  mov    di, word ptr [bp + 6]
2e75  mov    al, byte ptr ss:[di - 1]
2e79  xor    ah, ah
2e7b  mov    dx, 0x19
2e7e  mul    dx
2e80  mov    cx, ax
2e82  mov    al, byte ptr [0xa3c5]             ; cur_room
2e85  xor    ah, ah
2e87  mov    dx, 0x226
2e8a  mul    dx
2e8c  mov    di, ax
2e8e  add    di, cx
2e90  add    di, bx
2e92  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2e96  xor    ah, ah
2e98  mov    dx, 0x54
2e9b  mul    dx
2e9d  mov    di, ax
2e9f  add    di, 0x69ec
2ea3  push   ds
2ea4  push   di
2ea5  mov    ax, 1
2ea8  push   ax
2ea9  call   Graph_PutImage
2eae  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2eb3  je     0x2eb9
2eb5  push   cs
2eb6  call   move_dagger
  loc_2eb9:
2eb9  mov    byte ptr [0xa3b2], 0x14           ; loop_k
2ebe  jmp    0x2ec4
  loc_2ec0:
2ec0  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_2ec4:
2ec4  mov    al, byte ptr [0xa3b2]             ; loop_k
2ec7  xor    ah, ah
2ec9  mov    cx, 0x32
2ecc  imul   cx
2ece  push   ax
2ecf  call   Crt_Sound
2ed4  mov    ax, 0xa
2ed7  push   ax
2ed8  call   Crt_Delay
2edd  call   Crt_NoSound
2ee2  cmp    byte ptr [0xa3b2], 0x19           ; loop_k
2ee7  jne    0x2ec0
2ee9  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2eee  je     0x2ef4
2ef0  push   cs
2ef1  call   move_dagger
  loc_2ef4:
2ef4  mov    byte ptr [0xa3b2], 0x14           ; loop_k
2ef9  jmp    0x2eff
  loc_2efb:
2efb  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_2eff:
2eff  mov    al, byte ptr [0xa3b2]             ; loop_k
2f02  xor    ah, ah
2f04  mov    cx, 0x32
2f07  imul   cx
2f09  push   ax
2f0a  call   Crt_Sound
2f0f  mov    ax, 0xa
2f12  push   ax
2f13  call   Crt_Delay
2f18  call   Crt_NoSound
2f1d  cmp    byte ptr [0xa3b2], 0x1e           ; loop_k
2f22  jne    0x2efb
2f24  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
2f29  je     0x2f2f
2f2b  push   cs
2f2c  call   move_dagger
  loc_2f2f:
2f2f  mov    di, word ptr [bp + 6]
2f32  mov    al, byte ptr ss:[di - 2]
2f36  xor    ah, ah
2f38  mov    bx, ax
2f3a  mov    di, word ptr [bp + 6]
2f3d  mov    al, byte ptr ss:[di - 1]
2f41  xor    ah, ah
2f43  mov    dx, 0x19
2f46  mul    dx
2f48  mov    cx, ax
2f4a  mov    al, byte ptr [0xa3c5]             ; cur_room
2f4d  xor    ah, ah
2f4f  mov    dx, 0x226
2f52  mul    dx
2f54  mov    di, ax
2f56  add    di, cx
2f58  add    di, bx
2f5a  mov    al, byte ptr [di - 0x4a70]        ; +rooms
2f5e  xor    ah, ah
2f60  cmp    ax, 0x1e
2f63  jne    0x2f6c
2f65  mov    byte ptr [0xa3be], 4              ; held_item
2f6a  jmp    0x2f82
  loc_2f6c:
2f6c  cmp    ax, 0x22
2f6f  jne    0x2f78
2f71  mov    byte ptr [0xa3be], 6              ; held_item
2f76  jmp    0x2f82
  loc_2f78:
2f78  cmp    ax, 0x23
2f7b  jne    0x2f82
2f7d  mov    byte ptr [0xa3be], 8              ; held_item
  loc_2f82:
2f82  mov    di, word ptr [bp + 6]
2f85  mov    al, byte ptr ss:[di - 2]
2f89  xor    ah, ah
2f8b  mov    bx, ax
2f8d  mov    di, word ptr [bp + 6]
2f90  mov    al, byte ptr ss:[di - 1]
2f94  xor    ah, ah
2f96  mov    dx, 0x19
2f99  mul    dx
2f9b  mov    cx, ax
2f9d  mov    al, byte ptr [0xa3c5]             ; cur_room
2fa0  xor    ah, ah
2fa2  mov    dx, 0x226
2fa5  mul    dx
2fa7  mov    di, ax
2fa9  add    di, cx
2fab  add    di, bx
2fad  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
  loc_2fb2:
2fb2  jmp    0x34b6
  loc_2fb5:
2fb5  cmp    ax, 0x21
2fb8  je     0x2fbd
2fba  jmp    0x31c4
  loc_2fbd:
2fbd  mov    di, word ptr [bp + 6]
2fc0  mov    al, byte ptr ss:[di - 1]
2fc4  xor    ah, ah
2fc6  mov    cx, 5
2fc9  shl    ax, cl
2fcb  push   ax
2fcc  mov    di, word ptr [bp + 6]
2fcf  mov    al, byte ptr ss:[di - 2]
2fd3  xor    ah, ah
2fd5  mov    cx, 3
2fd8  shl    ax, cl
2fda  push   ax
2fdb  mov    di, 0x74c0
2fde  push   ds
2fdf  push   di
2fe0  mov    ax, 1
2fe3  push   ax
2fe4  call   Graph_PutImage
2fe9  dec    byte ptr [0xa3bd]                 ; stones_left
2fed  add    word ptr [0xb034], 0xc8           ; score
2ff3  adc    word ptr [0xb036], 0              ; score+2
2ff8  mov    al, 2
2ffa  push   ax
2ffb  push   cs
2ffc  call   draw_status_number
2fff  mov    al, 3
3001  push   ax
3002  push   cs
3003  call   draw_status_number
3006  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
300b  je     0x3011
300d  push   cs
300e  call   move_dagger
  loc_3011:
3011  mov    byte ptr [0xa3b2], 0x28           ; loop_k
3016  jmp    0x301c
  loc_3018:
3018  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_301c:
301c  mov    al, byte ptr [0xa3b2]             ; loop_k
301f  xor    ah, ah
3021  mov    cx, 0x32
3024  imul   cx
3026  push   ax
3027  call   Crt_Sound
302c  mov    ax, 7
302f  push   ax
3030  call   Crt_Delay
3035  call   Crt_NoSound
303a  cmp    byte ptr [0xa3b2], 0x2d           ; loop_k
303f  jne    0x3018
3041  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
3046  je     0x304c
3048  push   cs
3049  call   move_dagger
  loc_304c:
304c  mov    byte ptr [0xa3b2], 0x28           ; loop_k
3051  jmp    0x3057
  loc_3053:
3053  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_3057:
3057  mov    al, byte ptr [0xa3b2]             ; loop_k
305a  xor    ah, ah
305c  mov    cx, 0x3c
305f  imul   cx
3061  push   ax
3062  call   Crt_Sound
3067  mov    ax, 7
306a  push   ax
306b  call   Crt_Delay
3070  call   Crt_NoSound
3075  cmp    byte ptr [0xa3b2], 0x2d           ; loop_k
307a  jne    0x3053
307c  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
3081  je     0x3087
3083  push   cs
3084  call   move_dagger
  loc_3087:
3087  mov    byte ptr [0xa3b2], 0x28           ; loop_k
308c  jmp    0x3092
  loc_308e:
308e  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_3092:
3092  mov    al, byte ptr [0xa3b2]             ; loop_k
3095  xor    ah, ah
3097  mov    cx, 0x32
309a  imul   cx
309c  push   ax
309d  call   Crt_Sound
30a2  mov    ax, 7
30a5  push   ax
30a6  call   Crt_Delay
30ab  call   Crt_NoSound
30b0  cmp    byte ptr [0xa3b2], 0x32           ; loop_k
30b5  jne    0x308e
30b7  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
30bc  je     0x30c2
30be  push   cs
30bf  call   move_dagger
  loc_30c2:
30c2  mov    di, word ptr [bp + 6]
30c5  mov    al, byte ptr ss:[di - 2]
30c9  xor    ah, ah
30cb  mov    bx, ax
30cd  mov    di, word ptr [bp + 6]
30d0  mov    al, byte ptr ss:[di - 1]
30d4  xor    ah, ah
30d6  mov    dx, 0x19
30d9  mul    dx
30db  mov    cx, ax
30dd  mov    al, byte ptr [0xa3c5]             ; cur_room
30e0  xor    ah, ah
30e2  mov    dx, 0x226
30e5  mul    dx
30e7  mov    di, ax
30e9  add    di, cx
30eb  add    di, bx
30ed  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
30f2  cmp    byte ptr [0xa3bd], 0              ; stones_left
30f7  je     0x30fc
30f9  jmp    0x31c1
  loc_30fc:
30fc  mov    ax, 0xb800
30ff  push   ax
3100  xor    di, di
3102  pop    es
3103  push   es
3104  push   di
3105  mov    di, word ptr [bp + 6]
3108  add    di, 0xc118
310c  push   ss
310d  push   di
310e  mov    ax, 0x3ee4
3111  push   ax
3112  call   Sys_Move
3117  xor    ax, ax
3119  mov    word ptr [bp - 2], ax
311c  jmp    0x3121
  loc_311e:
311e  inc    word ptr [bp - 2]
  loc_3121:
3121  mov    ax, word ptr [bp - 2]
3124  mov    di, word ptr [bp + 6]
3127  add    di, ax
3129  mov    al, byte ptr ss:[di - 0x3ee8]
312e  not    al
3130  mov    dl, al
3132  mov    ax, word ptr [bp - 2]
3135  mov    di, word ptr [bp + 6]
3138  add    di, ax
313a  mov    byte ptr ss:[di - 0x7dce], dl
313f  cmp    word ptr [bp - 2], 0x3ee4
3144  jne    0x311e
3146  mov    word ptr [bp - 2], 1
314b  jmp    0x3150
  loc_314d:
314d  inc    word ptr [bp - 2]
  loc_3150:
3150  mov    al, byte ptr [bp - 2]
3153  shr    al, 1
3155  jae    0x3174
3157  mov    di, word ptr [bp + 6]
315a  add    di, 0x8232
315e  push   ss
315f  push   di
3160  mov    ax, 0xb800
3163  push   ax
3164  xor    di, di
3166  pop    es
3167  push   es
3168  push   di
3169  mov    ax, 0x3ee4
316c  push   ax
316d  call   Sys_Move
3172  jmp    0x318f
  loc_3174:
3174  mov    di, word ptr [bp + 6]
3177  add    di, 0xc118
317b  push   ss
317c  push   di
317d  mov    ax, 0xb800
3180  push   ax
3181  xor    di, di
3183  pop    es
3184  push   es
3185  push   di
3186  mov    ax, 0x3ee4
3189  push   ax
318a  call   Sys_Move
  loc_318f:
318f  mov    ax, word ptr [bp - 2]
3192  mov    cx, 0x1e
3195  imul   cx
3197  add    ax, 0x64
319a  push   ax
319b  call   Crt_Sound
31a0  mov    ax, 5
31a3  push   ax
31a4  call   Crt_Delay
31a9  mov    ax, 0x32
31ac  push   ax
31ad  call   Crt_Sound
31b2  mov    ax, 3
31b5  push   ax
31b6  call   Crt_Delay
31bb  cmp    word ptr [bp - 2], 0x14
31bf  jne    0x314d
  loc_31c1:
31c1  jmp    0x34b6
  loc_31c4:
31c4  cmp    ax, 0x38
31c7  je     0x320d
31c9  cmp    ax, 0x65
31cc  je     0x320d
31ce  cmp    ax, 0x66
31d1  je     0x320d
31d3  cmp    ax, 0x6a
31d6  je     0x320d
31d8  cmp    ax, 0x97
31db  je     0x320d
31dd  cmp    ax, 0x98
31e0  je     0x320d
31e2  cmp    ax, 0x9c
31e5  je     0x320d
31e7  cmp    ax, 0xa1
31ea  je     0x320d
31ec  cmp    ax, 0xc9
31ef  je     0x320d
31f1  cmp    ax, 0xca
31f4  je     0x320d
31f6  cmp    ax, 0xce
31f9  je     0x320d
31fb  cmp    ax, 0xd3
31fe  je     0x320d
3200  cmp    ax, 0xfb
3203  je     0x320d
3205  cmp    ax, 0xfc
3208  je     0x320d
320a  jmp    0x34b6
  loc_320d:
320d  cmp    byte ptr [0xa3be], 0              ; held_item
3212  je     0x3217
3214  jmp    0x34b6
  loc_3217:
3217  mov    di, word ptr [bp + 6]
321a  mov    al, byte ptr ss:[di - 2]
321e  xor    ah, ah
3220  mov    bx, ax
3222  mov    di, word ptr [bp + 6]
3225  mov    al, byte ptr ss:[di - 1]
3229  xor    ah, ah
322b  mov    dx, 0x19
322e  mul    dx
3230  mov    cx, ax
3232  mov    al, byte ptr [0xa3c5]             ; cur_room
3235  xor    ah, ah
3237  mov    dx, 0x226
323a  mul    dx
323c  mov    di, ax
323e  add    di, cx
3240  add    di, bx
3242  mov    al, byte ptr [di - 0x4a70]        ; +rooms
3246  xor    ah, ah
3248  cmp    ax, 0xa1
324b  je     0x3252
324d  cmp    ax, 0xd3
3250  jne    0x32bf
  loc_3252:
3252  mov    di, word ptr [bp + 6]
3255  mov    al, byte ptr ss:[di - 2]
3259  xor    ah, ah
325b  mov    bx, ax
325d  mov    di, word ptr [bp + 6]
3260  mov    al, byte ptr ss:[di - 1]
3264  xor    ah, ah
3266  mov    dx, 0x19
3269  mul    dx
326b  mov    cx, ax
326d  mov    al, byte ptr [0xa3c5]             ; cur_room
3270  xor    ah, ah
3272  mov    dx, 0x226
3275  mul    dx
3277  mov    di, ax
3279  add    di, cx
327b  add    di, bx
327d  mov    al, byte ptr [di - 0x4a70]        ; +rooms
3281  xor    ah, ah
3283  cdq
3284  mov    cx, 0x32
3287  idiv   cx
3289  mov    dx, ax
328b  mov    di, word ptr [bp + 6]
328e  mov    al, byte ptr ss:[di - 1]
3292  xor    ah, ah
3294  mov    cx, 5
3297  shl    ax, cl
3299  add    ax, dx
329b  sub    ax, 3
329e  push   ax
329f  mov    di, word ptr [bp + 6]
32a2  mov    al, byte ptr ss:[di - 2]
32a6  xor    ah, ah
32a8  mov    cx, 3
32ab  shl    ax, cl
32ad  push   ax
32ae  mov    di, 0x7c4c
32b1  push   ds
32b2  push   di
32b3  mov    ax, 1
32b6  push   ax
32b7  call   Graph_PutImage
32bc  jmp    0x33a7
  loc_32bf:
32bf  cmp    ax, 0x38
32c2  je     0x32d3
32c4  cmp    ax, 0x6a
32c7  je     0x32d3
32c9  cmp    ax, 0x9c
32cc  je     0x32d3
32ce  cmp    ax, 0xce
32d1  jne    0x333d
  loc_32d3:
32d3  mov    di, word ptr [bp + 6]
32d6  mov    al, byte ptr ss:[di - 2]
32da  xor    ah, ah
32dc  mov    bx, ax
32de  mov    di, word ptr [bp + 6]
32e1  mov    al, byte ptr ss:[di - 1]
32e5  xor    ah, ah
32e7  mov    dx, 0x19
32ea  mul    dx
32ec  mov    cx, ax
32ee  mov    al, byte ptr [0xa3c5]             ; cur_room
32f1  xor    ah, ah
32f3  mov    dx, 0x226
32f6  mul    dx
32f8  mov    di, ax
32fa  add    di, cx
32fc  add    di, bx
32fe  mov    al, byte ptr [di - 0x4a70]        ; +rooms
3302  xor    ah, ah
3304  cdq
3305  mov    cx, 0x32
3308  idiv   cx
330a  mov    dx, ax
330c  mov    di, word ptr [bp + 6]
330f  mov    al, byte ptr ss:[di - 1]
3313  xor    ah, ah
3315  mov    cx, 5
3318  shl    ax, cl
331a  add    ax, dx
331c  dec    ax
331d  push   ax
331e  mov    di, word ptr [bp + 6]
3321  mov    al, byte ptr ss:[di - 2]
3325  xor    ah, ah
3327  mov    cx, 3
332a  shl    ax, cl
332c  push   ax
332d  mov    di, 0x7c4c
3330  push   ds
3331  push   di
3332  mov    ax, 1
3335  push   ax
3336  call   Graph_PutImage
333b  jmp    0x33a7
  loc_333d:
333d  mov    di, word ptr [bp + 6]
3340  mov    al, byte ptr ss:[di - 2]
3344  xor    ah, ah
3346  mov    bx, ax
3348  mov    di, word ptr [bp + 6]
334b  mov    al, byte ptr ss:[di - 1]
334f  xor    ah, ah
3351  mov    dx, 0x19
3354  mul    dx
3356  mov    cx, ax
3358  mov    al, byte ptr [0xa3c5]             ; cur_room
335b  xor    ah, ah
335d  mov    dx, 0x226
3360  mul    dx
3362  mov    di, ax
3364  add    di, cx
3366  add    di, bx
3368  mov    al, byte ptr [di - 0x4a70]        ; +rooms
336c  xor    ah, ah
336e  cdq
336f  mov    cx, 0x32
3372  idiv   cx
3374  mov    dx, ax
3376  mov    di, word ptr [bp + 6]
3379  mov    al, byte ptr ss:[di - 1]
337d  xor    ah, ah
337f  mov    cx, 5
3382  shl    ax, cl
3384  add    ax, dx
3386  sub    ax, 2
3389  push   ax
338a  mov    di, word ptr [bp + 6]
338d  mov    al, byte ptr ss:[di - 2]
3391  xor    ah, ah
3393  mov    cx, 3
3396  shl    ax, cl
3398  push   ax
3399  mov    di, 0x7c4c
339c  push   ds
339d  push   di
339e  mov    ax, 1
33a1  push   ax
33a2  call   Graph_PutImage
  loc_33a7:
33a7  mov    byte ptr [0xa3be], 2              ; held_item
33ac  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
33b1  je     0x33b7
33b3  push   cs
33b4  call   move_dagger
  loc_33b7:
33b7  mov    byte ptr [0xa3b2], 0x14           ; loop_k
33bc  jmp    0x33c2
  loc_33be:
33be  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_33c2:
33c2  mov    al, byte ptr [0xa3b2]             ; loop_k
33c5  xor    ah, ah
33c7  mov    cx, 0x32
33ca  imul   cx
33cc  push   ax
33cd  call   Crt_Sound
33d2  mov    ax, 0xa
33d5  push   ax
33d6  call   Crt_Delay
33db  call   Crt_NoSound
33e0  cmp    byte ptr [0xa3b2], 0x19           ; loop_k
33e5  jne    0x33be
33e7  cmp    byte ptr [0xcb0c], 0              ; dagger_flying
33ec  je     0x33f2
33ee  push   cs
33ef  call   move_dagger
  loc_33f2:
33f2  mov    byte ptr [0xa3b2], 0x14           ; loop_k
33f7  jmp    0x33fd
  loc_33f9:
33f9  inc    byte ptr [0xa3b2]                 ; loop_k
  loc_33fd:
33fd  mov    al, byte ptr [0xa3b2]             ; loop_k
3400  xor    ah, ah
3402  mov    cx, 0x32
3405  imul   cx
3407  push   ax
3408  call   Crt_Sound
340d  mov    ax, 0xa
3410  push   ax
3411  call   Crt_Delay
3416  call   Crt_NoSound
341b  cmp    byte ptr [0xa3b2], 0x1e           ; loop_k
3420  jne    0x33f9
3422  mov    di, word ptr [bp + 6]
3425  mov    al, byte ptr ss:[di - 2]
3429  xor    ah, ah
342b  mov    bx, ax
342d  mov    di, word ptr [bp + 6]
3430  mov    al, byte ptr ss:[di - 1]
3434  xor    ah, ah
3436  mov    dx, 0x19
3439  mul    dx
343b  mov    cx, ax
343d  mov    al, byte ptr [0xa3c5]             ; cur_room
3440  xor    ah, ah
3442  mov    dx, 0x226
3445  mul    dx
3447  mov    di, ax
3449  add    di, cx
344b  add    di, bx
344d  cmp    byte ptr [di - 0x4a70], 0x38      ; +rooms
3452  jne    0x3486
3454  mov    di, word ptr [bp + 6]
3457  mov    al, byte ptr ss:[di - 2]
345b  xor    ah, ah
345d  mov    bx, ax
345f  mov    di, word ptr [bp + 6]
3462  mov    al, byte ptr ss:[di - 1]
3466  xor    ah, ah
3468  mov    dx, 0x19
346b  mul    dx
346d  mov    cx, ax
346f  mov    al, byte ptr [0xa3c5]             ; cur_room
3472  xor    ah, ah
3474  mov    dx, 0x226
3477  mul    dx
3479  mov    di, ax
347b  add    di, cx
347d  add    di, bx
347f  mov    byte ptr [di - 0x4a70], 0x64      ; +rooms
3484  jmp    0x34b6
  loc_3486:
3486  mov    di, word ptr [bp + 6]
3489  mov    al, byte ptr ss:[di - 2]
348d  xor    ah, ah
348f  mov    bx, ax
3491  mov    di, word ptr [bp + 6]
3494  mov    al, byte ptr ss:[di - 1]
3498  xor    ah, ah
349a  mov    dx, 0x19
349d  mul    dx
349f  mov    cx, ax
34a1  mov    al, byte ptr [0xa3c5]             ; cur_room
34a4  xor    ah, ah
34a6  mov    dx, 0x226
34a9  mul    dx
34ab  mov    di, ax
34ad  add    di, cx
34af  add    di, bx
34b1  sub    byte ptr [di - 0x4a70], 0x32      ; +rooms
  loc_34b6:
34b6  push   cs
34b7  call   move_mummies
34ba  mov    sp, bp
34bc  pop    bp
34bd  retf   2
34c0  db 00,00,00,40,0e,00,00,01,00,00,00,00,60,04,00,00
34d0  db 00,00,80,11,02,00,00,00,00,46,08,00,00,00,00,18

; ------------------------------------------------------------
check_pickup:
34e0  push   bp
34e1  mov    bp, sp
34e3  sub    sp, 0x7dce
34e7  mov    ax, word ptr [0xb058]             ; player_x
34ea  cdq
34eb  mov    cx, 0x20
34ee  idiv   cx
34f0  mov    byte ptr [bp - 1], al
34f3  mov    ax, word ptr [0xb05a]             ; player_y
34f6  sub    ax, 6
34f9  cdq
34fa  mov    cx, 8
34fd  idiv   cx
34ff  mov    byte ptr [bp - 2], al
3502  mov    al, byte ptr [bp - 2]
3505  xor    ah, ah
3507  mov    bx, ax
3509  mov    al, byte ptr [bp - 1]
350c  xor    ah, ah
350e  mov    dx, 0x19
3511  mul    dx
3513  mov    cx, ax
3515  mov    al, byte ptr [0xa3c5]             ; cur_room
3518  xor    ah, ah
351a  mov    dx, 0x226
351d  mul    dx
351f  mov    di, ax
3521  add    di, cx
3523  add    di, bx
3525  mov    al, byte ptr [di - 0x4a70]        ; +rooms
3529  push   ax
352a  mov    di, 0x34c0                        ; set cs:34c0 = [30,33,34,35,56,101,102,106,151,152,156,161,201,202,206,211,251,252]
352d  push   cs
352e  push   di
352f  call   Sys_SetIn
3534  je     0x353b
3536  push   bp
3537  push   cs
3538  call   pick_up_item
  loc_353b:
353b  mov    ax, word ptr [0xb05a]             ; player_y
353e  add    ax, 6
3541  cdq
3542  mov    cx, 8
3545  idiv   cx
3547  mov    byte ptr [bp - 2], al
354a  mov    al, byte ptr [bp - 2]
354d  xor    ah, ah
354f  mov    bx, ax
3551  mov    al, byte ptr [bp - 1]
3554  xor    ah, ah
3556  mov    dx, 0x19
3559  mul    dx
355b  mov    cx, ax
355d  mov    al, byte ptr [0xa3c5]             ; cur_room
3560  xor    ah, ah
3562  mov    dx, 0x226
3565  mul    dx
3567  mov    di, ax
3569  add    di, cx
356b  add    di, bx
356d  mov    al, byte ptr [di - 0x4a70]        ; +rooms
3571  push   ax
3572  mov    di, 0x34c0                        ; set cs:34c0 = [30,33,34,35,56,101,102,106,151,152,156,161,201,202,206,211,251,252]
3575  push   cs
3576  push   di
3577  call   Sys_SetIn
357c  je     0x3583
357e  push   bp
357f  push   cs
3580  call   pick_up_item
  loc_3583:
3583  mov    sp, bp
3585  pop    bp
3586  retf

; ------------------------------------------------------------
fanfare_50:
3587  push   bp
3588  mov    bp, sp
358a  mov    ax, 0x32
358d  push   ax
358e  call   Crt_Sound
3593  mov    ax, 0xb4
3596  push   ax
3597  call   Crt_Delay
359c  call   Crt_NoSound
35a1  mov    ax, 0x50
35a4  push   ax
35a5  call   Crt_Delay
35aa  mov    ax, 0x32
35ad  push   ax
35ae  call   Crt_Sound
35b3  mov    ax, 0x28
35b6  push   ax
35b7  call   Crt_Delay
35bc  call   Crt_NoSound
35c1  mov    ax, 0x64
35c4  push   ax
35c5  call   Crt_Delay
35ca  mov    ax, 0x32
35cd  push   ax
35ce  call   Crt_Sound
35d3  mov    ax, 0x28
35d6  push   ax
35d7  call   Crt_Delay
35dc  call   Crt_NoSound
35e1  mov    ax, 0x64
35e4  push   ax
35e5  call   Crt_Delay
35ea  mov    ax, 0x32
35ed  push   ax
35ee  call   Crt_Sound
35f3  mov    ax, 0x28
35f6  push   ax
35f7  call   Crt_Delay
35fc  call   Crt_NoSound
3601  mov    ax, 0xc8
3604  push   ax
3605  call   Crt_Delay
360a  mov    ax, 0x32
360d  push   ax
360e  call   Crt_Sound
3613  mov    ax, 0x28
3616  push   ax
3617  call   Crt_Delay
361c  call   Crt_NoSound
3621  mov    ax, 0xc8
3624  push   ax
3625  call   Crt_Delay
362a  mov    sp, bp
362c  pop    bp
362d  retf   2

; ------------------------------------------------------------
fanfare_53:
3630  push   bp
3631  mov    bp, sp
3633  mov    ax, 0x35
3636  push   ax
3637  call   Crt_Sound
363c  mov    ax, 0xb4
363f  push   ax
3640  call   Crt_Delay
3645  call   Crt_NoSound
364a  mov    ax, 0x50
364d  push   ax
364e  call   Crt_Delay
3653  mov    ax, 0x36
3656  push   ax
3657  call   Crt_Sound
365c  mov    ax, 0x28
365f  push   ax
3660  call   Crt_Delay
3665  call   Crt_NoSound
366a  mov    ax, 0x64
366d  push   ax
366e  call   Crt_Delay
3673  mov    ax, 0x36
3676  push   ax
3677  call   Crt_Sound
367c  mov    ax, 0x28
367f  push   ax
3680  call   Crt_Delay
3685  call   Crt_NoSound
368a  mov    ax, 0x64
368d  push   ax
368e  call   Crt_Delay
3693  mov    ax, 0x36
3696  push   ax
3697  call   Crt_Sound
369c  mov    ax, 0x28
369f  push   ax
36a0  call   Crt_Delay
36a5  call   Crt_NoSound
36aa  mov    ax, 0xc8
36ad  push   ax
36ae  call   Crt_Delay
36b3  mov    ax, 0x36
36b6  push   ax
36b7  call   Crt_Sound
36bc  mov    ax, 0x28
36bf  push   ax
36c0  call   Crt_Delay
36c5  call   Crt_NoSound
36ca  mov    ax, 0xc8
36cd  push   ax
36ce  call   Crt_Delay
36d3  mov    sp, bp
36d5  pop    bp
36d6  retf   2

; ------------------------------------------------------------
enter_exit:
36d9  push   bp
36da  mov    bp, sp
36dc  mov    al, 9
36de  push   ax
36df  push   word ptr [0xb042]
36e3  push   word ptr [0xb040]                 ; saved_int9
36e7  call   Dos_SetIntVec
36ec  mov    al, 8
36ee  push   ax
36ef  push   word ptr [0xb03e]
36f3  push   word ptr [0xb03c]                 ; saved_int8
36f7  call   Dos_SetIntVec
36fc  call   Crt_NoSound
3701  push   bp
3702  push   cs
3703  call   fanfare_50
3706  mov    ax, word ptr [0xb058]             ; player_x
3709  sub    ax, 0x10
370c  push   ax
370d  mov    ax, word ptr [0xb05a]             ; player_y
3710  sub    ax, 8
3713  push   ax
3714  mov    al, byte ptr [0xa3c0]             ; player_sprite
3717  xor    ah, ah
3719  mov    dx, 0x54
371c  mul    dx
371e  mov    di, ax
3720  add    di, 0x69ec
3724  push   ds
3725  push   di
3726  mov    ax, 1
3729  push   ax
372a  call   Graph_PutImage
372f  mov    ax, word ptr [0xb058]             ; player_x
3732  sub    ax, 0x11
3735  push   ax
3736  mov    ax, word ptr [0xb05a]             ; player_y
3739  sub    ax, 8
373c  push   ax
373d  mov    di, 0x89c0
3740  push   ds
3741  push   di
3742  xor    ax, ax
3744  push   ax
3745  call   Graph_PutImage
374a  push   bp
374b  push   cs
374c  call   fanfare_53
374f  mov    ax, word ptr [0xb074]             ; exit_x
3752  sub    ax, 0x20
3755  push   ax
3756  mov    ax, word ptr [0xb076]             ; exit_y
3759  sub    ax, 0x18
375c  push   ax
375d  mov    di, 0x8720
3760  push   ds
3761  push   di
3762  xor    ax, ax
3764  push   ax
3765  call   Graph_PutImage
376a  push   word ptr [0xb074]                 ; exit_x
376e  mov    ax, word ptr [0xb076]             ; exit_y
3771  sub    ax, 0x18
3774  push   ax
3775  mov    di, 0x8774
3778  push   ds
3779  push   di
377a  xor    ax, ax
377c  push   ax
377d  call   Graph_PutImage
3782  mov    ax, word ptr [0xb074]             ; exit_x
3785  sub    ax, 0x20
3788  push   ax
3789  mov    ax, word ptr [0xb076]             ; exit_y
378c  sub    ax, 8
378f  push   ax
3790  mov    di, 0x87c8
3793  push   ds
3794  push   di
3795  xor    ax, ax
3797  push   ax
3798  call   Graph_PutImage
379d  push   word ptr [0xb074]                 ; exit_x
37a1  mov    ax, word ptr [0xb076]             ; exit_y
37a4  sub    ax, 8
37a7  push   ax
37a8  mov    di, 0x881c
37ab  push   ds
37ac  push   di
37ad  xor    ax, ax
37af  push   ax
37b0  call   Graph_PutImage
37b5  mov    ax, word ptr [0xb058]             ; player_x
37b8  sub    ax, 0x11
37bb  push   ax
37bc  mov    ax, word ptr [0xb05a]             ; player_y
37bf  sub    ax, 8
37c2  push   ax
37c3  mov    di, 0x89c0
37c6  push   ds
37c7  push   di
37c8  xor    ax, ax
37ca  push   ax
37cb  call   Graph_PutImage
37d0  push   bp
37d1  push   cs
37d2  call   fanfare_50
37d5  mov    ax, word ptr [0xb074]             ; exit_x
37d8  sub    ax, 0x20
37db  push   ax
37dc  mov    ax, word ptr [0xb076]             ; exit_y
37df  sub    ax, 0x18
37e2  push   ax
37e3  mov    di, 0x8870
37e6  push   ds
37e7  push   di
37e8  xor    ax, ax
37ea  push   ax
37eb  call   Graph_PutImage
37f0  push   word ptr [0xb074]                 ; exit_x
37f4  mov    ax, word ptr [0xb076]             ; exit_y
37f7  sub    ax, 0x18
37fa  push   ax
37fb  mov    di, 0x88c4
37fe  push   ds
37ff  push   di
3800  xor    ax, ax
3802  push   ax
3803  call   Graph_PutImage
3808  mov    ax, word ptr [0xb074]             ; exit_x
380b  sub    ax, 0x20
380e  push   ax
380f  mov    ax, word ptr [0xb076]             ; exit_y
3812  sub    ax, 8
3815  push   ax
3816  mov    di, 0x8918
3819  push   ds
381a  push   di
381b  xor    ax, ax
381d  push   ax
381e  call   Graph_PutImage
3823  push   word ptr [0xb074]                 ; exit_x
3827  mov    ax, word ptr [0xb076]             ; exit_y
382a  sub    ax, 8
382d  push   ax
382e  mov    di, 0x896c
3831  push   ds
3832  push   di
3833  xor    ax, ax
3835  push   ax
3836  call   Graph_PutImage
383b  mov    ax, word ptr [0xb058]             ; player_x
383e  sub    ax, 0x11
3841  push   ax
3842  mov    ax, word ptr [0xb05a]             ; player_y
3845  sub    ax, 8
3848  push   ax
3849  mov    di, 0x89c0
384c  push   ds
384d  push   di
384e  mov    ax, 1
3851  push   ax
3852  call   Graph_PutImage
3857  push   bp
3858  push   cs
3859  call   fanfare_53
385c  mov    ax, 0x32
385f  push   ax
3860  call   Crt_Sound
3865  mov    ax, 0x28
3868  push   ax
3869  call   Crt_Delay
386e  mov    ax, 0x1f4
3871  push   ax
3872  call   Crt_Delay
3877  call   Crt_NoSound
387c  mov    byte ptr [0xa3b0], 1              ; loop_i
3881  jmp    0x3887
  loc_3883:
3883  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3887:
3887  mov    ax, 0x1f4
388a  push   ax
388b  call   Crt_Delay
3890  mov    ax, word ptr [0xb058]             ; player_x
3893  sub    ax, 0x11
3896  push   ax
3897  mov    ax, word ptr [0xb05a]             ; player_y
389a  sub    ax, 8
389d  push   ax
389e  mov    al, byte ptr [0xa3b0]             ; loop_i
38a1  xor    ah, ah
38a3  add    ax, 0x60
38a6  mov    dx, 0x54
38a9  mul    dx
38ab  mov    di, ax
38ad  add    di, 0x69ec
38b1  push   ds
38b2  push   di
38b3  mov    ax, 1
38b6  push   ax
38b7  call   Graph_PutImage
38bc  mov    ax, word ptr [0xb058]             ; player_x
38bf  sub    ax, 0x11
38c2  push   ax
38c3  mov    ax, word ptr [0xb05a]             ; player_y
38c6  sub    ax, 8
38c9  push   ax
38ca  mov    al, byte ptr [0xa3b0]             ; loop_i
38cd  xor    ah, ah
38cf  add    ax, 0x61
38d2  mov    dx, 0x54
38d5  mul    dx
38d7  mov    di, ax
38d9  add    di, 0x69ec
38dd  push   ds
38de  push   di
38df  mov    ax, 1
38e2  push   ax
38e3  call   Graph_PutImage
38e8  cmp    byte ptr [0xa3b0], 5              ; loop_i
38ed  jne    0x3883
38ef  mov    ax, word ptr [0xb058]             ; player_x
38f2  sub    ax, 0x11
38f5  push   ax
38f6  mov    ax, word ptr [0xb05a]             ; player_y
38f9  sub    ax, 8
38fc  push   ax
38fd  mov    di, 0x8b64
3900  push   ds
3901  push   di
3902  mov    ax, 1
3905  push   ax
3906  call   Graph_PutImage
390b  mov    ax, 0x3e8
390e  push   ax
390f  call   Crt_Delay
3914  mov    byte ptr [0xa3b1], 0              ; loop_j
3919  mov    byte ptr [0xa3b0], 1              ; loop_i
391e  jmp    0x3924
  loc_3920:
3920  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3924:
3924  mov    al, byte ptr [0xa3b0]             ; loop_i
3927  xor    ah, ah
3929  mov    di, ax
392b  mov    byte ptr [di + 0x7aab], 0
3930  cmp    byte ptr [0xa3b0], 0x20           ; loop_i
3935  jne    0x3920
3937  mov    byte ptr [0xa3b0], 0              ; loop_i
393c  jmp    0x3942
  loc_393e:
393e  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_3942:
3942  mov    byte ptr [0xa3b1], 0              ; loop_j
3947  jmp    0x394d
  loc_3949:
3949  inc    byte ptr [0xa3b1]                 ; loop_j
  loc_394d:
394d  mov    al, byte ptr [0xa3b1]             ; loop_j
3950  xor    ah, ah
3952  mov    cx, 5
3955  shl    ax, cl
3957  push   ax
3958  mov    al, byte ptr [0xa3b0]             ; loop_i
395b  xor    ah, ah
395d  mov    cx, 3
3960  shl    ax, cl
3962  push   ax
3963  mov    di, 0x7aa8
3966  push   ds
3967  push   di
3968  xor    ax, ax
396a  push   ax
396b  call   Graph_PutImage
3970  mov    ax, 5
3973  push   ax
3974  call   Crt_Delay
3979  mov    al, byte ptr [0xa3b1]             ; loop_j
397c  xor    ah, ah
397e  mov    dx, ax
3980  mov    ax, 0x13
3983  sub    ax, dx
3985  mov    cx, 5
3988  shl    ax, cl
398a  push   ax
398b  mov    al, byte ptr [0xa3b0]             ; loop_i
398e  xor    ah, ah
3990  mov    dx, ax
3992  mov    ax, 0x17
3995  sub    ax, dx
3997  mov    cx, 3
399a  shl    ax, cl
399c  push   ax
399d  mov    di, 0x7aa8
39a0  push   ds
39a1  push   di
39a2  xor    ax, ax
39a4  push   ax
39a5  call   Graph_PutImage
39aa  cmp    byte ptr [0xa3b1], 0x13           ; loop_j
39af  jne    0x3949
39b1  cmp    byte ptr [0xa3b0], 0xb            ; loop_i
39b6  jne    0x393e
39b8  mov    sp, bp
39ba  pop    bp
39bb  retf

; ------------------------------------------------------------
draw_text:
39bc  push   bp
39bd  mov    bp, sp
39bf  sub    sp, 0x102
39c3  les    di, ptr [bp + 6]
39c6  push   es
39c7  push   di
39c8  lea    di, [bp - 0x100]
39cc  push   ss
39cd  push   di
39ce  mov    ax, 0xff
39d1  push   ax
39d2  call   Sys_StrStore
39d7  mov    al, byte ptr [bp - 0x100]
39db  mov    byte ptr [bp - 0x101], al
39df  mov    al, 1
39e1  cmp    al, byte ptr [bp - 0x101]
39e5  jbe    0x39ea
39e7  jmp    0x3adc
  loc_39ea:
39ea  mov    byte ptr [0xa3b0], al             ; loop_i
39ed  jmp    0x39f3
  loc_39ef:
39ef  inc    byte ptr [0xa3b0]                 ; loop_i
  loc_39f3:
39f3  mov    al, byte ptr [0xa3b0]             ; loop_i
39f6  xor    ah, ah
39f8  mov    di, ax
39fa  mov    al, byte ptr [bp + di - 0x100]
39fe  cmp    al, 0x30
3a00  jb     0x3a1b
3a02  cmp    al, 0x39
3a04  ja     0x3a1b
3a06  mov    al, byte ptr [0xa3b0]             ; loop_i
3a09  xor    ah, ah
3a0b  mov    di, ax
3a0d  mov    al, byte ptr [bp + di - 0x100]
3a11  xor    ah, ah
3a13  sub    ax, 0x2f
3a16  mov    byte ptr [0xa3b1], al             ; loop_j
3a19  jmp    0x3a53
  loc_3a1b:
3a1b  cmp    al, 0x61
3a1d  jb     0x3a38
3a1f  cmp    al, 0x7a
3a21  ja     0x3a38
3a23  mov    al, byte ptr [0xa3b0]             ; loop_i
3a26  xor    ah, ah
3a28  mov    di, ax
3a2a  mov    al, byte ptr [bp + di - 0x100]
3a2e  xor    ah, ah
3a30  sub    ax, 0x56
3a33  mov    byte ptr [0xa3b1], al             ; loop_j
3a36  jmp    0x3a53
  loc_3a38:
3a38  cmp    al, 0x41
3a3a  jb     0x3a53
3a3c  cmp    al, 0x5a
3a3e  ja     0x3a53
3a40  mov    al, byte ptr [0xa3b0]             ; loop_i
3a43  xor    ah, ah
3a45  mov    di, ax
3a47  mov    al, byte ptr [bp + di - 0x100]
3a4b  xor    ah, ah
3a4d  sub    ax, 0x36
3a50  mov    byte ptr [0xa3b1], al             ; loop_j
  loc_3a53:
3a53  mov    al, byte ptr [0xa3b0]             ; loop_i
3a56  xor    ah, ah
3a58  mov    di, ax
3a5a  cmp    byte ptr [bp + di - 0x100], 0x20
3a5f  je     0x3ad0
3a61  cmp    word ptr [bp + 0xa], 0x14
3a65  jne    0x3a9a
3a67  mov    al, byte ptr [0xa3b0]             ; loop_i
3a6a  xor    ah, ah
3a6c  add    ax, word ptr [bp + 0xc]
3a6f  dec    ax
3a70  mov    cx, 0x14
3a73  imul   cx
3a75  push   ax
3a76  mov    ax, 0xc0
3a79  push   ax
3a7a  mov    al, byte ptr [0xa3b1]             ; loop_j
3a7d  xor    ah, ah
3a7f  add    ax, 0x8a
3a82  mov    dx, 0x54
3a85  mul    dx
3a87  mov    di, ax
3a89  add    di, 0x69ec
3a8d  push   ds
3a8e  push   di
3a8f  mov    ax, 2
3a92  push   ax
3a93  call   Graph_PutImage
3a98  jmp    0x3ad0
  loc_3a9a:
3a9a  mov    al, byte ptr [0xa3b0]             ; loop_i
3a9d  xor    ah, ah
3a9f  add    ax, word ptr [bp + 0xc]
3aa2  dec    ax
3aa3  mov    cx, 0x14
3aa6  imul   cx
3aa8  push   ax
3aa9  mov    ax, word ptr [bp + 0xa]
3aac  mov    cx, 0xa
3aaf  imul   cx
3ab1  push   ax
3ab2  mov    al, byte ptr [0xa3b1]             ; loop_j
3ab5  xor    ah, ah
3ab7  add    ax, 0x8a
3aba  mov    dx, 0x54
3abd  mul    dx
3abf  mov    di, ax
3ac1  add    di, 0x69ec
3ac5  push   ds
3ac6  push   di
3ac7  mov    ax, 2
3aca  push   ax
3acb  call   Graph_PutImage
  loc_3ad0:
3ad0  mov    al, byte ptr [0xa3b0]             ; loop_i
3ad3  cmp    al, byte ptr [bp - 0x101]
3ad7  je     0x3adc
3ad9  jmp    0x39ef
  loc_3adc:
3adc  mov    sp, bp
3ade  pop    bp
3adf  retf   8

; ------------------------------------------------------------
gamelib_init:
3ae2  push   bp
3ae3  mov    bp, sp
3ae5  mov    al, 9
3ae7  push   ax
3ae8  mov    di, 0x69e4
3aeb  push   ds
3aec  push   di
3aed  call   Dos_GetIntVec
3af2  mov    al, 8
3af4  push   ax
3af5  mov    di, 0x69e8
3af8  push   ds
3af9  push   di
3afa  call   Dos_GetIntVec
3aff  mov    sp, bp
3b01  pop    bp
3b02  retf
3b03  db 00,00,00,00,00,00,00,00,00,00,00,00,00

;==============================================================================
; SEGMENT 0c93  GRAPH   (linear 0c930..0fd30)
;==============================================================================
0000  db 51,'BGI Error: Graphics not initialized (use InitGraph)'
0034  db 32,'BGI Error:  Not in graphics mode'

; ------------------------------------------------------------
sub_0c93_0055:
0055  push   bp
0056  mov    bp, sp
0058  cmp    byte ptr [0xcda6], 0
005d  jne    0x7d
005f  mov    di, 0xcf12
0062  push   ds
0063  push   di
0064  mov    di, 0                             ; cs:'BGI Error: Graphics not initialized (use InitGraph)'
0067  push   cs
0068  push   di
0069  xor    ax, ax
006b  push   ax
006c  call   Sys_WriteStr
0071  call   Sys_WriteLn
0076  call   Sys_IOCheck
007b  jmp    0x99
  loc_007d:
007d  mov    di, 0xcf12
0080  push   ds
0081  push   di
0082  mov    di, 0x34                          ; cs:'BGI Error:  Not in graphics mode'
0085  push   cs
0086  push   di
0087  xor    ax, ax
0089  push   ax
008a  call   Sys_WriteStr
008f  call   Sys_WriteLn
0094  call   Sys_IOCheck
  loc_0099:
0099  mov    ax, 1
009c  call   Sys_Halt
00a1  mov    sp, bp
00a3  pop    bp
00a4  retf
00a5  db 55,89,e5,83,ec,02,c7,46,fe,01,00,8b,46,fe,89,ec
00b5  db 5d,ca,02,00,55,89,e5,c4,7e,08,06,57,ff,76,06,9a
00c5  db 29,03,3f,10,89,ec,5d,ca,06,00,55,89,e5,c4,7e,08
00d5  db 26,8b,05,26,0b,45,02,74,0d,c4,7e,08,06,57,ff,76
00e5  db 06,9a,64,03,3f,10,c4,7e,08,31,c0,26,89,05,26,89
00f5  db 45,02,89,ec,5d,ca,06,00

; ------------------------------------------------------------
sub_0c93_00fd:
00fd  push   bp
00fe  mov    bp, sp
0100  sub    sp, 8
0103  les    di, ptr [bp + 8]
0106  mov    ax, word ptr es:[di]
0109  add    word ptr [bp + 0xc], ax
010c  mov    ax, word ptr [bp + 0xc]
010f  mov    cx, 4
0112  shr    ax, cl
0114  add    ax, word ptr [bp + 0xe]
0117  mov    dx, ax
0119  xor    ax, ax
011b  mov    word ptr [bp - 8], ax
011e  mov    word ptr [bp - 6], dx
0121  mov    ax, word ptr [bp + 0xc]
0124  and    ax, 0xf
0127  or     ax, ax
0129  je     0x14c
012b  les    di, ptr [bp + 0xc]
012e  push   es
012f  push   di
0130  les    di, ptr [bp - 8]
0133  push   es
0134  push   di
0135  les    di, ptr [bp + 4]
0138  push   word ptr es:[di]
013b  call   Sys_Move
0140  mov    ax, word ptr [bp + 0xc]
0143  and    ax, 0xf
0146  les    di, ptr [bp + 8]
0149  sub    word ptr es:[di], ax
  loc_014c:
014c  les    ax, ptr [bp - 8]
014f  mov    dx, es
0151  mov    word ptr [bp - 4], ax
0154  mov    word ptr [bp - 2], dx
0157  mov    ax, word ptr [bp - 4]
015a  mov    dx, word ptr [bp - 2]
015d  mov    sp, bp
015f  pop    bp
0160  ret    0xc
0163  db 2,'pk'

; ------------------------------------------------------------
Graph_RegisterBGIdriver:
0166  push   bp
0167  mov    bp, sp
0169  sub    sp, 0x108
016d  cmp    byte ptr [0xcda6], 0
0172  je     0x182
0174  mov    word ptr [0xcd70], 0xfff5
017a  mov    word ptr [bp - 2], 0xfff5
017f  jmp    0x255
  loc_0182:
0182  mov    word ptr [0xcd70], 0xfffc
0188  mov    word ptr [bp - 2], 0xfffc
018d  lea    di, [bp - 0x108]
0191  push   ss
0192  push   di
0193  les    di, ptr [bp + 6]
0196  push   es
0197  push   di
0198  mov    ax, 2
019b  push   ax
019c  call   Sys_ArrToStr
01a1  mov    di, 0x163                         ; cs:'pk'
01a4  push   cs
01a5  push   di
01a6  call   Sys_StrCmp
01ab  je     0x1b0
01ad  jmp    0x255
  loc_01b0:
01b0  mov    ax, word ptr [bp + 6]
01b3  add    ax, 0x80
01b6  mov    dx, word ptr [bp + 8]
01b9  mov    word ptr [bp - 6], ax
01bc  mov    word ptr [bp - 4], dx
01bf  les    di, ptr [bp - 6]
01c2  mov    word ptr [bp - 0xc], di
01c5  mov    word ptr [bp - 0xa], es
01c8  les    di, ptr [bp - 0xc]
01cb  cmp    byte ptr es:[di + 6], 2
01d0  jb     0x1dc
01d2  les    di, ptr [bp - 0xc]
01d5  cmp    byte ptr es:[di + 8], 1
01da  jbe    0x1de
  loc_01dc:
01dc  jmp    0x255
  loc_01de:
01de  mov    ax, word ptr [0xcd10]
01e1  mov    word ptr [bp - 0xe], ax
01e4  xor    ax, ax
01e6  cmp    ax, word ptr [bp - 0xe]
01e9  jg     0x255
01eb  mov    word ptr [bp - 8], ax
01ee  jmp    0x1f3
  loc_01f0:
01f0  inc    word ptr [bp - 8]
  loc_01f3:
01f3  mov    ax, word ptr [bp - 8]
01f6  mov    dx, 0x1a
01f9  mul    dx
01fb  mov    di, ax
01fd  add    di, 0x26de
0201  push   ds
0202  push   di
0203  les    di, ptr [bp - 0xc]
0206  add    di, 0xa
020a  push   es
020b  push   di
020c  call   Sys_StrCmp
0211  jne    0x24d
0213  push   word ptr [bp + 8]
0216  push   word ptr [bp + 6]
0219  les    di, ptr [bp - 0xc]
021c  push   es
021d  push   di
021e  les    di, ptr [bp - 0xc]
0221  add    di, 4
0225  push   es
0226  push   di
0227  call   sub_0c93_00fd
022a  mov    cx, ax
022c  mov    bx, dx
022e  mov    ax, word ptr [bp - 8]
0231  mov    dx, 0x1a
0234  mul    dx
0236  mov    di, ax
0238  mov    word ptr [di + 0x26f4], cx
023c  mov    word ptr [di + 0x26f6], bx
0240  mov    ax, word ptr [bp - 8]
0243  mov    word ptr [bp - 2], ax
0246  xor    ax, ax
0248  mov    word ptr [0xcd70], ax
024b  jmp    0x255
  loc_024d:
024d  mov    ax, word ptr [bp - 8]
0250  cmp    ax, word ptr [bp - 0xe]
0253  jne    0x1f0
  loc_0255:
0255  mov    ax, word ptr [bp - 2]
0258  mov    sp, bp
025a  pop    bp
025b  retf   4
025e  db 2,'PK'

; ------------------------------------------------------------
sub_0c93_0261:
0261  push   bp
0262  mov    bp, sp
0264  sub    sp, 0x112
0268  mov    word ptr [0xcd70], 0xfff3
026e  mov    ax, word ptr [0xcd70]
0271  mov    word ptr [bp - 2], ax
0274  lea    di, [bp - 0x10a]
0278  push   ss
0279  push   di
027a  les    di, ptr [bp + 6]
027d  push   es
027e  push   di
027f  mov    ax, 2
0282  push   ax
0283  call   Sys_ArrToStr
0288  mov    di, 0x25e                         ; cs:'PK'
028b  push   cs
028c  push   di
028d  call   Sys_StrCmp
0292  je     0x297
0294  jmp    0x3a7
  loc_0297:
0297  xor    ax, ax
0299  mov    word ptr [bp - 0xa], ax
  loc_029c:
029c  mov    ax, word ptr [bp - 0xa]
029f  les    di, ptr [bp + 6]
02a2  add    di, ax
02a4  cmp    byte ptr es:[di], 0x1a
02a8  je     0x2b6
02aa  cmp    word ptr [bp - 0xa], 0x101
02af  jae    0x2b6
02b1  inc    word ptr [bp - 0xa]
02b4  jmp    0x29c
  loc_02b6:
02b6  cmp    word ptr [bp - 0xa], 0x100
02bb  jb     0x2c0
02bd  jmp    0x3a7
  loc_02c0:
02c0  les    di, ptr [bp + 6]
02c3  mov    ax, es
02c5  mov    dx, ax
02c7  les    di, ptr [bp + 6]
02ca  mov    ax, di
02cc  add    ax, word ptr [bp - 0xa]
02cf  inc    ax
02d0  mov    word ptr [bp - 6], ax
02d3  mov    word ptr [bp - 4], dx
02d6  les    di, ptr [bp - 6]
02d9  mov    word ptr [bp - 0xe], di
02dc  mov    word ptr [bp - 0xc], es
02df  les    di, ptr [bp - 0xe]
02e2  cmp    byte ptr es:[di + 8], 1
02e7  jb     0x2f3
02e9  les    di, ptr [bp - 0xe]
02ec  cmp    byte ptr es:[di + 0xa], 1
02f1  jbe    0x2f6
  loc_02f3:
02f3  jmp    0x3a7
  loc_02f6:
02f6  mov    word ptr [bp - 8], 1
02fb  jmp    0x300
  loc_02fd:
02fd  inc    word ptr [bp - 8]
  loc_0300:
0300  mov    ax, word ptr [bp - 8]
0303  mov    dx, 0xf
0306  mul    dx
0308  mov    di, ax
030a  add    di, 0x27f7
030e  push   ds
030f  push   di
0310  lea    di, [bp - 0x10e]
0314  push   ss
0315  push   di
0316  les    di, ptr [bp - 0xe]
0319  add    di, 2
031d  push   es
031e  push   di
031f  mov    ax, 4
0322  push   ax
0323  call   Sys_ArrToStr
0328  call   Sys_StrCmp
032d  jne    0x39e
032f  mov    ax, word ptr [bp - 8]
0332  mov    dx, 0xf
0335  mul    dx
0337  mov    di, ax
0339  add    di, 0x27ed
033d  mov    word ptr [bp - 0x112], di
0341  mov    word ptr [bp - 0x110], ds
0345  les    di, ptr [bp - 0x112]
0349  push   es
034a  push   di
034b  les    di, ptr [bp - 0x112]
034f  push   word ptr es:[di + 8]
0353  lcall  [0xcc1e]
0357  les    di, ptr [bp - 0x112]
035b  xor    ax, ax
035d  mov    word ptr es:[di], ax
0360  mov    word ptr es:[di + 2], ax
0364  push   word ptr [bp + 8]
0367  push   word ptr [bp + 6]
036a  les    di, ptr [bp - 0xe]
036d  push   es
036e  push   di
036f  les    di, ptr [bp - 0xe]
0372  add    di, 6
0376  push   es
0377  push   di
0378  call   sub_0c93_00fd
037b  les    di, ptr [bp - 0x112]
037f  mov    word ptr es:[di + 4], ax
0383  mov    word ptr es:[di + 6], dx
0387  les    di, ptr [bp - 0x112]
038b  xor    ax, ax
038d  mov    word ptr es:[di + 8], ax
0391  mov    ax, word ptr [bp - 8]
0394  mov    word ptr [bp - 2], ax
0397  xor    ax, ax
0399  mov    word ptr [0xcd70], ax
039c  jmp    0x3a7
  loc_039e:
039e  cmp    word ptr [bp - 8], 0x14
03a2  je     0x3a7
03a4  jmp    0x2fd
  loc_03a7:
03a7  mov    ax, word ptr [bp - 2]
03aa  mov    sp, bp
03ac  pop    bp
03ad  retf   4

; ------------------------------------------------------------
Graph_DetectGraph:
03b0  push   bp
03b1  mov    bp, sp
03b3  les    di, ptr [bp + 0xa]
03b6  push   es
03b7  push   di
03b8  les    di, ptr [bp + 6]
03bb  push   es
03bc  push   di
03bd  push   cs
03be  call   sub_0c93_1485
03c1  les    di, ptr [bp + 0xa]
03c4  cmp    word ptr es:[di], 0
03c8  jge    0x3db
03ca  les    di, ptr [bp + 0xa]
03cd  mov    word ptr es:[di], 0xfffe
03d2  les    di, ptr [bp + 0xa]
03d5  mov    ax, word ptr es:[di]
03d8  mov    word ptr [0xcd70], ax
  loc_03db:
03db  mov    sp, bp
03dd  pop    bp
03de  retf   8

; ------------------------------------------------------------
sub_0c93_03e1:
03e1  push   bp
03e2  mov    bp, sp
03e4  mov    ax, 0x55
03e7  mov    dx, 0xc93                         ; seg GRAPH
03ea  mov    word ptr [0xcd78], ax
03ed  mov    word ptr [0xcd7a], dx
03f1  mov    ax, 0x55
03f4  mov    dx, 0xc93                         ; seg GRAPH
03f7  mov    word ptr [0xcd8a], ax
03fa  mov    word ptr [0xcd8c], dx
03fe  xor    ax, ax
0400  mov    word ptr [0xcd7c], ax
0403  mov    word ptr [0xcd7e], ax
0406  xor    ax, ax
0408  mov    word ptr [0xcd8e], ax
040b  mov    word ptr [0xcd90], ax
040e  xor    ax, ax
0410  mov    word ptr [0xcd80], ax
0413  mov    word ptr [0xcd82], ax
0416  xor    ax, ax
0418  mov    word ptr [0xcd86], ax
041b  mov    word ptr [0xcd88], ax
041e  xor    ax, ax
0420  mov    word ptr [0xcd38], ax
0423  mov    word ptr [0xcd3a], ax
0426  xor    ax, ax
0428  mov    word ptr [0xcd3c], ax
042b  xor    ax, ax
042d  mov    word ptr [0xcd52], ax
0430  mov    word ptr [0xcd54], ax
0433  xor    ax, ax
0435  mov    word ptr [0xcd56], ax
0438  mov    byte ptr [0xcd42], 0
043d  mov    word ptr [0xcda2], 1
0443  mov    word ptr [0xcda4], 1
0449  xor    ax, ax
044b  mov    word ptr [0xcca2], ax
044e  mov    byte ptr [0xcda6], 0
0453  mov    sp, bp
0455  pop    bp
0456  ret

; ------------------------------------------------------------
sub_0c93_0457:
0457  push   bp
0458  mov    bp, sp
045a  sub    sp, 0x302
045e  les    di, ptr [bp + 0xe]
0461  push   es
0462  push   di
0463  lea    di, [bp - 0x102]
0467  push   ss
0468  push   di
0469  mov    ax, 0xff
046c  push   ax
046d  call   Sys_StrStore
0472  les    di, ptr [bp + 0xa]
0475  push   es
0476  push   di
0477  lea    di, [bp - 0x202]
047b  push   ss
047c  push   di
047d  mov    ax, 0xff
0480  push   ax
0481  call   Sys_StrStore
0486  mov    byte ptr [bp - 1], 0
048a  mov    word ptr [0xcd70], 0xfffd
0490  les    di, ptr [bp + 6]
0493  xor    ax, ax
0495  mov    word ptr es:[di], ax
0498  mov    di, 0xcc22
049b  push   ds
049c  push   di
049d  lea    di, [bp - 0x302]
04a1  push   ss
04a2  push   di
04a3  lea    di, [bp - 0x102]
04a7  push   ss
04a8  push   di
04a9  call   Sys_StrAssign
04ae  lea    di, [bp - 0x202]
04b2  push   ss
04b3  push   di
04b4  call   Sys_StrConcat
04b9  call   Sys_Assign
04be  mov    di, 0xcc22
04c1  push   ds
04c2  push   di
04c3  mov    ax, 1
04c6  push   ax
04c7  call   Sys_ResetFile
04cc  call   Sys_IOResult
04d1  or     ax, ax
04d3  je     0x509
04d5  cmp    byte ptr [bp - 0x102], 0
04da  jne    0x4e0
04dc  jmp    0x53e
04de  db eb,29
  loc_04e0:
04e0  mov    di, 0xcc22
04e3  push   ds
04e4  push   di
04e5  lea    di, [bp - 0x202]
04e9  push   ss
04ea  push   di
04eb  call   Sys_Assign
04f0  mov    di, 0xcc22
04f3  push   ds
04f4  push   di
04f5  mov    ax, 1
04f8  push   ax
04f9  call   Sys_ResetFile
04fe  call   Sys_IOResult
0503  or     ax, ax
0505  je     0x509
0507  jmp    0x53e
  loc_0509:
0509  xor    ax, ax
050b  mov    word ptr [0xcd70], ax
050e  mov    di, 0xcc22
0511  push   ds
0512  push   di
0513  call   Sys_FileSize
0518  les    di, ptr [bp + 6]
051b  mov    word ptr es:[di], ax
051e  les    di, ptr [bp + 6]
0521  cmp    word ptr es:[di], 0x3c00
0526  jbe    0x53a
0528  mov    ax, word ptr [bp + 4]
052b  mov    word ptr [0xcd70], ax
052e  mov    di, 0xcc22
0531  push   ds
0532  push   di
0533  call   Sys_Close
0538  jmp    0x53e
  loc_053a:
053a  mov    byte ptr [bp - 1], 1
  loc_053e:
053e  mov    al, byte ptr [bp - 1]
0541  mov    sp, bp
0543  pop    bp
0544  ret    0xe
0547  db 4,'.BGI'

; ------------------------------------------------------------
sub_0c93_054c:
054c  push   bp
054d  mov    bp, sp
054f  sub    sp, 0x20e
0553  les    di, ptr [bp + 4]
0556  push   es
0557  push   di
0558  lea    di, [bp - 0x102]
055c  push   ss
055d  push   di
055e  mov    ax, 0xff
0561  push   ax
0562  call   Sys_StrStore
0567  mov    byte ptr [bp - 1], 0
056b  lea    di, [bp - 0x20e]
056f  push   ss
0570  push   di
0571  mov    ax, word ptr [bp + 8]
0574  mov    dx, 0x1a
0577  mul    dx
0579  mov    di, ax
057b  add    di, 0x26de
057f  push   ds
0580  push   di
0581  call   Sys_StrAssign
0586  mov    di, 0x547                         ; cs:'.BGI'
0589  push   cs
058a  push   di
058b  call   Sys_StrConcat
0590  mov    di, 0xccae
0593  push   ds
0594  push   di
0595  mov    ax, 0xc
0598  push   ax
0599  call   Sys_StrStore
059e  mov    ax, word ptr [bp + 8]
05a1  mov    dx, 0x1a
05a4  mul    dx
05a6  mov    di, ax
05a8  mov    ax, word ptr [di + 0x26f4]
05ac  or     ax, word ptr [di + 0x26f6]
05b0  je     0x5dd
05b2  mov    ax, word ptr [bp + 8]
05b5  mov    dx, 0x1a
05b8  mul    dx
05ba  mov    di, ax
05bc  les    ax, ptr [di + 0x26f4]
05c0  mov    dx, es
05c2  mov    word ptr [0xcd8a], ax
05c5  mov    word ptr [0xcd8c], dx
05c9  xor    ax, ax
05cb  mov    word ptr [0xcd80], ax
05ce  mov    word ptr [0xcd82], ax
05d1  xor    ax, ax
05d3  mov    word ptr [0xcd84], ax
05d6  mov    byte ptr [bp - 1], 1
05da  jmp    0x6b8
  loc_05dd:
05dd  lea    di, [bp - 0x102]
05e1  push   ss
05e2  push   di
05e3  mov    di, 0xccae
05e6  push   ds
05e7  push   di
05e8  mov    di, 0xcd84
05eb  push   ds
05ec  push   di
05ed  mov    ax, 0xfffc
05f0  push   ax
05f1  call   sub_0c93_0457
05f4  or     al, al
05f6  jne    0x5fb
05f8  jmp    0x6b8
  loc_05fb:
05fb  les    ax, ptr [0x294a]
05ff  mov    dx, es
0601  mov    word ptr [0xcd14], ax
0604  mov    word ptr [0xcd16], dx
0608  mov    ax, 0xa5
060b  mov    dx, 0xc93                         ; seg GRAPH
060e  mov    word ptr [0x294a], ax
0611  mov    word ptr [0x294c], dx
0615  mov    di, 0xcd80
0618  push   ds
0619  push   di
061a  push   word ptr [0xcd84]
061e  lcall  [0xcc1a]
0622  les    ax, ptr [0xcd14]
0626  mov    dx, es
0628  mov    word ptr [0x294a], ax
062b  mov    word ptr [0x294c], dx
062f  mov    ax, word ptr [0xcd80]
0632  or     ax, word ptr [0xcd82]
0636  jne    0x640
0638  mov    word ptr [0xcd70], 0xfffb
063e  jmp    0x6b8
  loc_0640:
0640  mov    di, 0xcc22
0643  push   ds
0644  push   di
0645  les    di, ptr [0xcd80]
0649  push   es
064a  push   di
064b  push   word ptr [0xcd84]
064f  lea    di, [bp - 0x10a]
0653  push   ss
0654  push   di
0655  call   Sys_BlockRead
065a  mov    di, 0xcc22
065d  push   ds
065e  push   di
065f  call   Sys_Close
0664  call   Sys_IOResult
0669  or     ax, ax
066b  jne    0x688
066d  mov    ax, word ptr [bp - 0x10a]
0671  cmp    ax, word ptr [0xcd84]
0675  jne    0x688
0677  push   word ptr [0xcd82]
067b  push   word ptr [0xcd80]
067f  push   cs
0680  call   Graph_RegisterBGIdriver
0683  cmp    ax, word ptr [bp + 8]
0686  je     0x69d
  loc_0688:
0688  mov    word ptr [0xcd70], 0xfffc
068e  mov    di, 0xcd80
0691  push   ds
0692  push   di
0693  push   word ptr [0xcd84]
0697  lcall  [0xcc1e]
069b  jmp    0x6b8
  loc_069d:
069d  mov    ax, word ptr [bp + 8]
06a0  mov    dx, 0x1a
06a3  mul    dx
06a5  mov    di, ax
06a7  les    ax, ptr [di + 0x26f4]
06ab  mov    dx, es
06ad  mov    word ptr [0xcd8a], ax
06b0  mov    word ptr [0xcd8c], dx
06b4  mov    byte ptr [bp - 1], 1
  loc_06b8:
06b8  mov    al, byte ptr [bp - 1]
06bb  mov    sp, bp
06bd  pop    bp
06be  ret    6

; ------------------------------------------------------------
sub_0c93_06c1:
06c1  push   bp
06c2  mov    bp, sp
06c4  sub    sp, 8
06c7  cmp    byte ptr [0xcda6], 0
06cc  jne    0x6d2
06ce  push   cs
06cf  call   sub_0c93_0055
  loc_06d2:
06d2  xor    ax, ax
06d4  push   ax
06d5  xor    ax, ax
06d7  push   ax
06d8  push   word ptr [0xcd1a]
06dc  push   word ptr [0xcd1c]
06e0  mov    al, 1
06e2  push   ax
06e3  push   cs
06e4  call   Graph_SetViewPort
06e7  mov    di, 0xcdd2
06ea  push   ds
06eb  push   di
06ec  push   cs
06ed  call   sub_0c93_0e72
06f0  mov    di, 0xcdd2
06f3  push   ds
06f4  push   di
06f5  push   cs
06f6  call   sub_0c93_0dca
06f9  push   cs
06fa  call   sub_0c93_168d
06fd  cmp    ax, 1
0700  je     0x709
0702  xor    ax, ax
0704  push   ax
0705  push   cs
0706  call   sub_0c93_0d93
  loc_0709:
0709  mov    byte ptr [0xcd98], 0              ; cs:'BGI Error: Graphics not initialized (use InitGraph)'
070e  push   cs
070f  call   Graph_GetMaxColor
0712  push   ax
0713  push   cs
0714  call   Graph_SetColor
0717  lea    di, [bp - 8]
071a  push   ss
071b  push   di
071c  mov    ax, 8
071f  push   ax
0720  mov    al, 0xff
0722  push   ax
0723  call   Sys_FillChar
0728  lea    di, [bp - 8]
072b  push   ss
072c  push   di
072d  push   cs
072e  call   Graph_GetMaxColor
0731  push   ax
0732  push   cs
0733  call   sub_0c93_0d38
0736  mov    ax, 1
0739  push   ax
073a  push   cs
073b  call   Graph_GetMaxColor
073e  push   ax
073f  push   cs
0740  call   sub_0c93_0d0b
0743  xor    ax, ax
0745  push   ax
0746  xor    ax, ax
0748  push   ax
0749  mov    ax, 1
074c  push   ax
074d  push   cs
074e  call   sub_0c93_0c86
0751  xor    ax, ax
0753  push   ax
0754  xor    ax, ax
0756  push   ax
0757  mov    ax, 1
075a  push   ax
075b  push   cs
075c  call   sub_0c93_0f92
075f  xor    ax, ax
0761  push   ax
0762  mov    ax, 2
0765  push   ax
0766  push   cs
0767  call   sub_0c93_0f4e
076a  xor    ax, ax
076c  push   ax
076d  push   cs
076e  call   sub_0c93_138b
0771  xor    ax, ax
0773  push   ax
0774  xor    ax, ax
0776  push   ax
0777  push   cs
0778  call   sub_0c93_0c67
077b  mov    sp, bp
077d  pop    bp
077e  retf
077f  db 1,'\'

; ------------------------------------------------------------
Graph_InitGraph:
0781  push   bp
0782  mov    bp, sp
0784  sub    sp, 0x208
0788  les    di, ptr [bp + 6]
078b  push   es
078c  push   di
078d  lea    di, [bp - 0x100]
0791  push   ss
0792  push   di
0793  mov    ax, 0xff
0796  push   ax
0797  call   Sys_StrStore
079c  mov    ax, 0x1aa6
079f  mov    dx, 0xc93                         ; seg GRAPH
07a2  mov    word ptr [0xcd78], ax
07a5  mov    word ptr [0xcd7a], dx
07a9  push   word ptr [0xcd7a]
07ad  push   word ptr [0xcd78]
07b1  les    di, ptr [0xcd78]
07b5  push   es
07b6  push   di
07b7  les    di, ptr [0xcd78]
07bb  add    di, 2
07bf  push   es
07c0  push   di
07c1  call   sub_0c93_00fd
07c4  mov    word ptr [0xcd78], ax
07c7  mov    word ptr [0xcd7a], dx
07cb  mov    byte ptr [bp - 0x107], 0
07d0  les    di, ptr [bp + 0xe]
07d3  cmp    word ptr es:[di], 0
07d7  je     0x7dc
07d9  jmp    0x85b
  loc_07dc:
07dc  xor    ax, ax
07de  mov    word ptr [bp - 0x104], ax
07e2  mov    word ptr [bp - 0x106], 0xffff
  loc_07e8:
07e8  mov    ax, word ptr [bp - 0x104]
07ec  cmp    ax, word ptr [0xcd10]
07f0  jge    0x85b
07f2  cmp    word ptr [bp - 0x106], 0
07f7  jge    0x85b
07f9  mov    ax, word ptr [bp - 0x104]
07fd  mov    dx, 0x1a
0800  mul    dx
0802  mov    di, ax
0804  mov    ax, word ptr [di + 0x26f0]
0808  or     ax, word ptr [di + 0x26f2]
080c  je     0x855
080e  mov    ax, word ptr [bp - 0x104]
0812  mov    dx, 0x1a
0815  mul    dx
0817  mov    di, ax
0819  les    ax, ptr [di + 0x26f0]
081d  mov    dx, es
081f  mov    word ptr [0xcdee], ax
0822  mov    word ptr [0xcdf0], dx
0826  lcall  [0xcdee]
082a  mov    word ptr [bp - 0x106], ax
082e  cmp    word ptr [bp - 0x106], 0
0833  jl     0x855
0835  mov    ax, word ptr [bp - 0x104]
0839  mov    word ptr [0xcd6c], ax
083c  mov    ax, word ptr [bp - 0x104]
0840  les    di, ptr [bp + 0xe]
0843  mov    word ptr es:[di], ax
0846  mov    ax, word ptr [bp - 0x106]
084a  les    di, ptr [bp + 0xa]
084d  mov    word ptr es:[di], ax
0850  mov    byte ptr [bp - 0x107], 1
  loc_0855:
0855  inc    word ptr [bp - 0x104]
0859  jmp    0x7e8
  loc_085b:
085b  cmp    byte ptr [bp - 0x107], 0
0860  jne    0x877
0862  mov    di, 0xcd6c
0865  push   ds
0866  push   di
0867  les    di, ptr [bp + 0xe]
086a  push   es
086b  push   di
086c  les    di, ptr [bp + 0xa]
086f  push   es
0870  push   di
0871  push   cs
0872  call   sub_0c93_142d
0875  jmp    0x8a0
  loc_0877:
0877  mov    ax, word ptr [0xcd6c]
087a  mov    word ptr [bp - 0x104], ax
087e  les    di, ptr [bp + 0xe]
0881  mov    ax, word ptr es:[di]
0884  add    ax, 0x80
0887  mov    word ptr [bp - 0x106], ax
088b  lea    di, [bp - 0x104]
088f  push   ss
0890  push   di
0891  lea    di, [bp - 0x106]
0895  push   ss
0896  push   di
0897  les    di, ptr [bp + 0xa]
089a  push   es
089b  push   di
089c  push   cs
089d  call   sub_0c93_142d
  loc_08a0:
08a0  les    di, ptr [bp + 0xe]
08a3  cmp    word ptr es:[di], 0
08a7  jge    0x8bd
08a9  mov    word ptr [0xcd70], 0xfffe
08af  les    di, ptr [bp + 0xe]
08b2  mov    word ptr es:[di], 0xfffe
08b7  call   sub_0c93_03e1
08ba  jmp    0xa57
  loc_08bd:
08bd  les    di, ptr [bp + 0xa]
08c0  mov    ax, word ptr es:[di]
08c3  mov    word ptr [0xcd6e], ax
08c6  lea    di, [bp - 0x100]
08ca  push   ss
08cb  push   di
08cc  mov    di, 0xccbc
08cf  push   ds
08d0  push   di
08d1  mov    ax, 0x50
08d4  push   ax
08d5  call   Sys_StrStore
08da  cmp    byte ptr [0xccbc], 0
08df  je     0x927
08e1  mov    al, byte ptr [0xccbc]
08e4  xor    ah, ah
08e6  mov    di, ax
08e8  mov    al, byte ptr [di - 0x3344]
08ec  mov    byte ptr [bp - 0x101], al
08f0  cmp    byte ptr [bp - 0x101], 0x3a
08f5  je     0x927
08f7  cmp    byte ptr [bp - 0x101], 0x5c
08fc  je     0x927
08fe  lea    di, [bp - 0x208]
0902  push   ss
0903  push   di
0904  lea    di, [bp - 0x100]
0908  push   ss
0909  push   di
090a  call   Sys_StrAssign
090f  mov    di, 0x77f                         ; cs:'\'
0912  push   cs
0913  push   di
0914  call   Sys_StrConcat
0919  mov    di, 0xccbc
091c  push   ds
091d  push   di
091e  mov    ax, 0x50
0921  push   ax
0922  call   Sys_StrStore
  loc_0927:
0927  push   word ptr [0xcd6c]
092b  mov    di, 0xccbc
092e  push   ds
092f  push   di
0930  call   sub_0c93_054c
0933  or     al, al
0935  jne    0x946
0937  mov    ax, word ptr [0xcd70]
093a  les    di, ptr [bp + 0xe]
093d  mov    word ptr es:[di], ax
0940  call   sub_0c93_03e1
0943  jmp    0xa57
  loc_0946:
0946  mov    di, 0xcd2c
0949  push   ds
094a  push   di
094b  mov    ax, 0x3f
094e  push   ax
094f  mov    al, 0
0951  push   ax
0952  call   Sys_FillChar
0957  les    ax, ptr [0x294a]
095b  mov    dx, es
095d  mov    word ptr [0xcd14], ax
0960  mov    word ptr [0xcd16], dx
0964  mov    ax, 0xa5
0967  mov    dx, 0xc93                         ; seg GRAPH
096a  mov    word ptr [0x294a], ax
096d  mov    word ptr [0x294c], dx
0971  mov    di, 0xcd38
0974  push   ds
0975  push   di
0976  push   word ptr [0xcd0e]
097a  lcall  [0xcc1a]
097e  les    ax, ptr [0xcd14]
0982  mov    dx, es
0984  mov    word ptr [0x294a], ax
0987  mov    word ptr [0x294c], dx
098b  mov    ax, word ptr [0xcd38]
098e  or     ax, word ptr [0xcd3a]
0992  jne    0x9b5
0994  mov    word ptr [0xcd70], 0xfffb
099a  les    di, ptr [bp + 0xe]
099d  mov    word ptr es:[di], 0xfffb
09a2  mov    di, 0xcd80
09a5  push   ds
09a6  push   di
09a7  push   word ptr [0xcd84]
09ab  lcall  [0xcc1e]
09af  call   sub_0c93_03e1
09b2  jmp    0xa57
  loc_09b5:
09b5  mov    byte ptr [0xcd2d], 0
09ba  mov    byte ptr [0xcd42], 0
09bf  les    ax, ptr [0xcd38]
09c3  mov    dx, es
09c5  mov    word ptr [0xcd86], ax
09c8  mov    word ptr [0xcd88], dx
09cc  mov    ax, word ptr [0xcd0e]
09cf  mov    word ptr [0xcd3c], ax
09d2  les    ax, ptr [0xcd38]
09d6  mov    dx, es
09d8  mov    word ptr [0xcd52], ax
09db  mov    word ptr [0xcd54], dx
09df  mov    ax, word ptr [0xcd0e]
09e2  mov    word ptr [0xcd56], ax
09e5  mov    ax, 0xcd70
09e8  mov    dx, ds
09ea  mov    word ptr [0xcd46], ax
09ed  mov    word ptr [0xcd48], dx
09f1  mov    ax, 0xcd2c
09f4  mov    dx, ds
09f6  push   dx
09f7  push   ax
09f8  push   cs
09f9  call   sub_0c93_1290
09fc  mov    ax, word ptr [0xcd92]
09ff  mov    dx, word ptr [0xcd94]
0a03  mov    di, ax
0a05  mov    es, dx
0a07  push   es
0a08  push   di
0a09  mov    di, 0xcd18
0a0c  push   ds
0a0d  push   di
0a0e  mov    ax, 0x13
0a11  push   ax
0a12  call   Sys_Move
0a17  mov    ax, 0xcd2c
0a1a  mov    dx, ds
0a1c  push   dx
0a1d  push   ax
0a1e  push   cs
0a1f  call   sub_0c93_14db
0a22  cmp    byte ptr [0xcd18], 0
0a27  je     0xa36
0a29  mov    al, byte ptr [0xcd18]
0a2c  xor    ah, ah
0a2e  mov    word ptr [0xcd70], ax
0a31  call   sub_0c93_03e1
0a34  jmp    0xa57
  loc_0a36:
0a36  push   cs
0a37  call   sub_0c93_16c6
0a3a  mov    word ptr [0xcda0], ax
0a3d  mov    ax, word ptr [0xcd26]
0a40  mov    word ptr [0xcda2], ax
0a43  mov    word ptr [0xcda4], 0x2710
0a49  mov    byte ptr [0xcda6], 1              ; cs:'GI Error: Graphics not initialized (use InitGraph) BGI Error:  Not'
0a4e  push   cs
0a4f  call   sub_0c93_06c1
0a52  xor    ax, ax
0a54  mov    word ptr [0xcd70], ax
  loc_0a57:
0a57  mov    sp, bp
0a59  pop    bp
0a5a  retf   0xc

; ------------------------------------------------------------
sub_0c93_0a5d:
0a5d  push   bp
0a5e  mov    bp, sp
0a60  push   cs
0a61  call   sub_0c93_131f
0a64  mov    ax, word ptr [0xcd7c]
0a67  or     ax, word ptr [0xcd7e]
0a6b  jne    0xa87
0a6d  les    ax, ptr [0xcd78]
0a71  mov    dx, es
0a73  mov    word ptr [0xcd7c], ax
0a76  mov    word ptr [0xcd7e], dx
0a7a  mov    ax, 0x55
0a7d  mov    dx, 0xc93                         ; seg GRAPH
0a80  mov    word ptr [0xcd78], ax
0a83  mov    word ptr [0xcd7a], dx
  loc_0a87:
0a87  mov    sp, bp
0a89  pop    bp
0a8a  retf

; ------------------------------------------------------------
Graph_CloseGraph:
0a8b  push   bp
0a8c  mov    bp, sp
0a8e  sub    sp, 6
0a91  cmp    byte ptr [0xcda6], 0
0a96  jne    0xaa1
0a98  mov    word ptr [0xcd70], 0xffff
0a9e  jmp    0xb55
  loc_0aa1:
0aa1  push   cs
0aa2  call   sub_0c93_0a5d
0aa5  mov    di, 0xcd86
0aa8  push   ds
0aa9  push   di
0aaa  push   word ptr [0xcd0e]
0aae  lcall  [0xcc1e]
0ab2  mov    ax, word ptr [0xcd80]
0ab5  or     ax, word ptr [0xcd82]
0ab9  je     0xacf
0abb  mov    ax, word ptr [0xcd6c]
0abe  mov    dx, 0x1a
0ac1  mul    dx
0ac3  mov    di, ax
0ac5  xor    ax, ax
0ac7  mov    word ptr [di + 0x26f4], ax
0acb  mov    word ptr [di + 0x26f6], ax
  loc_0acf:
0acf  mov    di, 0xcd80
0ad2  push   ds
0ad3  push   di
0ad4  push   word ptr [0xcd84]
0ad8  lcall  [0xcc1e]
0adc  call   sub_0c93_03e1
0adf  mov    word ptr [bp - 2], 1
0ae4  jmp    0xae9
  loc_0ae6:
0ae6  inc    word ptr [bp - 2]
  loc_0ae9:
0ae9  mov    ax, word ptr [bp - 2]
0aec  mov    dx, 0xf
0aef  mul    dx
0af1  mov    di, ax
0af3  add    di, 0x27ed
0af7  mov    word ptr [bp - 6], di
0afa  mov    word ptr [bp - 4], ds
0afd  les    di, ptr [bp - 6]
0b00  cmp    byte ptr es:[di + 0xa], 0
0b05  je     0xb4f
0b07  les    di, ptr [bp - 6]
0b0a  cmp    word ptr es:[di + 8], 0
0b0f  je     0xb4f
0b11  les    di, ptr [bp - 6]
0b14  mov    ax, word ptr es:[di]
0b17  or     ax, word ptr es:[di + 2]
0b1b  je     0xb4f
0b1d  les    di, ptr [bp - 6]
0b20  push   es
0b21  push   di
0b22  les    di, ptr [bp - 6]
0b25  push   word ptr es:[di + 8]
0b29  lcall  [0xcc1e]
0b2d  les    di, ptr [bp - 6]
0b30  xor    ax, ax
0b32  mov    word ptr es:[di + 8], ax
0b36  les    di, ptr [bp - 6]
0b39  xor    ax, ax
0b3b  mov    word ptr es:[di], ax
0b3e  mov    word ptr es:[di + 2], ax
0b42  les    di, ptr [bp - 6]
0b45  xor    ax, ax
0b47  mov    word ptr es:[di + 4], ax
0b4b  mov    word ptr es:[di + 6], ax
  loc_0b4f:
0b4f  cmp    word ptr [bp - 2], 0x14
0b53  jne    0xae6
  loc_0b55:
0b55  mov    sp, bp
0b57  pop    bp
0b58  retf

; ------------------------------------------------------------
Graph_ClearDevice:
0b59  push   bp
0b5a  mov    bp, sp
0b5c  push   cs
0b5d  call   sub_0c93_14f7
0b60  xor    ax, ax
0b62  push   ax
0b63  xor    ax, ax
0b65  push   ax
0b66  push   cs
0b67  call   sub_0c93_0c67
0b6a  mov    sp, bp
0b6c  pop    bp
0b6d  retf

; ------------------------------------------------------------
Graph_SetViewPort:
0b6e  push   bp
0b6f  mov    bp, sp
0b71  cmp    word ptr [bp + 0xe], 0
0b75  jl     0xbbb
0b77  cmp    word ptr [bp + 0xc], 0
0b7b  jl     0xbbb
0b7d  mov    ax, word ptr [0xcd1a]
0b80  xor    dx, dx
0b82  mov    cx, ax
0b84  mov    bx, dx
0b86  mov    ax, word ptr [bp + 0xa]
0b89  cdq
0b8a  cmp    dx, bx
0b8c  jg     0xbbb
0b8e  jl     0xb94
0b90  cmp    ax, cx
0b92  ja     0xbbb
  loc_0b94:
0b94  mov    ax, word ptr [0xcd1c]
0b97  xor    dx, dx
0b99  mov    cx, ax
0b9b  mov    bx, dx
0b9d  mov    ax, word ptr [bp + 8]
0ba0  cdq
0ba1  cmp    dx, bx
0ba3  jg     0xbbb
0ba5  jl     0xbab
0ba7  cmp    ax, cx
0ba9  ja     0xbbb
  loc_0bab:
0bab  mov    ax, word ptr [bp + 0xa]
0bae  cmp    ax, word ptr [bp + 0xe]
0bb1  jl     0xbbb
0bb3  mov    ax, word ptr [bp + 8]
0bb6  cmp    ax, word ptr [bp + 0xc]
0bb9  jge    0xbc3
  loc_0bbb:
0bbb  mov    word ptr [0xcd70], 0xfff5
0bc1  jmp    0xbff
  loc_0bc3:
0bc3  mov    ax, word ptr [bp + 0xe]
0bc6  mov    word ptr [0xcdaa], ax
0bc9  mov    ax, word ptr [bp + 0xc]
0bcc  mov    word ptr [0xcdac], ax
0bcf  mov    ax, word ptr [bp + 0xa]
0bd2  mov    word ptr [0xcdae], ax
0bd5  mov    ax, word ptr [bp + 8]
0bd8  mov    word ptr [0xcdb0], ax
0bdb  mov    al, byte ptr [bp + 6]
0bde  mov    byte ptr [0xcdb2], al
0be1  push   word ptr [bp + 0xe]
0be4  push   word ptr [bp + 0xc]
0be7  push   word ptr [bp + 0xa]
0bea  push   word ptr [bp + 8]
0bed  mov    al, byte ptr [bp + 6]
0bf0  push   ax
0bf1  push   cs
0bf2  call   sub_0c93_12d0
0bf5  xor    ax, ax
0bf7  push   ax
0bf8  xor    ax, ax
0bfa  push   ax
0bfb  push   cs
0bfc  call   sub_0c93_0c67
  loc_0bff:
0bff  mov    sp, bp
0c01  pop    bp
0c02  retf   0xa

; ------------------------------------------------------------
Graph_ClearViewPort:
0c05  push   bp
0c06  mov    bp, sp
0c08  sub    sp, 4
0c0b  les    ax, ptr [0xcdba]
0c0f  mov    dx, es
0c11  mov    word ptr [bp - 4], ax
0c14  mov    word ptr [bp - 2], dx
0c17  xor    ax, ax
0c19  push   ax
0c1a  xor    ax, ax
0c1c  push   ax
0c1d  push   cs
0c1e  call   sub_0c93_0d0b
0c21  xor    ax, ax
0c23  push   ax
0c24  xor    ax, ax
0c26  push   ax
0c27  mov    ax, word ptr [0xcdae]
0c2a  sub    ax, word ptr [0xcdaa]
0c2e  push   ax
0c2f  mov    ax, word ptr [0xcdb0]
0c32  sub    ax, word ptr [0xcdac]
0c36  push   ax
0c37  push   cs
0c38  call   Graph_Bar
0c3b  cmp    word ptr [bp - 4], 0xc
0c3f  jne    0xc4f
0c41  mov    di, 0xcdbe
0c44  push   ds
0c45  push   di
0c46  push   word ptr [bp - 2]
0c49  push   cs
0c4a  call   sub_0c93_0d38
0c4d  jmp    0xc59
  loc_0c4f:
0c4f  push   word ptr [bp - 4]
0c52  push   word ptr [bp - 2]
0c55  push   cs
0c56  call   sub_0c93_0d0b
  loc_0c59:
0c59  xor    ax, ax
0c5b  push   ax
0c5c  xor    ax, ax
0c5e  push   ax
0c5f  push   cs
0c60  call   sub_0c93_0c67
0c63  mov    sp, bp
0c65  pop    bp
0c66  retf

; ------------------------------------------------------------
sub_0c93_0c67:
0c67  push   bp
0c68  mov    bp, sp
0c6a  push   word ptr [bp + 8]
0c6d  push   word ptr [bp + 6]
0c70  push   cs
0c71  call   sub_0c93_1503
0c74  mov    ax, word ptr [bp + 8]
0c77  mov    word ptr [0xcd9c], ax
0c7a  mov    ax, word ptr [bp + 6]
0c7d  mov    word ptr [0xcd9e], ax
0c80  mov    sp, bp
0c82  pop    bp
0c83  retf   4

; ------------------------------------------------------------
sub_0c93_0c86:
0c86  push   bp
0c87  mov    bp, sp
0c89  cmp    word ptr [bp + 0xa], 4
0c8d  ja     0xc95
0c8f  cmp    word ptr [bp + 6], 3
0c93  jbe    0xc9d
  loc_0c95:
0c95  mov    word ptr [0xcd70], 0xfff5
0c9b  jmp    0xcbc
  loc_0c9d:
0c9d  mov    ax, word ptr [bp + 0xa]
0ca0  mov    word ptr [0xcdb4], ax
0ca3  mov    ax, word ptr [bp + 8]
0ca6  mov    word ptr [0xcdb6], ax
0ca9  mov    ax, word ptr [bp + 6]
0cac  mov    word ptr [0xcdb8], ax
0caf  push   word ptr [bp + 0xa]
0cb2  push   word ptr [bp + 8]
0cb5  push   word ptr [bp + 6]
0cb8  push   cs
0cb9  call   sub_0c93_1732
  loc_0cbc:
0cbc  mov    sp, bp
0cbe  pop    bp
0cbf  retf   6

; ------------------------------------------------------------
Graph_Rectangle:
0cc2  push   bp
0cc3  mov    bp, sp
0cc5  push   word ptr [bp + 0xc]
0cc8  push   word ptr [bp + 0xa]
0ccb  push   word ptr [bp + 8]
0cce  push   word ptr [bp + 0xa]
0cd1  push   cs
0cd2  call   Graph_Line
0cd5  push   word ptr [bp + 8]
0cd8  push   word ptr [bp + 0xa]
0cdb  push   word ptr [bp + 8]
0cde  push   word ptr [bp + 6]
0ce1  push   cs
0ce2  call   Graph_Line
0ce5  push   word ptr [bp + 8]
0ce8  push   word ptr [bp + 6]
0ceb  push   word ptr [bp + 0xc]
0cee  push   word ptr [bp + 6]
0cf1  push   cs
0cf2  call   Graph_Line
0cf5  push   word ptr [bp + 0xc]
0cf8  push   word ptr [bp + 6]
0cfb  push   word ptr [bp + 0xc]
0cfe  push   word ptr [bp + 0xa]
0d01  push   cs
0d02  call   Graph_Line
0d05  mov    sp, bp
0d07  pop    bp
0d08  retf   8

; ------------------------------------------------------------
sub_0c93_0d0b:
0d0b  push   bp
0d0c  mov    bp, sp
0d0e  cmp    word ptr [bp + 8], 0xb
0d12  jbe    0xd1c
0d14  mov    word ptr [0xcd70], 0xfff5
0d1a  jmp    0xd32
  loc_0d1c:
0d1c  mov    ax, word ptr [bp + 8]
0d1f  mov    word ptr [0xcdba], ax
0d22  mov    ax, word ptr [bp + 6]
0d25  mov    word ptr [0xcdbc], ax
0d28  push   word ptr [bp + 8]
0d2b  push   word ptr [bp + 6]
0d2e  push   cs
0d2f  call   sub_0c93_178e
  loc_0d32:
0d32  mov    sp, bp
0d34  pop    bp
0d35  retf   4

; ------------------------------------------------------------
sub_0c93_0d38:
0d38  push   bp
0d39  mov    bp, sp
0d3b  sub    sp, 8
0d3e  les    di, ptr [bp + 8]
0d41  push   es
0d42  push   di
0d43  lea    di, [bp - 8]
0d46  push   ss
0d47  push   di
0d48  mov    ax, 8
0d4b  push   ax
0d4c  call   Sys_MoveFwd
0d51  push   cs
0d52  call   Graph_GetMaxColor
0d55  cmp    ax, word ptr [bp + 6]
0d58  jae    0xd62
0d5a  mov    word ptr [0xcd70], 0xfff5
0d60  jmp    0xd8d
  loc_0d62:
0d62  mov    word ptr [0xcdba], 0xc
0d68  mov    ax, word ptr [bp + 6]
0d6b  mov    word ptr [0xcdbc], ax
0d6e  lea    di, [bp - 8]
0d71  push   ss
0d72  push   di
0d73  mov    di, 0xcdbe
0d76  push   ds
0d77  push   di
0d78  mov    ax, 8
0d7b  push   ax
0d7c  call   Sys_MoveFwd
0d81  lea    di, [bp - 8]
0d84  push   ss
0d85  push   di
0d86  push   word ptr [bp + 6]
0d89  push   cs
0d8a  call   sub_0c93_13a5
  loc_0d8d:
0d8d  mov    sp, bp
0d8f  pop    bp
0d90  retf   6

; ------------------------------------------------------------
sub_0c93_0d93:
0d93  push   bp
0d94  mov    bp, sp
0d96  cmp    word ptr [bp + 6], 0xf
0d9a  jbe    0xd9e
0d9c  jmp    0xdc4
  loc_0d9e:
0d9e  mov    al, byte ptr [bp + 6]
0da1  mov    byte ptr [0xcd98], al
0da4  cmp    word ptr [bp + 6], 0
0da8  jne    0xdb1
0daa  mov    byte ptr [0xcdd3], 0
0daf  jmp    0xdbb
  loc_0db1:
0db1  mov    di, word ptr [bp + 6]
0db4  mov    al, byte ptr [di - 0x322d]
0db8  mov    byte ptr [0xcdd3], al
  loc_0dbb:
0dbb  mov    al, byte ptr [0xcdd3]
0dbe  cwde
0dbf  push   ax
0dc0  push   cs
0dc1  call   sub_0c93_16d7
  loc_0dc4:
0dc4  mov    sp, bp
0dc6  pop    bp
0dc7  retf   2

; ------------------------------------------------------------
sub_0c93_0dca:
0dca  push   bp
0dcb  mov    bp, sp
0dcd  sub    sp, 0x1c
0dd0  cmp    byte ptr [0xcda6], 0
0dd5  jne    0xdda
0dd7  jmp    0xe6c
  loc_0dda:
0dda  les    di, ptr [bp + 6]
0ddd  mov    word ptr [bp - 0x1a], di
0de0  mov    word ptr [bp - 0x18], es
0de3  les    di, ptr [bp - 0x1a]
0de6  cmp    byte ptr es:[di], 0x10
0dea  jbe    0xdf2
0dec  mov    byte ptr [bp - 3], 0x10
0df0  jmp    0xdfb
  loc_0df2:
0df2  les    di, ptr [bp - 0x1a]
0df5  mov    al, byte ptr es:[di]
0df8  mov    byte ptr [bp - 3], al
  loc_0dfb:
0dfb  mov    al, byte ptr [bp - 3]
0dfe  xor    ah, ah
0e00  dec    ax
0e01  mov    word ptr [bp - 0x1c], ax
0e04  xor    ax, ax
0e06  cmp    ax, word ptr [bp - 0x1c]
0e09  jg     0xe3d
0e0b  mov    word ptr [bp - 2], ax
0e0e  jmp    0xe13
  loc_0e10:
0e10  inc    word ptr [bp - 2]
  loc_0e13:
0e13  mov    ax, word ptr [bp - 2]
0e16  les    di, ptr [bp - 0x1a]
0e19  add    di, ax
0e1b  cmp    byte ptr es:[di + 1], 0xff
0e20  jle    0xe35
0e22  mov    ax, word ptr [bp - 2]
0e25  les    di, ptr [bp - 0x1a]
0e28  add    di, ax
0e2a  mov    al, byte ptr es:[di + 1]
0e2e  mov    di, word ptr [bp - 2]
0e31  mov    byte ptr [di - 0x322d], al
  loc_0e35:
0e35  mov    ax, word ptr [bp - 2]
0e38  cmp    ax, word ptr [bp - 0x1c]
0e3b  jne    0xe10
  loc_0e3d:
0e3d  les    di, ptr [bp - 0x1a]
0e40  cmp    byte ptr es:[di + 1], 0xff
0e45  je     0xe4c
0e47  mov    byte ptr [0xcd98], 0
  loc_0e4c:
0e4c  mov    di, 0xcdd2
0e4f  push   ds
0e50  push   di
0e51  lea    di, [bp - 0x16]
0e54  push   ss
0e55  push   di
0e56  mov    ax, 0x11
0e59  push   ax
0e5a  call   Sys_Move
0e5f  mov    byte ptr [bp - 5], 0
0e63  lea    di, [bp - 0x16]
0e66  push   ss
0e67  push   di
0e68  push   cs
0e69  call   sub_0c93_1720
  loc_0e6c:
0e6c  mov    sp, bp
0e6e  pop    bp
0e6f  retf   4

; ------------------------------------------------------------
sub_0c93_0e72:
0e72  push   bp
0e73  mov    bp, sp
0e75  push   cs
0e76  call   sub_0c93_169d
0e79  mov    di, ax
0e7b  mov    es, dx
0e7d  push   es
0e7e  push   di
0e7f  les    di, ptr [bp + 6]
0e82  push   es
0e83  push   di
0e84  mov    ax, 0x11
0e87  push   ax
0e88  call   Sys_MoveFwd
0e8d  mov    sp, bp
0e8f  pop    bp
0e90  retf   4

; ------------------------------------------------------------
Graph_PutImage:
0e93  push   bp
0e94  mov    bp, sp
0e96  sub    sp, 2
0e99  les    di, ptr [bp + 8]
0e9c  mov    ax, word ptr es:[di + 2]
0ea0  mov    word ptr [bp - 2], ax
0ea3  mov    ax, word ptr [bp + 0xc]
0ea6  add    ax, word ptr [0xcdac]
0eaa  cdq
0eab  mov    cx, ax
0ead  mov    bx, dx
0eaf  mov    ax, word ptr [0xcd1c]
0eb2  xor    dx, dx
0eb4  sub    ax, cx
0eb6  sbb    dx, bx
0eb8  les    di, ptr [bp + 8]
0ebb  mov    word ptr es:[di + 2], ax
0ebf  les    di, ptr [bp + 8]
0ec2  mov    ax, word ptr es:[di + 2]
0ec6  cmp    ax, word ptr [bp - 2]
0ec9  jbe    0xed5
0ecb  mov    ax, word ptr [bp - 2]
0ece  les    di, ptr [bp + 8]
0ed1  mov    word ptr es:[di + 2], ax
  loc_0ed5:
0ed5  les    di, ptr [bp + 8]
0ed8  mov    ax, word ptr es:[di]
0edb  xor    dx, dx
0edd  mov    cx, ax
0edf  mov    bx, dx
0ee1  mov    ax, word ptr [bp + 0xe]
0ee4  add    ax, word ptr [0xcdaa]
0ee8  cdq
0ee9  add    ax, cx
0eeb  adc    dx, bx
0eed  mov    cx, ax
0eef  mov    bx, dx
0ef1  mov    ax, word ptr [0xcd1a]
0ef4  xor    dx, dx
0ef6  cmp    dx, bx
0ef8  jl     0xf20
0efa  jg     0xf00
0efc  cmp    ax, cx
0efe  jb     0xf20
  loc_0f00:
0f00  mov    ax, word ptr [bp + 0xe]
0f03  add    ax, word ptr [0xcdaa]
0f07  or     ax, ax
0f09  jl     0xf20
0f0b  les    di, ptr [bp + 8]
0f0e  cmp    word ptr es:[di + 2], 0
0f13  jb     0xf20
0f15  mov    ax, word ptr [bp + 0xc]
0f18  add    ax, word ptr [0xcdac]
0f1c  or     ax, ax
0f1e  jge    0xf2c
  loc_0f20:
0f20  mov    ax, word ptr [bp - 2]
0f23  les    di, ptr [bp + 8]
0f26  mov    word ptr es:[di + 2], ax
0f2a  jmp    0xf48
  loc_0f2c:
0f2c  push   word ptr [bp + 0xe]
0f2f  push   word ptr [bp + 0xc]
0f32  les    di, ptr [bp + 8]
0f35  push   es
0f36  push   di
0f37  push   word ptr [bp + 6]
0f3a  push   cs
0f3b  call   sub_0c93_18d2
0f3e  mov    ax, word ptr [bp - 2]
0f41  les    di, ptr [bp + 8]
0f44  mov    word ptr es:[di + 2], ax
  loc_0f48:
0f48  mov    sp, bp
0f4a  pop    bp
0f4b  retf   0xa

; ------------------------------------------------------------
sub_0c93_0f4e:
0f4e  push   bp
0f4f  mov    bp, sp
0f51  cmp    word ptr [bp + 8], 0
0f55  jb     0xf69
0f57  cmp    word ptr [bp + 8], 2
0f5b  ja     0xf69
0f5d  cmp    word ptr [bp + 6], 0
0f61  jb     0xf69
0f63  cmp    word ptr [bp + 6], 2
0f67  jbe    0xf71
  loc_0f69:
0f69  mov    word ptr [0xcd70], 0xfff5
0f6f  jmp    0xf87
  loc_0f71:
0f71  mov    ax, word ptr [bp + 8]
0f74  mov    word ptr [0xcdea], ax
0f77  mov    ax, word ptr [bp + 6]
0f7a  mov    word ptr [0xcdec], ax
0f7d  push   word ptr [bp + 8]
0f80  push   word ptr [bp + 6]
0f83  push   cs
0f84  call   sub_0c93_13cf
  loc_0f87:
0f87  mov    sp, bp
0f89  pop    bp
0f8a  retf   4
0f8d  db 4,'.CHR'

; ------------------------------------------------------------
sub_0c93_0f92:
0f92  push   bp
0f93  mov    bp, sp
0f95  sub    sp, 0x10a
0f99  cmp    word ptr [bp + 0xa], 0x14
0f9d  ja     0xfbc
0f9f  cmp    word ptr [bp + 0xa], 0
0fa3  jb     0xfbc
0fa5  cmp    word ptr [bp + 0xa], 0
0fa9  je     0xfcf
0fab  mov    ax, word ptr [bp + 0xa]
0fae  mov    dx, 0xf
0fb1  mul    dx
0fb3  mov    di, ax
0fb5  cmp    byte ptr [di + 0x27f7], 0
0fba  jne    0xfcf
  loc_0fbc:
0fbc  mov    word ptr [0xcd70], 0xfff2
0fc2  xor    ax, ax
0fc4  mov    word ptr [bp + 0xa], ax
0fc7  mov    word ptr [bp + 6], 1
0fcc  jmp    0x11bc
  loc_0fcf:
0fcf  cmp    word ptr [bp + 0xa], 0
0fd3  jne    0xfd8
0fd5  jmp    0x11bc
  loc_0fd8:
0fd8  mov    ax, word ptr [bp + 0xa]
0fdb  cmp    ax, word ptr [0xcde4]
0fdf  jne    0xfe4
0fe1  jmp    0x11bc
  loc_0fe4:
0fe4  mov    ax, word ptr [bp + 0xa]
0fe7  cmp    ax, word ptr [0xcca2]
0feb  jne    0xff0
0fed  jmp    0x11a5
  loc_0ff0:
0ff0  cmp    word ptr [0xcca2], 0
0ff5  je     0x1047
0ff7  mov    ax, word ptr [0xcca2]
0ffa  mov    dx, 0xf
0ffd  mul    dx
0fff  mov    di, ax
1001  add    di, 0x27ed
1005  mov    word ptr [bp - 0xa], di
1008  mov    word ptr [bp - 8], ds
100b  les    di, ptr [bp - 0xa]
100e  cmp    word ptr es:[di + 8], 0
1013  je     0x1047
1015  les    di, ptr [bp - 0xa]
1018  push   es
1019  push   di
101a  les    di, ptr [bp - 0xa]
101d  push   word ptr es:[di + 8]
1021  lcall  [0xcc1e]
1025  les    di, ptr [bp - 0xa]
1028  xor    ax, ax
102a  mov    word ptr es:[di], ax
102d  mov    word ptr es:[di + 2], ax
1031  les    di, ptr [bp - 0xa]
1034  xor    ax, ax
1036  mov    word ptr es:[di + 4], ax
103a  mov    word ptr es:[di + 6], ax
103e  les    di, ptr [bp - 0xa]
1041  xor    ax, ax
1043  mov    word ptr es:[di + 8], ax
  loc_1047:
1047  mov    ax, word ptr [bp + 0xa]
104a  mov    dx, 0xf
104d  mul    dx
104f  mov    di, ax
1051  add    di, 0x27ed
1055  mov    word ptr [bp - 0xa], di
1058  mov    word ptr [bp - 8], ds
105b  les    di, ptr [bp - 0xa]
105e  mov    ax, word ptr es:[di + 4]
1062  or     ax, word ptr es:[di + 6]
1066  je     0x106b
1068  jmp    0x119f
  loc_106b:
106b  lea    di, [bp - 0x10a]
106f  push   ss
1070  push   di
1071  les    di, ptr [bp - 0xa]
1074  add    di, 0xa
1078  push   es
1079  push   di
107a  call   Sys_StrAssign
107f  mov    di, 0xf8d                         ; cs:'.CHR'
1082  push   cs
1083  push   di
1084  call   Sys_StrConcat
1089  mov    di, 0xcca4
108c  push   ds
108d  push   di
108e  mov    ax, 8
1091  push   ax
1092  call   Sys_StrStore
1097  mov    di, 0xccbc
109a  push   ds
109b  push   di
109c  mov    di, 0xcca4
109f  push   ds
10a0  push   di
10a1  lea    di, [bp - 2]
10a4  push   ss
10a5  push   di
10a6  mov    ax, 0xfff3
10a9  push   ax
10aa  call   sub_0c93_0457
10ad  or     al, al
10af  jne    0x10cb
10b1  cmp    word ptr [0xcd70], -3
10b6  jne    0x10be
10b8  mov    word ptr [0xcd70], 0xfff8
  loc_10be:
10be  xor    ax, ax
10c0  mov    word ptr [bp + 0xa], ax
10c3  mov    word ptr [bp + 6], 1
10c8  jmp    0x11bc
  loc_10cb:
10cb  les    ax, ptr [0x294a]
10cf  mov    dx, es
10d1  mov    word ptr [0xcd14], ax
10d4  mov    word ptr [0xcd16], dx
10d8  mov    ax, 0xa5
10db  mov    dx, 0xc93                         ; seg GRAPH
10de  mov    word ptr [0x294a], ax
10e1  mov    word ptr [0x294c], dx
10e5  lea    di, [bp - 6]
10e8  push   ss
10e9  push   di
10ea  push   word ptr [bp - 2]
10ed  lcall  [0xcc1a]
10f1  les    ax, ptr [0xcd14]
10f5  mov    dx, es
10f7  mov    word ptr [0x294a], ax
10fa  mov    word ptr [0x294c], dx
10fe  mov    ax, word ptr [bp - 6]
1101  or     ax, word ptr [bp - 4]
1104  jne    0x1123
1106  mov    di, 0xcc22
1109  push   ds
110a  push   di
110b  call   Sys_Close
1110  mov    word ptr [0xcd70], 0xfff7
1116  xor    ax, ax
1118  mov    word ptr [bp + 0xa], ax
111b  mov    word ptr [bp + 6], 1
1120  jmp    0x11bc
  loc_1123:
1123  mov    di, 0xcc22
1126  push   ds
1127  push   di
1128  les    di, ptr [bp - 6]
112b  push   es
112c  push   di
112d  push   word ptr [bp - 2]
1130  xor    ax, ax
1132  push   ax
1133  push   ax
1134  call   Sys_BlockRead
1139  mov    di, 0xcc22
113c  push   ds
113d  push   di
113e  call   Sys_Close
1143  call   Sys_IOResult
1148  or     ax, ax
114a  jne    0x1168
114c  push   word ptr [bp - 4]
114f  push   word ptr [bp - 6]
1152  push   cs
1153  call   sub_0c93_0261
1156  cdq
1157  mov    cx, ax
1159  mov    bx, dx
115b  mov    ax, word ptr [bp + 0xa]
115e  xor    dx, dx
1160  cmp    dx, bx
1162  jne    0x1168
1164  cmp    ax, cx
1166  je     0x1186
  loc_1168:
1168  mov    word ptr [0xcd70], 0xfff3
116e  lea    di, [bp - 6]
1171  push   ss
1172  push   di
1173  push   word ptr [bp - 2]
1176  lcall  [0xcc1e]
117a  xor    ax, ax
117c  mov    word ptr [bp + 0xa], ax
117f  mov    word ptr [bp + 6], 1
1184  jmp    0x11bc
  loc_1186:
1186  mov    ax, word ptr [bp - 2]
1189  les    di, ptr [bp - 0xa]
118c  mov    word ptr es:[di + 8], ax
1190  les    ax, ptr [bp - 6]
1193  mov    dx, es
1195  les    di, ptr [bp - 0xa]
1198  mov    word ptr es:[di], ax
119b  mov    word ptr es:[di + 2], dx
  loc_119f:
119f  mov    ax, word ptr [bp + 0xa]
11a2  mov    word ptr [0xcca2], ax
  loc_11a5:
11a5  mov    ax, word ptr [bp + 0xa]
11a8  mov    dx, 0xf
11ab  mul    dx
11ad  mov    di, ax
11af  les    ax, ptr [di + 0x27f1]
11b3  mov    dx, es
11b5  mov    word ptr [0xcd8e], ax
11b8  mov    word ptr [0xcd90], dx
  loc_11bc:
11bc  mov    ax, word ptr [bp + 0xa]
11bf  mov    word ptr [0xcde4], ax
11c2  mov    ax, word ptr [bp + 8]
11c5  mov    word ptr [0xcde6], ax
11c8  mov    ax, word ptr [bp + 6]
11cb  mov    word ptr [0xcde8], ax
11ce  push   word ptr [bp + 0xa]
11d1  push   word ptr [bp + 8]
11d4  push   word ptr [bp + 6]
11d7  push   cs
11d8  call   sub_0c93_17d9
11db  mov    sp, bp
11dd  pop    bp
11de  retf   6

; ------------------------------------------------------------
Graph_init:
11e1  push   bp
11e2  mov    bp, sp
11e4  xor    ax, ax
11e6  mov    word ptr [0xcd70], ax
11e9  mov    word ptr [0x2948], 0x100
11ef  mov    word ptr [0xcd0e], 0x1000
11f5  push   cs
11f6  call   sub_0c93_14b9
11f9  call   sub_0c93_03e1
11fc  mov    ax, 0xb9
11ff  mov    dx, 0xc93                         ; seg GRAPH
1202  mov    word ptr [0xcc1a], ax
1205  mov    word ptr [0xcc1c], dx
1209  mov    ax, 0xcf
120c  mov    dx, 0xc93                         ; seg GRAPH
120f  mov    word ptr [0xcc1e], ax
1212  mov    word ptr [0xcc20], dx
1216  mov    byte ptr [0xcca4], 0
121b  mov    byte ptr [0xccae], 0
1220  mov    word ptr [0xcd10], 6
1226  mov    word ptr [0xcd12], 0xa
122c  mov    word ptr [0xcda8], 1
1232  mov    word ptr [0xcda2], 1
1238  mov    word ptr [0xcda4], 1
123e  mov    sp, bp
1240  pop    bp
1241  retf

; ------------------------------------------------------------
sub_0c93_1242:
1242  push   es
1243  push   bx
1244  retf

; ------------------------------------------------------------
sub_0c93_1245:
1245  cmp    byte ptr [0xcdfb], 0xff
124a  jne    0x1283
124c  cmp    byte ptr [0xcda8], 0xa5
1251  jne    0x1259
1253  mov    byte ptr [0xcdfb], 0
1258  ret
  loc_1259:
1259  mov    ah, 0xf
125b  int    0x10
125d  mov    byte ptr [0xcdfb], al
1260  mov    ax, 0x40
1263  mov    es, ax
1265  mov    bx, 0x10
1268  mov    al, byte ptr es:[bx]
126b  mov    byte ptr [0xcdfc], al
126e  cmp    byte ptr [0xcdf4], 5
1273  je     0x1283
1275  cmp    byte ptr [0xcdf4], 7
127a  je     0x1283
127c  and    al, 0xcf
127e  or     al, 0x20
1280  mov    byte ptr es:[bx], al
  loc_1283:
1283  ret
1284  db 55,8b,ec,be,06,00,ff,1e,78,cd,5d,cb

; ------------------------------------------------------------
sub_0c93_1290:
1290  mov    byte ptr [0xcdfb], 0xff

; ------------------------------------------------------------
sub_0c93_1295:
1295  push   bp
1296  mov    bp, sp
1298  xor    ax, ax
129a  mov    ch, byte ptr [0xcdf5]
129e  cmp    byte ptr [0xcdf4], 5
12a3  jne    0x12a7
12a5  mov    ch, 3
  loc_12a7:
12a7  mov    cl, byte ptr [0xcdf3]
12ab  les    bx, ptr [bp + 6]
12ae  mov    ah, 1
12b0  cmp    byte ptr es:[bx + 0x16], 0
12b5  jne    0x12bd
12b7  xor    ah, ah
12b9  les    bx, ptr [0xcd8a]
  loc_12bd:
12bd  mov    si, 0
12c0  lcall  [0xcd78]
12c4  mov    word ptr [0xcd92], bx
12c8  mov    word ptr [0xcd94], es
12cc  pop    bp
12cd  retf   4

; ------------------------------------------------------------
sub_0c93_12d0:
12d0  push   bp
12d1  mov    bp, sp
12d3  mov    ax, word ptr [bp + 0xe]
12d6  mov    bx, word ptr [bp + 0xc]
12d9  mov    cx, word ptr [bp + 0xa]
12dc  mov    dx, word ptr [bp + 8]
12df  cmp    byte ptr [bp + 6], 0
12e3  jne    0x12e8
12e5  or     ah, 0x80
  loc_12e8:
12e8  mov    si, 0x38
12eb  lcall  [0xcd78]
12ef  pop    bp
12f0  retf   0xa
12f3  db 55,8b,ec,e8,4c,ff,8a,46,06,3c,0a,73,10,a2,f3,cd
1303  db ff,36,f9,cd,ff,36,f7,cd,9a,95,12,93,0c,c4,1e,f7
1313  db cd,be,02,00,ff,1e,78,cd,5d,ca,02,00

; ------------------------------------------------------------
sub_0c93_131f:
131f  push   bp
1320  mov    bp, sp
1322  cmp    byte ptr [0xcdfb], 0xff
1327  je     0x134c
1329  mov    si, 6
132c  lcall  [0xcd78]
1330  cmp    byte ptr [0xcda8], 0xa5
1335  je     0x134c
1337  mov    ax, 0x40
133a  mov    es, ax
133c  mov    bx, 0x10
133f  mov    al, byte ptr [0xcdfc]
1342  mov    byte ptr es:[bx], al
1345  xor    ah, ah
1347  mov    al, byte ptr [0xcdfb]
134a  int    0x10
  loc_134c:
134c  mov    byte ptr [0xcdfb], 0xff
1351  pop    bp
1352  retf
1353  db 55,8b,ec,8a,46,06,32,e4,50,be,32,00,ff,1e,78,cd
1363  db 26,8b,5f,0c,eb,18,5d,ca,02,00,55,8b,ec,8a,46,06
1373  db 32,e4,50,be,32,00,ff,1e,78,cd,26,8b,5f,0a
  loc_1381:
1381  pop    ax
1382  call   sub_0c93_1242
1387  pop    bp
1388  retf   2

; ------------------------------------------------------------
sub_0c93_138b:
138b  push   bp
138c  mov    bp, sp
138e  mov    al, byte ptr [bp + 6]
1391  xor    ah, ah
1393  push   ax
1394  mov    si, 0x32
1397  lcall  [0xcd78]
139b  mov    bx, word ptr es:[bx + 0xe]
139f  jmp    0x1381
13a1  db 5d,ca,02,00

; ------------------------------------------------------------
sub_0c93_13a5:
13a5  push   bp
13a6  mov    bp, sp
13a8  mov    ah, byte ptr [bp + 6]
13ab  mov    byte ptr [0xcd97], ah
13af  mov    al, byte ptr [0xcd96]
13b2  mov    si, 0x1e
13b5  lcall  [0xcd78]
13b9  mov    byte ptr [0xcd9a], 0xc
13be  les    bx, ptr [bp + 8]
13c1  mov    ax, 0xffff
13c4  mov    si, 0x20
13c7  lcall  [0xcd78]
13cb  pop    bp
13cc  retf   6

; ------------------------------------------------------------
sub_0c93_13cf:
13cf  push   bp
13d0  mov    bp, sp
13d2  mov    ah, byte ptr [bp + 8]
13d5  mov    al, byte ptr [bp + 6]
13d8  mov    si, 0x2a
13db  lcall  [0xcd78]
13df  pop    bp
13e0  retf   4
13e3  db 55,8b,ec,8b,46,08,2b,46,0c,79,02,f7,d8,40,05,07
13f3  db 00,d1,e8,d1,e8,d1,e8,50,be,32,00,ff,1e,78,cd,26
1403  db 8b,5f,08,9a,42,12,93,0c,5b,f7,e3,8b,4e,06,2b,4e
1413  db 0a,79,02,f7,d9,41,f7,e1,05,06,00,72,04,23,d2,74
1423  db 05,b8,ff,ff,8b,d0,5d,ca,08,00

; ------------------------------------------------------------
sub_0c93_142d:
142d  push   bp
142e  mov    bp, sp
1430  mov    byte ptr [0xcdf2], 0xff
1435  mov    byte ptr [0xcdf3], 0
143a  mov    byte ptr [0xcdf5], 0xa
143f  les    di, ptr [bp + 0xa]
1442  mov    al, byte ptr es:[di]
1445  mov    byte ptr [0xcdf4], al
1448  and    al, al
144a  jne    0x1454
144c  call   sub_0c93_1497
144f  mov    al, byte ptr [0xcdf2]
1452  jmp    0x1479
  loc_1454:
1454  les    di, ptr [bp + 6]
1457  mov    al, byte ptr es:[di]
145a  mov    byte ptr [0xcdf3], al
145d  les    di, ptr [bp + 0xa]
1460  mov    bl, byte ptr es:[di]
1463  and    bl, bl
1465  js     0x1481
1467  xor    bh, bh
1469  mov    al, byte ptr cs:[bx + 0x1908]
146e  mov    byte ptr [0xcdf5], al
1471  mov    al, byte ptr cs:[bx + 0x18ec]
1476  mov    byte ptr [0xcdf2], al
  loc_1479:
1479  les    di, ptr [bp + 0xe]
147c  xor    ah, ah
147e  mov    word ptr es:[di], ax
  loc_1481:
1481  pop    bp
1482  retf   0xc

; ------------------------------------------------------------
sub_0c93_1485:
1485  push   bp
1486  mov    bp, sp
1488  push   word ptr [0xcdf2]
148c  call   sub_0c93_1497
148f  pop    word ptr [0xcdf2]
1493  pop    bp
1494  retf   8

; ------------------------------------------------------------
sub_0c93_1497:
1497  push   bp
1498  call   sub_0c93_1916
149b  pop    bp
149c  les    di, ptr [bp + 0xa]
149f  mov    al, byte ptr [0xcdf4]
14a2  xor    ah, ah
14a4  cmp    al, 0xff
14a6  jne    0x14aa
14a8  mov    ah, al
  loc_14aa:
14aa  mov    word ptr es:[di], ax
14ad  xor    ah, ah
14af  mov    al, byte ptr [0xcdf3]
14b2  les    di, ptr [bp + 6]
14b5  mov    word ptr es:[di], ax
14b8  ret

; ------------------------------------------------------------
sub_0c93_14b9:
14b9  xor    ax, ax
14bb  mov    byte ptr [0xcdf2], 0xff
14c0  mov    byte ptr [0xcdf3], al
14c3  mov    byte ptr [0xcdf4], al
14c6  mov    byte ptr [0xcdf5], al
14c9  mov    byte ptr [0xcdf6], al
14cc  mov    word ptr [0xcdf7], ax
14cf  mov    word ptr [0xcdf9], ax
14d2  mov    byte ptr [0xcdfb], 0xff
14d7  mov    byte ptr [0xcdfc], al
14da  retf

; ------------------------------------------------------------
sub_0c93_14db:
14db  push   bp
14dc  mov    bp, sp
14de  call   sub_0c93_1245
14e1  les    bx, ptr [bp + 6]
14e4  mov    word ptr [0xcdf7], bx
14e8  mov    word ptr [0xcdf9], es
14ec  mov    si, 2
14ef  lcall  [0xcd78]
14f3  pop    bp
14f4  retf   4

; ------------------------------------------------------------
sub_0c93_14f7:
14f7  push   bp
14f8  mov    bp, sp
14fa  mov    si, 4
14fd  lcall  [0xcd78]
1501  pop    bp
1502  retf

; ------------------------------------------------------------
sub_0c93_1503:
1503  push   bp
1504  mov    bp, sp
1506  mov    ax, word ptr [bp + 8]
1509  mov    bx, word ptr [bp + 6]
150c  mov    si, 8
150f  lcall  [0xcd78]
1513  pop    bp
1514  retf   4
1517  db 55,8b,ec,8b,46,08,8b,5e,06,be,0a,00,ff,1e,78,cd
1527  db 5d,ca,04,00

; ------------------------------------------------------------
Graph_Line:
152b  push   bp
152c  mov    bp, sp
152e  mov    ax, word ptr [bp + 0xc]
1531  mov    bx, word ptr [bp + 0xa]
1534  mov    cx, word ptr [bp + 8]
1537  mov    dx, word ptr [bp + 6]
153a  mov    si, 0xc
153d  lcall  [0xcd78]
1541  pop    bp
1542  retf   8
1545  db 55,8b,ec,8b,4e,0a,c4,5e,06,b8,06,00,be,0e,00,ff
1555  db 1e,78,cd,5d,ca,06,00,55,8b,ec,8b,4e,0a,c4,5e,06
1565  db b8,07,00,be,0e,00,ff,1e,78,cd,5d,ca,06,00

; ------------------------------------------------------------
Graph_Bar:
1573  push   bp
1574  mov    bp, sp
1576  mov    ax, word ptr [bp + 0xc]
1579  mov    bx, word ptr [bp + 0xa]
157c  mov    cx, word ptr [bp + 8]
157f  mov    dx, word ptr [bp + 6]
1582  mov    si, 0x12
1585  lcall  [0xcd78]
1589  pop    bp
158a  retf   8
158d  db 55,8b,ec,8b,46,10,8b,5e,0e,8b,4e,0c,8b,56,0a,3b
159d  db c1,72,01,91,3b,da,73,02,87,da,51,52,be,08,00,ff
15ad  db 1e,78,cd,5b,58,8b,4e,08,8b,56,06,be,10,00,ff,1e
15bd  db 78,cd,5d,ca,0c,00,55,8b,ec,8b,46,10,8b,5e,0e,be
15cd  db 08,00,ff,1e,78,cd,8b,46,0c,8b,5e,0a,8b,4e,08,8b
15dd  db 56,06,be,14,00,ff,1e,78,cd,5d,ca,0c,00,55,8b,ec
15ed  db 8b,46,0c,8b,5e,0a,be,08,00,ff,1e,78,cd,8b,46,08
15fd  db 8b,5e,06,be,18,00,ff,1e,78,cd,b8,00,00,bb,68,01
160d  db 8b,4e,08,8b,56,06,be,14,00,ff,1e,78,cd,5d,ca,08
161d  db 00,55,8b,ec,8b,46,10,8b,5e,0e,be,08,00,ff,1e,78
162d  db cd,8b,46,0c,8b,5e,0a,8b,4e,08,8b,56,06,be,16,00
163d  db ff,1e,78,cd,5d,ca,0c,00,55,8b,ec,1e,b8,ff,ff,be
164d  db 14,00,ff,1e,78,cd,8b,f3,06,1f,c4,7e,06,fc,b9,06
165d  db 00,f3,a5,1f,5d,ca,04,00

; ------------------------------------------------------------
Graph_SetColor:
1665  push   bp
1666  mov    bp, sp
1668  mov    al, byte ptr [bp + 6]
166b  mov    byte ptr [0xcd96], al
166e  mov    ah, byte ptr [0xcd97]
1672  mov    si, 0x1e
1675  lcall  [0xcd78]
1679  pop    bp
167a  retf   2

; ------------------------------------------------------------
Graph_GetMaxColor:
167d  push   bp
167e  mov    bp, sp
1680  xor    al, al
1682  mov    si, 0x3a
1685  lcall  [0xcd78]
1689  mov    ax, cx
168b  pop    bp
168c  retf

; ------------------------------------------------------------
sub_0c93_168d:
168d  push   bp
168e  mov    bp, sp
1690  xor    al, al
1692  mov    si, 0x3a
1695  lcall  [0xcd78]
1699  mov    ax, bx
169b  pop    bp
169c  retf

; ------------------------------------------------------------
sub_0c93_169d:
169d  push   bp
169e  mov    bp, sp
16a0  mov    al, 1
16a2  mov    si, 0x3a
16a5  lcall  [0xcd78]
16a9  mov    dx, es
16ab  mov    ax, bx
16ad  pop    bp
16ae  retf
16af  db 55,8b,ec,b0,02,8b,4e,06,be,00,00,ff,1e,78,cd,8c
16bf  db c2,8b,c3,5d,ca,02,00

; ------------------------------------------------------------
sub_0c93_16c6:
16c6  push   bp
16c7  mov    bp, sp
16c9  mov    al, 1
16cb  mov    si, 0
16ce  lcall  [0xcd78]
16d2  mov    ax, cx
16d4  dec    ax
16d5  pop    bp
16d6  retf

; ------------------------------------------------------------
sub_0c93_16d7:
16d7  push   bp
16d8  mov    bp, sp
16da  mov    bl, byte ptr [bp + 6]
16dd  xor    bh, bh
16df  mov    ax, 0xffff
16e2  mov    si, 0x1a
16e5  lcall  [0xcd78]
16e9  pop    bp
16ea  retf   2
16ed  db 55,8b,ec,8b,46,0c,80,cc,80,8b,5e,0a,8b,4e,08,8b
16fd  db 56,06,be,1a,00,ff,1e,78,cd,5d,ca,08,00,55,8b,ec
170d  db 8b,46,08,32,e4,8b,5e,06,be,1a,00,ff,1e,78,cd,5d
171d  db ca,04,00

; ------------------------------------------------------------
sub_0c93_1720:
1720  push   bp
1721  mov    bp, sp
1723  les    bx, ptr [bp + 6]
1726  inc    bx
1727  mov    si, 0x1c
172a  lcall  [0xcd78]
172e  pop    bp
172f  retf   4

; ------------------------------------------------------------
sub_0c93_1732:
1732  push   bp
1733  mov    bp, sp
1735  mov    ax, word ptr [bp + 0xa]
1738  mov    byte ptr [0xcd99], al
173b  mov    bx, word ptr [bp + 8]
173e  mov    cl, byte ptr [bp + 6]
1741  mov    byte ptr [0xcdf6], cl
1745  xor    ch, ch
1747  mov    si, 0x22
174a  lcall  [0xcd78]
174e  pop    bp
174f  retf   6
1752  db 55,8b,ec,8b,46,0a,8b,5e,08,8b,4e,06,c4,36,f7,cd
1762  db 26,8b,7c,0c,26,8b,54,0e,26,03,7c,10,83,ef,02,fa
1772  db 87,e7,8c,d5,8e,d2,fb,57,55,be,2c,00,ff,1e,78,cd
1782  db 5b,58,fa,8e,d3,8b,e0,fb,5d,ca,06,00

; ------------------------------------------------------------
sub_0c93_178e:
178e  push   bp
178f  mov    bp, sp
1791  mov    ah, byte ptr [bp + 6]
1794  mov    byte ptr [0xcd97], ah
1798  mov    al, byte ptr [0xcd96]
179b  mov    si, 0x1e
179e  lcall  [0xcd78]
17a2  mov    al, byte ptr [bp + 8]
17a5  mov    byte ptr [0xcd9a], al
17a8  mov    ah, al
17aa  mov    si, 0x20
17ad  lcall  [0xcd78]
17b1  pop    bp
17b2  retf   4
17b5  db 55,8b,ec,8b,46,0c,8b,5e,0a,be,08,00,ff,1e,78,cd
17c5  db c4,5e,06,26,8a,0f,32,ed,43,be,26,00,ff,1e,78,cd
17d5  db 5d,ca,08,00

; ------------------------------------------------------------
sub_0c93_17d9:
17d9  push   bp
17da  mov    bp, sp
17dc  les    bx, ptr [0xcd92]
17e0  mov    bx, word ptr es:[bx + 0x10]
17e4  and    bx, 0x7f7f
17e8  mov    dl, byte ptr [bp + 6]
17eb  mov    al, bh
17ed  mul    dl
17ef  mov    cx, ax
17f1  mov    al, bl
17f3  mul    dl
17f5  mov    bx, ax
17f7  mov    al, byte ptr [bp + 0xa]
17fa  mov    ah, byte ptr [bp + 8]
17fd  and    al, al
17ff  je     0x1816
1801  les    di, ptr [0xcd92]
1805  cmp    byte ptr es:[di + 1], 3
180a  je     0x1816
180c  mov    cl, dl
180e  xor    ch, ch
1810  mov    bx, cx
1812  mov    dx, word ptr [0xcd90]
  loc_1816:
1816  mov    si, 0x24
1819  lcall  [0xcd78]
181d  pop    bp
181e  retf   6
1821  db 55,8b,ec,8b,46,0c,8b,5e,0a,8b,4e,08,8b,56,06,80
1831  db cc,80,be,24,00,ff,1e,78,cd,5d,ca,08,00,55,8b,ec
1841  db c4,5e,06,26,8a,0f,32,ed,43,be,28,00,ff,1e,78,cd
1851  db 8b,c3,5d,ca,04,00,4d,00,55,8b,ec,b9,01,00,0e,07
1861  db bb,57,18,be,28,00,ff,1e,78,cd,8b,c1,5d,cb,55,8b
1871  db ec,8b,46,08,8b,5e,06,be,2e,00,ff,1e,78,cd,32,e4
1881  db 8a,c2,5d,ca,04,00,55,8b,ec,8b,46,0a,8b,5e,08,8a
1891  db 56,06,be,30,00,ff,1e,78,cd,5d,ca,06,00,55,8b,ec
18a1  db c4,5e,06,8b,4e,10,8b,56,0e,8b,76,0c,8b,7e,0a,3b
18b1  db ce,72,02,87,f1,3b,d7,72,02,87,fa,2b,f1,26,89,37
18c1  db 2b,fa,26,89,7f,02,be,34,00,ff,1e,78,cd,5d,ca,0c
18d1  db 00

; ------------------------------------------------------------
sub_0c93_18d2:
18d2  push   bp
18d3  mov    bp, sp
18d5  les    bx, ptr [bp + 8]
18d8  mov    cx, word ptr [bp + 0xe]
18db  mov    dx, word ptr [bp + 0xc]
18de  mov    al, byte ptr [bp + 6]
18e1  mov    si, 0x36
18e4  lcall  [0xcd78]
18e8  pop    bp
18e9  retf   0xa
18ec  db 00,00,00,01,01,01,02,03,04,01,05,06,07,ff,00,04
18fc  db 05,01,00,00,00,00,05,02,00,00,00,00,00,04,05,01
190c  db 01,00,01,00,05,02,00,00,00,7f

; ------------------------------------------------------------
sub_0c93_1916:
1916  mov    byte ptr [0xcdf2], 0xff
191b  mov    byte ptr [0xcdf4], 0xff
1920  mov    byte ptr [0xcdf3], 0
1925  call   sub_0c93_194c
1928  mov    bl, byte ptr [0xcdf4]
192c  cmp    bl, 0xff
192f  je     0x194b
1931  xor    bh, bh
1933  mov    al, byte ptr cs:[bx + 0x18ec]
1938  mov    byte ptr [0xcdf2], al
193b  mov    al, byte ptr cs:[bx + 0x18fa]
1940  mov    byte ptr [0xcdf3], al
1943  mov    al, byte ptr cs:[bx + 0x1908]
1948  mov    byte ptr [0xcdf5], al
  loc_194b:
194b  ret

; ------------------------------------------------------------
sub_0c93_194c:
194c  mov    ah, 0xf
194e  int    0x10
1950  cmp    al, 7
1952  je     0x1985
1954  call   sub_0c93_1a41
1957  jae    0x195f
1959  mov    byte ptr [0xcdf4], 6
195e  ret
  loc_195f:
195f  call   sub_0c93_19b3
1962  jae    0x1968
  loc_1964:
1964  call   sub_0c93_19d1
1967  ret
  loc_1968:
1968  call   sub_0c93_1a76
196b  and    ax, ax
196d  je     0x1975
196f  mov    byte ptr [0xcdf4], 0xa
1974  ret
  loc_1975:
1975  mov    byte ptr [0xcdf4], 1
197a  call   sub_0c93_1a20
197d  jae    0x1984
197f  mov    byte ptr [0xcdf4], 2
  loc_1984:
1984  ret
  loc_1985:
1985  call   sub_0c93_19b3
1988  jb     0x1964
198a  call   sub_0c93_1a44
198d  and    al, al
198f  je     0x1997
1991  mov    byte ptr [0xcdf4], 7
1996  ret
  loc_1997:
1997  mov    si, 0xb800
199a  mov    es, si
199c  xor    si, si
199e  mov    ax, word ptr es:[si]
19a1  not    ax
19a3  not    word ptr es:[si]
19a6  nop
19a7  nop
19a8  cmp    ax, word ptr es:[si]
19ab  jne    0x19b2
19ad  mov    byte ptr [0xcdf4], 1
  loc_19b2:
19b2  ret

; ------------------------------------------------------------
sub_0c93_19b3:
19b3  mov    ax, 0x1200
19b6  mov    bl, 0x10
19b8  mov    bh, 0xff
19ba  mov    cl, 0xf
19bc  int    0x10
19be  cmp    cl, 0xc
19c1  jge    0x19cf
19c3  cmp    bh, 1
19c6  jg     0x19cf
19c8  cmp    bl, 3
19cb  jg     0x19cf
19cd  stc
19ce  ret
  loc_19cf:
19cf  clc
19d0  ret

; ------------------------------------------------------------
sub_0c93_19d1:
19d1  mov    byte ptr [0xcdf4], 4
19d6  cmp    bh, 1
19d9  je     0x1a0b
19db  call   sub_0c93_1a11
19de  jb     0x1a0a
19e0  and    bl, bl
19e2  je     0x1a0a
19e4  mov    byte ptr [0xcdf4], 3
19e9  call   sub_0c93_1a20
19ec  jb     0x1a05
19ee  mov    bx, 0xc000
19f1  mov    es, bx
19f3  mov    bx, 0x39
19f6  cmp    word ptr es:[bx], 0x345a
19fb  jne    0x1a0a
19fd  cmp    word ptr es:[bx + 2], 0x3934
1a03  jne    0x1a0a
  loc_1a05:
1a05  mov    byte ptr [0xcdf4], 9
  loc_1a0a:
1a0a  ret
  loc_1a0b:
1a0b  mov    byte ptr [0xcdf4], 5
1a10  ret

; ------------------------------------------------------------
sub_0c93_1a11:
1a11  cmp    cl, 2
1a14  jb     0x1a1f
1a16  cmp    cl, 6
1a19  cmc
1a1a  jae    0x1a1f
1a1c  cmp    cl, 8
  loc_1a1f:
1a1f  ret

; ------------------------------------------------------------
sub_0c93_1a20:
1a20  mov    ax, 0x1a00
1a23  int    0x10
1a25  cmp    al, 0x1a
1a27  jne    0x1a3f
1a29  cmp    bl, 7
1a2c  je     0x1a3d
1a2e  cmp    bl, 8
1a31  je     0x1a3d
1a33  cmp    bl, 0xb
1a36  jb     0x1a3f
1a38  cmp    bl, 0xc
1a3b  ja     0x1a3f
  loc_1a3d:
1a3d  stc
1a3e  ret
  loc_1a3f:
1a3f  clc
1a40  ret

; ------------------------------------------------------------
sub_0c93_1a41:
1a41  xor    al, al
1a43  ret

; ------------------------------------------------------------
sub_0c93_1a44:
1a44  mov    dx, 0x3ba
1a47  xor    bl, bl
1a49  in     al, dx
1a4a  and    al, 0x80
1a4c  mov    ah, al
1a4e  mov    cx, 0x8000
  loc_1a51:
1a51  in     al, dx
1a52  and    al, 0x80
1a54  cmp    al, ah
1a56  je     0x1a5f
1a58  inc    bl
1a5a  cmp    bl, 0xa
1a5d  jae    0x1a64
  loc_1a5f:
1a5f  loop   0x1a51
1a61  xor    al, al
1a63  ret
  loc_1a64:
1a64  mov    cx, 0x8000
  loc_1a67:
1a67  in     al, dx
1a68  and    al, 0x30
1a6a  cmp    al, 0x10
1a6c  jne    0x1a73
1a6e  loop   0x1a67
1a70  mov    al, 2
1a72  ret
  loc_1a73:
1a73  mov    al, 1
1a75  ret

; ------------------------------------------------------------
sub_0c93_1a76:
1a76  mov    al, 6
1a78  xor    cx, cx
1a7a  xor    dx, dx
1a7c  mov    ah, 0x30
1a7e  int    0x10
1a80  mov    ax, cx
1a82  or     ax, dx
1a84  je     0x1aa3
1a86  push   ds
1a87  mov    ds, cx
1a89  mov    bx, dx
1a8b  mov    al, byte ptr [bx + 2]
1a8e  pop    ds
1a8f  or     al, al
1a91  je     0x1a97
1a93  cmp    al, 2
1a95  jne    0x1aa3
  loc_1a97:
1a97  mov    dx, 0x188
1a9a  in     al, dx
1a9b  test   al, 4
1a9d  je     0x1aa3
1a9f  mov    ax, 1
1aa2  ret
  loc_1aa3:
1aa3  xor    ax, ax
1aa5  ret
1aa6  db 20,00,30,19,00,00,00,00,00,00,00,00,00,00,00,00
1ab6  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
1ac6  db 1e,0e,1f,56,ff,94,13,00,5e,1f,2e,ff,2e,70,00,90
1ad6  db 20,20,00,c6,01,50,02,a7,00,a7,00,0d,01,18,01,65
1ae6  db 01,a9,00,5c,01,7c,01,85,01,a7,00,a7,00,a7,00,a7
1af6  db 00,9b,02,aa,02,db,02,80,13,92,01,98,01,bc,01,34
1b06  db 01,5c,01,53,01,a7,00,71,01,71,01,b0,00,a7,00,a8
1b16  db 00,ae,00,a7,00,a7,00,a7,00,a7,00,a7,00,a7,00,a7
1b26  db 00,a7,00,a7,00,a7,00,a7,00,a7,00,a7,00,a7,00,00
1b36  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
1b46  db 00,10,27,00,00,00,00,00,00,00,00,00,00,08,00,08
1b56  db 01,00,00,00,00,64,00,64,00,00,01,00,00,00,00,01
1b66  db 00,00,00,5e,5e,1f,cb,c3,c3,e8,01,04,eb,f5,eb,f3
1b76  db 50,c7,06,84,00,00,00,c7,06,86,00,00,00,80,e4,7f
1b86  db 3b,c1,72,01,91,3b,da,72,02,87,da,23,c0,78,21,23
1b96  db db,78,1d,83,f9,01,7c,18,83,fa,01,7c,13,a3,84,00
1ba6  db 89,1e,86,00,e8,16,00,58,22,e4,79,03,e8,02,00,c3
1bb6  db 58,33,c0,8b,d8,8b,0e,7d,00,8b,16,7f,00,a3,88,00
1bc6  db 89,1e,8a,00,89,0e,8c,00,89,16,8e,00,c3,e8,4c,00
1bd6  db a3,f0,02,89,1e,f2,02,c3,8b,0e,f0,02,8b,16,f2,02
1be6  db e8,ea,ff,50,53,e8,1d,03,5b,58,be,08,00,ff,1e,70
1bf6  db 00,e9,6f,ff,e8,25,00,e8,03,12,73,14,be,2c,00,ff
1c06  db 1e,70,00,3c,ff,75,09,c4,1e,78,00,26,c7,07,f9,ff
1c16  db e9,50,ff,e8,06,00,e8,e4,11,73,f5,c3,03,06,84,00
1c26  db 03,1e,86,00,c3,e8,06,00,e8,da,02,e9,35,ff,e8,eb
1c36  db ff,91,87,da,e8,e5,ff,91,87,da,c3,c3,e8,ef,ff,e8
1c46  db 6e,11,73,cc,c3,3d,ff,ff,75,f1,0e,07,bb,f4,02,e9
1c56  db 11,ff,e8,d8,11,e9,0b,ff,80,3e,99,00,00,74,06,e8
1c66  db d1,14,e9,fe,fe,80,3e,6f,00,00,74,0f,8b,c1,f7,26
1c76  db 64,13,8b,d8,8b,0e,66,13,e9,e8,fe,c3,88,26,62,13
1c86  db a2,63,13,e9,dd,fe,22,c0,74,01,c3,c6,06,92,00,00
1c96  db c6,06,7c,00,00,89,1e,70,00,8c,06,72,00,a2,6f,00
1ca6  db 33,c0,8b,f0,ff,1e,70,00,89,1e,74,00,8c,06,76,00
1cb6  db 06,53,c4,3e,70,00,83,c7,10,b0,9a,fc,aa,b8,38,03
1cc6  db ab,8c,c8,ab,2e,c4,36,74,00,83,c6,02,26,8b,04,a3
1cd6  db 7d,00,2e,c4,36,74,00,83,c6,04,26,8b,04,a3,7f,00
1ce6  db a1,7d,00,b9,e8,03,f7,e1,2e,c4,36,74,00,83,c6,0a
1cf6  db 26,f7,34,40,a3,95,00,a1,7f,00,f7,e1,2e,c4,36,74
1d06  db 00,83,c6,0c,26,f7,34,40,a3,97,00,5b,07,e9,53,fe
1d16  db 50,53,51,52,06,26,8b,47,0c,40,40,a3,a3,04,26,8b
1d26  db 47,0e,a3,a5,04,26,8b,47,10,33,d2,b9,06,00,f7,f1
1d36  db a3,9f,04,26,c4,5f,1a,89,1e,78,00,8c,06,7a,00,07
1d46  db 5a,59,5b,58,ff,1e,70,00,c6,06,99,00,00,e9,13,fe
1d56  db a3,9a,00,be,1e,00,ff,1e,70,00,c3,a3,9a,00,c3,a3
1d66  db 90,00,be,20,00,ff,1e,70,00,c3,3c,ff,75,07,c7,06
1d76  db 90,00,0c,0c,c3,a3,90,00,c3,32,c0,8b,1e,a1,00,b9
1d86  db 01,00,eb,05,32,c0,b9,03,00,a2,9e,00,88,0e,9f,00
1d96  db b9,01,00,be,22,00,ff,1e,70,00,c3,a2,9e,00,88,0e
1da6  db 9f,00,89,1e,a1,00,c3,00,00,00,00,00,00,00,00,00
1db6  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
1dc6  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,10,00
1dd6  db 8a,06,12,00,03,04,20,00,ca,03,26,00,29,18,24,00
1de6  db 97,13,28,00,73,16,16,00,0a,08,18,00,e7,07,0e,00
1df6  db e3,0a,14,00,93,07,00,00,1e,0e,1f,50,8b,fe,be,0e
1e06  db 03,ad,23,c0,74,0c,3b,c7,ad,75,f6,8b,f8,58,ff,d7
1e16  db 1f,cb,58,1f,cb,a1,f0,02,8b,1e,f2,02,eb,0a,2e,a3
1e26  db f0,02,2e,89,1e,f2,02,c3,e8,9a,02,72,0e,a3,f0,02
1e36  db 89,1e,f2,02,be,08,00,ff,1e,70,00,c3,03,06,f0,02
1e46  db 03,1e,f2,02,a3,f0,02,89,1e,f2,02,eb,db,03,06,f0
1e56  db 02,03,1e,f2,02,50,53,e8,0a,00,5b,58,a3,f0,02,89
1e66  db 1e,f2,02,c3,e8,5e,02,72,13,51,52,8b,c8,8b,d3,87
1e76  db 06,f0,02,87,1e,f2,02,e8,8b,00,5a,59,c3,e8,30,0f
1e86  db 73,07,be,12,00,ff,1e,70,00,c3,a3,90,00,c6,06,e2
1e96  db 0a,ff,c3,00,00,00,00,00,00,00,00,00,00,00,00,00
1ea6  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
1eb6  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
1ec6  db 00,00,00,0e,07,43,41,8b,fb,bb,d3,03,89,07,89,7f
1ed6  db 02,89,47,04,89,57,06,89,4f,08,89,57,0a,89,4f,0c
1ee6  db 89,7f,0e,89,47,10,89,7f,12,b8,00,80,89,47,14,89
1ef6  db 47,16,b8,06,00,b9,08,00,be,0e,00,ff,1e,70,00,c3
1f06  db e8,c2,01,72,13,80,3e,9f,00,03,73,0d,e8,ed,0c,73
1f16  db 07,be,0c,00,ff,1e,70,00,c3,e8,34,00,8b,f8,2b,f9
1f26  db 79,02,f7,df,8b,f3,2b,f2,79,02,f7,de,3b,fe,8b,3e
1f36  db e0,0a,73,0f,2b,c7,2b,cf,e8,15,00,d1,e7,03,c7,03
1f46  db cf,eb,0d,2b,df,2b,d7,e8,06,00,d1,e7,03,df,03,d7
1f56  db 50,53,51,52,57,e8,b4,ff,5f,5a,59,5b,58,c3,00,00
1f66  db 00,00,00,00,00,00,00,00,00,00,00,00,00,3c,08,72
1f76  db 02,b0,05,32,e4,d0,e0,8b,f8,ff,a5,bd,04,cd,04,31
1f86  db 05,6f,05,36,05,df,04,5b,05,e5,04,e9,04,c6,06,9e
1f96  db 04,01,c7,06,a1,04,00,00,c7,06,a7,04,00,00,c3,c6
1fa6  db 06,9e,04,02,c3,32,c0,eb,02,b0,ff,e3,43,50,06,53
1fb6  db 51,33,c0,e8,b7,ff,59,5f,07,e8,f0,00,e8,5d,fc,e8
1fc6  db e0,00,23,c9,75,f3,58,22,c0,b8,01,00,74,1f,c4,1e
1fd6  db a3,04,26,8b,07,26,8b,5f,02,c7,06,a7,04,00,00,e8
1fe6  db 46,fe,b8,03,00,80,3e,9a,00,00,74,01,48,e8,7d,ff
1ff6  db c3,e8,2d,00,eb,58,e8,28,00,a1,a1,04,3b,06,9f,04
2006  db 73,19,3d,04,00,72,14,c4,1e,a3,04,8b,0e,9f,04,c6
2016  db 06,9e,04,00,be,0e,00,ff,1e,70,00,c6,06,9e,04,00
2026  db c3,b8,00,80,8b,d8,e8,ff,fd,c6,06,9e,04,00,c3,81
2036  db 3e,97,00,b4,00,72,05,c6,06,e2,0a,ff,80,3e,e2,0a
2046  db 00,74,08,e8,db,ff,e8,05,00,eb,ae,e8,a8,ff,c6,06
2056  db 9e,04,00,c4,3e,a3,04,8b,0e,a1,04,3b,0e,9f,04,72
2066  db 03,e9,d7,00,83,f9,02,72,b2,ff,36,f0,02,ff,36,f2
2076  db 02,e8,2b,00,e8,35,00,80,ff,80,75,0d,22,db,74,16
2086  db e8,1c,00,23,c9,75,ed,eb,0d,06,57,51,e8,d5,fd,59
2096  db 5f,07,23,c9,75,de,8f,06,f2,02,8f,06,f0,02,c3,e8
20a6  db 0a,00,06,57,51,e8,80,fd,59,5f,07,c3,bb,00,80,e3
20b6  db 0b,26,8b,05,47,47,26,8b,1d,47,47,49,c3,1e,0e,1f
20c6  db e8,02,00,1f,c3,80,3e,9e,04,00,74,6e,80,3e,9e,04
20d6  db 02,74,10,83,3e,a7,04,00,75,1a,a3,a9,04,89,1e,ab
20e6  db 04,eb,36,8a,16,9a,00,e8,13,0d,73,07,be,30,00,ff
20f6  db 1e,70,00,c3,3b,06,a9,04,75,1f,3b,1e,ab,04,75,19
2106  db 83,3e,a7,04,01,74,32,e8,0f,00,b8,01,80,8b,d8,e8
2116  db 07,00,c7,06,a7,04,00,00,c3,ff,06,a7,04,8b,3e,a1
2126  db 04,3b,3e,9f,04,73,14,d1,e7,d1,e7,c4,36,a3,04,03
2136  db fe,ab,26,89,1d,ff,06,a1,04,f9,c3,06,53,c4,1e,78
2146  db 00,26,c7,07,fa,ff,5b,07,f9,c3,51,52,a3,04,03,89
2156  db 1e,06,03,8b,0e,f0,02,8b,16,f2,02,89,0e,00,03,89
2166  db 16,02,03,e8,d1,00,a1,9a,00,72,09,86,e0,be,1e,00
2176  db ff,1e,70,00,8b,1e,06,03,53,a1,00,03,e8,e5,fc,a1
2186  db 04,03,5b,50,e8,dd,fc,58,8b,1e,02,03,53,e8,d4,fc
2196  db 5b,a1,00,03,e8,cd,fc,a1,04,03,8b,1e,02,03,50,e8
21a6  db 86,fc,58,5a,59,0b,c9,74,3f,52,8b,d1,8b,fa,d1,e2
21b6  db 03,d7,d1,ea,d1,ea,80,3e,92,00,00,74,0f,8b,ca,f7
21c6  db d9,5f,23,ff,75,05,e8,4f,00,eb,1d,57,03,c1,2b,da
21d6  db 50,e8,90,fc,58,8b,1e,06,03,2b,da,53,e8,85,fc,5b
21e6  db 5f,23,ff,74,03,e8,0b,00,a1,9a,00,be,1e,00,ff,1e
21f6  db 70,00,c3,a1,00,03,03,c1,e8,69,fc,a1,00,03,8b,1e
2206  db 06,03,53,e8,5e,fc,5b,a1,04,03,50,53,e8,19,fc,5b
2216  db 58,03,c1,2b,da,e9,4c,fc,a1,00,03,8b,1e,06,03,53
2226  db 50,e8,04,fc,58,5b,2b,da,03,c1,53,e8,36,fc,a1,04
2236  db 03,03,c1,5b,e9,2d,fc,3b,c1,7c,01,91,3b,da,7d,02
2246  db 87,da,40,49,4b,42,e8,34,fc,f9,c3,f8,c3,00,00,00
2256  db 00,00,ff,c6,06,92,07,00,e8,3c,01,80,3e,9f,00,03
2266  db 73,12,be,04,00,80,3e,e2,0a,00,75,08,81,3e,97,00
2276  db b4,00,72,27,50,53,32,c0,b9,01,00,be,22,00,ff,1e
2286  db 70,00,33,c0,e8,e6,fc,5b,58,e8,9d,02,e8,6e,02,b8
2296  db 01,00,e8,d8,fc,a0,9e,00,e9,e0,fa,e8,10,01,e8,5c
22a6  db 02,b8,05,00,e9,c6,fc,ff,36,f0,02,ff,36,f2,02,50
22b6  db 53,ff,36,9a,00,33,ff,57,8b,3e,f0,02,03,f8,8b,36
22c6  db f2,02,57,56,57,56,e8,47,05,c3,c6,06,92,07,ff,80
22d6  db 3e,92,00,00,74,02,87,ca,e8,bc,00,80,3e,e2,0a,00
22e6  db 75,08,81,3e,97,00,b4,00,72,03,e9,8f,02,33,d2,88
22f6  db 16,91,07,89,16,8d,07,89,16,8f,07,89,16,04,03,89
2306  db 16,06,03,89,16,08,03,89,16,0a,03,e8,d0,01,50,53
2316  db 33,d2,b9,5a,00,f7,f1,8b,f8,8b,c3,33,d2,f7,f1,3d
2326  db 04,00,72,03,b8,03,00,8b,f0,5b,58,3b,f7,74,1e,53
2336  db 50,b8,5a,00,47,f7,e7,8b,d8,58,53,33,f6,3b,c3,9c
2346  db e8,6b,00,9d,74,03,e8,0e,01,58,5b,eb,c1,33,f6,3b
2356  db c3,9c,e8,59,00,9d,74,03,e8,fc,00,a1,f0,02,8b,1e
2366  db f2,02,8b,0e,8d,07,89,0e,04,03,8b,16,8f,07,89,16
2376  db 06,03,80,3e,92,07,00,74,1a,03,c8,03,d3,50,53,e8
2386  db 7e,fb,5b,58,8b,0e,08,03,8b,16,0a,03,03,c8,03,d3
2396  db e8,6d,fb,e8,67,01,c3,89,0e,00,03,89,16,02,03,50
23a6  db a1,f0,02,a3,f4,02,a1,f2,02,a3,f6,02,58,c3,8b,0e
23b6  db 00,03,8b,16,02,03,80,3e,92,00,00,74,06,05,5a,00
23c6  db 83,c3,5a,8b,fb,2b,f8,89,3e,93,00,23,ff,75,03,e9
23d6  db bf,00,ff,36,f0,02,ff,36,f2,02,51,52,ff,36,9a,00
23e6  db bf,ff,ff,57,56,53,53,50,50,e8,be,00,a3,04,03,58
23f6  db e8,c4,00,a3,06,03,58,e8,b0,00,a3,08,03,58,e8,b6
2406  db 00,a3,0a,03,5e,5e,ff,36,04,03,ff,36,06,03,ff,36
2416  db 08,03,50,8b,c6,e8,55,fb,a1,04,03,3b,06,08,03,75
2426  db 16,a1,06,03,3b,06,0a,03,75,0d,81,3e,93,00,5e,01
2436  db 73,21,83,c4,14,eb,0a,83,3e,93,00,02,73,15,83,c4
2446  db 14,a1,08,03,8b,1e,0a,03,03,06,f0,02,03,1e,f2,02
2456  db e9,d5,f9,e8,ba,03,c3,80,3e,92,07,00,75,08,b8,01
2466  db 00,e8,09,fb,eb,2b,e8,ac,f9,c4,1e,a3,04,26,8b,07
2476  db 26,8b,5f,02,c7,06,a7,04,00,00,e8,ab,f9,b8,03,00
2486  db e8,ea,fa,a1,a1,04,2d,03,00,72,06,a3,a1,04,e8,bd
2496  db fb,80,3e,91,07,00,75,11,c6,06,91,07,ff,a1,04,03
24a6  db a3,8d,07,a1,06,03,a3,8f,07,c3,5f,e8,c9,06,8b,0e
24b6  db 00,03,e8,11,00,ff,e7,5f,e8,c9,06,8b,0e,02,03,e8
24c6  db 04,00,f7,d8,ff,e7,8b,d0,8b,c3,8b,d9,e8,03,00,8b
24d6  db c2,c3,8b,c8,8b,c2,f7,e3,91,f7,e3,03,d1,c3,51,52
24e6  db b9,68,01,33,d2,f7,f1,52,3b,d9,74,08,33,d2,8b,c3
24f6  db f7,f1,8b,da,58,3b,c3,72,01,93,5a,59,c3,0e,07,fc
2506  db be,f4,02,8b,fe,ad,2b,06,84,00,ab,8b,d8,ad,2b,06
2516  db 86,00,ab,8b,c8,be,04,03,ad,03,c3,ab,ad,03,c1,ab
2526  db ad,03,c3,ab,ad,03,c1,ab,c3,3b,c3,72,0b,81,c3,68
2536  db 01,eb,05,3b,c3,72,01,93,80,3e,92,00,00,74,06,05
2546  db 5a,00,83,c3,5a,8b,0e,00,03,89,0e,00,03,8b,0e,02
2556  db 03,89,0e,02,03,53,50,50,50,e8,4e,ff,a3,0c,03,58
2566  db e8,54,ff,8b,d8,a1,0c,03,03,06,f0,02,03,1e,f2,02
2576  db e8,b5,f8,58,58,5b,40,3b,c3,7e,da,c3,50,53,33,c0
2586  db e8,ea,f9,5b,58,e8,ab,ff,e8,8a,f8,c4,1e,a3,04,26
2596  db 8b,07,26,8b,5f,02,e8,8f,f8,b8,02,00,e9,ce,f9,00
25a6  db 01,00,00,81,3e,97,00,b4,00,72,05,c6,06,e2,0a,ff
25b6  db 8b,ec,83,ec,18,3d,03,00,72,26,89,4e,f0,89,5e,fe
25c6  db 89,46,f8,d1,e0,d1,e0,03,d8,89,5e,fc,ff,36,9a,00
25d6  db e8,d3,01,73,0b,e8,0f,00,e8,2b,02,73,03,e8,07,00
25e6  db 58,83,c4,18,e9,69,f7,06,1f,e8,db,00,8b,46,f4,89
25f6  db 46,f6,c7,46,ee,00,00,e8,2f,00,e8,f9,00,8b,46,ec
2606  db 80,7e,e8,02,90,72,12,ff,46,ee,8b,5e,ea,3b,5e,ee
2616  db 75,07,c7,46,ee,00,00,f7,eb,01,46,f6,8b,46,f6,3b
2626  db 46,f2,7c,d3,1e,07,0e,1f,c3,c7,46,fa,00,00,8b,5e
2636  db fe,43,43,8b,0f,8b,46,f6,83,c3,04,8b,f9,8b,17,8b
2646  db ca,80,fe,80,74,1a,3b,d7,7c,02,87,d7,3b,c2,7c,e8
2656  db 3b,c7,7d,e4,53,51,e8,17,00,e8,3b,00,59,5b,eb,d5
2666  db 80,fa,01,75,0a,83,c3,04,8b,0f,80,fd,80,75,c6,c3
2676  db 8b,77,fa,8b,7f,fc,8b,4f,fe,8b,17,3b,d7,7c,04,87
2686  db ce,87,d7,8b,c1,2b,fa,74,0d,8b,46,f6,2b,c2,2b,f1
2696  db f7,ee,f7,ff,03,c1,c3,8b,d0,8b,76,fc,8b,46,fa,3b
26a6  db 46,f0,73,22,ff,46,fa,23,c0,74,15,48,8b,d8,d1,e3
26b6  db 8b,08,40,3b,ca,7c,09,8b,d8,d1,e3,89,08,48,75,eb
26c6  db 8b,d8,d1,e3,89,10,c3,c7,46,f4,ff,7f,c7,46,f2,00
26d6  db 80,8b,5e,fe,43,43,8b,07,43,43,80,fc,80,75,05,3c
26e6  db 01,74,f1,c3,3b,46,f4,7d,03,89,46,f4,3b,46,f2,7c
26f6  db e3,89,46,f2,eb,de,8b,76,fc,33,c0,8b,4e,fa,e3,26
2706  db 8b,d8,d1,e3,50,56,1e,55,a9,01,00,8b,00,8b,5e,f6
2716  db 0e,1f,75,05,e8,14,00,eb,03,e8,21,00,5d,1f,5e,58
2726  db 40,3b,46,fa,72,da,c3,00,00,00,00,83,3e,44,0d,00
2736  db 74,03,e8,d1,00,a3,67,0c,89,1e,69,0c,c3,83,3e,44
2746  db 0d,00,74,03,e8,bf,00,8b,c8,8b,d3,87,0e,67,0c,87
2756  db 16,69,0c,3b,c1,72,01,91,80,3e,e2,0a,00,75,03,e9
2766  db 1b,f7,be,0c,00,ff,1e,70,00,c3,00,00,01,00,00,02
2776  db 04,02,00,5a,00,00,0a,e1,87,02,0a,01,e1,87,02,02
2786  db 05,87,e1,03,02,05,87,87,01,5a,0a,00,00,01,87,11
2796  db e1,e1,03,05,01,00,00,03,0a,01,00,00,03,05,02,00
27a6  db 00,00,00,01,00,00,c7,06,44,0d,00,00,a0,90,00,fe
27b6  db c8,f8,78,4f,80,3e,e2,0a,00,75,02,32,c0,8a,d8,d0
27c6  db e3,d0,e3,02,d8,32,ff,81,c3,aa,0c,8b,f3,ac,88,46
27d6  db e8,ac,32,e4,89,46,ea,ac,f7,2e,e0,0a,89,46,ec,ac
27e6  db 32,e4,80,3e,92,00,00,74,08,80,3e,e2,0a,00,74,01
27f6  db ac,e8,12,00,06,a0,9b,00,8a,e0,be,1e,00,ff,1e,70
2806  db 00,07,f9,c3,00,00,32,c0,c3,00,00,00,00,00,00,00
2816  db 55,8b,ec,83,ec,2a,8b,46,0e,e8,72,02,89,46,0e,a3
2826  db 9a,00,8b,46,0a,8b,5e,08,e8,15,02,89,46,da,8b,46
2836  db 06,8b,5e,04,e8,09,02,c6,46,d6,00,3b,46,da,7f,04
2846  db c6,46,d6,ff,89,46,d8,f7,46,12,ff,ff,75,03,ff,46
2856  db 12,f7,46,10,ff,ff,75,03,ff,46,10,8b,46,10,8b,5e
2866  db 12,3b,c3,77,02,8b,c3,f7,e0,bb,64,00,e8,0a,02,73
2876  db 03,e9,d1,00,89,46,dc,89,56,de,8b,5e,12,e8,e7,01
2886  db e8,e4,01,89,46,f8,89,56,fa,33,c0,89,46,fe,89,46
2896  db ec,89,46,ee,8b,46,dc,8b,56,de,8b,5e,10,89,5e,fc
28a6  db e8,c4,01,e8,c1,01,89,46,f4,89,56,f6,e8,ca,01,73
28b6  db 03,e9,91,00,8b,f2,8b,f8,e8,be,01,73,03,e9,85,00
28c6  db 2b,46,dc,1b,56,de,89,46,f0,89,56,f2,d1,e7,d1,d6
28d6  db 89,7e,e8,89,76,ea,e8,de,00,e8,72,00,8b,46,f0,8b
28e6  db 5e,f2,03,c0,13,db,03,46,e4,13,5e,e6,03,46,e4,13
28f6  db 5e,e6,3b,5e,e2,7c,0a,75,05,3b,46,e0,72,03,e8,94
2906  db 00,e8,6f,00,8b,46,ee,3b,46,ea,7c,ca,75,08,8b,46
2916  db ec,3b,46,e8,72,c0,e8,9e,00,e8,32,00,8b,46,e4,8b
2926  db 5e,e6,d1,eb,d1,d8,03,46,f0,13,5e,f2,3b,5e,e2,7f
2936  db 0a,75,05,3b,46,e0,77,03,e8,38,00,e8,57,00,f7,46
2946  db fc,00,80,74,d1,8b,e5,5d,e8,58,01,c2,14,00,8b,46
2956  db ec,03,46,f8,89,46,e4,8b,46,ee,13,46,fa,89,46,e6
2966  db 8b,46,e8,2b,46,f4,89,46,e0,8b,46,ea,1b,46,f6,89
2976  db 46,e2,c3,ff,46,fe,8b,46,e4,01,46,f0,8b,46,e6,11
2986  db 46,f2,8b,46,e4,03,46,f8,89,46,ec,8b,46,e6,13,46
2996  db fa,89,46,ee,c3,ff,4e,fc,8b,46,e0,29,46,f0,8b,46
29a6  db e2,19,46,f2,8b,46,e0,2b,46,f4,89,46,e8,8b,46,e2
29b6  db 1b,46,f6,89,46,ea,c3,8b,56,0e,8b,76,fe,8b,7e,fc
29c6  db f7,46,0c,00,80,75,37,56,57,8b,c6,8b,df,8b,c8,8b
29d6  db d3,f7,d8,e8,16,00,5f,5e,56,57,f7,df,8b,c6,8b,df
29e6  db 8b,c8,8b,d3,f7,d8,e8,03,00,5f,5e,c3,03,46,16,03
29f6  db 5e,14,03,4e,16,03,56,14,55,e8,81,f4,5d,c3,e8,0e
2a06  db 00,f7,de,e8,09,00,f7,de,f7,df,e8,02,00,f7,de,8b
2a16  db c6,8b,df,e8,2a,00,80,7e,d6,00,75,0b,3b,46,da,7c
2a26  db 05,3b,46,d8,7e,0c,c3,3b,46,da,7d,06,3b,46,d8,7e
2a36  db 01,c3,57,56,03,76,16,03,7e,14,e8,4a,00,5e,5f,c3
2a46  db f7,db,0a,e4,78,0f,0a,ff,78,05,2b,d8,8b,c3,c3,05
2a56  db 70,17,03,c3,c3,0a,ff,78,08,f7,d8,05,d0,07,2b,c3
2a66  db c3,05,a0,0f,2b,c3,c3,0b,db,f9,74,0c,33,c9,87,ca
2a76  db 91,f7,f3,91,f7,f3,87,ca,c3,8b,c8,8b,c2,f7,e3,72
2a86  db 05,91,f7,e3,03,d1,c3,8b,c6,8b,df,e9,9a,f3,80,3e
2a96  db 6f,00,00,75,24,50,be,32,00,ff,1e,70,00,26,8b,1f
2aa6  db 58,eb,12,80,3e,6f,00,00,75,0f,be,32,00,ff,1e,70
2ab6  db 00,26,8b,5f,02,0e,e8,01,00,c3,06,53,cb,00,00,00
2ac6  db 00,00,00,3b,02,77,04,b2,06,ed,08,27,0b,61,0d,99
2ad6  db 0f,d0,11,06,14,3a,16,6c,18,9c,1a,cb,1c,f7,1e,20
2ae6  db 21,48,23,6c,25,8d,27,ac,29,c7,2b,df,2d,f3,2f,03
2af6  db 32,0f,34,18,36,1c,38,1c,3a,17,3c,0e,3e,00,40,ec
2b06  db 41,d4,43,b6,45,93,47,6a,49,3c,4b,08,4d,cd,4e,8d
2b16  db 50,46,52,f9,53,a6,55,4b,57,ea,58,82,5a,13,5c,9c
2b26  db 5d,1f,5f,9a,60,0d,62,79,63,dd,64,39,66,8d,67,d9
2b36  db 68,1d,6a,59,6b,8c,6c,b7,6d,d9,6e,f3,6f,04,71,0c
2b46  db 72,0b,73,01,74,ef,74,d3,75,ad,76,7f,77,47,78,06
2b56  db 79,bc,79,68,7a,0a,7b,a3,7b,32,7c,b8,7c,33,7d,a5
2b66  db 7d,0e,7e,6c,7e,c1,7e,0b,7f,4c,7f,83,7f,b0,7f,d3
2b76  db 7f,ec,7f,fb,7f,00,80,55,83,ec,00,8b,ec,83,46,04
2b86  db 5a,eb,07,90,55,83,ec,00,8b,ec,c6,06,00,10,00,8b
2b96  db 46,04,85,c0,7d,06,f7,d8,f6,16,00,10,33,d2,b9,68
2ba6  db 01,f7,f9,8b,c2,3d,b4,00,7e,07,2d,b4,00,f6,16,00
2bb6  db 10,3d,5a,00,7e,05,f7,d8,05,b4,00,d1,e0,8b,f0,8b
2bc6  db 9c,01,10,8b,cb,33,c0,f8,d1,d3,d1,d0,80,3e,00,10
2bd6  db 00,74,0a,f7,d3,f7,d0,83,c3,01,15,00,00,83,c4,00
2be6  db 5d,c3,00,00,00,00,00,00,00,00,00,00,00,00,00,00
2bf6  db 00,00,00,00,00,00,00,00,00,00,00,00,c6,06,83,00
2c06  db 01,80,3e,92,00,00,75,39,e8,f2,01,73,0c,91,87,da
2c16  db e8,ea,01,91,87,da,73,01,c3,a3,34,11,89,1e,36,11
2c26  db 89,0e,38,11,89,16,3a,11,e8,28,00,80,3e,83,00,00
2c36  db 74,11,a1,34,11,8b,1e,36,11,8b,0e,38,11,8b,16,3a
2c46  db 11,f9,c3,b8,ff,ff,8b,d8,8b,c8,8b,d0,c6,06,83,00
2c56  db 00,f8,c3,bb,34,11,e8,f4,00,8a,e8,bb,38,11,e8,ec
2c66  db 00,0a,c5,75,01,c3,a1,38,11,2b,06,34,11,70,d4,a3
2c76  db 30,11,a1,3a,11,2b,06,36,11,70,c8,a3,32,11,bb,34
2c86  db 11,e8,c9,00,8a,e8,bb,38,11,e8,c1,00,8a,d0,0a,c5
2c96  db 75,01,c3,22,d5,74,06,c6,06,83,00,00,c3,22,ed,75
2ca6  db 03,e8,d5,00,c6,06,83,00,02,83,3e,30,11,00,75,1e
2cb6  db a1,36,11,3b,06,8a,00,7d,06,a1,8a,00,a3,36,11,a1
2cc6  db 8e,00,3b,06,36,11,7d,03,a3,36,11,eb,76,90,83,3e
2cd6  db 32,11,00,75,1e,a1,34,11,3b,06,88,00,7d,06,a1,88
2ce6  db 00,a3,34,11,a1,8c,00,3b,06,34,11,7d,03,a3,34,11
2cf6  db eb,51,90,a1,34,11,3b,06,88,00,7d,0d,a1,88,00,50
2d06  db e8,9c,00,8f,06,34,11,eb,3a,a1,8c,00,3b,06,34,11
2d16  db 7d,0a,50,e8,89,00,8f,06,34,11,eb,27,a1,36,11,3b
2d26  db 06,8a,00,7d,0d,a1,8a,00,50,e8,62,00,8f,06,36,11
2d36  db eb,11,a1,8e,00,3b,06,36,11,7d,08,50,e8,4f,00,8f
2d46  db 06,36,11,22,ed,75,03,e8,2f,00,e9,31,ff,32,d2,8b
2d56  db 07,3b,06,88,00,7d,02,b2,01,3b,06,8c,00,7e,02,b2
2d66  db 02,8b,47,02,3b,06,8a,00,7d,03,80,c2,04,3b,06,8e
2d76  db 00,7e,03,80,c2,08,8a,c2,c3,a1,34,11,87,06,38,11
2d86  db a3,34,11,a1,36,11,87,06,3a,11,a3,36,11,c3,2b,06
2d96  db 36,11,f7,2e,30,11,f7,3e,32,11,01,06,34,11,c3,2b
2da6  db 06,34,11,f7,2e,32,11,f7,3e,30,11,01,06,36,11,c3
2db6  db 80,3e,92,00,00,75,36,50,53,51,52,e8,3e,fe,72,05
2dc6  db 87,da,e8,37,fe,5a,59,5b,58,73,23,8b,3e,88,00,8b
2dd6  db 36,8c,00,e8,19,00,91,e8,15,00,91,8b,3e,8a,00,8b
2de6  db 36,8e,00,93,e8,08,00,93,92,e8,03,00,92,f9,c3,3b
2df6  db c7,7d,03,8b,c7,c3,3b,c6,76,02,8b,c6,c3,80,3e,92
2e06  db 00,00,75,18,3b,06,8c,00,77,14,3b,1e,8e,00,77,0e
2e16  db 3b,06,88,00,7c,08,3b,1e,8a,00,7c,02,f9,c3,f8,c3
2e26  db 00,00,00,00,00,00,00,00,08,00,00,00,00,32,ed,e3
2e36  db 0e,53,06,88,0e,6c,13,e8,0e,01,07,5b,e8,3b,01,c3
2e46  db 80,3e,6f,00,00,75,06,e8,0d,00,e9,16,ed,be,24,00
2e56  db ff,1e,70,00,e9,0c,ed,22,e4,79,28,80,3e,6f,00,00
2e66  db 75,18,50,53,51,52,be,24,00,ff,1e,70,00,e8,0a,00
2e76  db 5a,59,5b,58,80,e4,7f,e9,db,01,89,1e,64,13,89,0e
2e86  db 66,13,c3,a3,60,13,89,1e,64,13,89,0e,66,13,c7,06
2e96  db 68,13,08,00,c6,06,99,00,00,c7,06,6a,13,00,00,c7
2ea6  db 06,68,15,00,00,80,3e,7c,00,03,74,17,22,c0,74,19
2eb6  db e8,4f,02,83,3e,68,15,00,74,0f,c6,06,99,00,ff,89
2ec6  db 1e,68,13,c7,06,6a,13,ff,ff,8b,1e,64,13,8b,0e,66
2ed6  db 13,80,3e,99,00,00,74,03,e8,54,00,a1,60,13,8b,16
2ee6  db 62,13,80,3e,99,00,00,74,05,e8,46,01,eb,19,0b,db
2ef6  db 75,05,bb,08,00,8b,cb,33,d2,80,3e,6f,00,00,75,07
2f06  db be,24,00,ff,1e,70,00,89,1e,64,13,89,0e,66,13,c3
2f16  db 00,00,03,05,02,03,03,04,01,01,04,03,05,03,02,01
2f26  db 05,02,03,01,04,01,e8,06,00,a1,60,13,e9,03,01,8b
2f36  db 1e,68,13,83,fb,0a,72,03,bb,0a,00,d0,e3,8b,9f,50
2f46  db 14,8a,cf,32,ed,32,ff,c3,a1,f0,02,8b,1e,f2,02,53
2f56  db 8b,d8,80,3e,6a,13,00,75,03,e8,4f,00,58,53,8b,d8
2f66  db 80,3e,6b,13,00,75,03,e8,68,00,58,a3,f0,02,89,1e
2f76  db f2,02,be,08,00,ff,1e,70,00,c3,80,3e,6a,13,00,75
2f86  db 08,a1,f0,02,23,c0,79,01,c3,8a,0e,6c,13,32,ed,a1
2f96  db 62,13,80,3e,7c,00,00,75,0a,80,3e,99,00,00,74,03
2fa6  db e9,46,03,be,26,00,ff,1e,70,00,c3,a1,66,13,80,3e
2fb6  db 61,13,01,74,10,80,3e,62,13,00,74,15,a0,6c,13,32
2fc6  db e4,f7,26,64,13,80,3e,62,13,01,75,03,d1,e8,48,2b
2fd6  db d8,c3,a1,66,13,80,3e,61,13,01,75,09,a0,6c,13,32
2fe6  db e4,f7,26,64,13,80,3e,63,13,02,74,0b,80,3e,63,13
2ff6  db 01,75,02,d1,e8,2b,d8,c3,00,00,00,00,00,00,00,00
3006  db ff,00,01,00,01,00,01,00,01,00,01,00,01,00,01,00
3016  db 01,00,2b,00,00,00,00,00,00,00,00,00,00,00,00,00
3026  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
3036  db 00,00,80,3e,7c,00,03,74,1b,88,26,41,15,3a,06,40
3046  db 15,74,27,a2,40,15,53,51,e8,85,00,59,5b,72,1b,c6
3056  db 06,40,15,ff,c3,a3,4a,15,89,1e,4c,15,89,0e,4e,15
3066  db 89,16,50,15,33,db,89,1e,68,13,23,db,75,24,a1,4a
3076  db 15,a3,42,15,a1,4e,15,a3,46,15,a1,4c,15,23,c0,75
3086  db 01,40,a3,44,15,a1,50,15,23,c0,75,01,40,a3,48,15
3096  db eb,31,89,1e,42,15,89,1e,46,15,89,0e,44,15,89,0e
30a6  db 48,15,80,3e,41,15,00,75,1a,8b,1e,81,00,b9,10,27
30b6  db 3b,d9,73,0f,f7,e1,f7,f3,8b,d8,23,db,75,01,43,89
30c6  db 1e,42,15,e8,4b,00,8b,1e,6a,15,8b,0e,6c,15,f9,c3
30d6  db a1,68,15,23,c0,75,06,c6,06,40,15,ff,c3,c7,06,66
30e6  db 15,00,00,c5,36,66,15,b9,10,00,bf,52,15,0e,07,f3
30f6  db a4,0e,1f,80,3e,52,15,2b,c6,06,59,15,00,f9,74,01
3106  db f5,c3,8e,c2,33,f6,26,80,3c,2b,75,04,89,16,68,15
3116  db c3,a0,5a,15,2a,06,5c,15,32,e4,50,f7,26,42,15,f7
3126  db 36,44,15,a3,6a,15,58,f7,26,46,15,f7,36,48,15,a3
3136  db 6c,15,c3,e8,09,00,8b,1e,6e,15,8b,0e,6c,15,c3,53
3146  db 51,e8,cd,ff,a1,53,15,d1,e0,05,10,00,c5,3e,66,15
3156  db 03,f8,33,d2,e3,1e,26,8a,07,43,2e,2a,06,56,15,2e
3166  db 3a,06,53,15,73,0c,32,e4,8b,f7,03,f0,02,14,73,02
3176  db fe,c6,e2,e2,0e,1f,8b,c2,f7,26,42,15,f7,36,44,15
3186  db a3,6e,15,59,5b,c3,c7,06,62,15,00,00,c7,06,64,15
3196  db 00,00,2a,06,56,15,3a,06,53,15,72,01,c3,32,e4,d1
31a6  db e0,c4,3e,66,15,8b,df,83,c3,10,03,d8,26,03,3f,03
31b6  db 3e,57,15,80,3e,59,15,00,74,05,eb,77,90,5f,07,e8
31c6  db 59,00,06,57,d0,e0,32,e4,8b,f8,ff,a5,0e,17,16,17
31d6  db 45,17,3b,17,47,17,a1,62,15,8b,1e,64,15,8a,0e,92
31e6  db 00,80,e1,01,8a,2e,41,15,3a,cd,75,08,22,c9,74,05
31f6  db f7,d8,eb,01,93,e8,ab,01,5f,07,c3,e8,93,00,a3,62
3206  db 15,89,1e,64,15,eb,b6,e8,87,00,8b,c8,8b,d3,87,0e
3216  db 62,15,87,16,64,15,e8,95,01,eb,a2,26,8b,0d,86,e9
3226  db 47,47,32,c0,f6,c5,80,74,02,04,02,f6,c1,80,74,02
3236  db fe,c0,c3,06,57,33,c0,e8,33,ed,5f,07,e8,dc,ff,06
3246  db 57,d0,e0,32,e4,8b,f8,ff,95,8f,17,5f,07,eb,ed,97
3256  db 17,a5,17,b0,17,b0,17,ff,0e,a1,04,b8,03,00,e8,0c
3266  db ed,58,e9,71,ff,b8,03,00,e8,02,ed,33,c0,e9,fd,ec
3276  db e8,1e,00,a3,62,15,89,1e,64,15,f7,db,80,3e,92,00
3286  db 00,74,03,f7,d8,93,03,06,f0,02,03,1e,f2,02,e9,97
3296  db eb,8a,c5,e8,10,00,e8,22,00,50,8a,c1,e8,07,00,e8
32a6  db 30,00,8b,d8,58,c3,33,d2,24,7f,8a,d8,32,ff,24,40
32b6  db 74,06,fe,cf,4a,80,cb,80,8b,c3,c3,8b,1e,42,15,83
32c6  db fb,01,74,02,f7,eb,8b,1e,44,15,83,fb,01,74,02,f7
32d6  db fb,c3,8b,1e,46,15,83,fb,01,74,02,f7,eb,8b,1e,48
32e6  db 15,83,fb,01,74,02,f7,fb,c3,80,3e,40,15,ff,74,45
32f6  db e3,43,ff,36,9e,00,a3,70,15,06,53,e8,38,00,51,32
3306  db c0,b9,01,00,e8,74,ea,80,3e,59,15,00,74,08,a1,9a
3316  db 00,86,c4,e8,3a,ea,59,5b,07,26,8a,07,22,c0,74,0c
3326  db 06,53,51,e8,60,fe,59,5b,07,43,e2,ed,58,50,e8,4a
3336  db ea,8f,06,9e,00,c3,51,e8,05,fe,e8,05,00,e8,35,00
3346  db 59,c3,a1,6e,15,80,3e,41,15,00,74,07,a1,6c,15,01
3356  db 06,f0,02,80,3e,70,15,00,74,1a,80,3e,70,15,01,75
3366  db 03,d1,e8,48,80,3e,92,00,00,74,05,01,06,f2,02,c3
3376  db 29,06,f0,02,c3,a1,6e,15,80,3e,41,15,00,75,03,a1
3386  db 6c,15,80,3e,71,15,00,74,19,80,3e,71,15,01,75,02
3396  db d1,e8,80,3e,92,00,00,74,05,01,06,f0,02,c3,01,06
33a6  db f2,02,c3,f7,db,01,1e,f2,02,01,06,f0,02,c3,50,a0
33b6  db 92,00,24,01,8a,26,41,15,3a,c4,75,0b,22,c0,58,74
33c6  db 0e,f7,d8,f7,d9,eb,0c,58,93,87,ca,f7,d8,f7,d9,f7
33d6  db db,f7,da,03,06,f0,02,03,1e,f2,02,03,0e,f0,02,03
33e6  db 16,f2,02,e8,16,f8,73,07,be,0c,00,ff,1e,70,00,c3
33f6  db 00,00,00,00,00,00,00,00,00,00

;==============================================================================
; SEGMENT 0fd3  DOS   (linear 0fd30..0fdd0)
;==============================================================================

; ------------------------------------------------------------
Dos_MsDos:
0000  pop    si
0001  pop    dx
0002  pop    cx
0003  pop    bx
0004  mov    al, 0x21
0006  push   ax
0007  push   bx
0008  push   cx
0009  push   dx
000a  push   si

; ------------------------------------------------------------
Dos_Intr:
000b  push   bp
000c  push   ds
000d  mov    bp, sp
000f  pushf
0010  mov    bx, 0x45
0013  push   cs
0014  push   bx
0015  xor    bx, bx
0017  mov    ds, bx
0019  mov    bl, byte ptr [bp + 0xc]
001c  shl    bx, 1
001e  shl    bx, 1
0020  lds    bx, ptr [bx]
0022  push   ds
0023  push   bx
0024  lds    si, ptr [bp + 8]
0027  cld
0028  lodsw  ax, word ptr [si]
0029  push   ax
002a  lodsw  ax, word ptr [si]
002b  mov    bx, ax
002d  lodsw  ax, word ptr [si]
002e  mov    cx, ax
0030  lodsw  ax, word ptr [si]
0031  mov    dx, ax
0033  lodsw  ax, word ptr [si]
0034  mov    bp, ax
0036  lodsw  ax, word ptr [si]
0037  push   ax
0038  lodsw  ax, word ptr [si]
0039  mov    di, ax
003b  lodsw  ax, word ptr [si]
003c  push   ax
003d  lodsw  ax, word ptr [si]
003e  mov    es, ax
0040  pop    ds
0041  pop    si
0042  pop    ax
0043  cli
0044  retf
0045  db 9c,06,57,55,8b,ec,c4,7e,10,fc,ab,8b,c3,ab,8b,c1
0055  db ab,8b,c2,ab,58,ab,8b,c6,ab,58,ab,8c,d8,ab,58,ab
0065  db 58,ab,1f,5d,ca,06,00

; ------------------------------------------------------------
Dos_GetIntVec:
006c  push   bp
006d  mov    bp, sp
006f  mov    al, byte ptr [bp + 0xa]
0072  mov    ah, 0x35
0074  int    0x21
0076  mov    ax, es
0078  les    di, ptr [bp + 6]
007b  cld
007c  xchg   bx, ax
007d  stosw  word ptr es:[di], ax
007e  xchg   bx, ax
007f  stosw  word ptr es:[di], ax
0080  pop    bp
0081  retf   6

; ------------------------------------------------------------
Dos_SetIntVec:
0084  push   bp
0085  mov    bp, sp
0087  push   ds
0088  lds    dx, ptr [bp + 6]
008b  mov    al, byte ptr [bp + 0xa]
008e  mov    ah, 0x25
0090  int    0x21
0092  pop    ds
0093  pop    bp
0094  retf   6
0097  db 00,00,00,00,00,00,00,00,00

;==============================================================================
; SEGMENT 0fdd  CRT   (linear 0fdd0..103f0)
;==============================================================================

; ------------------------------------------------------------
Crt_init:
0000  push   bp
0001  mov    bp, sp
0003  call   sub_0fdd_0030
0006  mov    di, 0xce12
0009  push   ds
000a  push   di
000b  push   cs
000c  call   sub_0fdd_032e
000f  mov    di, 0xce12
0012  push   ds
0013  push   di
0014  call   Sys_ResetText
0019  mov    di, 0xcf12
001c  push   ds
001d  push   di
001e  push   cs
001f  call   sub_0fdd_032e
0022  mov    di, 0xcf12
0025  push   ds
0026  push   di
0027  call   Sys_RewriteText
002c  mov    sp, bp
002e  pop    bp
002f  retf

; ------------------------------------------------------------
sub_0fdd_0030:
0030  mov    ah, 0xf
0032  call   sub_0fdd_0608
0035  cmp    al, 7
0037  je     0x43
0039  cmp    al, 3
003b  jbe    0x43
003d  mov    ax, 3
0040  call   sub_0fdd_0099
  loc_0043:
0043  call   sub_0fdd_00e7
0046  mov    ah, 8
0048  xor    bh, bh
004a  call   sub_0fdd_0608
004d  mov    al, ah
004f  and    al, 0x7f
0051  mov    byte ptr [0xce0e], al
0054  mov    byte ptr [0xce04], al
0057  xor    ax, ax
0059  mov    byte ptr [0xcdff], al
005c  mov    byte ptr [0xce0f], al
005f  mov    byte ptr [0xce10], al
0062  inc    ax
0063  mov    byte ptr [0xcdfe], al
0066  mov    ax, 0x40
0069  mov    es, ax
006b  mov    di, 0x6c
006e  mov    al, byte ptr es:[di]
  loc_0071:
0071  cmp    al, byte ptr es:[di]
0074  je     0x71
0076  mov    al, byte ptr es:[di]
0079  mov    cx, 0xffff
007c  call   sub_0fdd_02be
007f  mov    ax, 0x37
0082  xchg   cx, ax
0083  not    ax
0085  xor    dx, dx
0087  div    cx
0089  mov    word ptr [0xce0a], ax
008c  push   ds
008d  push   cs
008e  pop    ds
008f  mov    dx, 0x12f
0092  mov    ax, 0x251b
0095  int    0x21
0097  pop    ds
0098  ret

; ------------------------------------------------------------
sub_0fdd_0099:
0099  mov    dx, 0x40
009c  mov    es, dx
009e  and    byte ptr es:[0x87], 0xfe
00a4  cmp    al, 7
00a6  je     0xae
00a8  cmp    al, 4
00aa  jb     0xae
00ac  mov    al, 3
  loc_00ae:
00ae  push   ax
00af  mov    ah, 0
00b1  call   sub_0fdd_0608
00b4  pop    ax
00b5  or     ah, ah
00b7  je     0xe6
00b9  mov    ax, 0x1112
00bc  mov    bl, 0
00be  call   sub_0fdd_0608
00c1  mov    ax, 0x1130
00c4  mov    bh, 0
00c6  mov    dl, 0
00c8  call   sub_0fdd_0608
00cb  cmp    dl, 0x2a
00ce  jne    0xe6
00d0  or     byte ptr es:[0x87], 1
00d6  mov    ax, 0x100
00d9  mov    cx, 0x600
00dc  call   sub_0fdd_0608
00df  mov    ah, 0x12
00e1  mov    bl, 0x20
00e3  call   sub_0fdd_0608
  loc_00e6:
00e6  ret

; ------------------------------------------------------------
sub_0fdd_00e7:
00e7  mov    ah, 0xf
00e9  call   sub_0fdd_0608
00ec  push   ax
00ed  mov    ax, 0x1130
00f0  mov    bh, 0
00f2  mov    dl, 0
00f4  call   sub_0fdd_0608
00f7  pop    ax
00f8  mov    cl, 0
00fa  or     dl, dl
00fc  jne    0x106
00fe  mov    dl, 0x18
0100  cmp    al, 3
0102  ja     0x106
0104  mov    cl, 1
  loc_0106:
0106  mov    dh, dl
0108  mov    dl, ah
010a  dec    dl
010c  mov    ah, 0
010e  cmp    dh, 0x18
0111  jbe    0x115
0113  mov    ah, 1
  loc_0115:
0115  mov    word ptr [0xce02], ax
0118  mov    word ptr [0xce0c], dx
011c  mov    byte ptr [0xce01], cl
0120  mov    byte ptr [0xce00], 1
0125  xor    ax, ax
0127  mov    word ptr [0xce06], ax
012a  mov    word ptr [0xce08], dx
012e  ret
012f  db 50,1e,b8,61,11,8e,d8,80,3e,fe,cd,00,74,05,c6,06
013f  db 10,ce,01,1f,58,cf

; ------------------------------------------------------------
sub_0fdd_0145:
0145  cmp    byte ptr [0xce10], 0
014a  jne    0x14d
014c  ret
  loc_014d:
014d  mov    byte ptr [0xce10], 0
  loc_0152:
0152  mov    ah, 1
0154  int    0x16
0156  je     0x15e
0158  mov    ah, 0
015a  int    0x16
015c  jmp    0x152
  loc_015e:
015e  mov    al, 0x5e
0160  call   sub_0fdd_047b
0163  mov    al, 0x43
0165  call   sub_0fdd_047b
0168  call   sub_0fdd_0474
016b  int    0x23
016d  mov    bx, sp
016f  mov    ax, word ptr ss:[bx + 4]
0173  call   sub_0fdd_0099
0176  call   sub_0fdd_00e7
0179  mov    al, byte ptr [0xce0e]
017c  mov    byte ptr [0xce04], al
017f  retf   2
0182  db 8b,dc,36,8a,57,0a,36,8a,77,08,36,8a,4f,06,36,8a
0192  db 6f,04,3a,d1,77,27,3a,f5,77,23,fe,ca,78,1f,fe,ce
01a2  db 78,1b,fe,c9,3a,0e,0c,ce,77,13,fe,cd,3a,2e,0d,ce
01b2  db 77,0b,89,16,06,ce,89,0e,08,ce,e8,3d,03,ca,08,00

; ------------------------------------------------------------
Crt_ClrScr:
01c2  mov    ax, 0x600
01c5  mov    bh, byte ptr [0xce04]
01c9  mov    cx, word ptr [0xce06]
01cd  mov    dx, word ptr [0xce08]
01d1  call   sub_0fdd_0608
01d4  mov    dx, word ptr [0xce06]
01d8  call   sub_0fdd_04fc
01db  retf
01dc  db e8,16,03,b8,00,06,8a,3e,04,ce,8b,ca,8a,16,08,ce
01ec  db e8,19,04,cb,b8,01,07,eb,03,b8,01,06,50,e8,f9,02
01fc  db 58,8a,3e,04,ce,8a,0e,06,ce,8a,ee,8b,16,08,ce,3a
020c  db ee,75,02,32,c0,e8,f4,03,cb,8b,dc,36,8a,57,06,36
021c  db 8a,77,04,fe,ca,02,16,06,ce,72,17,3a,16,08,ce,77
022c  db 11,fe,ce,02,36,07,ce,72,09,3a,36,09,ce,77,03,e8
023c  db be,02,ca,04,00,e8,b1,02,8a,c2,2a,06,06,ce,fe,c0
024c  db cb,e8,a5,02,8a,c6,2a,06,07,ce,fe,c0,cb,8b,dc,36
025c  db 8a,47,04,a8,f0,74,04,24,0f,0c,80,80,26,04,ce,70
026c  db 08,06,04,ce,ca,02,00,8b,dc,36,8a,47,04,24,07,b1
027c  db 04,d2,e0,80,26,04,ce,8f,08,06,04,ce,ca,02,00,80
028c  db 26,04,ce,f7,cb,80,0e,04,ce,08,cb,a0,0e,ce,a2,04
029c  db ce,cb

; ------------------------------------------------------------
Crt_Delay:
029e  mov    bx, sp
02a0  mov    dx, word ptr ss:[bx + 4]
02a4  or     dx, dx
02a6  je     0x2bb
02a8  xor    di, di
02aa  mov    es, di
02ac  mov    al, byte ptr es:[di]
02af  mov    bx, word ptr [0xce0a]
  loc_02b3:
02b3  mov    cx, bx
02b5  call   sub_0fdd_02be
02b8  dec    dx
02b9  jne    0x2b3
  loc_02bb:
02bb  retf   2

; ------------------------------------------------------------
sub_0fdd_02be:
02be  cmp    al, byte ptr es:[di]
02c1  jne    0x2c5
02c3  loop   0x2be
  loc_02c5:
02c5  ret

; ------------------------------------------------------------
Crt_Sound:
02c6  mov    bx, sp
02c8  mov    bx, word ptr ss:[bx + 4]
02cc  mov    ax, 0x34dd
02cf  mov    dx, 0x12
02d2  cmp    dx, bx
02d4  jae    0x2f0
02d6  div    bx
02d8  mov    bx, ax
02da  in     al, 0x61
02dc  test   al, 3
02de  jne    0x2e8
02e0  or     al, 3
02e2  out    0x61, al
02e4  mov    al, 0xb6
02e6  out    0x43, al
  loc_02e8:
02e8  mov    al, bl
02ea  out    0x42, al
02ec  mov    al, bh
02ee  out    0x42, al
  loc_02f0:
02f0  retf   2

; ------------------------------------------------------------
Crt_NoSound:
02f3  in     al, 0x61
02f5  and    al, 0xfc
02f7  out    0x61, al
02f9  retf

; ------------------------------------------------------------
Crt_KeyPressed:
02fa  cmp    byte ptr [0xce0f], 0
02ff  jne    0x309
0301  mov    ah, 1
0303  int    0x16
0305  mov    al, 0
0307  je     0x30b
  loc_0309:
0309  mov    al, 1
  loc_030b:
030b  retf

; ------------------------------------------------------------
Crt_ReadKey:
030c  mov    al, byte ptr [0xce0f]
030f  mov    byte ptr [0xce0f], 0
0314  or     al, al
0316  jne    0x32a
0318  xor    ah, ah
031a  int    0x16
031c  or     al, al
031e  jne    0x32a
0320  mov    byte ptr [0xce0f], ah
0324  or     ah, ah
0326  jne    0x32a
0328  mov    al, 3
  loc_032a:
032a  call   sub_0fdd_0145
032d  retf

; ------------------------------------------------------------
sub_0fdd_032e:
032e  mov    bx, sp
0330  push   ds
0331  lds    di, ptr ss:[bx + 4]
0335  mov    word ptr [di + 2], 0xd7b0
033a  mov    word ptr [di + 4], 0x80
033f  lea    ax, [di + 0x80]
0343  mov    word ptr [di + 0xc], ax
0346  mov    word ptr [di + 0xe], ds
0349  mov    word ptr [di + 0x10], 0x359
034e  mov    word ptr [di + 0x12], cs
0351  mov    byte ptr [di + 0x30], 0
0355  pop    ds
0356  retf   4
0359  db 8b,dc,1e,36,c5,7f,04,b8,91,03,bb,6f,04,8b,cb,81
0369  db 7d,02,b1,d7,74,0a,c7,45,02,b2,d7,b8,3e,04,8b,d8
0379  db 89,45,14,8c,4d,16,89,5d,18,8c,4d,1a,89,4d,1c,8c
0389  db 4d,1e,33,c0,1f,ca,04,00,55,8b,ec,c4,7e,06,26,8b
0399  db 55,04,4a,4a,26,8b,75,08,26,c4,7d,0c,33,db,c6,06
03a9  db 0f,ce,00,0e,e8,5c,ff,b9,01,00,3c,08,74,34,3c,13
03b9  db 74,30,3c,04,74,44,49,3c,1b,74,27,3c,01,74,23,3c
03c9  db 06,74,37,3c,1a,74,46,3c,0d,74,4f,3c,20,72,cf,3b
03d9  db da,74,cb,26,88,01,43,e8,98,00,3b,de,76,c0,8b,f3
03e9  db eb,bc,0b,db,74,b8,b0,08,e8,87,00,b0,20,e8,82,00
03f9  db b0,08,e8,7d,00,4b,e2,ea,eb,a4,3b,de,74,a0,26,8a
0409  db 01,3c,20,72,99,e8,6a,00,43,e2,ef,eb,91,80,3e,ff
0419  db cd,00,74,8a,26,88,01,43,eb,0a,e8,4e,00,26,c7,01
0429  db 0d,0a,43,43,c4,7e,06,33,c0,26,89,45,08,26,89,5d
0439  db 0a,5d,ca,04,00,8b,dc,36,c4,7f,04,26,8b,4d,08,26
0449  db 29,4d,08,e3,19,26,c4,7d,0c,80,3e,00,ce,00,75,0b
0459  db 26,8a,05,e8,1c,00,47,e2,f7,eb,03,e8,9c,00,e8,db
0469  db fc,33,c0,ca,04,00,33,c0,ca,04,00

; ------------------------------------------------------------
sub_0fdd_0474:
0474  mov    al, 0xd
0476  call   sub_0fdd_047b
0479  mov    al, 0xa

; ------------------------------------------------------------
sub_0fdd_047b:
047b  push   bx
047c  push   cx
047d  push   dx
047e  push   es
047f  push   ax
0480  call   sub_0fdd_04f5
0483  pop    ax
0484  cmp    al, 7
0486  je     0x4b2
0488  cmp    al, 8
048a  je     0x4b9
048c  cmp    al, 0xd
048e  je     0x4c3
0490  cmp    al, 0xa
0492  je     0x4c9
0494  mov    ah, 9
0496  mov    bl, byte ptr [0xce04]
049a  xor    bh, bh
049c  mov    cx, 1
049f  push   dx
04a0  call   sub_0fdd_0608
04a3  pop    dx
04a4  inc    dl
04a6  cmp    dl, byte ptr [0xce08]
04aa  jbe    0x4cc
04ac  mov    dl, byte ptr [0xce06]
04b0  jmp    0x4c9
  loc_04b2:
04b2  mov    ah, 0xe
04b4  call   sub_0fdd_0608
04b7  jmp    0x4cc
  loc_04b9:
04b9  cmp    dl, byte ptr [0xce06]
04bd  je     0x4cc
04bf  dec    dl
04c1  jmp    0x4cc
  loc_04c3:
04c3  mov    dl, byte ptr [0xce06]
04c7  jmp    0x4cc
  loc_04c9:
04c9  call   sub_0fdd_04d4
  loc_04cc:
04cc  call   sub_0fdd_04fc
04cf  pop    es
04d0  pop    dx
04d1  pop    cx
04d2  pop    bx
04d3  ret

; ------------------------------------------------------------
sub_0fdd_04d4:
04d4  inc    dh
04d6  cmp    dh, byte ptr [0xce09]
04da  jbe    0x4f4
04dc  dec    dh
04de  push   cx
04df  push   dx
04e0  mov    ax, 0x601
04e3  mov    bh, byte ptr [0xce04]
04e7  mov    cx, word ptr [0xce06]
04eb  mov    dx, word ptr [0xce08]
04ef  call   sub_0fdd_0608
04f2  pop    dx
04f3  pop    cx
  loc_04f4:
04f4  ret

; ------------------------------------------------------------
sub_0fdd_04f5:
04f5  mov    ah, 3
04f7  xor    bh, bh
04f9  jmp    0x608

; ------------------------------------------------------------
sub_0fdd_04fc:
04fc  mov    ah, 2
04fe  xor    bh, bh
0500  jmp    0x608
0503  db 1e,b8,40,00,8e,d8,8b,16,50,00,1f,8b,da,8b,f7,26
0513  db 8a,05,3c,07,74,21,3c,08,74,2c,3c,0a,74,35,3c,0d
0523  db 74,39,47,fe,c2,3a,16,08,ce,76,3c,e8,6f,00,e8,a0
0533  db ff,8a,16,06,ce,eb,2c,e8,63,00,51,52,b8,07,0e,e8
0543  db c3,00,5a,59,eb,1c,e8,54,00,3a,16,06,ce,74,13,fe
0553  db ca,eb,0f,e8,47,00,e8,78,ff,eb,07,e8,3f,00,8a,16
0563  db 06,ce,47,8b,f7,8b,da,e2,a6,e8,31,00,1e,b8,40,00
0573  db 8e,d8,89,16,50,00,8a,c6,f6,26,4a,00,32,f6,03,c2
0583  db 8b,c8,8b,16,63,00,b0,0e,ee,eb,00,8a,c5,42,ee,eb
0593  db 00,4a,b0,0f,ee,eb,00,8a,c1,42,ee,1f,c3,3b,f7,74
05a3  db 63,51,52,57,1e,06,8b,cf,2b,ce,8a,16,01,ce,8a,36
05b3  db 04,ce,b8,40,00,8e,d8,8a,c7,f6,26,4a,00,32,ff,03
05c3  db c3,d1,e0,8b,f8,8b,da,8b,16,63,00,83,c2,06,b8,00
05d3  db b8,80,3e,49,00,07,75,02,b4,b0,06,1f,8e,c0,fc,0a
05e3  db db,74,16,ac,8a,d8,ec,a8,01,75,fb,fa,ec,a8,01,74
05f3  db fb,8b,c3,ab,fb,e2,ec,eb,06,8a,e7,ac,ab,e2,fc,07
0603  db 1f,5f,5a,59,c3

; ------------------------------------------------------------
sub_0fdd_0608:
0608  push   si
0609  push   di
060a  push   bp
060b  push   es
060c  int    0x10
060e  pop    es
060f  pop    bp
0610  pop    di
0611  pop    si
0612  ret
0613  db 00,00,00,00,00,00,00,00,00,00,00,00,00

;==============================================================================
; SEGMENT 103f  SYSTEM   (linear 103f0..11610)
;==============================================================================

; ------------------------------------------------------------
System_init:
0000  mov    dx, 0x1161                        ; seg DATA
0003  mov    ds, dx
0005  mov    word ptr [0x2958], es
0009  xor    bp, bp
000b  mov    ax, sp
000d  add    ax, 0x13
0010  mov    cl, 4
0012  shr    ax, cl
0014  mov    dx, ss
0016  add    ax, dx
0018  mov    word ptr [0x2930], ax
001b  mov    word ptr [0x2932], ax
001e  add    ax, word ptr [0x292a]
0022  mov    word ptr [0x2934], ax
0025  mov    word ptr [0x293e], ax
0028  mov    word ptr [0x2942], ax
002b  mov    ax, word ptr es:[2]
002f  sub    ax, 0x1000
0032  mov    word ptr [0x2946], ax
0035  mov    di, 0xd012
0038  mov    si, 0x1dd
003b  mov    cx, 0x12
003e  nop
003f  cld
  loc_0040:
0040  lodsb  al, byte ptr cs:[si]
0042  mov    ah, 0x35
0044  int    0x21
0046  mov    word ptr [di], bx
0048  mov    word ptr [di + 2], es
004b  add    di, 4
004e  loop   0x40
0050  push   ds
0051  push   cs
0052  pop    ds
0053  mov    dx, 0xce
0056  mov    ax, 0x2500
0059  int    0x21
005b  mov    dx, 0xd5
005e  mov    ax, 0x2523
0061  int    0x21
0063  mov    dx, 0x9d
0066  mov    ax, 0x2524
0069  int    0x21
006b  mov    dx, 0xc6
006e  mov    ax, 0x253f
0071  int    0x21
0073  pop    ds
0074  mov    ax, 0xce12
0077  push   ds
0078  push   ax
0079  push   ds
007a  push   ax
007b  mov    ax, 0x206
007e  push   cs
007f  push   ax
0080  push   cs
0081  call   sub_103f_0ba2
0084  push   cs
0085  call   Sys_ResetText
0088  mov    ax, 0xcf12
008b  push   ds
008c  push   ax
008d  push   ds
008e  push   ax
008f  mov    ax, 0x206
0092  push   cs
0093  push   ax
0094  push   cs
0095  call   sub_103f_0ba2
0098  push   cs
0099  call   Sys_RewriteText
009c  retf
009d  db fb,83,c4,06,58,83,e7,1f,81,c7,96,00,80,fc,39,73
00ad  db 03,bf,ff,ff,57,b4,54,cd,21,8b,ec,80,4e,16,01,58
00bd  db 5b,59,5a,5e,5f,5d,1f,07,cf,b8,d0,00,83,c4,06,eb
00cd  db 03,b8,c8,00
  loc_00d1:
00d1  pop    cx
00d2  pop    bx
00d3  jmp    0xdc
00d5  db b8,ff,00

; ------------------------------------------------------------
Sys_Halt:
00d8  xor    cx, cx
00da  xor    bx, bx
  loc_00dc:
00dc  mov    dx, 0x1161                        ; seg DATA
00df  mov    ds, dx
00e1  sti
00e2  mov    word ptr [0x2952], ax
00e5  mov    ax, cx
00e7  or     ax, bx
00e9  je     0x10a
00eb  mov    ax, word ptr [0x2936]
  loc_00ee:
00ee  or     ax, ax
00f0  je     0x103
00f2  mov    es, ax
00f4  cmp    bx, word ptr es:[0x10]
00f9  je     0x101
00fb  mov    ax, word ptr es:[0x14]
00ff  jmp    0xee
  loc_0101:
0101  mov    bx, es
  loc_0103:
0103  sub    bx, word ptr [0x2958]
0107  sub    bx, 0x10
  loc_010a:
010a  mov    word ptr [0x2954], cx
010e  mov    word ptr [0x2956], bx
0112  les    bx, ptr [0x294e]
0116  mov    ax, es
0118  or     ax, bx
011a  je     0x12f
011c  xor    ax, ax
011e  mov    word ptr [0x294e], ax
0121  mov    word ptr [0x2950], ax
0124  mov    word ptr [0x295c], ax
0127  mov    ax, 0x112
012a  push   cs
012b  push   ax
012c  push   es
012d  push   bx
012e  retf
  loc_012f:
012f  mov    ax, 0xce12
0132  push   ds
0133  push   ax
0134  push   cs
0135  call   sub_103f_0c6b
0138  mov    ax, 0xcf12
013b  push   ds
013c  push   ax
013d  push   cs
013e  call   sub_103f_0c6b
0141  mov    di, 0xd012
0144  mov    si, 0x1dd
0147  mov    cx, 0x12
014a  nop
014b  cld
  loc_014c:
014c  lodsb  al, byte ptr cs:[si]
014e  mov    ah, 0x25
0150  push   ds
0151  lds    dx, ptr [di]
0153  int    0x21
0155  pop    ds
0156  add    di, 4
0159  loop   0x14c
015b  mov    ax, word ptr [0x2954]
015e  or     ax, word ptr [0x2956]
0162  je     0x18d
0164  mov    bx, 0x1ef
0167  call   sub_103f_0194
016a  mov    ax, word ptr [0x2952]
016d  call   sub_103f_01a2
0170  mov    bx, 0x1fe
0173  call   sub_103f_0194
0176  mov    ax, word ptr [0x2956]
0179  call   sub_103f_01bc
017c  mov    al, 0x3a
017e  call   sub_103f_01d6
0181  mov    ax, word ptr [0x2954]
0184  call   sub_103f_01bc
0187  mov    bx, 0x203
018a  call   sub_103f_0194
  loc_018d:
018d  mov    ax, word ptr [0x2952]
0190  mov    ah, 0x4c
0192  int    0x21

; ------------------------------------------------------------
sub_103f_0194:
0194  mov    al, byte ptr cs:[bx]
0197  or     al, al
0199  je     0x1a1
019b  call   sub_103f_01d6
019e  inc    bx
019f  jmp    0x194
  loc_01a1:
01a1  ret

; ------------------------------------------------------------
sub_103f_01a2:
01a2  mov    cl, 0x64
01a4  call   sub_103f_01ae
01a7  mov    cl, 0xa
01a9  call   sub_103f_01ae
01ac  jmp    0x1b2

; ------------------------------------------------------------
sub_103f_01ae:
01ae  xor    ah, ah
01b0  div    cl
  loc_01b2:
01b2  add    al, 0x30
01b4  push   ax
01b5  call   sub_103f_01d6
01b8  pop    ax
01b9  mov    al, ah
01bb  ret

; ------------------------------------------------------------
sub_103f_01bc:
01bc  push   ax
01bd  mov    al, ah
01bf  call   sub_103f_01c3
01c2  pop    ax

; ------------------------------------------------------------
sub_103f_01c3:
01c3  push   ax
01c4  mov    cl, 4
01c6  shr    al, cl
01c8  call   sub_103f_01ce
01cb  pop    ax
01cc  and    al, 0xf

; ------------------------------------------------------------
sub_103f_01ce:
01ce  add    al, 0x30
01d0  cmp    al, 0x3a
01d2  jb     0x1d6
01d4  add    al, 7

; ------------------------------------------------------------
sub_103f_01d6:
01d6  mov    dl, al
01d8  mov    ah, 6
01da  int    0x21
01dc  ret
01dd  db 00,02,1b,23,24,34,35,36,37,38,39,3a,3b,3c,3d,3e
01ed  db 3f,75,52,75,6e,74,69,6d,65,20,65,72,72,6f,72,20
01fd  db 00,20,61,74,20,00,2e,0d,0a,00

; ------------------------------------------------------------
Sys_IOResult:
0207  xor    ax, ax
0209  xchg   word ptr [0x295c], ax
020d  retf

; ------------------------------------------------------------
Sys_IOCheck:
020e  cmp    word ptr [0x295c], 0
0213  jne    0x216
0215  retf
  loc_0216:
0216  mov    ax, word ptr [0x295c]
0219  jmp    0xd1
021c  db 8b,f4,36,8e,44,02,26,3b,55,02,7f,07,7c,14,26,3b
022c  db 05,72,0f,26,3b,55,06,7c,08,7f,07,26,3b,45,04,77
023c  db 01,cb,b8,c9,00,e9,8d,fe,8b,f4,2b,f0,72,0d,81,ee
024c  db 00,02,72,07,3b,36,5a,29,72,01,cb,b8,ca,00,e9,74
025c  db fe

; ------------------------------------------------------------
Sys_MoveFwd:
025d  mov    bx, sp
025f  mov    dx, ds
0261  lds    si, ptr ss:[bx + 0xa]
0265  les    di, ptr ss:[bx + 6]
0269  mov    cx, word ptr ss:[bx + 4]
026d  cld
026e  rep movsb byte ptr es:[di], byte ptr [si]
0270  mov    ds, dx
0272  retf   0xa
0275  db 8b,c8,8b,da,8b,f0,8b,fa,f7,e1,50,52,8b,c6,f7,e3
0285  db 8b,d8,8b,c7,f7,e1,8b,c8,5a,58,03,d3,03,d1,cb

; ------------------------------------------------------------
sub_103f_0294:
0294  push   bp
0295  mov    bp, cx
0297  or     bp, bx
0299  je     0x2fb
029b  or     bx, bx
029d  pushf
029e  jns    0x2aa
02a0  not    cx
02a2  not    bx
02a4  add    cx, 1
02a7  adc    bx, 0
  loc_02aa:
02aa  or     dx, dx
02ac  pushf
02ad  jns    0x2b9
02af  not    ax
02b1  not    dx
02b3  add    ax, 1
02b6  adc    dx, 0
  loc_02b9:
02b9  mov    si, cx
02bb  mov    di, bx
02bd  xor    cx, cx
02bf  xor    bx, bx
02c1  mov    bp, 0x21
  loc_02c4:
02c4  rcl    cx, 1
02c6  rcl    bx, 1
02c8  sub    cx, si
02ca  sbb    bx, di
02cc  jae    0x2d2
02ce  add    cx, si
02d0  adc    bx, di
  loc_02d2:
02d2  cmc
02d3  rcl    ax, 1
02d5  rcl    dx, 1
02d7  dec    bp
02d8  jne    0x2c4
02da  popf
02db  jns    0x2ec
02dd  not    cx
02df  not    bx
02e1  add    cx, 1
02e4  adc    bx, 0
02e7  popf
02e8  jns    0x2ef
02ea  jmp    0x2f9
  loc_02ec:
02ec  popf
02ed  jns    0x2f9
  loc_02ef:
02ef  not    ax
02f1  not    dx
02f3  add    ax, 1
02f6  adc    dx, 0
  loc_02f9:
02f9  pop    bp
02fa  retf
  loc_02fb:
02fb  pop    bp
02fc  mov    ax, 0xc8
02ff  jmp    0xd1
0302  db 83,e1,1f,74,06,d1,ea,d1,d8,e2,fa,cb,83,e1,1f,74
0312  db 06,d1,e0,d1,d2,e2,fa,cb,0b,d2,7d,0a,f7,d0,f7,d2
0322  db 05,01,00,83,d2,00,cb

; ------------------------------------------------------------
Sys_GetMem:
0329  push   bp
032a  mov    bp, sp
  loc_032c:
032c  mov    ax, word ptr [bp + 6]
032f  call   sub_103f_0446
0332  jae    0x34f
0334  mov    ax, word ptr [0x294a]
0337  or     ax, word ptr [0x294c]
033b  je     0x35d
033d  push   word ptr [bp + 6]
0340  lcall  [0x294a]
0344  or     ax, ax
0346  je     0x35d
0348  dec    ax
0349  jne    0x32c
034b  xor    cx, cx
034d  xor    bx, bx
  loc_034f:
034f  les    di, ptr [bp + 8]
0352  mov    word ptr es:[di], cx
0355  mov    word ptr es:[di + 2], bx
0359  pop    bp
035a  retf   6
  loc_035d:
035d  pop    bp
035e  mov    ax, 0xcb
0361  jmp    0xd1

; ------------------------------------------------------------
Sys_FreeMem:
0364  push   bp
0365  mov    bp, sp
0367  mov    ax, word ptr [bp + 6]
036a  les    di, ptr [bp + 8]
036d  mov    cx, word ptr es:[di]
0370  mov    bx, word ptr es:[di + 2]
0374  call   sub_103f_04e2
0377  jb     0x37d
0379  pop    bp
037a  retf   6
  loc_037d:
037d  pop    bp
037e  mov    ax, 0xcc
0381  jmp    0xd1
0384  db 8b,dc,36,c4,7f,04,a1,40,29,26,89,05,a1,42,29,26
0394  db 89,45,02,ca,04,00,8b,dc,36,c4,7f,04,26,8b,05,a3
03a4  db 40,29,26,8b,45,02,a3,42,29,33,c0,a3,44,29,ca,04
03b4  db 00,e8,16,02,8b,c6,8b,d7,c4,3e,44,29,2b,16,42,29
03c4  db 2b,06,40,29,73,27,05,10,00,4a,eb,21,26,03,55,06
03d4  db 26,2b,55,02,26,03,45,04,3d,10,00,72,04,2d,10,00
03e4  db 42,26,2b,05,73,04,05,10,00,4a,83,c7,08,0b,ff,75
03f4  db db,e8,2d,02,cb,e8,d2,01,8b,c6,8b,d7,c4,3e,44,29
0404  db 2b,16,42,29,2b,06,40,29,73,30,05,10,00,4a,eb,2a
0414  db 26,8b,5d,06,26,2b,5d,02,3b,da,72,1b,26,8b,4d,04
0424  db 26,2b,0d,73,04,83,c1,10,4b,3b,da,77,06,72,08,3b
0434  db c8,72,04,8b,c1,8b,d3,83,c7,08,0b,ff,75,d2,e8,e0
0444  db 01,cb

; ------------------------------------------------------------
sub_103f_0446:
0446  call   sub_103f_0617
0449  les    di, ptr [0x2944]
044d  jmp    0x45e
  loc_044f:
044f  mov    bx, word ptr es:[di + 6]
0453  sub    bx, word ptr es:[di + 2]
0457  cmp    bx, dx
0459  jae    0x49f
  loc_045b:
045b  add    di, 8
  loc_045e:
045e  or     di, di
0460  jne    0x44f
0462  call   sub_103f_05ce
0465  mov    cx, si
0467  mov    bx, di
0469  sub    bx, word ptr [0x2942]
046d  sub    cx, word ptr [0x2940]
0471  jae    0x477
0473  add    cx, 0x10
0476  dec    bx
  loc_0477:
0477  cmp    bx, dx
0479  ja     0x481
047b  jb     0x49e
047d  cmp    cx, ax
047f  jb     0x49e
  loc_0481:
0481  mov    cx, word ptr [0x2940]
0485  mov    bx, word ptr [0x2942]
0489  add    dx, bx
048b  add    ax, cx
048d  cmp    ax, 0x10
0490  jb     0x496
0492  sub    ax, 0x10
0495  inc    dx
  loc_0496:
0496  mov    word ptr [0x2940], ax
0499  mov    word ptr [0x2942], dx
049d  clc
  loc_049e:
049e  ret
  loc_049f:
049f  mov    cx, word ptr es:[di + 4]
04a3  sub    cx, word ptr es:[di]
04a6  jae    0x4ac
04a8  add    cx, 0x10
04ab  dec    bx
  loc_04ac:
04ac  cmp    bx, dx
04ae  ja     0x4b6
04b0  jb     0x45b
04b2  cmp    cx, ax
04b4  jb     0x45b
  loc_04b6:
04b6  mov    cx, word ptr es:[di]
04b9  mov    bx, word ptr es:[di + 2]
04bd  add    dx, bx
04bf  add    ax, cx
04c1  cmp    ax, 0x10
04c4  jb     0x4ca
04c6  sub    ax, 0x10
04c9  inc    dx
  loc_04ca:
04ca  mov    word ptr es:[di], ax
04cd  mov    word ptr es:[di + 2], dx
04d1  cmp    dx, word ptr es:[di + 6]
04d5  jne    0x4e0
04d7  cmp    ax, word ptr es:[di + 4]
04db  jne    0x4e0
04dd  call   sub_103f_05b9
  loc_04e0:
04e0  clc
04e1  ret

; ------------------------------------------------------------
sub_103f_04e2:
04e2  or     ax, ax
04e4  je     0x519
04e6  call   sub_103f_0617
04e9  add    dx, bx
04eb  add    ax, cx
04ed  cmp    ax, 0x10
04f0  jb     0x4f6
04f2  sub    ax, 0x10
04f5  inc    dx
  loc_04f6:
04f6  cmp    bx, word ptr [0x293e]
04fa  jb     0x518
04fc  ja     0x504
04fe  cmp    cx, word ptr [0x293c]
0502  jb     0x518
  loc_0504:
0504  cmp    dx, word ptr [0x2942]
0508  ja     0x518
050a  jb     0x512
050c  cmp    ax, word ptr [0x2940]
0510  ja     0x518
  loc_0512:
0512  les    di, ptr [0x2944]
0516  jmp    0x567
  loc_0518:
0518  stc
  loc_0519:
0519  ret
  loc_051a:
051a  cmp    bx, word ptr es:[di + 2]
051e  jb     0x53e
0520  ja     0x527
0522  cmp    cx, word ptr es:[di]
0525  jb     0x53e
  loc_0527:
0527  cmp    bx, word ptr es:[di + 6]
052b  ja     0x564
052d  jb     0x535
052f  cmp    cx, word ptr es:[di + 4]
0533  ja     0x564
  loc_0535:
0535  mov    cx, word ptr es:[di]
0538  mov    bx, word ptr es:[di + 2]
053c  jmp    0x54b
  loc_053e:
053e  cmp    dx, word ptr es:[di + 2]
0542  jb     0x564
0544  ja     0x54b
0546  cmp    ax, word ptr es:[di]
0549  jb     0x564
  loc_054b:
054b  cmp    dx, word ptr es:[di + 6]
054f  ja     0x561
0551  jb     0x559
0553  cmp    ax, word ptr es:[di + 4]
0557  ja     0x561
  loc_0559:
0559  mov    ax, word ptr es:[di + 4]
055d  mov    dx, word ptr es:[di + 6]
  loc_0561:
0561  call   sub_103f_05b9
  loc_0564:
0564  add    di, 8
  loc_0567:
0567  or     di, di
0569  jne    0x51a
056b  cmp    dx, word ptr [0x2942]
056f  jne    0x580
0571  cmp    ax, word ptr [0x2940]
0575  jne    0x580
0577  mov    word ptr [0x2940], cx
057b  mov    word ptr [0x2942], bx
057f  ret
  loc_0580:
0580  call   sub_103f_0595
0583  jb     0x594
0585  mov    word ptr es:[di], cx
0588  mov    word ptr es:[di + 2], bx
058c  mov    word ptr es:[di + 4], ax
0590  mov    word ptr es:[di + 6], dx
  loc_0594:
0594  ret

; ------------------------------------------------------------
sub_103f_0595:
0595  mov    di, word ptr [0x2944]
0599  sub    di, 8
059c  je     0x5b7
059e  mov    si, di
05a0  shr    si, 1
05a2  shr    si, 1
05a4  shr    si, 1
05a6  shr    si, 1
05a8  add    si, word ptr [0x2946]
05ac  cmp    si, word ptr [0x2942]
05b0  jbe    0x5b7
05b2  mov    word ptr [0x2944], di
05b6  ret
  loc_05b7:
05b7  stc
05b8  ret

; ------------------------------------------------------------
sub_103f_05b9:
05b9  mov    si, word ptr [0x2944]
05bd  cld
05be  movsw  word ptr es:[di], word ptr es:[si]
05c0  movsw  word ptr es:[di], word ptr es:[si]
05c2  movsw  word ptr es:[di], word ptr es:[si]
05c4  movsw  word ptr es:[di], word ptr es:[si]
05c6  sub    di, 8
05c9  mov    word ptr [0x2944], si
05cd  ret

; ------------------------------------------------------------
sub_103f_05ce:
05ce  mov    di, word ptr [0x2944]
05d2  or     di, di
05d4  jne    0x5e7
05d6  sub    di, word ptr [0x2948]
05da  jne    0x5ef
05dc  xor    si, si
05de  mov    di, word ptr [0x2946]
05e2  add    di, 0x1000
05e6  ret
  loc_05e7:
05e7  sub    di, word ptr [0x2948]
05eb  jae    0x5ef
05ed  xor    di, di
  loc_05ef:
05ef  mov    si, di
05f1  and    si, 0xf
05f4  shr    di, 1
05f6  shr    di, 1
05f8  shr    di, 1
05fa  shr    di, 1
05fc  add    di, word ptr [0x2946]
0600  cmp    di, word ptr [0x2942]
0604  ja     0x616
0606  jb     0x60e
0608  cmp    si, word ptr [0x2940]
060c  jae    0x616
  loc_060e:
060e  mov    si, word ptr [0x2940]
0612  mov    di, word ptr [0x2942]
  loc_0616:
0616  ret

; ------------------------------------------------------------
sub_103f_0617:
0617  mov    dx, ax
0619  and    ax, 0xf
061c  shr    dx, 1
061e  shr    dx, 1
0620  shr    dx, 1
0622  shr    dx, 1
0624  ret
0625  db b1,04,d3,c2,8b,ca,83,e1,f0,83,e2,0f,0b,c1,c3

; ------------------------------------------------------------
Sys_StrAssign:
0634  cld
0635  mov    bx, sp
0637  mov    dx, ds
0639  les    di, ptr ss:[bx + 8]
063d  lds    si, ptr ss:[bx + 4]
0641  lodsb  al, byte ptr [si]
0642  stosb  byte ptr es:[di], al
0643  mov    cl, al
0645  xor    ch, ch
0647  rep movsb byte ptr es:[di], byte ptr [si]
0649  mov    ds, dx
064b  retf   4

; ------------------------------------------------------------
Sys_StrStore:
064e  cld
064f  mov    bx, sp
0651  mov    dx, ds
0653  lds    si, ptr ss:[bx + 0xa]
0657  les    di, ptr ss:[bx + 6]
065b  mov    cx, word ptr ss:[bx + 4]
065f  lodsb  al, byte ptr [si]
0660  cmp    al, cl
0662  jbe    0x666
0664  mov    al, cl
  loc_0666:
0666  stosb  byte ptr es:[di], al
0667  mov    cl, al
0669  xor    ch, ch
066b  rep movsb byte ptr es:[di], byte ptr [si]
066d  mov    ds, dx
066f  retf   0xa
0672  db 8b,dc,36,c4,7f,04,26,8a,05,32,e4,ca,04,00

; ------------------------------------------------------------
Sys_Copy:
0680  cld
0681  mov    bx, sp
0683  mov    dx, ds
0685  les    di, ptr ss:[bx + 0xc]
0689  lds    si, ptr ss:[bx + 8]
068d  mov    al, byte ptr [si]
068f  xor    ah, ah
0691  mov    cx, word ptr ss:[bx + 6]
0695  or     cx, cx
0697  jg     0x69c
0699  mov    cx, 1
  loc_069c:
069c  add    si, cx
069e  sub    ax, cx
06a0  jb     0x6b5
06a2  inc    ax
06a3  mov    cx, word ptr ss:[bx + 4]
06a7  or     cx, cx
06a9  jge    0x6ad
06ab  xor    cx, cx
  loc_06ad:
06ad  cmp    ax, cx
06af  jbe    0x6b7
06b1  mov    ax, cx
06b3  jmp    0x6b7
  loc_06b5:
06b5  xor    ax, ax
  loc_06b7:
06b7  stosb  byte ptr es:[di], al
06b8  mov    cx, ax
06ba  rep movsb byte ptr es:[di], byte ptr [si]
06bc  mov    ds, dx
06be  retf   8

; ------------------------------------------------------------
Sys_StrConcat:
06c1  cld
06c2  mov    bx, sp
06c4  mov    dx, ds
06c6  les    di, ptr ss:[bx + 8]
06ca  lds    si, ptr ss:[bx + 4]
06ce  mov    cl, byte ptr es:[di]
06d1  xor    ch, ch
06d3  lodsb  al, byte ptr [si]
06d4  add    byte ptr es:[di], al
06d7  jae    0x6e1
06d9  mov    byte ptr es:[di], 0xff
06dd  mov    al, cl
06df  not    al
  loc_06e1:
06e1  add    di, cx
06e3  inc    di
06e4  mov    cl, al
06e6  rep movsb byte ptr es:[di], byte ptr [si]
06e8  mov    ds, dx
06ea  retf   4
06ed  db fc,8b,dc,1e,36,c5,77,08,36,c4,7f,04,8a,0c,32,ed
06fd  db 26,8a,15,32,f6,2b,d1,72,18,b8,01,00,0b,c9,74,13
070d  db 42,46,47,51,56,57,f3,a6,5f,5e,59,74,06,40,4a,75
071d  db f1,33,c0,1f,ca,08,00

; ------------------------------------------------------------
Sys_StrCmp:
0724  cld
0725  mov    bx, sp
0727  mov    dx, ds
0729  lds    si, ptr ss:[bx + 8]
072d  les    di, ptr ss:[bx + 4]
0731  lodsb  al, byte ptr [si]
0732  mov    ah, byte ptr es:[di]
0735  inc    di
0736  mov    cl, al
0738  cmp    cl, ah
073a  jbe    0x73e
073c  mov    cl, ah
  loc_073e:
073e  or     cl, cl
0740  je     0x748
0742  xor    ch, ch
0744  repe cmpsb byte ptr [si], byte ptr es:[di]
0746  jne    0x74a
  loc_0748:
0748  cmp    al, ah
  loc_074a:
074a  mov    ds, dx
074c  retf   8

; ------------------------------------------------------------
Sys_CharToStr:
074f  cld
0750  mov    bx, sp
0752  les    di, ptr ss:[bx + 6]
0756  mov    al, 1
0758  stosb  byte ptr es:[di], al
0759  mov    al, byte ptr ss:[bx + 4]
075d  stosb  byte ptr es:[di], al
075e  retf   2

; ------------------------------------------------------------
Sys_ArrToStr:
0761  cld
0762  mov    bx, sp
0764  mov    dx, ds
0766  les    di, ptr ss:[bx + 0xa]
076a  lds    si, ptr ss:[bx + 6]
076e  mov    ax, word ptr ss:[bx + 4]
0772  stosb  byte ptr es:[di], al
0773  mov    cx, ax
0775  rep movsb byte ptr es:[di], byte ptr [si]
0777  mov    ds, dx
0779  retf   6
077c  db 55,8b,ec,81,ec,00,02,8d,be,00,ff,16,57,c4,7e,0a
078c  db 06,57,b8,01,00,50,8b,46,06,48,50,0e,e8,e5,fe,c4
079c  db 7e,0e,06,57,0e,e8,1d,ff,8d,be,00,fe,16,57,c4,7e
07ac  db 0a,06,57,ff,76,06,b8,ff,00,50,0e,e8,c6,fe,0e,e8
07bc  db 03,ff,c4,7e,0a,06,57,ff,76,08,0e,e8,84,fe,8b,e5
07cc  db 5d,ca,0c,00,55,8b,ec,81,ec,00,02,83,7e,06,00,7e
07dc  db 43,8d,be,00,ff,16,57,c4,7e,0a,06,57,b8,01,00,50
07ec  db 8b,46,08,48,50,0e,e8,8b,fe,8d,be,00,fe,16,57,c4
07fc  db 7e,0a,06,57,8b,46,08,03,46,06,50,b8,ff,00,50,0e
080c  db e8,71,fe,0e,e8,ae,fe,c4,7e,0a,06,57,b8,ff,00,50
081c  db 0e,e8,2e,fe,8b,e5,5d,ca,08,00,fc,8b,dc,8c,da,36
082c  db c4,7f,0a,36,c5,77,06,36,8b,5f,04,8a,cf,32,ed,32
083c  db c0,f3,aa,8a,cb,f3,a4,b1,20,2a,cb,2a,cf,f3,aa,8e
084c  db da,ca,06,00,fc,8b,dc,36,c4,7f,04,b9,10,00,33,c0
085c  db f3,ab,cb,8b,dc,36,c4,7f,06,36,8a,47,04,8a,d8,32
086c  db ff,b1,03,d3,eb,8a,c8,80,e1,07,b0,01,d2,e0,26,08
087c  db 01,ca,02,00,8b,dc,36,c4,7f,08,36,8a,47,06,36,8a
088c  db 57,04,2a,d0,72,1f,fe,c2,8a,d8,32,ff,b1,03,d3,eb
089c  db 8a,c8,80,e1,07,b0,01,d2,e0,26,08,01,d0,c0,83,d3
08ac  db 00,fe,ca,75,f4,ca,04,00,fc,8b,dc,8c,da,36,c5,77
08bc  db 0a,36,c4,7f,06,36,8b,5f,04,8a,cf,32,ed,03,f1,8a
08cc  db cb,f3,a4,8e,da,ca,0a,00

; ------------------------------------------------------------
Sys_SetIn:
08d4  mov    bx, sp
08d6  les    di, ptr ss:[bx + 4]
08da  mov    al, byte ptr ss:[bx + 8]
08de  mov    bl, al
08e0  xor    bh, bh
08e2  mov    cl, 3
08e4  shr    bx, cl
08e6  mov    cl, al
08e8  and    cl, 7
08eb  mov    al, 1
08ed  shl    al, cl
08ef  test   byte ptr es:[bx + di], al
08f2  retf   6
08f5  db fc,8b,dc,8c,da,36,c4,7f,08,36,c5,77,04,b9,10,00
0905  db ad,26,0b,05,ab,e2,f9,8e,da,ca,04,00,fc,8b,dc,8c
0915  db da,36,c4,7f,08,36,c5,77,04,b9,10,00,ad,f7,d0,26
0925  db 23,05,ab,e2,f7,8e,da,ca,04,00,fc,8b,dc,8c,da,36
0935  db c4,7f,08,36,c5,77,04,b9,10,00,ad,26,23,05,ab,e2
0945  db f9,8e,da,ca,04,00,fc,8b,dc,8c,da,36,c4,7f,08,36
0955  db c5,77,04,b9,10,00,f3,a7,8e,da,ca,08,00,fc,8b,dc
0965  db 8c,da,36,c4,7f,08,36,c5,77,04,b9,10,00,ad,26,0b
0975  db 05,af,75,02,e2,f7,8e,da,ca,08,00

; ------------------------------------------------------------
Sys_Random:
0980  call   sub_103f_09cf
0983  xor    ax, ax
0985  mov    bx, sp
0987  mov    bx, word ptr ss:[bx + 4]
098b  or     bx, bx
098d  je     0x993
098f  xchg   dx, ax
0990  div    bx
0992  xchg   dx, ax
  loc_0993:
0993  retf   2
0996  db e8,36,00,93,b8,80,00,b9,20,00,f6,c6,80,75,0a,d1
09a6  db e3,d1,d2,fe,c8,e2,f3,32,c0,80,e6,7f,cb,e8,19,00
09b6  db cd,3c,9f,06,cd,09,cd,37,06,5e,29,cd,35,e1,cd,35
09c6  db fd,cd,39,d9,cd,3d,cb,e1,ff

; ------------------------------------------------------------
sub_103f_09cf:
09cf  mov    ax, word ptr [0x295e]
09d2  mov    bx, word ptr [0x2960]
09d6  mov    cx, ax
09d8  mul    word ptr cs:[0xa05]
09dd  shl    cx, 1
09df  shl    cx, 1
09e1  shl    cx, 1
09e3  add    ch, cl
09e5  add    dx, cx
09e7  add    dx, bx
09e9  shl    bx, 1
09eb  shl    bx, 1
09ed  add    dx, bx
09ef  add    dh, bl
09f1  mov    cl, 5
09f3  shl    bx, cl
09f5  add    dh, bl
09f7  add    ax, 1
09fa  adc    dx, 0
09fd  mov    word ptr [0x295e], ax
0a00  mov    word ptr [0x2960], dx
0a04  ret
0a05  db 05,84,b4,2c,cd,21,89,0e,5e,29,89,16,60,29,cb

; ------------------------------------------------------------
sub_103f_0a14:
0a14  push   di
0a15  cld
0a16  mov    bx, ax
0a18  or     dx, dx
0a1a  jge    0xa29
0a1c  not    bx
0a1e  not    dx
0a20  add    bx, 1
0a23  adc    dx, 0
0a26  mov    al, 0x2d
0a28  stosb  byte ptr es:[di], al
  loc_0a29:
0a29  mov    si, 0xa66
0a2c  mov    cl, 9
  loc_0a2e:
0a2e  cmp    dx, word ptr cs:[si + 2]
0a32  jb     0xa3b
0a34  ja     0xa42
0a36  cmp    bx, word ptr cs:[si]
0a39  jae    0xa42
  loc_0a3b:
0a3b  add    si, 4
0a3e  dec    cl
0a40  jne    0xa2e
  loc_0a42:
0a42  inc    cl
  loc_0a44:
0a44  mov    al, 0x2f
  loc_0a46:
0a46  inc    al
0a48  sub    bx, word ptr cs:[si]
0a4b  sbb    dx, word ptr cs:[si + 2]
0a4f  jae    0xa46
0a51  add    bx, word ptr cs:[si]
0a54  adc    dx, word ptr cs:[si + 2]
0a58  add    si, 4
0a5b  stosb  byte ptr es:[di], al
0a5c  dec    cl
0a5e  jne    0xa44
0a60  mov    cx, di
0a62  pop    di
0a63  sub    cx, di
0a65  ret
0a66  db 00,ca,9a,3b,00,e1,f5,05,80,96,98,00,40,42,0f,00
0a76  db a0,86,01,00,10,27,00,00,e8,03,00,00,64,00,00,00
0a86  db 0a,00,00,00,01,00,00,00,33,c0,33,d2,33,f6,e3,59
0a96  db 26,80,3d,2b,74,07,26,80,3d,2d,75,05,46,47,49,e3
0aa6  db 48,26,80,3d,24,74,44,26,8a,1d,80,eb,3a,80,c3,0a
0ab6  db 73,28,f7,c2,00,f0,75,31,53,d1,e0,d1,d2,52,50,d1
0ac6  db e0,d1,d2,d1,e0,d1,d2,5b,03,c3,5b,13,d3,5b,32,ff
0ad6  db 03,c3,83,d2,00,78,12,47,e2,cd,4e,75,0a,f7,d0,f7
0ae6  db d2,05,01,00,83,d2,00,f8,c3,f9,c3,47,49,e3,fa,26
0af6  db 8a,1d,80,fb,61,72,03,80,eb,20,80,eb,3a,80,c3,0a
0b06  db 72,0b,80,eb,17,80,c3,06,73,d0,80,c3,0a,b7,04,d1
0b16  db e0,d1,d2,72,d4,fe,cf,75,f6,0a,c3,47,e2,d1,eb,ba

; ------------------------------------------------------------
Sys_StrLong:
0b26  push   bp
0b27  mov    bp, sp
0b29  sub    sp, 0x20
0b2c  mov    ax, word ptr [bp + 0xe]
0b2f  mov    dx, word ptr [bp + 0x10]
0b32  lea    di, [bp - 0x20]
0b35  push   ss
0b36  pop    es
0b37  call   sub_103f_0a14
0b3a  push   ds
0b3b  mov    si, di
0b3d  push   ss
0b3e  pop    ds
0b3f  les    di, ptr [bp + 8]
0b42  mov    dx, word ptr [bp + 6]
0b45  mov    ax, word ptr [bp + 0xc]
0b48  cmp    ax, dx
0b4a  jle    0xb4e
0b4c  mov    ax, dx
  loc_0b4e:
0b4e  cmp    cx, dx
0b50  jle    0xb54
0b52  mov    cx, dx
  loc_0b54:
0b54  cmp    ax, cx
0b56  jge    0xb5a
0b58  mov    ax, cx
  loc_0b5a:
0b5a  cld
0b5b  stosb  byte ptr es:[di], al
0b5c  sub    ax, cx
0b5e  je     0xb68
0b60  push   cx
0b61  mov    cx, ax
0b63  mov    al, 0x20
0b65  rep stosb byte ptr es:[di], al
0b67  pop    cx
  loc_0b68:
0b68  rep movsb byte ptr es:[di], byte ptr [si]
0b6a  pop    ds
0b6b  mov    sp, bp
0b6d  pop    bp
0b6e  retf   0xc
0b71  db 55,8b,ec,c4,7e,0a,26,8a,0d,32,ed,47,e3,09,26,80
0b81  db 3d,20,75,03,47,e2,f7,e8,03,ff,72,02,e3,09,8b,cf
0b91  db 2b,4e,0a,33,c0,33,d2,c4,7e,06,26,89,0d,5d,ca,08
0ba1  db 00

; ------------------------------------------------------------
sub_103f_0ba2:
0ba2  mov    bx, sp
0ba4  push   ds
0ba5  les    di, ptr ss:[bx + 8]
0ba9  lds    si, ptr ss:[bx + 4]
0bad  cld
0bae  xor    ax, ax
0bb0  stosw  word ptr es:[di], ax
0bb1  mov    ax, 0xd7b0
0bb4  stosw  word ptr es:[di], ax
0bb5  mov    ax, 0x80
0bb8  stosw  word ptr es:[di], ax
0bb9  xor    ax, ax
0bbb  stosw  word ptr es:[di], ax
0bbc  stosw  word ptr es:[di], ax
0bbd  stosw  word ptr es:[di], ax
0bbe  lea    ax, [di + 0x74]
0bc1  stosw  word ptr es:[di], ax
0bc2  mov    ax, es
0bc4  stosw  word ptr es:[di], ax
0bc5  mov    ax, 0xcb7
0bc8  stosw  word ptr es:[di], ax
0bc9  mov    ax, cs
0bcb  stosw  word ptr es:[di], ax
0bcc  xor    ax, ax
0bce  mov    cx, 0xe
0bd1  rep stosw word ptr es:[di], ax
0bd3  lodsb  al, byte ptr [si]
0bd4  cmp    al, 0x4f
0bd6  jbe    0xbda
0bd8  mov    al, 0x4f
  loc_0bda:
0bda  mov    cl, al
0bdc  xor    ch, ch
0bde  rep movsb byte ptr es:[di], byte ptr [si]
0be0  xor    al, al
0be2  stosb  byte ptr es:[di], al
0be3  pop    ds
0be4  retf   8
0be7  db 8b,dc,36,c4,7f,0a,36,8b,47,04,26,89,45,04,36,8b
0bf7  db 47,06,26,89,45,0c,36,8b,47,08,26,89,45,0e,33,c0
0c07  db 26,89,45,08,26,89,45,0a,ca,0a,00

; ------------------------------------------------------------
Sys_ResetText:
0c12  mov    dx, 0xd7b1
0c15  jmp    0xc1f

; ------------------------------------------------------------
Sys_RewriteText:
0c17  mov    dx, 0xd7b2
0c1a  jmp    0xc1f
0c1c  db ba,b3,d7
  loc_0c1f:
0c1f  mov    bx, sp
0c21  les    di, ptr ss:[bx + 4]
0c25  mov    ax, word ptr es:[di + 2]
0c29  cmp    ax, 0xd7b1
0c2c  je     0xc40
0c2e  cmp    ax, 0xd7b2
0c31  je     0xc40
0c33  cmp    ax, 0xd7b0
0c36  je     0xc48
0c38  mov    word ptr [0x295c], 0x66
0c3e  jmp    0xc64
  loc_0c40:
0c40  push   dx
0c41  push   es
0c42  push   di
0c43  push   cs
0c44  call   sub_103f_0c6b
0c47  pop    dx
  loc_0c48:
0c48  xor    ax, ax
0c4a  mov    word ptr es:[di + 2], dx
0c4e  mov    word ptr es:[di + 8], ax
0c52  mov    word ptr es:[di + 0xa], ax
0c56  mov    bx, 0x10
0c59  call   sub_103f_0ca6
0c5c  je     0xc64
0c5e  mov    word ptr es:[di + 2], 0xd7b0
  loc_0c64:
0c64  retf   4
0c67  db b0,00,eb,02

; ------------------------------------------------------------
sub_103f_0c6b:
0c6b  mov    al, 1
0c6d  mov    bx, sp
0c6f  les    di, ptr ss:[bx + 4]
0c73  cmp    word ptr es:[di + 2], 0xd7b1
0c79  je     0xc93
0c7b  cmp    word ptr es:[di + 2], 0xd7b2
0c81  je     0xc8b
0c83  mov    word ptr [0x295c], 0x67
0c89  jmp    0xca3
  loc_0c8b:
0c8b  push   ax
0c8c  mov    bx, 0x14
0c8f  call   sub_103f_0ca6
0c92  pop    ax
  loc_0c93:
0c93  or     al, al
0c95  je     0xca3
0c97  mov    bx, 0x1c
0c9a  call   sub_103f_0ca6
0c9d  mov    word ptr es:[di + 2], 0xd7b0
  loc_0ca3:
0ca3  retf   4

; ------------------------------------------------------------
sub_103f_0ca6:
0ca6  push   es
0ca7  push   di
0ca8  push   es
0ca9  push   di
0caa  lcall  es:[bx + di]
0cad  or     ax, ax
0caf  je     0xcb4
0cb1  mov    word ptr [0x295c], ax
  loc_0cb4:
0cb4  pop    di
0cb5  pop    es
0cb6  ret
0cb7  db 8b,dc,1e,36,c5,7f,04,33,c9,89,0d,b8,00,3d,81,7d
0cc7  db 02,b1,d7,74,0d,b0,02,ff,05,81,7d,02,b3,d7,74,02
0cd7  db b4,3c,80,7d,30,00,74,09,8d,55,30,cd,21,72,4f,89
0ce7  db 05,b8,93,0d,33,c9,8b,d9,81,7d,02,b1,d7,74,29,8b
0cf7  db 1d,b8,00,44,cd,21,b8,e8,0d,8b,c8,8c,cb,f6,c2,80
0d07  db 75,11,81,7d,02,b3,d7,75,03,e8,26,00,b8,c3,0d,33
0d17  db c9,8b,d9,c7,45,02,b2,d7,89,45,14,8c,4d,16,89,4d
0d27  db 18,89,5d,1a,c7,45,1c,08,0e,8c,4d,1e,33,c0,1f,ca
0d37  db 04,00,33,d2,33,c9,8b,1d,b8,02,42,cd,21,2d,80,00
0d47  db 83,da,00,73,04,33,c0,33,d2,8b,ca,8b,d0,8b,1d,b8
0d57  db 00,42,cd,21,8d,95,80,00,b9,80,00,8b,1d,b4,3f,cd
0d67  db 21,73,02,33,c0,33,db,3b,d8,74,20,80,b9,80,00,1a
0d77  db 74,03,43,eb,f2,8b,d3,2b,d0,b9,ff,ff,8b,1d,b8,02
0d87  db 42,cd,21,33,c9,8b,1d,b4,40,cd,21,c3,8b,dc,1e,36
0d97  db c4,7f,04,26,c5,55,0c,26,8b,4d,04,26,8b,1d,b4,3f
0da7  db cd,21,72,10,26,89,45,0a,33,c0,26,c7,45,08,00,00
0db7  db 1f,ca,04,00,26,c7,45,0a,00,00,eb,ee,8b,dc,1e,36
0dc7  db c4,7f,04,26,c5,55,0c,33,c9,26,87,4d,08,26,8b,1d
0dd7  db b4,40,cd,21,72,07,2b,c1,74,03,b8,65,00,1f,ca,04
0de7  db 00,8b,dc,1e,36,c4,7f,04,26,c5,55,0c,33,c9,26,87
0df7  db 4d,08,26,8b,1d,b4,40,cd,21,72,02,33,c0,1f,ca,04
0e07  db 00,8b,dc,36,c4,7f,04,26,8b,1d,83,fb,04,76,06,b4
0e17  db 3e,cd,21,72,02,33,c0,ca,04,00,83,3e,5c,29,00,75
0e27  db 08,26,81,7d,02,b1,d7,75,0d,26,8b,5d,08,26,8b,55
0e37  db 0a,26,c4,7d,0c,c3,c7,06,5c,29,68,00,eb,eb,3b,da
0e47  db 74,05,26,8a,01,f8,c3,8b,fc,36,c4,7d,02,e8,3d,00
0e57  db 8b,d0,3b,da,75,ec,b0,1a,f9,c3

; ------------------------------------------------------------
sub_103f_0e61:
0e61  cmp    word ptr [0x295c], 0
0e66  jne    0xe70
0e68  cmp    word ptr es:[di + 2], 0xd7b2
0e6e  jne    0xe7d
  loc_0e70:
0e70  mov    bx, word ptr es:[di + 8]
0e74  mov    dx, word ptr es:[di + 4]
0e78  les    di, ptr es:[di + 0xc]
0e7c  ret
  loc_0e7d:
0e7d  mov    word ptr [0x295c], 0x69
0e83  jmp    0xe70

; ------------------------------------------------------------
sub_103f_0e85:
0e85  mov    byte ptr es:[bx + di], al
0e88  inc    bx
0e89  cmp    bx, dx
0e8b  je     0xe8e
0e8d  ret
  loc_0e8e:
0e8e  mov    di, sp
0e90  les    di, ptr ss:[di + 2]
0e94  push   cx
0e95  push   si
0e96  push   ds
0e97  mov    dx, 0x1161                        ; seg DATA
0e9a  mov    ds, dx
0e9c  mov    word ptr es:[di + 8], bx
0ea0  push   es
0ea1  push   di
0ea2  push   es
0ea3  push   di
0ea4  lcall  es:[di + 0x14]
0ea8  or     ax, ax
0eaa  je     0xeaf
0eac  mov    word ptr [0x295c], ax
  loc_0eaf:
0eaf  pop    di
0eb0  pop    es
0eb1  mov    ax, word ptr es:[di + 0xa]
0eb5  mov    bx, word ptr es:[di + 8]
0eb9  mov    dx, word ptr es:[di + 4]
0ebd  les    di, ptr es:[di + 0xc]
0ec1  pop    ds
0ec2  pop    si
0ec3  pop    cx
0ec4  ret
0ec5  db 8b,dc,36,c4,7f,04,06,57,e8,51,ff,75,14,e8,70,ff
0ed5  db 3c,1a,74,0d,43,3c,0d,75,f4,e8,64,ff,3c,0a,75,01
0ee5  db 43,5f,07,26,89,5d,08,eb,25

; ------------------------------------------------------------
Sys_WriteLn:
0eee  mov    bx, sp
0ef0  les    di, ptr ss:[bx + 4]
0ef4  push   es
0ef5  push   di
0ef6  call   sub_103f_0e61
0ef9  jne    0xf05
0efb  mov    al, 0xd
0efd  call   sub_103f_0e85
0f00  mov    al, 0xa
0f02  call   sub_103f_0e85
  loc_0f05:
0f05  pop    di
0f06  pop    es
0f07  mov    word ptr es:[di + 8], bx
0f0b  jmp    0xf13
0f0d  db 8b,dc,36,c4,7f,04
  loc_0f13:
0f13  cmp    word ptr es:[di + 0x1a], 0
0f18  jne    0xf1d
  loc_0f1a:
0f1a  retf   4
  loc_0f1d:
0f1d  cmp    word ptr [0x295c], 0
0f22  jne    0xf1a
0f24  push   es
0f25  push   di
0f26  lcall  es:[di + 0x18]
0f2a  or     ax, ax
0f2c  je     0xf1a
0f2e  mov    word ptr [0x295c], ax
0f31  jmp    0xf1a
0f33  db 55,8b,ec,1e,c4,7e,0c,06,57,e8,e2,fe,c5,76,08,b9
0f43  db 00,00,75,15,e8,fb,fe,3c,0d,74,0e,3c,1a,74,0a,43
0f53  db 41,46,88,04,3b,4e,06,75,eb,2b,f1,88,0c,5f,07,26
0f63  db 89,5d,08,1f,5d,ca,06,00

; ------------------------------------------------------------
Sys_WriteStr:
0f6b  push   bp
0f6c  mov    bp, sp
0f6e  push   ds
0f6f  les    di, ptr [bp + 0xc]
0f72  push   es
0f73  push   di
0f74  call   sub_103f_0e61
0f77  jne    0xf9e
0f79  lds    si, ptr [bp + 8]
0f7c  mov    cx, word ptr [bp + 6]
0f7f  cld
0f80  lodsb  al, byte ptr [si]
0f81  xor    ah, ah
0f83  sub    cx, ax
0f85  jle    0xf93
  loc_0f87:
0f87  mov    al, 0x20
0f89  call   sub_103f_0e85
0f8c  loop   0xf87
0f8e  mov    al, byte ptr [si - 1]
0f91  xor    ah, ah
  loc_0f93:
0f93  mov    cx, ax
0f95  jcxz   0xf9e
  loc_0f97:
0f97  cld
0f98  lodsb  al, byte ptr [si]
0f99  call   sub_103f_0e85
0f9c  loop   0xf97
  loc_0f9e:
0f9e  pop    di
0f9f  pop    es
0fa0  mov    word ptr es:[di + 8], bx
0fa4  pop    ds
0fa5  pop    bp
0fa6  retf   6

; ------------------------------------------------------------
Sys_Assign:
0fa9  mov    bx, sp
0fab  push   ds
0fac  les    di, ptr ss:[bx + 8]
0fb0  lds    si, ptr ss:[bx + 4]
0fb4  cld
0fb5  xor    ax, ax
0fb7  stosw  word ptr es:[di], ax
0fb8  mov    ax, 0xd7b0
0fbb  stosw  word ptr es:[di], ax
0fbc  xor    ax, ax
0fbe  mov    cx, 0x16
0fc1  rep stosw word ptr es:[di], ax
0fc3  lodsb  al, byte ptr [si]
0fc4  cmp    al, 0x4f
0fc6  jbe    0xfca
0fc8  mov    al, 0x4f
  loc_0fca:
0fca  mov    cl, al
0fcc  xor    ch, ch
0fce  rep movsb byte ptr es:[di], byte ptr [si]
0fd0  xor    al, al
0fd2  stosb  byte ptr es:[di], al
0fd3  pop    ds
0fd4  retf   8

; ------------------------------------------------------------
Sys_ResetFile:
0fd7  mov    al, byte ptr [0x2962]
0fda  mov    ah, 0x3d
0fdc  xor    dx, dx
0fde  jmp    0xfe6

; ------------------------------------------------------------
Sys_RewriteFile:
0fe0  mov    ax, 0x3c00
0fe3  mov    dx, 1
  loc_0fe6:
0fe6  push   bp
0fe7  mov    bp, sp
0fe9  les    di, ptr [bp + 8]
0fec  cmp    word ptr es:[di + 2], 0xd7b0
0ff2  je     0x100e
0ff4  cmp    word ptr es:[di + 2], 0xd7b3
0ffa  je     0x1004
0ffc  mov    word ptr [0x295c], 0x66
1002  jmp    0x1038
  loc_1004:
1004  push   ax
1005  push   dx
1006  push   es
1007  push   di
1008  push   cs
1009  call   Sys_Close
100c  pop    dx
100d  pop    ax
  loc_100e:
100e  cmp    byte ptr es:[di + 0x30], 0
1013  je     0x1027
1015  push   ds
1016  lea    dx, [di + 0x30]
1019  push   es
101a  pop    ds
101b  xor    cx, cx
101d  int    0x21
101f  pop    ds
1020  jae    0x1028
1022  mov    word ptr [0x295c], ax
1025  jmp    0x1038
  loc_1027:
1027  xchg   dx, ax
  loc_1028:
1028  mov    word ptr es:[di + 2], 0xd7b3
102e  mov    word ptr es:[di], ax
1031  mov    ax, word ptr [bp + 6]
1034  mov    word ptr es:[di + 4], ax
  loc_1038:
1038  pop    bp
1039  retf   6
103c  db 8b,dc,36,c4,7f,04,e8,38,00,75,0e,33,c9,26,8b,1d
104c  db b4,40,cd,21,73,03,a3,5c,29,ca,04,00

; ------------------------------------------------------------
Sys_Close:
1058  mov    bx, sp
105a  les    di, ptr ss:[bx + 4]
105e  call   sub_103f_107d
1061  jne    0x107a
1063  mov    bx, word ptr es:[di]
1066  cmp    bx, 4
1069  jbe    0x1074
106b  mov    ah, 0x3e
106d  int    0x21
106f  jae    0x1074
1071  mov    word ptr [0x295c], ax
  loc_1074:
1074  mov    word ptr es:[di + 2], 0xd7b0
  loc_107a:
107a  retf   4

; ------------------------------------------------------------
sub_103f_107d:
107d  cmp    word ptr es:[di + 2], 0xd7b3
1083  je     0x108b
1085  mov    word ptr [0x295c], 0x67
  loc_108b:
108b  ret

; ------------------------------------------------------------
Sys_ReadRec:
108c  mov    ah, 0x3f
108e  mov    dx, 0x64
1091  jmp    0x1098

; ------------------------------------------------------------
Sys_WriteRec:
1093  mov    ah, 0x40
1095  mov    dx, 0x65
  loc_1098:
1098  push   bp
1099  mov    bp, sp
109b  les    di, ptr [bp + 0xa]
109e  call   sub_103f_107d
10a1  jne    0x10be
10a3  push   ds
10a4  push   dx
10a5  lds    dx, ptr [bp + 6]
10a8  mov    cx, word ptr es:[di + 4]
10ac  mov    bx, word ptr es:[di]
10af  int    0x21
10b1  pop    dx
10b2  pop    ds
10b3  jb     0x10bb
10b5  cmp    ax, cx
10b7  je     0x10be
10b9  mov    ax, dx
  loc_10bb:
10bb  mov    word ptr [0x295c], ax
  loc_10be:
10be  pop    bp
10bf  retf   4

; ------------------------------------------------------------
Sys_BlockRead:
10c2  mov    bl, 0x3f
10c4  mov    cx, 0x64
10c7  jmp    0x10ce
10c9  db b3,40,b9,65,00
  loc_10ce:
10ce  push   bp
10cf  mov    bp, sp
10d1  les    di, ptr [bp + 0x10]
10d4  call   sub_103f_107d
10d7  jne    0x1118
10d9  mov    ax, word ptr [bp + 0xa]
10dc  or     ax, ax
10de  je     0x10fc
10e0  push   ds
10e1  push   cx
10e2  mul    word ptr es:[di + 4]
10e6  mov    cx, ax
10e8  lds    dx, ptr [bp + 0xc]
10eb  mov    ah, bl
10ed  mov    bx, word ptr es:[di]
10f0  int    0x21
10f2  pop    cx
10f3  pop    ds
10f4  jb     0x1115
10f6  xor    dx, dx
10f8  div    word ptr es:[di + 4]
  loc_10fc:
10fc  les    di, ptr [bp + 6]
10ff  mov    dx, es
1101  or     dx, di
1103  je     0x110a
1105  mov    word ptr es:[di], ax
1108  jmp    0x1126
  loc_110a:
110a  cmp    ax, word ptr [bp + 0xa]
110d  je     0x1126
110f  mov    word ptr [0x295c], cx
1113  jmp    0x1126
  loc_1115:
1115  mov    word ptr [0x295c], ax
  loc_1118:
1118  les    di, ptr [bp + 6]
111b  mov    dx, es
111d  or     dx, di
111f  je     0x1126
1121  xor    ax, ax
1123  mov    word ptr es:[di], ax
  loc_1126:
1126  pop    bp
1127  retf   0xe

; ------------------------------------------------------------
Sys_Seek:
112a  push   bp
112b  mov    bp, sp
112d  les    di, ptr [bp + 0xa]
1130  call   sub_103f_107d
1133  jne    0x1156
1135  mov    ax, word ptr [bp + 8]
1138  mul    word ptr es:[di + 4]
113c  mov    cx, ax
113e  mov    ax, word ptr [bp + 6]
1141  mul    word ptr es:[di + 4]
1145  add    cx, dx
1147  mov    dx, ax
1149  mov    bx, word ptr es:[di]
114c  mov    ax, 0x4200
114f  int    0x21
1151  jae    0x1156
1153  mov    word ptr [0x295c], ax
  loc_1156:
1156  pop    bp
1157  retf   8
115a  db e8,44,00,72,0f,26,8b,4d,04,83,f9,01,74,06,33,db
116a  db 0e,e8,26,f1,ca,04,00

; ------------------------------------------------------------
Sys_FileSize:
1171  call   sub_103f_11a1
1174  jb     0x1189
1176  mov    ax, cx
1178  mov    dx, bx
117a  mov    cx, word ptr es:[di + 4]
117e  cmp    cx, 1
1181  je     0x1189
1183  xor    bx, bx
1185  push   cs
1186  call   sub_103f_0294
  loc_1189:
1189  retf   4
118c  db e8,12,00,72,0b,2b,c1,1b,d3,72,05,b0,01,ca,04,00
119c  db 32,c0,ca,04,00

; ------------------------------------------------------------
sub_103f_11a1:
11a1  mov    bx, sp
11a3  les    di, ptr ss:[bx + 6]
11a7  cmp    word ptr es:[di + 2], 0xd7b3
11ad  jne    0x11da
11af  xor    cx, cx
11b1  xor    dx, dx
11b3  mov    bx, word ptr es:[di]
11b6  mov    ax, 0x4201
11b9  int    0x21
11bb  push   dx
11bc  push   ax
11bd  xor    cx, cx
11bf  xor    dx, dx
11c1  mov    bx, word ptr es:[di]
11c4  mov    ax, 0x4202
11c7  int    0x21
11c9  pop    bx
11ca  pop    cx
11cb  push   dx
11cc  push   ax
11cd  mov    dx, bx
11cf  mov    bx, word ptr es:[di]
11d2  mov    ax, 0x4200
11d5  int    0x21
11d7  pop    cx
11d8  pop    bx
11d9  ret
  loc_11da:
11da  mov    word ptr [0x295c], 0x67
11e0  xor    ax, ax
11e2  xor    dx, dx
11e4  stc
11e5  ret

; ------------------------------------------------------------
Sys_Move:
11e6  mov    bx, sp
11e8  mov    dx, ds
11ea  lds    si, ptr ss:[bx + 0xa]
11ee  les    di, ptr ss:[bx + 6]
11f2  mov    cx, word ptr ss:[bx + 4]
11f6  cld
11f7  cmp    si, di
11f9  jae    0x1202
11fb  add    si, cx
11fd  add    di, cx
11ff  dec    si
1200  dec    di
1201  std
  loc_1202:
1202  rep movsb byte ptr es:[di], byte ptr [si]
1204  mov    ds, dx
1206  retf   0xa

; ------------------------------------------------------------
Sys_FillChar:
1209  mov    bx, sp
120b  les    di, ptr ss:[bx + 8]
120f  mov    cx, word ptr ss:[bx + 6]
1213  mov    al, byte ptr ss:[bx + 4]
1217  cld
1218  rep stosb byte ptr es:[di], al
121a  retf   8
121d  db 00,00,00
