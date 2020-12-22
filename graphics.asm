INCLUDE Irvine32.inc
INCLUDE graphics.inc
INCLUDE mechanics.inc

mGotoXY MACRO X, Y
    push edx
    mov dl, X
    mov dh, Y
	call GotoXY
    pop edx
ENDM

.data
outputHandle DWORD ?
bufferSize COORD <100, 25>
empty_char BYTE " ", 0
map BYTE "              .                                                                                     ", 0
    BYTE "              |                                                                                     ", 0
    BYTE "     .               /                                                                              ", 0
    BYTE "      \       I                                        .-~~-                                        ", 0
    BYTE "                  /                                ~ ~(      )_ _                                   ", 0
    BYTE "        \  ,g8888R__                         (                -.                                    ", 0
    BYTE "          d88888888(`  )__.                   ~- . ______ .-)                 .-~~~~-.              ", 0
    BYTE " -  --==  88888(          ).=--                                           .- ~ ~-(       )_         ", 0
    BYTE "          Y8P(             '__`.                                  _//                    ~ -.       ", 0
    BYTE "        .+(`(      .            )                                |                           ' )_   ", 0
    BYTE "       ((    (..__.:'-'--___  :        .-~~-.                       \               ..__          .'", 0
    BYTE "       `(       ) )             _ _(   .        )_                     ~- ._ ,. ,.,./    \,.. -~    ", 0
    BYTE "         ` __.:'   )          (                      ))                                             ", 0
    BYTE "      ( )       --'             `- __.___::---__'                                                   ", 0
    BYTE "                                                                                                    ", 0
    BYTE "                                                                                                    ", 0
    BYTE "                                                                                                    ", 0
    BYTE "                                                                                                    ", 0
    BYTE "                                                                                                    ", 0
    BYTE "                                                                                                    ", 0
    BYTE "                                                                                                    ", 0
    BYTE "                                                                                                    ", 0
    BYTE "                                                                                                    ", 0
    BYTE "                                                                                                    ", 0
    BYTE "--..,___.--,--'`,---..-.--+--.,,-,,..._.--...._.-.__...,..,___.--,--'`,---..-.--+--.,,-,,..._.--....", 0
map_rows BYTE 25

scoreMsg BYTE "Score: ", 0

cactus1 BYTE "_  _   ", 0
        BYTE "|||| *-", 0
        BYTE "\\|| ||", 0
        BYTE "  ||_//", 0
        BYTE "  ||-- ", 0
cactus1_rows BYTE 5

cactus2 BYTE ",. *.   ", 0
        BYTE "||_|| ,.", 0
        BYTE "`--|| ||", 0
        BYTE "   ||_||", 0
        BYTE "   |.--`", 0
cactus2_rows BYTE 5
cactus_color BYTE green

dinosaur_right BYTE "       __ ", 0
               BYTE "      / .\", 0
               BYTE "      | -'", 0
               BYTE "- ----' |>", 0
               BYTE " \_   _/  ", 0
               BYTE "   V L    ", 0

dinosaur_left BYTE "       __ ", 0
              BYTE "      / .\", 0
              BYTE "      | -'", 0
              BYTE "- ----' |>", 0
              BYTE " \_   _/  ", 0
              BYTE "   / V    ", 0
dinosaur_rows BYTE 6
dinosaur_color BYTE lightCyan

.code
InitHandle PROC
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
    INVOKE SetConsoleScreenBufferSize, eax, bufferSize
    ret
InitHandle ENDP

RenderMap PROC USES eax ecx edx esi
    movzx ecx, map_rows
    mov esi, OFFSET map
renderRow:
    mov edx, esi
    call WriteString
    call Crlf

    INVOKE Str_length, esi
    add esi, eax
    inc esi
    loop renderRow
    ret
RenderMap ENDP

RenderScore PROC USES eax edx,
    position: Coord2D

    mGotoXY position.X, position.Y
    mov edx, OFFSET scoreMsg
    call WriteString
    call GetScore
    call WriteDec
    ret
RenderScore ENDP

RenderElement PROC USES eax ecx edx esi,
    character: PTR BYTE,
    color: BYTE,
    rowSize: BYTE,
    position: Coord2D
    
    movzx ecx, rowSize
    mov esi, character
drawElement:
    ; dh = row(Y), dl = col(X)
    mGotoXY position.X, position.Y

    ; set color
    movzx eax, color
    call SetTextColor

    mov edx, esi
    call WriteString

    INVOKE Str_length, esi
    add esi, eax
    inc esi
    inc position.Y
    loop drawElement

    ; set color back to white
    mov eax, 1111b
    call SetTextColor
    ret
RenderElement ENDP

ClearElement PROC USES ebx ecx edx,
    colSize: BYTE,
    rowSize: BYTE,
    position: Coord2D

    movzx ebx, position.X
    movzx ecx, rowSize
    mov edx, OFFSET empty_char
doNextRow:
    push ecx
    movzx ecx, colSize
    mov position.X, bl
clearColumn:
    mGotoXY position.X, position.Y
    call WriteString
    inc position.X
    loop clearColumn
    pop ecx
    inc position.Y
    loop doNextRow
    ret
ClearElement ENDP

; left = 0, right = 1
RenderDinosaur PROC,
    pose: BYTE,
    position: Coord2D
    .IF pose == 1
        INVOKE RenderElement, OFFSET dinosaur_left, dinosaur_color, dinosaur_rows, position
    .ELSE
        INVOKE RenderElement, OFFSET dinosaur_right, dinosaur_color, dinosaur_rows, position
    .ENDIF
    ret
RenderDinosaur ENDP

RenderCactus PROC,
    position: Coord2D
    INVOKE RenderElement, OFFSET cactus1, cactus_color, cactus1_rows, position
    ret
RenderCactus ENDP
END