extends Bulletin
class_name InteractionPrompt

var prompt_text := ""

func initialize(prompt)-> void:
	if prompt is String:
		prompt_text = prompt

func _ready() -> void:
	$Label.text = prompt_text
