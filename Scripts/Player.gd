class_name Player
extends KinematicBody2D

# initialize state machine
enum STATES {IDLE, WALKING}

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 800


var state : int = STATES.IDLE

# store most recent non-zero movement input for setting attack direction
var velocity : Vector2 = Vector2.ZERO
var lastVelocity : Vector2 = Vector2.ZERO


onready var MainInventoryBox : Control = get_node("/root/GameWorld/GUI")

func _ready() -> void:
	MainInventoryBox.visible = false


func _physics_process(delta) -> void:
	match state:
		STATES.IDLE: idle(delta)
		STATES.WALKING: walking(delta)


func readMovement() -> Vector2:
	var _i = Vector2.ZERO

	_i.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_i.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# normalize vector fixes fast/distorted diagonals
	return _i.normalized()


func walking(delta) -> void:
	var _i = readMovement()
	if _i != Vector2.ZERO:
		lastVelocity = _i
		velocity = move_and_slide(_i * MAX_SPEED)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		state = STATES.IDLE


func idle(delta) -> void:
	if self.visible:
		var _i = readMovement()
		if _i != Vector2.ZERO:
			state = STATES.WALKING
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if Input.is_action_just_pressed("ui_accept"):
		if MainInventoryBox.visible:
			MainInventoryBox.visible = false
			self.visible = true
		else:
			MainInventoryBox.visible = true
			self.visible = false




