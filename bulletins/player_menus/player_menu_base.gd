extends Bulletin

class_name PlayerMenuBase

# Right-click and select "Access as Unique Name", then ctrl-drag to here
@onready var inventory_grid_container: GridContainer = %InventoryGridContainer

# set by the 
@onready var item_description_label: Label = %ItemDescriptionLabel
@onready var item_extra_info_label: Label = %ItemExtraInfoLabel

func _enter_tree() -> void:
	EventSystem.INV_inventory_updated.connect(update_inventory_slots)
	EventSystem.INV_set_description_label.connect(set_description_label)
	EventSystem.INV_set_extra_info_label.connect(set_extra_info_label)
	
func _ready() -> void:
	EventSystem.PLY_freeze_player.emit()
	EventSystem.INV_ask_to_update_inventory.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func close() -> void:
	EventSystem.PLY_unfreeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.CraftingMenu)

func set_description_label(str: String) -> void:
	item_description_label.text = str

func set_extra_info_label(str: String) -> void:
	item_extra_info_label.text = str

func update_inventory_slots(inventory: Array) -> void:
	for i in inventory.size():
		inventory_grid_container.get_child(i).set_item_key(inventory[i])
