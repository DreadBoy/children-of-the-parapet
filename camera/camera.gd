extends Marker3D

@onready var player = Global.player;

func _process(delta):
	position = player.position
