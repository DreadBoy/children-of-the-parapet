extends Marker3D

@onready var player = $"../character";

func _process(delta):
	position = player.position
