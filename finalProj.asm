TITLE finalProject

include Irvine32.inc
include utils.inc
include graphics.inc
include mechanics.inc

main EQU start@0

.data
gameTitle BYTE "Test Game", 0
timeStamp DWORD 0

.code
main PROC
    INVOKE InitHandle
    INVOKE InitRandom
    INVOKE SetConsoleTitle, ADDR gameTitle

    INVOKE GameStart
    INVOKE GameOver
    call WaitMsg
    call Clrscr
    exit
main ENDP
END main
