extends VBoxContainer
class_name PlayerStatsContainer

@onready var energy_bar: TextureProgressBar = $EnergyBar

func _enter_tree() -> void:
	EventSystem.PLY_energy_updated.connect(energy_updated)

func energy_updated(max_energy: float, current_energy: float) -> void:
	energy_bar.max_value = max_energy
	energy_bar.value = current_energy
