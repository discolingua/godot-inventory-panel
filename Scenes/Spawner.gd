class_name Spawner
extends Area2D

const Mob = preload("res://Scenes/Mob.tscn")

func _on_SpawnTimer_timeout():
	var mob = Mob.instance()
	mob.position = self.position
	get_parent().add_child(mob)


