extends AudioStreamPlayer
class_name SFXController


func _enter_tree() -> void:
	EventSystem.SFX_play_sfx.connect(play_sfx)
	EventSystem.SFX_play_dynamic_sfx.connect(play_dynamic_sfx)


func _ready() -> void:
	bus = "SFX"


func play_sfx(key : SFXConfig.Keys) -> void:
	stream = SFXConfig.get_audio_stream(key)
	play()


func play_dynamic_sfx(key : SFXConfig.Keys, position : Vector3, pitch_rand := 0.0) -> void:
	var audio_player := AudioStreamPlayer3D.new()
	add_child(audio_player)
	audio_player.bus = "SFX"
	audio_player.stream = SFXConfig.get_audio_stream(key)
	audio_player.pitch_scale = 1 + randf_range(-pitch_rand, pitch_rand)
	audio_player.global_position = position
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.play()
