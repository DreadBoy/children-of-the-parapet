extends Node3D

@onready var state_machine = $AnimationTree["parameters/playback"]

func _on_player_enter(area: Area3D):
	print("%s entered gate" % area)
	state_machine.travel("break")
	
