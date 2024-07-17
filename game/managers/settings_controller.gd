extends Node

const SAVE_PATH = "user://settings.tres"


var settings_resource : SettingsResource


func _enter_tree() -> void:
	EventSystem.SET_music_volume_changed.connect(music_volume_changed)
	EventSystem.SET_sfx_volume_changed.connect(sfx_volume_changed)
	EventSystem.SET_res_scale_changed.connect(res_scale_changed)
	EventSystem.SET_ssaa_changed.connect(ssaa_changed)
	EventSystem.SET_fullscreen_changed.connect(fullscreen_changed)
	EventSystem.SET_ask_settings_resource.connect(send_settings_resource)
	
	EventSystem.SET_save_settings.connect(save_settings)


func _ready() -> void:
	load_settings()
	apply_settings()


func load_settings() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		settings_resource = ResourceLoader.load(SAVE_PATH, "SettingsResource")
	
	if settings_resource == null:
		settings_resource = SettingsResource.new()


func save_settings() -> void:
	ResourceSaver.save(settings_resource, SAVE_PATH)


func apply_settings() -> void:
	apply_music_volume(settings_resource.music_volume)
	apply_sfx_volume(settings_resource.sfx_volume)
	apply_res_scale(settings_resource.res_scale)
	apply_ssaa(settings_resource.ssaa_enabled)
	apply_fullscreen(settings_resource.fullscreen_enabled)


func send_settings_resource(target_callable : Callable) -> void:
	target_callable.call(settings_resource)


func music_volume_changed(volume_linear : float) -> void:
	settings_resource.music_volume = volume_linear
	apply_music_volume(volume_linear)

func apply_music_volume(volume_linear : float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(volume_linear))


func sfx_volume_changed(volume_linear : float) -> void:
	settings_resource.sfx_volume = volume_linear
	apply_sfx_volume(volume_linear)

func apply_sfx_volume(volume_linear : float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(volume_linear))


func res_scale_changed(scale : float) -> void:
	settings_resource.res_scale = scale
	apply_res_scale(scale)

func apply_res_scale(scale : float) -> void:
	get_viewport().set_scaling_3d_scale(scale)


func ssaa_changed(enabled : bool) -> void:
	settings_resource.ssaa_enabled = enabled
	apply_ssaa(enabled)

func apply_ssaa(enabled : bool) -> void:
	get_viewport().set_screen_space_aa(
		Viewport.SCREEN_SPACE_AA_FXAA if enabled else Viewport.SCREEN_SPACE_AA_DISABLED
	)


func fullscreen_changed(enabled : bool) -> void:
	settings_resource.fullscreen_enabled = enabled
	apply_fullscreen(enabled)

func apply_fullscreen(enabled : bool) -> void:
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED
	)
