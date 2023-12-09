extends Node3D

@onready var state_machine = $AnimationTree["parameters/playback"]

func _on_player_enter(_body: Node3D):
	state_machine.travel("break")
	
