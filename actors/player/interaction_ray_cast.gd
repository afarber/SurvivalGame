extends RayCast3D

var is_hitting := false

func check_interaction() -> void:
	var collider := get_collider()
	if not collider is Interactable:
		return

	print("check_interaction ", collider)

	if is_colliding():
		if Input.is_action_just_pressed("interact"):
			collider.start_interaction()

		if not is_hitting:
			is_hitting = true
			EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.InteractionPrompt, collider.prompt)

	elif is_hitting:
		is_hitting = false
		EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.InteractionPrompt)

