class_name Mob
extends KinematicBody2D

var run_speed = 25
var velocity = Vector2.ZERO
var player = null
var hitBody = null

func _physics_process(_delta):
    velocity = Vector2.ZERO

    # chase player if close enough
    if player:
        velocity = position.direction_to(player.position) * run_speed
    velocity = move_and_slide(velocity)


func _on_SeekRadius_body_entered(body:Node2D):
    print("seek " + body.name)
    if body.name == "Player":
        player = body


func _on_SeekRadius_body_exited(_body:Node2D):
	player = null



func _on_HitBoxArea2D_body_entered(_body:Node):
    if _body.is_in_group("Bullets"):
        print("Mob collide")
