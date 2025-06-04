extends CharacterBody3D
class_name Enemy

@onready var animation_tree: AnimationTree = $AnimationTree
var state_machine

@export var speed = 5.0
var direction: Vector3

func _ready() -> void:
	direction = (transform.basis * Vector3.BACK).normalized()
	state_machine = animation_tree["parameters/playback"]
	state_machine.travel("Walking_D_Skeletons")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
	
	if not $VisibleOnScreenNotifier3D.is_on_screen(): free()

func _on_hit_area_area_entered(area: Area3D) -> void:
	if area is Bullet:
		$DeathTimer.start()
		state_machine.travel("Death_C_Skeletons")
		direction = Vector3.ZERO
		area.queue_free()
		$HitArea.queue_free()

func _on_death_timer_timeout() -> void:
	queue_free()
