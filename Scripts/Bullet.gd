class_name Bullet
extends Area2D

var speed : Vector2 = Vector2(-5,0)


func _ready():
	pass


func _physics_process(delta):
	position += speed * delta
	if speed.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false



func _on_Bullet_body_entered( _body : KinematicBody2D):
	if _body.is_in_group("Mobs"):
		print("bullet signal")
		_body.queue_free()