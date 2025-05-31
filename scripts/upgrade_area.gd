extends Area3D
class_name UpgradeArea

@export var speed = 15
const upgrade_types = ["Fire Rate", "Speed"]

var value = 1
@onready var upgrade = upgrade_types.pick_random()

func _physics_process(delta: float) -> void:
	position.z += speed * delta
	
	$SubViewport/Label.text = upgrade + "\n+ " + str(value)
	
	if not $VisibleOnScreenNotifier3D.is_on_screen(): free()

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var player: Player = body
		
		if upgrade == "Fire Rate":
			player.upgrade_fire_rate(value * 0.1)
		elif upgrade == "Speed":
			player.upgrade_speed(value)
		
		call_deferred("free")

func _on_area_entered(area: Area3D) -> void:
	if area is Bullet:
		area.free()
		value += 1
