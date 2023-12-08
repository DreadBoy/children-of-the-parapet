extends CharacterBody3D

@export var speed = 1
@export var turn_speed = 3
@export var attack_range = 1
@export var attack_angle = 30

@export var player: Node3D

@onready var state_machine = $Pivot/"boss-1"/AnimationTree["parameters/playback"]

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
	var _range = player.transform.origin.distance_to(transform.origin)
	var angle = (-transform.basis.z).angle_to(player.transform.origin - transform.origin)
	return _range > attack_range or  angle >  deg_to_rad(attack_angle)

func _look_after_player(delta):
	transform = transform.interpolate_with(transform.looking_at(player.transform.origin, Vector3.UP), delta * turn_speed)

func _on_player_hit(body: Node3D):
	print(body)
	pass
