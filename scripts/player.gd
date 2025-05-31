extends CharacterBody3D
class_name Player

@export var speed = 10
@export var bullet_scene: PackedScene
@export var min_fire_rate: float = 0.2
@export var max_speed: int = 100

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

func upgrade_fire_rate(time_off: float) -> void:
	var new_time = $ShootTimer.wait_time - time_off
	$ShootTimer.wait_time = max(new_time, min_fire_rate)

func upgrade_speed(increase: int) -> void:
	speed = min(speed + increase, max_speed)

func _on_shoot_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	
	bullet.position = position
	bullet.rotation = rotation
	
	get_parent().add_child(bullet)
