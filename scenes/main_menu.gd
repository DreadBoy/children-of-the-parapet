extends Node3D


func on_start():
	Global.load_next_scene("level_1")
	Global.player.visible = true
