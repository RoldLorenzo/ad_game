extends Area3D

@export var speed = 50

func _physics_process(delta: float) -> void:
	position.z -= speed * delta
	
	if position.z <= -200:
		free()
