extends CharacterBody3D
class_name Player

# Emmitted whenever an attribute (like speed or firerate) gets changed.
signal attribute_changed(attribute_name: String, new_value: float)

@onready var animation_tree: AnimationTree = $AnimationTree
@export var bullet_scene: PackedScene
const max_speed: int = 100
const min_speed: float = 5.0
const max_fire_rate_cooldown = 5
const min_fire_rate_cooldown = 0.2
const min_damage = 0.5
const max_damage = 100

@export var speed = 10 :
	set(value):
		speed = clampi(value, min_speed, max_speed)
		attribute_changed.emit("speed", speed)

@export var fire_rate = 2 :
	set(value):
		fire_rate = clampf(value, min_fire_rate_cooldown, max_fire_rate_cooldown)
		$ShootTimer.wait_time = fire_rate
		attribute_changed.emit("fire_rate", fire_rate)

@export var damage = 1.0 :
	set(value):
		damage = clampf(value, min_damage, max_damage)
		attribute_changed.emit("damage", damage)

func _ready() -> void:
	attribute_changed.emit("speed", speed)
	attribute_changed.emit("fire_rate", fire_rate)
	attribute_changed.emit("damage", damage)

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
	bullet.damage = damage
	
	get_parent().add_child(bullet)
