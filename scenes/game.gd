extends Node

func on_starting_area_exit():
	add_child(load("res://scenes/arena.tscn").instantiate())
	$"starting-area".queue_free()
