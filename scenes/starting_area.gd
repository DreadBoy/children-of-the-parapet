extends Node

signal OnAreaExit()

func on_doorway_entered(body: Node3D):
	OnAreaExit.emit()
