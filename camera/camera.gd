extends Marker3D

@onready var player = Global.player
@onready var camera: Camera3D = $Camera3D

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0

func _ready():
	Global.on_camera_shake.connect(apply_shake)

func _process(delta):
	position = player.position
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, 5 * delta)
		camera.h_offset = rng.randf_range(-shake_strength, shake_strength)
		camera.v_offset = rng.randf_range(-shake_strength, shake_strength)
	
func apply_shake(strength: float):
	if strength > .3:
		push_warning("Camera shake above 0.3 is inadvisable")
	shake_strength = strength
