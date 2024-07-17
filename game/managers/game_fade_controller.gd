extends ColorRect
class_name GameFadeController

@export var animation_player: AnimationPlayer

func _enter_tree() -> void:
	EventSystem.GAM_game_fade_in.connect(fade_in)
	EventSystem.GAM_game_fade_out.connect(fade_out)


func fade_in(fade_time:float, maybe_callback = null, show_loading_label = false) -> void:
	var tween := create_tween()
	tween.tween_property(self, "color", Color.BLACK, fade_time)
	tween.parallel().tween_method(set_master_volume, 1.0, 0.0, fade_time)
	
	if maybe_callback is Callable:
		tween.tween_callback(maybe_callback)
	
	if show_loading_label:
		tween.tween_callback(animation_player.play.bind("loading_animation"))


func fade_out(fade_time:float, maybe_callback = null) -> void:
	var tween := create_tween()
	tween.tween_property(self, "color", Color(0,0,0,0), fade_time)
	tween.parallel().tween_method(set_master_volume, 0.0, 1.0, fade_time)
	
	if maybe_callback is Callable:
		tween.tween_callback(maybe_callback)
	
	animation_player.play("RESET")


func set_master_volume(volume_linear:float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(volume_linear))
