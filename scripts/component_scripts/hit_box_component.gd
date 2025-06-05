extends Area3D
class_name HitBoxComponent

@export var health_component : HealthComponent

func damage(damage_value: float) -> void:
	if health_component:
		health_component.damage(damage_value)
