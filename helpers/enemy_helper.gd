extends Node3D
class_name EnemyHelper

@onready var parent: Node3D = get_parent()
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

var target: Node3D
	
func _update_actor_target(node: Node3D):
	_update_target_position(node)
	target = node

func _update_target_position(node):
	if node:
		navigation_agent.set_target_position(node.global_position)
	else:
		navigation_agent.set_target_position(global_position)

func _physics_process(_delta):
	_update_target_position(target)
	
func _get_next_point():
	if not target:
		return null
	var point = navigation_agent.get_next_path_position()
	return Vector3(point.x, parent.global_position.y, point.z)

func has_target():
	return target

func is_farther_away_than(attack_range: float):
	var nextPoint = _get_next_point()
	if not nextPoint:
		return false
	var _range = nextPoint.distance_to(parent.global_position)
	return _range > attack_range

func is_facing_away_more_than(attack_angle: float):
	var nextPoint = _get_next_point()
	if not nextPoint:
		return false
	var angle = (-parent.transform.basis.z).angle_to(nextPoint - parent.global_position)
	return angle > deg_to_rad(attack_angle)

func turn_after_player(turn_speed: float):
	var nextPoint = _get_next_point()
	if not nextPoint:
		return
	parent.global_transform = parent.global_transform.interpolate_with(
		parent.global_transform.looking_at(nextPoint, Vector3.UP),
		turn_speed
	)
	
func look_at_player():
	var nextPoint = _get_next_point()
	if not nextPoint:
		return
	parent.global_transform = parent.global_transform.looking_at(
		nextPoint, Vector3.UP
	)

func _on_area_3d_body_entered(body: Node3D):
	print("area entered %s" % body)
	if body is Player:
		_update_actor_target(body)

func _on_area_3d_body_exited(body):
	print("area exited %s" % body)
	if body is Player:
		_update_actor_target(null)
