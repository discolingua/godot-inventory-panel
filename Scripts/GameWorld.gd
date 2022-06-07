class_name GameWorld
extends Node2D
# Main helper class for handling the inventory grid




# geometry of inventory panel
const GRID_COLUMNS = 4
const GRID_ROWS = 4
const CELL_SIZE = 32
const MARGIN = 8

# amount of padding around the edges of the grid
const marginOffset : Vector2 = Vector2(MARGIN, MARGIN)

# offset to adjust center-aligned nodes
const originOffset : Vector2 = Vector2( CELL_SIZE / 2, CELL_SIZE / 2)

enum ITEMS {
	EMPTY = 0,
	SOLID_TILE = 1,
	POTION = 2
}

const itemScenes : Array = [
	"res://Scenes/GridCell.tscn",
	"res://Scenes/GridCell.tscn",
	"res://Scenes/Potion.tscn",
]

# index of the item grabbed by the mouse cursor
export var grabbedItem : int

# serialized 1D array of grid cells, e.g. a 4x4 grid = indices 0-15
var inventoryGridContents : Array = []
const itemSceneIndex : Array =  []

# x-y coordinates of the top left corner of panel
onready var gridPosition : Vector2 = $GUI.rect_position

# set all inventory slots to empty (non-null)
func _ready():

	# initialize the item grid array with all zeroes
	for _i in range(0,GRID_COLUMNS * GRID_ROWS):
		inventoryGridContents.append(0)

	# load the packed scenes for the items in the index
	for _i in range(0,ITEMS.size()):
		itemSceneIndex.append(load(itemScenes[_i]))


func _input(event):
	if event is InputEventMouseButton \
		and event.button_index == BUTTON_LEFT \
		and event.is_pressed():

			var clickSpot : Vector2 = get_viewport().get_mouse_position()

			# set click measurements relative to the top left corner of the inv grid
			var clickCoords : Vector2 = clickSpot - gridPosition - marginOffset

			# ignore click unless it's inside a grid cell
			if boundsCheck(clickCoords):

				# get the coords of the clicked cell
				var cellNumber = getCellIndex(clickCoords)

				# set item index in the inventory grid array,then redraw the grid
				print("assigning to "+ str(cellNumber))
				inventoryGridContents[cellNumber] = 2
				gridRedraw()


# add an item (packed scene) to a specific cell of the grid
func addGridItem( cell : int, itemIndex : int ) -> void:

	# Look up the item in the index to get a node to instantiate
	var cellToAdd = itemSceneIndex[itemIndex].instance()
	cellToAdd.position = getCellCoordinates(cell) + originOffset

	# remove any executable code attached to the node
	cellToAdd.set_script(null)

	add_child(cellToAdd)

# check if mouse pointer is hovering over a valid grid cell
func boundsCheck(_clickCoords : Vector2) -> bool:

	if _clickCoords.x < 0 or _clickCoords.y < 0 \
			or _clickCoords.x > CELL_SIZE * GRID_COLUMNS \
			or _clickCoords.y > CELL_SIZE * GRID_ROWS:
		return false
	else:
		return true



# set all inventory tiles to 0 (empty)
func clearTiles() -> void:
	for tile in get_tree().get_nodes_in_group("inventoryTiles"):
		tile.queue_free()


# translates raw x-y mouse click coordinates to cell number (0-15)
func getCellIndex(clickCoords : Vector2) -> int:
	var clickColumn = int(clickCoords.x / CELL_SIZE)
	var clickRow = int(clickCoords.y / CELL_SIZE)
	return clickRow * GRID_COLUMNS + clickColumn


# translates linear cell number to x-y coords of that cell
func getCellCoordinates (cellNumber : int) -> Vector2:
	var _y = int(float(cellNumber) / GRID_ROWS)
	var _x = int(cellNumber % GRID_ROWS)
	_x = _x * CELL_SIZE + gridPosition.x + marginOffset.x
	_y = _y * CELL_SIZE + gridPosition.y + marginOffset.y
	return Vector2(_x,_y)


# clear and then redraw all grid cells
func gridRedraw() -> void:
	clearTiles()
	for _i in range(0, inventoryGridContents.size()):
		if inventoryGridContents[_i] > 0:
			print ("drawing " + str(_i))
			addGridItem(_i, inventoryGridContents[_i])
