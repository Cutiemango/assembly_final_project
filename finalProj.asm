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

    INVOKE RenderBackground, 1h
wait_input:
    call ReadChar
    .IF ax == 3920h ; wait for space key
        call Clrscr
        INVOKE GameStart
        INVOKE GameOver
        call WaitMsg
        call Clrscr
    .ELSE
        jmp wait_input
    .ENDIF
    exit
main ENDP
END main
