extends Node

@export var upgrade_area_scene: PackedScene
@onready var spawn_points = [$LeftSpawnPoint, $RightSpawnPoint]

func _on_spawn_timer_timeout() -> void:
	var upgrade_area: UpgradeArea = upgrade_area_scene.instantiate()
	
	var spawn_point = spawn_points.pick_random()
	upgrade_area.position = spawn_point.position
	
	self.add_child(upgrade_area)
