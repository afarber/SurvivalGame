extends Bulletin
class_name PlayerMenuBase


@onready var inventory_slot_container: GridContainer = %InventorySlotContainer
@onready var item_info_label: Label = %ItemInfoLabel
@onready var extra_info_label: Label = %ExtraInfoLabel


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	EventSystem.INV_inventory_updated.connect(update_inventory)
	EventSystem.INV_set_item_info_label.connect(set_info_label.bind(item_info_label))
	EventSystem.INV_set_extra_info_label.connect(set_info_label.bind(extra_info_label))
	EventSystem.PLA_freeze_player.emit()
	EventSystem.INV_ask_update_inventory.emit()
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)


func update_inventory(inventory:Array) -> void:
	for i in inventory.size():
		inventory_slot_container.get_child(i).set_item_key(inventory[i])


func set_info_label(text:String, label:Label) -> void:
	label.text = text


func close() -> void:
	EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.CraftingMenu)
	EventSystem.PLA_unfreeze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.UIClick)
