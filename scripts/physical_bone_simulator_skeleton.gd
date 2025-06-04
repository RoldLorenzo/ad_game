extends PhysicalBoneSimulator3D

@onready var bone_head: PhysicalBone3D = $"Physical Bone Head"
var push := 0

func _physics_process(delta: float) -> void:
	if push > 0:
		bone_head.linear_velocity = Vector3.MODEL_REAR * push

func hit() -> void:
	active = true
	push = 50
	
	var timer = Timer.new()
	timer.wait_time = 0.1
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
	physical_bones_start_simulation()

func _on_timer_timeout() -> void:
	push = 0
