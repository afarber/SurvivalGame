extends Bulletin

# Right-click and select "Access as Unique Name", then ctrl-drag to here
@onready var inventory_grid_container: GridContainer = %InventoryGridContainer

@onready var item_description_label: Label = %ItemDescriptionLabel

func _enter_tree() -> void:
	EventSystem.INV_inventory_updated.connect(update_inventory_slots)

func _ready() -> void:
	EventSystem.PLY_freeze_player.emit()
	EventSystem.INV_ask_to_update_inventory.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	for inventory_slot in inventory_grid_container.get_children():
		inventory_slot.mouse_entered.connect(show_item_info.bind(inventory_slot))
		inventory_slot.mouse_exited.connect(hide_item_info)
		
func close() -> void:
	EventSystem.PLY_unfreeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.CraftingMenu)

func show_item_info(inventory_slot: InventorySlot) -> void:
	# Do not show any info when the mouse is dragging anything
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	var item_key = inventory_slot.item_key
	if item_key == null:
		return
	
	item_description_label.text = ItemConfig.get_resource(item_key).display_name

func hide_item_info() -> void:
	item_description_label.text = ""

func update_inventory_slots(inventory: Array) -> void:
	print("update_inventory_slots: ", inventory)
	for i in inventory.size():
		inventory_grid_container.get_child(i).set_item_key(inventory[i])
