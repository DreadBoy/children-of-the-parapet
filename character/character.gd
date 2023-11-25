extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO
var state_machine

func _ready():
	state_machine = $Pivot/character/AnimationTree["parameters/playback"]
	state_machine.travel("idle")
	
func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.z -= 1
	if Input.is_action_pressed("move_left"):
		direction.z += 1
	if Input.is_action_pressed("move_up"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.x += 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	else:
		target_velocity.y = 0

	velocity = target_velocity
	
	$Pivot.look_at(position + direction, Vector3.UP)
	move_and_slide()

	if direction != Vector3.ZERO and state_machine.get_current_node() != "walk":
		state_machine.travel("walk")
	elif direction == Vector3.ZERO and state_machine.get_current_node() != "idle":
		state_machine.travel("idle")
