extends VBoxContainer
class_name PlayerStatsContainer

@onready var health_bar: TextureProgressBar = $HealthBar
@onready var energy_bar: TextureProgressBar = $EnergyBar

func _enter_tree() -> void:
	EventSystem.PLY_health_updated.connect(health_updated)
	EventSystem.PLY_energy_updated.connect(energy_updated)

func health_updated(max_health: float, current_health: float) -> void:
	health_bar.max_value = max_health
	health_bar.value = current_health

func energy_updated(max_energy: float, current_energy: float) -> void:
	energy_bar.max_value = max_energy
	energy_bar.value = current_energy
