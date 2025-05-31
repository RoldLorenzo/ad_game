extends CharacterBody3D

@export var speed = 10
@export var bullet_scene: PackedScene

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	velocity = direction * speed
	move_and_slide()

func _on_shoot_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	
	bullet.position = position
	bullet.rotation = rotation
	
	get_parent().add_child(bullet)
