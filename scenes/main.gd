extends Node3D

func _ready() -> void:
	GlobalDependencies.actions_menu = %ActionsMenu
	GlobalDependencies.actions_menu_list = %ActionsMenu/ScrollContainer/ItemList
