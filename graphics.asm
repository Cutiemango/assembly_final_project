INCLUDE Irvine32.inc
INCLUDE graphics.inc
INCLUDE mechanics.inc

.data
outputHandle DWORD ?
bufferSize COORD <118, 30>
empty_char BYTE " ", 0

start_screen BYTE "                                                                                                              ", 0
             BYTE "                                                                                                              ", 0
             BYTE "                                                                                                              ", 0
             BYTE "                                                                 ###   ###   ####   ###   ###                 ", 0
             BYTE "                                                                 #  #  #  #  #     ##    ##                   ", 0
             BYTE "                                                                 ####  ###   ###    ###   ###                 ", 0
             BYTE "                                                                 #     # ##  #        #     #                 ", 0
             BYTE "                                                                 #     #  #  ####  ####  ####                 ", 0
             BYTE "                                 ############                                                                 ", 0
             BYTE "                               ################         ######    #######      ##         ####     ########   ", 0
             BYTE "                               ###  ###########       ###    ##   ##    ##    ####      ###  ##    ##     #   ", 0
             BYTE "                               ################       ##          ##     #    # ##     ##          ##         ", 0
             BYTE "                               ################         ####      ##   ###   ##  ##    ##          ######     ", 0
             BYTE "                               ########                     ##    ######     ######    ##          ##         ", 0
             BYTE "                               ############                  ##   ##        ##   ##    ##      #   ##         ", 0
             BYTE "                           ###########                ##    ###   ##        ##    ##    ##    ##   ##     #   ", 0
             BYTE "              #        ###############                ######      ##       ###    ###    #####     ########   ", 0
             BYTE "              ##     ####################                                                                     ", 0
             BYTE "              ###  ##################   #                #####   ###        ###  #####   ##    ###   #####    ", 0
             BYTE "              #######################                      #    #   #      ##      #     ###   #  #    #      ", 0
             BYTE "                ####################                       #    #   #       ###    #    ## #   ###     #      ", 0
             BYTE "                  ##################                       #    #   #         #    #    #####  # ##    #      ", 0
             BYTE "                   ##############                          #     ###       ####    #    #   #  #  #    #      ", 0
             BYTE "                       ###  ##                                                                                ", 0
             BYTE "                      ###   ##                                                                                ", 0
             BYTE "                      ##     #                                                                                ", 0
             BYTE "                       ##     ##                                                                              ", 0
             BYTE "                                                                                                              ", 0
             BYTE "                                                                                                              ", 0
             BYTE "                                                                                                              ", 0

end_screen BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                 ########        ##          ##    ##      ########                           ", 0
           BYTE "                                ##      ##      ####         ###  ###      ##     #                           ", 0
           BYTE "                               ###       #      # ##        ## ## # ##     ##                                 ", 0
           BYTE "                               ###             ##  ##       ##  ##  ##     #####                              ", 0
           BYTE "                               ###    ####     ######       ##  ##  ##     ##                                 ", 0
           BYTE "                               ###      ##    ##   ##      ##        ##    ##                                 ", 0
           BYTE "                                ###     ##    ##    ##     ##        ##    ##     #                           ", 0
           BYTE "                                 ########    ###    ###   ####      ####   ########                           ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                 #######      ###      ###    ########    ########                            ", 0
           BYTE "                                ##     ###     ##      ##     ##     #    ##     ##                           ", 0
           BYTE "                               ##       ###    ##      ##     ##          ##      #                           ", 0
           BYTE "            ################   ##       ###    ##     ##      #####       ##    ###    ###################    ", 0
           BYTE "                               ##       ###     ##    ##      ##          #######                             ", 0
           BYTE "                               ##       ###     ##   ##       ##          ##   #                              ", 0
           BYTE "                                ##     ###        ####        ##     #    ##    ##                            ", 0
           BYTE "                                 #######           ##         ########    ##     ####                         ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0
           BYTE "                                                                                                              ", 0

