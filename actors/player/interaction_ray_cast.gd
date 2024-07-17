extends RayCast3D
class_name InteractionRayCast

var is_hitting := false

func check_interaction() -> void:
	if is_colliding():
		if Input.is_action_just_pressed("interact"):
			get_collider().start_interaction()
		
		if not is_hitting:
			is_hitting = true
			EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.InteractionPrompt, get_collider().prompt)
	
	elif is_hitting:
		is_hitting = false
		EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.InteractionPrompt)
