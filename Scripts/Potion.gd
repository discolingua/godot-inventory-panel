class_name Potion
extends Area2D

var isHovering : bool = false

func _input(event):
    if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed() \
	and isHovering:
        self.on_click()

func _on_Potion_mouse_entered():
	isHovering = true
	print("hover in")


func _on_Potion_mouse_exited():
	isHovering = false
	print("hover out")


func on_click():
    print("Click")

