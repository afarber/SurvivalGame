extends AudioStreamPlayer
class_name MusicController


func _enter_tree() -> void:
	EventSystem.MUS_play_music.connect(play_music)


func _ready() -> void:
	bus = "Music"


func play_music(key : MusicConfig.Keys) -> void:
	stream = MusicConfig.get_audio_stream(key)
	play()
