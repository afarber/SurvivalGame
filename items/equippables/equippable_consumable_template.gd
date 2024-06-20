extends EquippableItem
class_name EquippableConsumable

var consumable_item_resource: ConsumableItemResource

func consume() -> void:
	EventSystem.PLY_change_health.emit(consumable_item_resource.health_change)
	EventSystem.PLY_change_energy.emit(consumable_item_resource.energy_change)
	# delete the item from the inventory slot
	EventSystem.EQU_delete_equipped_item.emit()

func destroy_self() -> void:
	# delete the item from the player hands
	EventSystem.EQU_unequip_item.emit()
