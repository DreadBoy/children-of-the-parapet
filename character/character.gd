extends CharacterBody3D

@export var speed = 3

@onready var state_machine = $Pivot/character/AnimationTree["parameters/playback"]

var target_velocity = Vector3.ZERO

func _ready():
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

	velocity = target_velocity
	
	if direction != Vector3.ZERO:
		$Pivot.look_at(position + direction, Vector3.UP)
	move_and_slide()

	if direction != Vector3.ZERO and state_machine.get_current_node() != "walk":
		state_machine.travel("walk")
	elif direction == Vector3.ZERO and state_machine.get_current_node() != "idle":
		state_machine.travel("idle")
