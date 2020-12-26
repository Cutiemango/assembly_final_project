INCLUDE Irvine32.inc
INCLUDE graphics.inc

.data
tickTimeStamp DWORD ?
mapCoord Coord2D <0, 0>
dinoCoord Coord2D <20, 23>
scoreCoord Coord2D <0, 31>

cactusInitCoord Coord2D <90, 24>
birdLowerInitCoord Coord2D <90, 26>
birdUpperInitCoord Coord2D <90, 18>

obstacles ObstacleData <0, <0, 0>>, <0, <0, 0>>, <0, <0, 0>>
obstacleCount BYTE 1
nextObstacleTick BYTE 5

dinoPose BYTE 0
crouchStatus BYTE 0

currentScore DWORD 0
isGameOver BYTE 0
jumpTickCounter BYTE 0

msg BYTE "GAME OVER", 0

.code
NextObstacle PROC USES eax ebx esi
    mov eax, 11
    call RandomRange
    add eax, 20
    mov nextObstacleTick, al

    .IF obstacleCount <= 2h
        ; spawn new obstacle
        xor esi, esi
find_index:
        .IF obstacles[esi].coords.X > 0h
            .IF esi < 6h
                add esi, 3h
                jmp find_index
            .ELSE
                ret
            .ENDIF
        .ELSE
            ; choose random object
            inc obstacleCount
            mov eax, 4
            call RandomRange
            mov (ObstacleData PTR obstacles[esi]).object, al

            .IF al == 3h
                mov al, birdUpperInitCoord.X
                mov bl, birdUpperInitCoord.Y
            .ELSEIF al == 2h
                mov al, birdLowerInitCoord.X
                mov bl, birdLowerInitCoord.Y
            .ELSE
                mov al, cactusInitCoord.X
                mov bl, cactusInitCoord.Y
            .ENDIF

            mov (Coord2D PTR obstacles[esi].coords).X, al
            mov (Coord2D PTR obstacles[esi].coords).Y, bl
        .ENDIF
    .ELSE
        ret
    .ENDIF
    ret
NextObstacle ENDP

CheckCollision PROC
    xor esi, esi
find_index:
    .IF obstacles[esi].coords.X > 20
        .IF obstacles[esi].coords.X < 30
            .IF dinoCoord.Y > 18
                inc isGameOver
                ret
            .ENDIF
        .ENDIF
    .ENDIF
    .IF esi < 6h
        add esi, 3h
        jmp find_index
    .ENDIF
    ret
CheckCollision ENDP

DoTick PROC USES esi
    INVOKE CheckCollision
    ; try to spawn new obstacle
    .IF nextObstacleTick == 0h
        INVOKE NextObstacle
    .ELSE
        dec nextObstacleTick
    .ENDIF

    ; do obstacle move
    xor esi, esi ; esi = 0h
render_obstacle:
    .IF isGameOver == 1h
        ret
    .ENDIF

    .IF obstacles[esi].coords.X > 0h
        .IF obstacles[esi].object >= 2h
            INVOKE ClearElement, 9, 3, Coord2D PTR obstacles[esi].coords
        .ELSE
            INVOKE ClearElement, 8, 5, Coord2D PTR obstacles[esi].coords
        .ENDIF
        sub (Coord2D PTR obstacles[esi].coords).X, 3h
        .IF obstacles[esi].coords.X > 0h
            INVOKE RenderObstacle, obstacles[esi].object, Coord2D PTR obstacles[esi].coords
        .ELSE
            dec obstacleCount
        .ENDIF
    .ENDIF
    .IF esi < 6h
        add esi, 3
        jmp render_obstacle
    .ENDIF

render_others:
    ; clear old dino
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
    INVOKE RenderDinosaur, dinoPose, dinoCoord
    INVOKE RenderScore, scoreCoord
    ; change dino pose
    xor dinoPose, 1h

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
    mov ecx, 2h
tick:
    .IF isGameOver == 1h
        ret
    .ENDIF
    INVOKE GetTickCount
    mov ebx, eax
    sub eax, tickTimeStamp

    .IF eax >= 50h
        INVOKE ReadInput
        INVOKE DoTick ; do tick
        mov tickTimeStamp, ebx ; update timeStamp
    .ENDIF

    inc ecx
    loop tick
    ret
GameStart ENDP

GameOver PROC
    call Clrscr
    mov edx, OFFSET msg
    call WriteString
    call Crlf
    ret
GameOver ENDP
END