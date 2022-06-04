extends Node2D


const COLUMNS = 4
const ROWS = 4
const CELL_SIZE = 32
const MARGIN = 8

var inventoryGridContents : Array = []


# func _ready():

	# initialize empty 2 dimensional array
	# for _x in range(COLUMNS):
	# 	inventoryGridContents[_x] = []
	# 	for _y in range(ROWS):
	# 		inventoryGridContents[_x][_y] = 0

func _input(event):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		print (getCell(get_viewport().get_mouse_position()))



func getCell(clickSpot : Vector2) -> Vector2:
	var gridPosition : Vector2 = $GUI.rect_position
	var marginOffset : Vector2 = Vector2(MARGIN, MARGIN)
	var invCoords : Vector2 = clickSpot - gridPosition - marginOffset
	var clickColumn = int(invCoords.x / CELL_SIZE)
	var clickRow = int(invCoords.y / CELL_SIZE)
	return Vector2(clickRow, clickColumn)
