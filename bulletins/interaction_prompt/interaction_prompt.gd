extends Bulletin
class_name InteractionPrompt


@onready var label: Label = $Label


var prompt_text := ""


func initialize(prompt) -> void:
	if prompt is String:
		prompt_text = "E\n" + prompt


func _ready() -> void:
	label.text = prompt_text

