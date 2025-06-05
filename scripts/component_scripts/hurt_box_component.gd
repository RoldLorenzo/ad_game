extends Area3D
class_name HurtBoxComponent

@export var damage: float = 1.0

func _on_area_entered(area: Area3D) -> void:
	if area is HitBoxComponent:
		var hitbox: HitBoxComponent = area
		
		hitbox.damage(damage)
