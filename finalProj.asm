TITLE finalProject

include Irvine32.inc
include graphics.inc
include mechanics.inc

main EQU start@0

.data
gameTitle BYTE "Dino Game", 0
timeStamp DWORD 0

.code
main PROC
    INVOKE InitHandle
    INVOKE SetConsoleTitle, ADDR gameTitle

    INVOKE RenderBackground, START_MAP
wait_input:
    call ReadChar
    .IF ax == 3920h ; wait for space key
        call Clrscr
        INVOKE GameStart
        INVOKE GameOver
    .ELSEIF ax == 011bh ; esc = quit game
        jmp quit_game
    .ENDIF
    jmp wait_input
quit_game:
    call Clrscr
    exit
main ENDP
END main
