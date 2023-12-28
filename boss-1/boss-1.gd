extends CharacterBody3D

@export var speed = 1
@export var turn_speed = 2.5
@export var attack_range = 1
@export var attack_angle = 30

@onready var state_machine = $Pivot/"boss-1"/AnimationTree["parameters/playback"]
@onready var player: Node3D = Global.player

func _ready():
	state_machine.travel("idle")
	$Pivot/"boss-1"/"club-area".body_entered.connect(_on_player_hit)

func _physics_process(delta):
	
	var state = state_machine.get_current_node()
	
	if state == "idle" and _should_move_closer():
		_look_after_player(delta)
		state_machine.travel("walk")
	elif state == "idle":
		_look_after_player(delta)
		state_machine.travel("attack")
	elif state == "walk" and _should_move_closer():
		_look_after_player(delta)
		velocity = Vector3.FORWARD * speed
		velocity = velocity.rotated(Vector3.UP, rotation.y)
		move_and_slide()
	elif state == "walk":
		_look_after_player(delta)
		state_machine.travel("attack")

func _should_move_closer():
	var _range = player.global_position.distance_to(global_position)
	var outOfRange = _range > attack_range
	var angle = (-transform.basis.z).angle_to(player.global_position - global_position)
	var outOfAngle = angle > deg_to_rad(attack_angle)
	return outOfRange or outOfAngle

func _look_after_player(delta):
	global_transform = global_transform.interpolate_with(
		global_transform.looking_at(player.global_position, Vector3.UP),
		delta * turn_speed
	)

func _on_player_hit(_body: Node3D):
	Global.load_next_scene("game_loss")
	pass
