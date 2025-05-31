extends CharacterBody3D

@onready var animation_tree: AnimationTree = $AnimationTree

@export var speed = 10
@export var bullet_scene: PackedScene

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
	
	bullet.position = position
	bullet.rotation = rotation
	
	get_parent().add_child(bullet)
