extends Node3D
class_name Bullet

@export var speed = 50

func _physics_process(delta: float) -> void:
	position.z -= speed * delta
	
	if position.z <= -200:
		free()

func _on_hurt_box_component_area_entered(area: Area3D) -> void:
	if area is UpgradeArea:
		var upgrade_area: UpgradeArea = area
		
		upgrade_area.value += int($HurtBoxComponent.damage)
		
	queue_free()
