ObstacleData STRUCT
  object BYTE ?
  coords Coord2D <>
ObstacleData ENDS

CACTUS_1 = 0h
CACTUS_2 = 1h
GROUNDED_BIRD = 2h
FLYING_BIRD = 3h

NextObstacle PROTO
IncreaseDifficulty PROTO
DoTick PROTO
CheckCollision PROTO
ReadInput PROTO
ResetVariables PROTO
GetScore PROTO
GameStart PROTO
GameOver PROTO