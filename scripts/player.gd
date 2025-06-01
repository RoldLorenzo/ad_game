extends CharacterBody3D
class_name Player

@onready var animation_tree: AnimationTree = $AnimationTree
@export var bullet_scene: PackedScene
const max_speed = 100
const min_speed = 5
const max_fire_rate_cooldown = 5
const min_fire_rate_cooldown = 0.2

@export var speed = 10 :
	set(value):
		if value > max_speed:
			speed = max_speed
		elif value < min_speed:
			speed = min_speed
		else:
			speed = value

@export var fire_rate = 2 :
	set(value):
		print(value)
		
		if value > max_fire_rate_cooldown:
			fire_rate = max_fire_rate_cooldown
		elif value < min_fire_rate_cooldown:
			fire_rate = min_fire_rate_cooldown
		else:
			fire_rate = value
		
		print(fire_rate)
		$ShootTimer.wait_time = fire_rate

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	animation_tree.set("parameters/Transition/transition_request", "Run")
	
	if Input.is_action_pressed("move_right"):
		animation_tree.set("parameters/Transition/transition_request", "RunRight")
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		animation_tree.set("parameters/Transition/transition_request", "RunLeft")
		direction.x -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	velocity = direction * speed
	move_and_slide()

func _on_shoot_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	
	bullet.position = $BulletSpawnPos.global_position
	
	get_parent().add_child(bullet)
