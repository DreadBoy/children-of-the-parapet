extends CharacterBody3D
class_name Player

@export var gravity = 6
@export var speed = 3
@export var dash_speed = 6

@onready var state_machine = $Pivot/character/AnimationTree["parameters/playback"]


func _ready():
	state_machine.travel("idle")
	$Pivot/"character"/"attack-area".body_entered.connect(_on_attack)
	$Pivot/"character"/"scene-area".body_entered.connect(_on_scene_hit)
	
func _physics_process(_delta):
	var state = state_machine.get_current_node()

	if state == "dash":
		var direction = _get_direction()
		
		var target_velocity = -$Pivot.global_transform.basis.z * dash_speed + direction / dash_speed

		if direction != Vector3.ZERO:
			$Pivot.look_at(position + target_velocity, Vector3.UP)
		
		velocity = target_velocity
		move_and_slide()
	elif state == "knockback":
		velocity = $Pivot.global_transform.basis.z * speed / 2
		move_and_slide()
	elif state == "walk" or state == "idle":
		var direction = _get_direction()
		
		var target_velocity = direction * speed
		target_velocity.y = -gravity

		velocity = target_velocity
		
		if direction != Vector3.ZERO:
			$Pivot.look_at(position + direction, Vector3.UP)
		move_and_slide()

		if Input.is_action_pressed("dash"):
			state_machine.travel("dash")
		elif direction != Vector3.ZERO and state != "walk":
			state_machine.travel("walk")
		elif direction == Vector3.ZERO and state != "idle":
			state_machine.travel("idle")

func _on_attack(body: Node3D):
	if state_machine.get_current_node() == "dash":
		print("attacked %s while dashing" % body)
		var health = Health.find_in_node(body)
		if health:
			health.deal_damage(self, 1)
		state_machine.travel("knockback")

func _on_scene_hit(body: Node3D):
	if state_machine.get_current_node() == "dash":
		print("hit wall %s while dashing" % body)
		state_machine.travel("knockback")

func _got_hit(source: Node3D, damage: int):
	if not state_machine.get_current_node() == "dash":
		print("got hit for %s" % damage)
		$Pivot.look_at(source.global_position, Vector3.UP)
		# TODO Create new state "was damaged" that is similar to knockback
		# but also changes model (make it red and squished for example)
		# doesn't change rotation but still moves away from source
		state_machine.travel("knockback")

func _get_direction():
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
	
	return direction
