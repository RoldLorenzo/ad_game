extends Node

@export var upgrade_area_scene: PackedScene
@export var enemy_skeleton_scene: PackedScene
@onready var spawn_positions = [$LeftSpawnPoint.position, $RightSpawnPoint.position]

# Spawns either:
# Two upgrade areas side by side, one negative and one positive;
# One upgrade area that moves side to side (that could be positive or negative)
func _on_spawn_timer_timeout() -> void:
	var spawn_amnt = randi_range(0, 2)
	var is_positive = [true, false].pick_random()
	
	if spawn_amnt == 1:
		var upgrade_area: UpgradeArea = upgrade_area_scene.instantiate()
		
		var spawn_position = spawn_positions.pick_random()
		
		var x_speed = randi_range(5, 10)
		x_speed = x_speed if spawn_position.x < 0 else -x_speed
		
		add_upgrade_area(upgrade_area, spawn_position, is_positive, x_speed)
	elif spawn_amnt == 2:
		var upgrade_area_left: UpgradeArea = upgrade_area_scene.instantiate()
		var upgrade_area_right: UpgradeArea = upgrade_area_scene.instantiate()
		
		add_upgrade_area(upgrade_area_left, spawn_positions[0], is_positive, 0)
		add_upgrade_area(upgrade_area_right, spawn_positions[1], not is_positive, 0)
	
	spawn_skeletons(randi_range(0, 1))

func add_upgrade_area(upgrade_area: UpgradeArea, position: Vector3, is_positive: bool, x_speed: int) -> void:
	upgrade_area.position = position
	upgrade_area.x_speed = x_speed
	
	if not is_positive:
		upgrade_area.value = randi_range(-10, -3)
	
	self.add_child(upgrade_area)

func spawn_skeletons(amount: int) -> void:
	var spawn_position = spawn_positions.pick_random()
	for i in range(amount):
		var skeleton = enemy_skeleton_scene.instantiate()
		skeleton.position = spawn_position
		self.add_child(skeleton)

func _on_rogue_hooded_attribute_changed(attribute_name: String, new_value: float) -> void:
	if attribute_name == "speed":
		$HUD/PlayerSpeed.text = "Speed: " + str(new_value)
	elif attribute_name == "fire_rate":
		$HUD/PlayerFireRate.text = "Fire Rate: " + str(new_value)
	elif attribute_name == "damage":
		$HUD/PlayerDamage.text = "Damage: " + str(new_value)
