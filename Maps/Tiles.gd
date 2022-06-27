tool
extends TileMap


export (int) var counter = 0
export (bool) var generateAutoTileCollision = false

var tileSize = 8
var sheetSize = Vector2(20, 127)



func _ready():
	print("Tiles.gd ready func")
	_generateAutotileCollision()


func _generateAutotileCollision():
	print("Tiles.gd generate autotile collision")
	for x in sheetSize.x:
		for y in sheetSize.y:
			var shape = ConvexPolygonShape2D.new()
			shape.points = [Vector2(0,0),
							Vector2(0, tileSize),
							Vector2(tileSize, tileSize),
							Vector2(tileSize, 0),
							Vector2(0,0)]
			tile_set.tile_add_shape(0, shape,
									Transform2D(0.0, Vector2(0,0)),
									false,
									Vector2(x,y))



