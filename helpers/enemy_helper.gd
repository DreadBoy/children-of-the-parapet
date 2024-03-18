extends Node3D
class_name EnemyHelper

@onready var player: Node3D = Global.player
@onready var parent: Node3D = get_parent()

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

var synced = false

func _ready():
	_actor_setup.call_deferred()
	
func _actor_setup():
	await get_tree().physics_frame
	synced = true
	_update_actor_target()

func _update_actor_target():
	if synced:
		navigation_agent.set_target_position(player.global_position)

func _physics_process(_delta):
	_update_actor_target()
	
func _get_target():
	var target = navigation_agent.get_next_path_position()
	return Vector3(target.x, parent.global_position.y, target.z)
	
func is_farther_away_than(attack_range: float):
	var target = _get_target()
	var _range = target.distance_to(parent.global_position)
	return _range > attack_range

func is_facing_away_more_than(attack_angle: float):
	var target = _get_target()
	var angle = (-parent.transform.basis.z).angle_to(target - parent.global_position)
	return angle > deg_to_rad(attack_angle)

func turn_after_player(turn_speed: float):
	var target = _get_target()
	parent.global_transform = parent.global_transform.interpolate_with(
		parent.global_transform.looking_at(target, Vector3.UP),
		turn_speed
	)
	
func look_at_player():
	var target = _get_target()
	parent.global_transform = parent.global_transform.looking_at(
		target, Vector3.UP
	)
