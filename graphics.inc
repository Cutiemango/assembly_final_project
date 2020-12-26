Coord2D STRUCT
  X BYTE ?
  Y BYTE ?
Coord2D ENDS

; type: 0 = cactus1, 1 = cactus2, 2 = bird, 3 = flying bird
ObstacleData STRUCT
  object BYTE ?
  coords Coord2D <>
ObstacleData ENDS

; dh = row(Y), dl = col(X)
mGotoXY MACRO X, Y
    push edx
    mov dl, X
    mov dh, Y
	call GotoXY
    pop edx
ENDM

InitHandle PROTO
RenderBackground PROTO, mapNumber: BYTE
RenderScore PROTO, position: Coord2D
RenderObstacle PROTO, object: BYTE, position: Coord2D
RenderDinosaur PROTO, pose: BYTE, position: Coord2D
RenderDinoCrouch PROTO, pose: BYTE, position: Coord2D
RenderElement PROTO, character: PTR BYTE, color: BYTE, rowSize: BYTE, position: Coord2D
ClearElement PROTO, colSize: BYTE, rowSize: BYTE, position: Coord2D
