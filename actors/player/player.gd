extends CharacterBody3D
class_name Player

@export var normal_speed := 3.0
@export var sprint_speed := 5.0
@export var jump_velocity := 4.0
@export var mouse_sensitivity := 0.005
@export var gravity := 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head: Node3D = $Head
@onready var interaction_ray_cast: RayCast3D = $Head/InteractionRayCast
@onready var equippable_item_holder: Node3D = $Head/EquippableItemHolder

func _enter_tree() -> void:
	EventSystem.PLY_freeze_player.connect(set_freeze.bind(true))
	EventSystem.PLY_unfreeze_player.connect(set_freeze.bind(false))

func set_freeze(freeze: bool) -> void:
	set_process(!freeze)
	set_physics_process(!freeze)
	set_process_input(!freeze)
	set_process_unhandled_key_input(!freeze)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	interaction_ray_cast.check_interaction()

func _physics_process(delta: float) -> void:
	move()
	if Input.is_action_just_pressed("use_item"):
		equippable_item_holder.try_to_use_item()

func move() -> void:
	var is_sprinting := false
	
	if is_on_floor():
		is_sprinting = Input.is_action_pressed("sprint")
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
	else:
		velocity.y -= gravity
		
	var speed := sprint_speed if is_sprinting else normal_speed

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := transform.basis * Vector3(input_dir.x, 0,  input_dir.y)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_around(event.relative)

func look_around(relative: Vector2) -> void:
	rotate_y(-relative.x * mouse_sensitivity)
	head.rotate_x(-relative.y * mouse_sensitivity)
	# down -90, up 90
	head.rotation_degrees.x = clampf(head.rotation_degrees.x, -90, 90)

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("open_crafting_menu"):
		EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.CraftingMenu)
	elif event.is_action_pressed("item_hotkey"):
		EventSystem.EQU_hotkey_pressed.emit(int(event.as_text()))



func _physics_process_old(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * normal_speed
		velocity.z = direction.z * normal_speed
	else:
		velocity.x = move_toward(velocity.x, 0, normal_speed)
		velocity.z = move_toward(velocity.z, 0, normal_speed)

	move_and_slide()
