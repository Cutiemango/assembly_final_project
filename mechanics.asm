INCLUDE Irvine32.inc
INCLUDE graphics.inc

.data
tickTimeStamp DWORD ?
mapCoord Coord2D <0, 0>
cactusCoord Coord2D <90, 19>
dinoCoord Coord2D <20, 18>
scoreCoord Coord2D <0, 26>
dinoPose BYTE 0

currentScore DWORD 0

jumpTick BYTE 0

.code
DoTick PROC
    INVOKE ClearElement, 8, 5, cactusCoord
    ; do cactus move
    .IF cactusCoord.X == 0h
        mov cactusCoord.X, 90
    .ELSE
        sub cactusCoord, 2
    .ENDIF

    INVOKE RenderCactus, cactusCoord
    INVOKE ClearElement, 10, 6, dinoCoord
    INVOKE RenderDinosaur, dinoPose, dinoCoord
    INVOKE RenderScore, scoreCoord

    ; change dinosaur pose
    .IF dinoPose == 1h
        mov dinoPose, 0
    .ELSE
        inc dinoPose
    .ENDIF

    inc currentScore
    ret
DoTick ENDP

GetScore PROC
    mov eax, currentScore
    ret
GetScore ENDP

GameStart PROC
    INVOKE RenderMap

    ; initialize timeStamp
    INVOKE GetTickCount
    mov tickTimeStamp, eax
    mov ecx, 2
tick:
    INVOKE GetTickCount
    mov ebx, eax
    sub eax, tickTimeStamp

    .IF eax >= 50
        INVOKE DoTick ; do tick
        mov tickTimeStamp, ebx ; update timeStamp
    .ENDIF

    inc ecx
    loop tick
    ret
GameStart ENDP
END