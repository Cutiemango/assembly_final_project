INCLUDE Irvine32.inc
INCLUDE graphics.inc

.data
currentScore DWORD 0
tickTimeStamp DWORD ?
mapCoord Coord2D <0, 0>
dinoCoord Coord2D <20, 23>
scoreCoord Coord2D <0, 31>
endScoreCoord Coord2D <48, 27>

cactusInitCoord Coord2D <90, 24>
birdLowerInitCoord Coord2D <90, 26>
birdUpperInitCoord Coord2D <90, 22>

obstacles ObstacleData <0, <0, 0>>, <0, <0, 0>>, <0, <0, 0>>
obstacleCount BYTE 1
nextObstacleTick BYTE 5

dinoPose BYTE 0
isCrouching BYTE 0
jumpTickCounter BYTE 0

isGameOver BYTE 0
difficulty BYTE 25

.code
NextObstacle PROC USES eax ebx esi
    ; next obstacle tick = 15 ~ 25
    mov eax, 6
    call RandomRange
    movzx ebx, difficulty
    add eax, ebx
    mov nextObstacleTick, al

    .IF obstacleCount <= 2h
        ; spawn new obstacle
        xor esi, esi
loop_obstacles:
        .IF obstacles[esi].coords.X > 0h
            .IF esi < 6h
                add esi, 3h
                jmp loop_obstacles
            .ELSE
                ret ; no space for new obstacle, return
            .ENDIF
        .ELSE
            ; choose random object (0 ~ 3)
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

IncreaseDifficulty PROC USES eax ebx edx
    mov eax, currentScore
    mov edx, 0
    mov ebx, 100
    div ebx ; edx = remainder

    ; checks if score % 100 = 0
    .IF edx == 0
        dec difficulty
    .ENDIF
    ret
IncreaseDifficulty ENDP

CheckCollision PROC
    xor esi, esi
loop_obstacles:
    .IF obstacles[esi].coords.X > 20
        .IF obstacles[esi].coords.X < 30
            .IF isCrouching == 0h
                .IF dinoCoord.Y > 18
                    inc isGameOver
                    ret
                .ELSEIF obstacles[esi].object == 3h
                    inc isGameOver
                    ret
                .ENDIF
            .ENDIF
        .ENDIF
    .ENDIF
    .IF esi < 6h
        add esi, 3h
        jmp loop_obstacles
    .ENDIF
    ret
CheckCollision ENDP

DoTick PROC USES esi
    INVOKE CheckCollision
    .IF isGameOver == 1h
        ret
    .ENDIF

render_dinosaur:
    ; clear old dino
    .IF isCrouching == 0h
        INVOKE ClearElement, 10, 6, dinoCoord
    .ELSE
        INVOKE ClearElement, 10, 4, dinoCoord
    .ENDIF

    ; do dino jump
    .IF jumpTickCounter > 8h
        dec dinoCoord.Y
    .ELSEIF jumpTickCounter > 0h
        inc dinoCoord.Y
    .ENDIF

    .IF jumpTickCounter > 0h
        dec jumpTickCounter
    .ENDIF
    .IF isCrouching == 0h
        INVOKE RenderDinosaur, dinoPose, dinoCoord
    .ELSE
        INVOKE RenderDinoCrouch, dinoPose, dinoCoord
    .ENDIF
    INVOKE RenderScore, scoreCoord
    ; change dino pose
    xor dinoPose, 1h

    ; try to spawn new obstacle
    .IF nextObstacleTick == 0h
        INVOKE NextObstacle
    .ELSE
        dec nextObstacleTick
    .ENDIF

    ; do obstacle move
    xor esi, esi
render_obstacle:
    .IF obstacles[esi].coords.X > 0h
        ; clear old obstacle
        .IF obstacles[esi].object >= 2h
            INVOKE ClearElement, 9, 3, Coord2D PTR obstacles[esi].coords
        .ELSE
            INVOKE ClearElement, 8, 5, Coord2D PTR obstacles[esi].coords
        .ENDIF

        ; move obstacle
        sub (Coord2D PTR obstacles[esi].coords).X, 3h

        ; determine if we need to re-render the obstacle
        .IF obstacles[esi].coords.X > 0h
            INVOKE RenderObstacle, obstacles[esi].object, Coord2D PTR obstacles[esi].coords
        .ELSE
            dec obstacleCount
        .ENDIF

    .ENDIF

    ; go to next index
    .IF esi < 6h
        add esi, 3
        jmp render_obstacle
    .ENDIF

    inc currentScore
    ret
DoTick ENDP

ReadInput PROC
    call ReadKey
    .IF ax == 4800h ; up key
        .IF jumpTickCounter == 0h
            mov jumpTickCounter, 16
            mov isCrouching, 0h
        .ENDIF
    .ELSEIF ax == 5000h ; down key
        xor isCrouching, 1h
    .ENDIF
    ret
ReadInput ENDP

GetScore PROC
    mov eax, currentScore
    ret
GetScore ENDP

GameStart PROC
    ; draw map
    INVOKE RenderBackground, 0h

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

    .IF eax >= 50
        INVOKE ReadInput
        INVOKE DoTick ; do tick
        INVOKE IncreaseDifficulty
        mov tickTimeStamp, ebx ; update timeStamp
    .ENDIF

    inc ecx
    loop tick
    ret
GameStart ENDP

GameOver PROC
    call Clrscr
    INVOKE RenderBackground, 2h
    INVOKE RenderScore, endScoreCoord
    mGotoXY 0, 31
    ret
GameOver ENDP
END