extends Marker3D

@onready var player = Global.player
@onready var camera: Camera3D = $Camera3D

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0
var targets = []
var camera_distance: float = 0

func _ready():
	Global.on_camera_shake.connect(apply_shake)
	Global.on_enemy_aggro.connect(_add_enemy)
	Global.on_enemy_deaggro.connect(_remove_enemy)
	camera_distance = camera.transform.origin.distance_to(Vector3.ZERO)

func _process(delta):
	position = player.position
	_find_correct_zoom(delta)
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, 5 * delta)
		camera.h_offset = rng.randf_range(-shake_strength, shake_strength)
		camera.v_offset = rng.randf_range(-shake_strength, shake_strength)
	
func apply_shake(strength: float):
	if strength > .3:
		push_warning("Camera shake above 0.3 is inadvisable")
	shake_strength = strength

func _add_enemy(enemy: Node3D):
	if not targets.has(enemy):
		targets.append(enemy)
	print(targets)

func _remove_enemy(enemy: Node3D):
	targets = targets.filter(func(t): return t != enemy)
	print(targets)

func _find_correct_zoom(delta):
	
	var zoom_speed: float = 5.0  # Base zoom speed (adjustable)
	var min_zoom_speed: float = 5.0  # Minimum zoom speed
	var max_zoom_speed: float = 20.0  # Maximum zoom speed (faster when far away)
	var smoothing_factor: float = 0.5  # Controls how smooth the lerp is
	
	var aabb = AABB(player.global_transform.origin, Vector3.ZERO)
	for node in targets:
		if node is Node3D:
			aabb = aabb.expand(node.global_transform.origin)
	
	aabb = aabb.abs()
	var distance_to_fit = max(aabb.size.length(), camera_distance)

	var current_offset = camera.transform.origin.distance_to(Vector3.ZERO)
	var distance_difference = distance_to_fit - current_offset
	
	var dynamic_zoom_speed = clamp(zoom_speed * abs(distance_difference), min_zoom_speed, max_zoom_speed)
	var new_offset = lerp(current_offset, distance_to_fit, smoothing_factor * dynamic_zoom_speed * delta)
	camera.translate_object_local(Vector3(0, 0, new_offset - current_offset))
	
	# DebugDraw3D.draw_aabb(aabb, Color.BROWN, 6)
