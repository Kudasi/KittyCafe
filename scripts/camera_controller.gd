extends Camera3D

@onready var origin : Node3D = $"../.."
@onready var anchor : Node3D = $".."

var moving : bool = false
var rotating : bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			moving = event.is_pressed()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if event.is_pressed() else Input.MOUSE_MODE_VISIBLE 
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			rotating = event.is_pressed()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if event.is_pressed() else Input.MOUSE_MODE_VISIBLE 
	
	if event is InputEventMouseMotion:
		if moving:
			origin.position -= 0.01 * event.relative.x * global_basis.x
			origin.position -= 0.01 * event.relative.y * global_basis.x.cross(Vector3.UP)
		if rotating:
			origin.rotation.y -= 0.01 * event.relative.x
			anchor.rotation.x -= 0.01 * event.relative.y
			anchor.rotation.x = clampf(anchor.rotation.y, TAU - PI / 3.0, TAU)
