extends StaticBody2D


onready var scrollSpeed : Vector2 = Vector2(-0.2, 0)


func _physics_process(_delta):
	position += scrollSpeed

