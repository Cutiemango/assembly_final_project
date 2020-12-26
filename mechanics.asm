INCLUDE Irvine32.inc
INCLUDE graphics.inc

.data
tickTimeStamp DWORD ?
mapCoord Coord2D <0, 0>
cactusCoord Coord2D <90, 24>
dinoCoord Coord2D <20, 23>
scoreCoord Coord2D <0, 31>
dinoPose BYTE 0

currentScore DWORD 0

jumpTickCounter BYTE 0
crouchStatus BYTE 0

.code
DoTick PROC
    INVOKE ClearElement, 8, 5, cactusCoord
    INVOKE ClearElement, 10, 6, dinoCoord

    ; do dino jump
    .IF jumpTickCounter > 8h
        dec dinoCoord.Y
    .ELSEIF jumpTickCounter > 0h
        inc dinoCoord.Y
    .ENDIF

    .IF jumpTickCounter > 0h
        dec jumpTickCounter
    .ENDIF

    ; do cactus move
    .IF cactusCoord.X == 0h
        mov cactusCoord.X, 90
    .ELSE
        sub cactusCoord, 3
    .ENDIF

    INVOKE RenderCactus, cactusCoord
    INVOKE RenderDinosaur, dinoPose, dinoCoord
    INVOKE RenderScore, scoreCoord

    ; change dinosaur pose
    xor dinoPose, 1

    inc currentScore
    ret
DoTick ENDP

ReadInput PROC
    call ReadKey
    .IF ax == 4800h
        .IF jumpTickCounter == 0h
            mov jumpTickCounter, 16
        .ENDIF
    .ELSEIF ax == 5000h
        ; do crouch animation
    .ENDIF
    ret
ReadInput ENDP

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
        INVOKE ReadInput
        INVOKE DoTick ; do tick
        mov tickTimeStamp, ebx ; update timeStamp
    .ENDIF

    inc ecx
    loop tick
    ret
GameStart ENDP
END