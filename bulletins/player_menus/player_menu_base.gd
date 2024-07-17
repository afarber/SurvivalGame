extends Bulletin
class_name PlayerMenuBase

@onready var inventory_slot_container: GridContainer = %InventorySlotContainer
@onready var item_info_label: Label = %ItemInfoLabel
@onready var extra_info_label: Label = %ExtraInfoLabel


func _enter_tree() -> void:
	EventSystem.INV_inventory_updated.connect(update_inventory)


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	EventSystem.PLA_freeze_player.emit()
	EventSystem.INV_ask_update_inventory.emit()
	
	for inventory_slot in inventory_slot_container.get_children():
		inventory_slot.mouse_entered.connect(show_item_info.bind(inventory_slot))
		inventory_slot.mouse_exited.connect(hide_item_info)
	
	for hotbar_slot in get_tree().get_nodes_in_group("HotbarSlots"):
		hotbar_slot.mouse_entered.connect(show_item_info.bind(hotbar_slot))
		hotbar_slot.mouse_exited.connect(hide_item_info)
	
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
	
	%ScrapSlot.item_scrapped.connect(hide_item_info)


func show_item_info(inventory_slot:InventorySlot) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	var item_key = inventory_slot.item_key
	
	if item_key == null:
		return
	
	var item_resource:ItemResource = ItemConfig.get_item_resource(item_key)
	item_info_label.text = item_resource.display_name + "\n" + item_resource.description


func hide_item_info() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	item_info_label.text = ""


func update_inventory(inventory:Array) -> void:
	for i in inventory.size():
		inventory_slot_container.get_child(i).set_item_key(inventory[i])


func close() -> void:
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.CraftingMenu)
	EventSystem.PLA_unfreeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
