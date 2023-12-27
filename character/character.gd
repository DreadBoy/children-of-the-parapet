extends CharacterBody3D

@export var speed = 3
@export var dash_speed = 6

@onready var state_machine = $Pivot/character/AnimationTree["parameters/playback"]

var target_velocity = Vector3.ZERO

func _ready():
	state_machine.travel("idle")
	$Pivot/"character"/"attack-area".body_entered.connect(_on_attack)
	$Pivot/"character"/"scene-area".body_entered.connect(_on_scene_hit)
	
func _physics_process(_delta):
	var state = state_machine.get_current_node()

	if state == "dash":
		velocity = -$Pivot.global_transform.basis.z * dash_speed
		move_and_slide()
	elif state == "knockback":
		velocity = $Pivot.global_transform.basis.z * speed / 2
		move_and_slide()
	elif state == "walk" or state == "idle":
			
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

		if Input.is_action_pressed("dash"):
			state_machine.travel("dash")
		elif direction != Vector3.ZERO and state != "walk":
			state_machine.travel("walk")
		elif direction == Vector3.ZERO and state != "idle":
			state_machine.travel("idle")

func _on_attack(body: Node3D):
	if state_machine.get_current_node() == "dash":
		print("attacked %s while dashing" % body)
		Global.OnBossDamage.emit()
		state_machine.travel("knockback")

func _on_scene_hit(body: Node3D):
	if state_machine.get_current_node() == "dash":
		print("hit wall %s while dashing" % body)
		state_machine.travel("knockback")

