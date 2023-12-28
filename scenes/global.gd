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
