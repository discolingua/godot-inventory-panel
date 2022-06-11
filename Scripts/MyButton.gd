class_name MyButton
extends Button

onready var myTimer = get_node("Timer")


func _on_Timer_timeout():
	print (".")


func _on_Button_button_up():
	print("click")
	myTimer.paused = not myTimer.paused
