class_name Mob
extends KinematicBody2D

var run_speed = 25
var velocity = Vector2.ZERO
var player = null

func _physics_process(_delta):
    velocity = Vector2.ZERO
    if player:
        velocity = position.direction_to(player.position) * run_speed
    velocity = move_and_slide(velocity)


func _on_SeekRadius_body_entered(body:Node):
	player = body

func _on_SeekRadius_body_exited(_body:Node):
	player = null



