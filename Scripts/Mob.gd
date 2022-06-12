class_name Mob
extends KinematicBody2D

var run_speed = 25
var velocity = Vector2.ZERO
var hitBody = null

func _physics_process(_delta):
    var player = get_node("/root/GameWorld/Player")

    # chase player if close enough
    velocity = position.direction_to(player.position) * run_speed
    velocity = move_and_slide(velocity)


func _on_HitBoxArea2D_body_entered(_body:Node):
    if _body.is_in_group("Bullets"):
        print("Mob collide")
