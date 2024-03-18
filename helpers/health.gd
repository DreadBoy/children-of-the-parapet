extends Node3D
class_name Health

@export var health: int

signal on_dead(source: Node3D)
signal on_damage_received(source: Node3D, damage: int)

func deal_damage(source: Node3D, damage: int):
	health -= damage
	on_damage_received.emit(source, damage)
	if not is_alive():
		on_dead.emit(source)

func is_alive():
	return health > 0

static func find_in_node(node: Node3D):
	var nodes = node.get_children().filter(func(child): return child is Health)
	if not nodes.is_empty():
		return nodes[0]
	return null
	
