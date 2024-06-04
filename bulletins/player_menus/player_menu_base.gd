extends Bulletin

# Right-click and select "Access as Unique Name", then ctrl-drag to here
@onready var inventory_grid_container: GridContainer = %InventoryGridContainer

@onready var item_description_label: Label = %ItemDescriptionLabel

func _enter_tree() -> void:
	EventSystem.INV_inventory_updated.connect(update_inventory_slots)
	EventSystem.INV_show_item_info.connect(show_item_info)

func _ready() -> void:
	EventSystem.PLY_freeze_player.emit()
	EventSystem.INV_ask_to_update_inventory.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func close() -> void:
	EventSystem.PLY_unfreeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.CraftingMenu)

func show_item_info(str: String) -> void:
	item_description_label.text = str

func update_inventory_slots(inventory: Array) -> void:
	print("update_inventory_slots: ", inventory)
	for i in inventory.size():
		inventory_grid_container.get_child(i).set_item_key(inventory[i])
