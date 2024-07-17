extends Camera3D
class_name ShakingCamera


@export var noise_speed := 1
@export var noise_multiplier := 0.25

var noise := FastNoiseLite.new()


func _ready() -> void:
	noise.seed = randi()
	noise.frequency = noise_speed * 0.00001


func _process(_delta: float) -> void:
	rotation.x = noise.get_noise_1d(Time.get_ticks_msec()) * noise_multiplier
	rotation.y = noise.get_noise_1d(Time.get_ticks_msec() + 10000) * noise_multiplier
