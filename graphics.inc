Coord2D STRUCT
  X BYTE ?
  Y BYTE ?
Coord2D ENDS

; dh = row(Y), dl = col(X)
mGotoXY MACRO X, Y
    push edx
    mov dl, X
    mov dh, Y
	call GotoXY
    pop edx
ENDM

GAME_MAP = 0h
START_MAP = 1h
END_MAP = 2h

InitHandle PROTO
RenderBackground PROTO, mapNumber: BYTE
RenderScore PROTO, position: Coord2D
RenderReplayMsg PROTO, position: Coord2D
RenderObstacle PROTO, object: BYTE, position: Coord2D
RenderDinosaur PROTO, pose: BYTE, position: Coord2D
RenderDinoCrouch PROTO, pose: BYTE, position: Coord2D
RenderElement PROTO, character: PTR BYTE, color: BYTE, rowSize: BYTE, position: Coord2D
RenderFloor PROTO, tick: DWORD, position: Coord2D
ClearElement PROTO, colSize: BYTE, rowSize: BYTE, position: Coord2D
