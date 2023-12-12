extends Marker3D

@onready var player = Global.player;

func _process(_delta):
	position = player.position
