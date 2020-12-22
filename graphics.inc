Coord2D STRUCT
  X BYTE ?
  Y BYTE ?
Coord2D ENDS

InitHandle PROTO
RenderMap PROTO
RenderScore PROTO, position: Coord2D
RenderCactus PROTO, position: Coord2D
RenderDinosaur PROTO, pose: BYTE, position: Coord2D
RenderElement PROTO, character: PTR BYTE, color: BYTE, rowSize: BYTE, position: Coord2D
ClearElement PROTO, colSize: BYTE, rowSize: BYTE, position: Coord2D
