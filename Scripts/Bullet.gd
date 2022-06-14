class_name Bullet
extends Area2D

var speed : Vector2 = Vector2(-5,0)

var BloodSplat : PackedScene = preload("res://Scenes/Bloodsplat.tscn")


func _physics_process(delta):
	position += speed * delta
	if speed.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false



func _on_Bullet_body_entered( _body : KinematicBody2D):
	if _body is Mob:
		var bloodSplat = BloodSplat.instance()
		bloodSplat.speed = Vector2(speed / 10)
		bloodSplat.position = self.position
		get_parent().add_child(bloodSplat)
		_body.queue_free()
		queue_free()
