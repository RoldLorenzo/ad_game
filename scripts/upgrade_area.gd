extends Area3D
class_name UpgradeArea

const upgrade_types = ["Fire Rate", "Speed"]
const max_x = 3.75
const min_x = -3.75

var blue = Color.from_rgba8(0, 170, 255, 150)
var red = Color.from_rgba8(255, 0, 0, 150)
var x_speed = 0
var value = 1
@export var speed = 15
@onready var upgrade = upgrade_types.pick_random()

func _ready() -> void:
	var material = StandardMaterial3D.new()
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	$MeshInstance3D.material_override = material

func _physics_process(delta: float) -> void:
	position.z += speed * delta
	position.x += x_speed * delta
	
	if value >= 0:
		$MeshInstance3D.material_override.albedo_color = blue
	else:
		$MeshInstance3D.material_override.albedo_color = red
	
	if position.x >= max_x:
		position.x = max_x
		x_speed *= -1
	if position.x <= min_x:
		position.x = min_x
		x_speed *= -1
	
	$SubViewport/Label.text = upgrade + "\n " + str(value)
	
	if not $VisibleOnScreenNotifier3D.is_on_screen(): free()

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var player: Player = body
		
		if upgrade == "Fire Rate":
			player.fire_rate -= value * 0.1
		elif upgrade == "Speed":
			player.speed += value
		
		call_deferred("free")

func _on_area_entered(area: Area3D) -> void:
	if area is Bullet:
		area.free()
		value += 1
