extends Node
class_name Station

const DEFAULT_ACTION_ICON = preload("res://assets/kenney_game-icons/Vector/default_action_icon.tres")

@export var click_area : Area3D
@export var menu_position : Node3D

signal station_clicked
signal action_selected(action_name : StringName)

var actions : Array[StationAction] = []

func _ready() -> void:
	click_area.input_event.connect(func(_1, event : InputEvent, _2, _3, _4):
		print("AAA")
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			#if GlobalDependencies.selected_waiter:
				station_clicked.emit()
				show_station_menu()
	)

func add_action(action : StationAction) -> void:
	actions.append(action)
	
func remove_action(action : StationAction) -> void:
	actions.erase(action)
	
func remove_action_by_unique_name(action_name : StringName) -> void:
	actions.remove_at(actions.find_custom(func(a): return a.unique_name == action_name))

func show_station_menu():
	GlobalDependencies.actions_menu_list.clear()
	for action in actions:
		GlobalDependencies.actions_menu_list.add_item(action.name, action.icon if action.icon else DEFAULT_ACTION_ICON)
	GlobalDependencies.actions_menu_list.visible = true
	
	GlobalDependencies.actions_menu.global_position = get_viewport().get_camera_3d().unproject_position(menu_position.global_position)
