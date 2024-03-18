extends CharacterBody3D

@onready var player: Node3D = Global.player

@onready var enemy_helper: EnemyHelper = $EnemyHelper
@onready var state_machine = $AnimationTree["parameters/playback"]

func _physics_process(delta):
	var state = state_machine.get_current_node()
	
	if state == "idle" and enemy_helper.is_facing_away_more_than(5):
		state_machine.travel("rotating")
	elif state == "rotating":
		enemy_helper.turn_after_player(delta * 10)
		if not enemy_helper.is_facing_away_more_than(5):
			state_machine.travel("idle")
	elif state == "idle":
		enemy_helper.look_at_player()
		state_machine.travel("jumping")
	elif state == "jumping":
		var direction = Vector3.FORWARD * 5
		direction = direction.rotated(Vector3.UP, rotation.y)
		var collision = move_and_collide(direction * delta)
		if collision:
			# There's currently a bug where you can't travel from "jumping" to "cooldown" immediately.
			# So leapstone will try to keep jumping until "cooldown" is reached naturally 
			# after "jumping" animation.
			state_machine.travel("cooldown")

func _on_body_entered(body: Node3D):
	var health = Health.find_in_node(body)
	if health:
		health.deal_damage(self, 1)


func _on_dead(_source: Node3D):
	queue_free()
