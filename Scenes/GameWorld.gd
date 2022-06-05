class_name GameWorld
extends Node2D
# Main helper class for handling the inventory grid




# geometry of inventory panel
const GRID_COLUMNS = 4
const GRID_ROWS = 4
const CELL_SIZE = 32
const MARGIN = 8

# marginOffset is the amount of padding around the edges of the grid
const marginOffset : Vector2 = Vector2(MARGIN, MARGIN)


# index of the item grabbed by the mouse cursor
export var grabbedItem : int

# grid cells are serialized into a 1D array, e.g. a 4x4 grid = indices 0-15
var inventoryGridContents : Array = []

# grid square node for image in the grid
const GridCell = preload("res://Scenes/GridCell.tscn")

# x-y coordinates of the top left corner of panel
onready var gridPosition : Vector2 = $GUI.rect_position

# set all inventory slots to empty (non-null)
func _ready():
	for _i in range(0,GRID_COLUMNS * GRID_ROWS):
		inventoryGridContents.append(0)


func _input(event):
	if event is InputEventMouseButton \
		and event.button_index == BUTTON_LEFT \
		and event.is_pressed():
			var cellNumber = getCellIndex(get_viewport().get_mouse_position())
			var cellCoordinates = getCellCoordinates(cellNumber)
			print (cellCoordinates)
			var clickedCell = GridCell.instance()
			clickedCell.rect_position = cellCoordinates
			clickedCell.rect_size = Vector2(CELL_SIZE, CELL_SIZE)
			add_child(clickedCell)


func getCellIndex(clickSpot : Vector2) -> int:
	var invCoords : Vector2 = clickSpot - gridPosition - marginOffset
	var clickColumn = int(invCoords.x / CELL_SIZE)
	var clickRow = int(invCoords.y / CELL_SIZE)
	return clickRow * GRID_COLUMNS + clickColumn


func getCellCoordinates (cellNumber : int) -> Vector2:
	var _y = int(float(cellNumber) / GRID_ROWS)
	var _x = int(cellNumber % GRID_ROWS)
	_x = _x * CELL_SIZE + gridPosition.x + marginOffset.x
	_y = _y * CELL_SIZE + gridPosition.y + marginOffset.y
	return Vector2(_x,_y)
