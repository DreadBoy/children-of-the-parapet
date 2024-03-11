extends Node3D
class_name EnemyHelper

@onready var player: Node3D = Global.player
@onready var parent: Node3D = get_parent()

func is_farther_away_than(attack_range: float):
	var _range = player.global_position.distance_to(parent.global_position)
	return _range > attack_range

func is_facing_away_more_than(attack_angle: float):
	var angle = (-parent.transform.basis.z).angle_to(player.global_position - parent.global_position)
	return angle > deg_to_rad(attack_angle)

func turn_after_player(turn_speed: float):
	parent.global_transform = parent.global_transform.interpolate_with(
		parent.global_transform.looking_at(player.global_position, Vector3.UP),
		turn_speed
	)
	
func look_at_player():
	parent.global_transform = parent.global_transform.looking_at(
		player.global_position, Vector3.UP
	)
