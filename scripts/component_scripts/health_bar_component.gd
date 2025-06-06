extends Node3D
class_name HealthBarComponent

@export var health_component: HealthComponent
var max_health: float = 10.0

func _ready() -> void:
	# Health bar doesn't show until hp has changed
	visible = false
	
	if health_component:
		max_health = health_component.max_health
		health_component.connect("health_changed", update_health_bar)
	
func update_health_bar(new_value: float) -> void:
	$SubViewport/ProgressBar.value = 100 * new_value / max_health
	
	visible = true
