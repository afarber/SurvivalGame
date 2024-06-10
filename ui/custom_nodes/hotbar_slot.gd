extends InventorySlot

class_name HotbarSlot

func _ready() -> void:
	$NumTextureRect/NumLabel.text = str(get_index() + 1)
