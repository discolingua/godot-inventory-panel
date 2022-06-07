class_name GuiCollider
extends Area2D
# listens if the mouse cursor is hovering over the grid


export var isHovering : bool


func _on_GuiCollider_mouse_entered():
	print ("yawp")
	isHovering = true


func _on_GuiCollider_mouse_exited():
	isHovering = false
