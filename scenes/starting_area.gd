extends Node

func on_doorway_entered(_body: Node3D):
	Global.load_next_scene("arena")