map BYTE "                                .                                                                                     ", 0
    BYTE "                                |                                                                                     ", 0
    BYTE "                       .               /                                                                              ", 0
    BYTE "                        \       I                                        .-~~-                                        ", 0
    BYTE "                                    /                                ~ ~(      )_ _                                   ", 0
    BYTE "                          \  ,g8888R__                         (                -.                                    ", 0
    BYTE "                            d88888888(`  )__.                   ~- . ______ .-)                 .-~~~~-.              ", 0
    BYTE "                   -  --==  88888(          ).=--                                           .- ~ ~-(       )_         ", 0
    BYTE "                            Y8P(             '__`.                                  _//                    ~ -.       ", 0
    BYTE "                          .+(`(      .            )                                |                           ' )_   ", 0
    BYTE "                         ((    (..__.:'-'--___  :        .-~~-.                       \               ..__        .'  ", 0
    BYTE "      __                 `(       ) )             _ _(   .        )_                     ~- ._ ,. ,.,./    \,.. -~    ", 0
    BYTE "     /   \_                ` __.:'   )          (                      ))                                             ", 0
    BYTE "  (         \                     --'             `- __.___::---__'                                                   ", 0
    BYTE " ( _  _..     _)                                                                      __                              ", 0
    BYTE "         ~ ~~-                                                                     _/   )                             ", 0 
    BYTE "                                                                               (         \'.                          ", 0  
    BYTE "                                                                              (         __/-~~         __             ", 0  
    BYTE "                                                                                ~~~''--;              (   )           ", 0
    BYTE "                                                                                                    C.     ')         ", 0
    BYTE "                                                                                                      '~~~/           ", 0
    BYTE "                                                                                                                      ", 0
    BYTE "                                                                                                                      ", 0
    BYTE "                                                                                                                      ", 0
    BYTE "                                                                                                                      ", 0
    BYTE "                                                                                                                      ", 0
    BYTE "                                                                                                                      ", 0
    BYTE "                                                                                                                      ", 0
    BYTE "                                                                                                                      ", 0
    BYTE ".,---,---..-.--+--.,,-..,_.--,--'`,---..-.--+--.,,-,,..._.--...._.-.__...,..,___.--,--'`,---..-.--+--.,,-,,..._.--....", 0
background_rows BYTE 30

scoreMsg BYTE "Score: ", 0

cactus1 BYTE "_   _   ", 0
        BYTE "|| // -*", 0
        BYTE "\\||  //", 0
        BYTE "  ||_// ", 0
        BYTE "  ||--  ", 0
cactus1_rows BYTE 5

cactus2 BYTE ",. *.   ", 0
        BYTE "||_|| ,.", 0
        BYTE "`--|| ||", 0
        BYTE "   ||_||", 0
        BYTE "   |.--`", 0
cactus2_rows BYTE 5
cactus_color BYTE green

bird BYTE " _  |\   ", 0
     BYTE "<_]_| \ _", 0
     BYTE "  \__ /-=", 0
bird_rows BYTE 3
bird_color BYTE brown

dinosaur_crouch_left BYTE "      ___ ", 0
                     BYTE "\- --' ._]", 0
                     BYTE " \_ _/--' ", 0
                     BYTE "  y i     ", 0

dinosaur_crouch_right BYTE "      ___ ", 0
                      BYTE "\- --' ._]", 0
                      BYTE " \_ _/--' ", 0
                      BYTE "  i v     ", 0
dinosaur_crouch_rows BYTE 4

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

RenderBackground PROC USES eax ecx edx esi,
    mapNumber: BYTE

    movzx ecx, background_rows
    .IF mapNumber == 0h
        mov esi, OFFSET map
    .ELSEIF mapNumber == 1h
        mov esi, OFFSET start_screen
    .ELSEIF mapNumber == 2h
        mov esi, OFFSET end_screen
    .ELSE
        ret
    .ENDIF
renderRow:
    mov edx, esi
    call WriteString
    call Crlf

    INVOKE Str_length, esi
    add esi, eax
    inc esi
    loop renderRow
    ret
RenderBackground ENDP

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

    .IF pose == 1h
        INVOKE RenderElement, OFFSET dinosaur_left, dinosaur_color, dinosaur_rows, position
    .ELSE
        INVOKE RenderElement, OFFSET dinosaur_right, dinosaur_color, dinosaur_rows, position
    .ENDIF
    ret
RenderDinosaur ENDP

RenderDinoCrouch PROC,
    pose: BYTE,
    position: Coord2D

    add position.Y, 2h
    .IF pose == 1h
        INVOKE RenderElement, OFFSET dinosaur_crouch_left, dinosaur_color, dinosaur_crouch_rows, position
    .ELSE
        INVOKE RenderElement, OFFSET dinosaur_crouch_right, dinosaur_color, dinosaur_crouch_rows, position
    .ENDIF
    ret
RenderDinoCrouch ENDP

RenderObstacle PROC,
    object: BYTE,
    position: Coord2D

    .IF object == 0h
        INVOKE RenderElement, OFFSET cactus1, cactus_color, cactus1_rows, position
    .ELSEIF object == 1h
        INVOKE RenderElement, OFFSET cactus2, cactus_color, cactus2_rows, position
    .ELSEIF object >= 2h
        INVOKE RenderElement, OFFSET bird, bird_color, bird_rows, position
    .ENDIF
    ret
RenderObstacle ENDP
END