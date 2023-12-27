extends Node3D

var boss_health = 10
@onready var boss_bar = $"PanelContainer/MarginContainer/HBoxContainer/ColorRect"

func _ready():
	Global.OnBossDamage.connect(_on_boss_damage)
	await get_tree().create_timer(0).timeout
	_update_ui()

func _process(delta):
	pass

func _on_boss_damage():
	boss_health = boss_health - 1
	_update_ui()
	if boss_health == 0:
		Global.OnGameWon.emit()

func _update_ui():
	var parent = boss_bar.get_parent_control()
	boss_bar.custom_minimum_size = Vector2(parent.size.x * boss_health / 10, 0)
