extends Node
class_name HealthComponent

signal health_changed(new_value)
signal die

@export var max_health: float = 10.0
var health

func _ready() -> void:
	health = max_health

func damage(damage_value: float) -> void:
	health -= damage_value
	
	if health <= 0:
		health = 0
		die.emit()
	
	health_changed.emit(health)
