extends Node2D


const COLUMNS = 4
const ROWS = 4
const CELL_SIZE = 32

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
		print (get_viewport().get_mouse_position())


func _physics_process(_delta) -> void:
	var _i : Vector2 = get_viewport().get_mouse_position()



func getCell(_clickSpot : Vector2) -> Vector2:
	var collideGrid : Node2D = get_node("GUI/Area2D")
	print(collideGrid.position)
	var gridOffset : Vector2 = Vector2.ZERO
	gridOffset.x = collideGrid.position.x - 64  # magic number fix this
	gridOffset.y = collideGrid.position.y - 64
	print(gridOffset)
	return collideGrid.position

