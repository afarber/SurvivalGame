extends EquippableItem
class_name EquippableConsumable

var consumable_item_resource:ConsumableItemResource


func consume() -> void:
	EventSystem.PLA_change_health.emit(consumable_item_resource.health_change)
	EventSystem.PLA_change_energy.emit(consumable_item_resource.energy_change)
	EventSystem.EQU_delete_equipped_item.emit()
	EventSystem.SFX_play_sfx.emit(SFXConfig.Keys.Eat)


func destroy_self() -> void:
	EventSystem.EQU_unequip_item.emit()
