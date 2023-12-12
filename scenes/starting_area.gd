extends Node

signal OnAreaExit()

func on_doorway_entered(_body: Node3D):
	OnAreaExit.emit()
