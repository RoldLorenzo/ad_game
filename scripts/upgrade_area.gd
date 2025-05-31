extends Area3D
class_name UpgradeArea

@export var speed = 5

func _physics_process(delta: float) -> void:
	position.z += speed * delta
