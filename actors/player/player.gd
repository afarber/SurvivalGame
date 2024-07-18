extends CharacterBody3D
class_name Player


@export var normal_speed := 3.0
@export var sprint_speed := 5.0
@export var walking_energy_consumption_per_1m := -0.05
@export var jump_velocity := 4.0
@export var gravity := 0.2
@export var mouse_sensitivity := 0.005
@export var walking_footstep_audio_interval := 0.6
@export var sprinting_footstep_audio_interval := 0.3

@onready var head: Node3D = $Head
@onready var interaction_ray_cast: RayCast3D = %InteractionRayCast
@onready var item_holder: Node3D = %ItemHolder
@onready var footstep_audio_timer: Timer = $FootstepAudioTimer


var is_grounded := true
var is_sprinting := false


func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	EventSystem.PLA_freeze_player.connect(set_freeze.bind(true))
	EventSystem.PLA_unfreeze_player.connect(set_freeze.bind(false))


func _ready() -> void:
	EventSystem.HUD_show_hud.emit()


func _exit_tree() -> void:
	EventSystem.HUD_hide_hud.emit()


func set_freeze(freeze:bool) -> void:
	set_process(!freeze)
	set_physics_process(!freeze)
	set_process_input(!freeze)


func _process(_delta: float) -> void:
	interaction_ray_cast.check_interaction()


func _physics_process(delta: float) -> void:
	move()
	check_walking_consumption(delta)
	
	if Input.is_action_just_pressed("use_equipped_item"):
		item_holder.try_to_use_item()


func move():
	if is_on_floor():
		is_sprinting = Input.is_action_pressed("sprint")
		
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
		
		if velocity != Vector3.ZERO and footstep_audio_timer.is_stopped():
			EventSystem.SFX_play_dynamic_sfx.emit(SFXConfig.Keys.Footstep, global_position, 0.3)
			footstep_audio_timer.start(walking_footstep_audio_interval if not is_sprinting else sprinting_footstep_audio_interval)
		
		if not is_grounded:
			is_grounded = true
			EventSystem.SFX_play_dynamic_sfx.emit(SFXConfig.Keys.JumpLand, global_position)
	
	else:
		velocity.y -= gravity
		
		if is_grounded:
			is_grounded = false
	
	var speed := normal_speed if not is_sprinting else sprint_speed
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	velocity.z = direction.z * speed
	velocity.x = direction.x * speed
	
	move_and_slide()


func check_walking_consumption(delta:float) -> void:
	if velocity.z or velocity.x:
		EventSystem.PLA_change_energy.emit(
			delta *
			walking_energy_consumption_per_1m *
			Vector2(velocity.z, velocity.x).length()
		)


func _input(event) -> void:
	if event is InputEventMouseMotion:
		look_around(event.relative)


func look_around(relative:Vector2):
	rotate_y(-relative.x * mouse_sensitivity)
	head.rotate_x(-relative.y * mouse_sensitivity)
	head.rotation.x = clampf(head.rotation.x, -PI/2, PI/2)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.PauseMenu)
	
	elif event.is_action_pressed("open_crafting_menu"):
		EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.CraftingMenu)
	
	elif event.is_action_pressed("item_hotkey"):
		EventSystem.EQU_hotkey_pressed.emit(int(event.as_text()))
