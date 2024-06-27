extends CharacterBody3D
class_name Animal

enum States {
	Idle,
	Wander,
	Hurt,
	Flee,
	Chase,
	Attack,
	Dead
}

# custom blend time to make animations switch less instant
const ANIM_BLEND_TIME = 0.2

var state := States.Idle

@onready var player:CharacterBody3D = get_tree().get_first_node_in_group("Player")

@onready var idle_timer: Timer = %IdleTimer
@onready var wander_timer: Timer = %WanderTimer
@onready var flee_timer: Timer = %FleeTimer
@onready var disappear_after_death_timer: Timer = %DisappearAfterDeathTimer

@onready var main_collision_shape: CollisionShape3D = $CollisionShape3D
@onready var meat_spawn_marker: Marker3D = $MeatSpawnMarker
@onready var eyes_marker: Marker3D = $EyesMarker
@onready var attack_hit_area: Area3D = $AttackHitArea
@onready var nav_agent_3d: NavigationAgent3D = $NavigationAgent3D

@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var normal_speed := 0.6
@export var fleeing_speed := 1.8
@export var max_health := 80.0
@export var idle_animations: Array[String] = []
@export var hurt_animations: Array[String] = []
@export var flee_animations: Array[String] = []
@export var turn_speed_weight := 0.07
@export var min_idle_time := 2.0
@export var max_idle_time := 7.0
@export var min_wander_time := 2.0
@export var max_wander_time := 4.0
@export var min_flee_time := 3.0
@export var max_flee_time := 4.0
@export var is_aggressive := false
@export var attack_distance := 2.0
@export var damage := 20.0

var health := max_health

func _ready() -> void:
	animation_player.animation_finished.connect(animation_finished)

func animation_finished(_animation_name: String) -> void:
	if state == States.Idle:
		animation_player.play(idle_animations.pick_random(), ANIM_BLEND_TIME)
	elif state == States.Hurt:
		if not is_aggressive:
			set_state(States.Flee)

func _physics_process(_delta: float) -> void:
	if state == States.Wander:
		wander_loop()
	elif state == States.Flee:
		flee_loop()
	elif state == States.Chase:
		chase_loop()
	elif state == States.Attack:
		attack_loop()

func wander_loop() -> void:
	look_forward()
	move_and_slide()

func flee_loop() -> void:
	look_forward()
	move_and_slide()

func chase_loop() -> void:
	look_forward()
	if global_position.distance_to(player.global_position) < attack_distance:
		set_state(States.Attack)
		return
	# navigate towards the player
	nav_agent_3d.target_position = player.global_position
	var dir := global_position.direction_to(nav_agent_3d.get_next_path_position())

func attack_loop() -> void:
	look_forward()
	move_and_slide()

func look_forward() -> void:
	# rotate the animal into same direction in which it is moving
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z) + PI, turn_speed_weight)

func pick_wander_velocity() -> void:
	# forward, then rotate by random value
	var dir := Vector2(0, -1).rotated(randf() * PI * 2)
	velocity = Vector3(dir.x, 0, dir.y) * normal_speed

func pick_away_from_player_velocity() -> void:
	if not player:
		set_state(States.Idle)
		return
	# get direction from player global position to animal global_position
	var dir := player.global_position.direction_to(global_position)
	dir.y = 0
	velocity = dir.normalized() * fleeing_speed

func _on_idle_timer_timeout() -> void:
	set_state(States.Wander)

func _on_wander_timer_timeout() -> void:
	set_state(States.Idle)

func _on_flee_timer_timeout() -> void:
	set_state(States.Idle)

func _on_disappear_after_death_timer_timeout() -> void:
	queue_free()

func set_state(new_state: States) -> void:
	state = new_state
	match state:
		States.Idle:
			idle_timer.start(randf_range(min_idle_time, max_idle_time))
			animation_player.play(idle_animations.pick_random(), ANIM_BLEND_TIME)
		States.Wander:
			pick_wander_velocity()
			wander_timer.start(randf_range(min_wander_time, max_wander_time))
			animation_player.play("Walk", ANIM_BLEND_TIME)
		States.Hurt:
			idle_timer.stop()
			wander_timer.stop()
			flee_timer.stop()
			animation_player.play(hurt_animations.pick_random(), ANIM_BLEND_TIME)
		States.Flee:
			pick_away_from_player_velocity()
			flee_timer.start(randf_range(min_flee_time, max_flee_time))
			animation_player.play(flee_animations.pick_random(), ANIM_BLEND_TIME)
		States.Dead:
			animation_player.play("Death", ANIM_BLEND_TIME)
			main_collision_shape.disabled = true
			var meat_scene := ItemConfig.get_pickuppable_item(ItemConfig.Keys.RawMeat)
			EventSystem.SPA_spawn_scene.emit(meat_scene, meat_spawn_marker.global_transform)
			idle_timer.stop()
			wander_timer.stop()
			flee_timer.stop()
			set_physics_process(false)
			disappear_after_death_timer.start(10)

func take_hit(wepon_item_resource: WeaponItemResource) -> void:
	health -= wepon_item_resource.damage
	
	if state != States.Dead and health < 0:
		set_state(States.Dead)
	elif state not in [States.Flee, States.Dead]:
		set_state(States.Flee)
