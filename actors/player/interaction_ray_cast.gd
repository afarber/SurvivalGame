extends RayCast3D

var is_hitting := false

# this method is called repeatedly by _process in player.gd
func check_interaction() -> void:
	if is_colliding() and get_collider() is Interactable:
		print("interaction ray is_colliding with ", get_collider())

		if Input.is_action_just_pressed("interact"):
			get_collider().start_interaction()

		if not is_hitting:
			is_hitting = true
			EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.InteractionPrompt, get_collider().prompt)

	elif is_hitting:
		is_hitting = false
		EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.InteractionPrompt)

