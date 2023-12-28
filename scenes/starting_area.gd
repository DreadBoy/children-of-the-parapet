extends Node

func _ready():
	Global.player.visible = true

func on_doorway_entered(_body: Node3D):
	Global.load_next_scene("arena")
