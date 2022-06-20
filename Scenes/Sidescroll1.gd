extends Sprite

var scrollSpeed : float = 0.2


func _physics_process(_delta):
	position.x -= scrollSpeed
