extends Node

@onready var player = $/root/Main/player
@onready var root = $/root/Main

var currentScene = "main_menu"

signal OnBossDamage()

func load_next_scene(next_scene: String):
	root.get_node(currentScene).queue_free()
	currentScene = next_scene
	
	var new_scene = load("res://scenes/%s.tscn" % next_scene).instantiate()
	root.add_child(new_scene)
	
	var starting_point = new_scene.get_node("starting_point")
	if starting_point:
		player.position = starting_point.position
	

func frame_freeze(time_scale: float, duration: float):
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration * time_scale).timeout
	Engine.time_scale = 1
