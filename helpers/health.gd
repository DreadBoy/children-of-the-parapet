extends Node3D
class_name Health


@export var health: int

signal on_dead()

func receive_damage(damage: int):
	health -= damage
	if not is_alive():
		on_dead.emit()

func is_alive():
	return health > 0

static func find_in_node(node: Node3D):
	var nodes = node.get_children().filter(func(child): return child is Health)
	if not nodes.is_empty():
		return nodes[0]
	return null
	
