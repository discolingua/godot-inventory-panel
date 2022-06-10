class_name Bullet
extends Area2D

var speed : Vector2 = Vector2(-5,0)


func _ready():
	pass

func _physics_process(delta):
	position += speed * delta



func _on_Bullet_body_entered( _body : KinematicBody2D):
	print("yaa")