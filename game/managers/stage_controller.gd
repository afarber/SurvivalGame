extends Node
class_name StageController


const FADE_TIME = 1.0

var thread := Thread.new()

var is_stage_changing := false

func _enter_tree() -> void:
	EventSystem.STA_change_stage.connect(start_stage_change_sequence)

func _ready() -> void:
	start_stage_change_sequence(StageConfig.Keys.MainMenu)

func start_stage_change_sequence(stage_key:StageConfig.Keys) -> void:
	if is_stage_changing:
		return
	
	is_stage_changing = true
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	EventSystem.GAM_game_fade_in.emit(FADE_TIME, game_faded_in.bind(stage_key), true)

func game_faded_in(stage_key:StageConfig.Keys) -> void:
	for stage in get_children():
		stage.queue_free()
	
	EventSystem.BUL_destroy_all_bulletins.emit()
	
	thread.start(load_stage.bind(stage_key))

func load_stage(stage_key:StageConfig.Keys) -> void:
	var new_stage := StageConfig.get_stage(stage_key)
	#call_deferred("add_child", new_stage)
	call_deferred_thread_group("add_child", new_stage)
	new_stage.loading_complete.connect(loading_complete)
	call_deferred("join_thread")

func join_thread() -> void:
	thread.wait_to_finish()

func loading_complete() -> void:
	EventSystem.GAM_game_fade_out.emit(FADE_TIME)
	is_stage_changing = false
