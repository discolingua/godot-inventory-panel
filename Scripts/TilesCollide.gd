class_name TilesCollide
extends TileMap

var ldtkPath = "res://Maps/1bit sidescroll.ldtk"
var csvArray : Array

func _ready():
	var ldtkJson = load_LDtk_file(ldtkPath)
	print("TilesCollide.gd tried to read some JSON")
	csvArray = ldtkJson.levels[0].layerInstances[0].intGridCsv
	print(csvArray)

#get LDtk file as JSON.
func load_LDtk_file(filepath):
	var json_file = File.new()
	json_file.open(filepath, File.READ)
	var json = JSON.parse(json_file.get_as_text()).result
	json_file.close()

	json['base_dir'] = filepath.get_base_dir()

	return json
