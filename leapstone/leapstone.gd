extends CharacterBody3D

@onready var player: Node3D = Global.player

@onready var enemy_helper: EnemyHelper = $EnemyHelper
@onready var state_machine = $leapstone_animated/AnimationTree["parameters/playback"]

func _ready():
	pass


func _physics_process(delta):
	var state = state_machine.get_current_node()
	
	if state == "idle" and enemy_helper.is_facing_away_more_than(5):
		state_machine.travel("rotating")
	elif state == "idle":
		enemy_helper.look_at_player()
		state_machine.travel("jumping")
	elif state == "rotating":
		enemy_helper.turn_after_player(delta * 10)
		if not enemy_helper.is_facing_away_more_than(5):
			state_machine.travel("idle")
	elif state == "jumping":
		var velocity = Vector3.FORWARD * 5
		velocity = velocity.rotated(Vector3.UP, rotation.y)
		var collision = move_and_collide(velocity * delta)
		if collision:
			state_machine.travel("cooldown")
