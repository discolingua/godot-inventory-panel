class_name BloodSplat
extends Particles2D

var speed : Vector2 = Vector2.ZERO

func _ready():
	print("ITS A ME")

func _physics_process(delta):
	position += speed * delta