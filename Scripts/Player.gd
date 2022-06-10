class_name Player
extends KinematicBody2D

# initialize state machine
enum STATES {IDLE, WALKING, INVENTORY}

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 800

export var cursorTexture : ImageTexture = ImageTexture.new()

var state : int = STATES.IDLE

var Bullet : PackedScene = preload("res://Scenes/Bullet.tscn")

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
		STATES.INVENTORY: manageInventory()


func readMovement() -> Vector2:
	var _i : Vector2 = Vector2.ZERO

	_i.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_i.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# normalize vector fixes fast/distorted diagonals
	return _i.normalized()


func walking(delta) -> void:
	var _i : Vector2 = readMovement()
	if _i != Vector2.ZERO:
		lastVelocity = _i
		velocity += move_and_slide(_i * MAX_SPEED)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		state = STATES.IDLE


func idle(delta) -> void:
	var _i = readMovement()
	if _i != Vector2.ZERO:
		state = STATES.WALKING
	else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if Input.is_action_just_pressed("ui_accept"):
			MainInventoryBox.visible = true
			self.visible = false
			state = STATES.INVENTORY
	if Input.is_key_pressed(KEY_A):
		print("blep")
		var bullet : Area2D =  Bullet.instance()
		bullet.position = self.position
		bullet.speed = Vector2(-30, 0)
		get_parent().add_child(bullet)



func manageInventory() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		MainInventoryBox.visible = false
		self.visible = true
		state = STATES.IDLE
