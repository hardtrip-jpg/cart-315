extends Node3D

@export var camera : PhantomCamera3D
@export var area : Area3D
@export var active := false
@export var col : CollisionShape3D
@export var mesh : MeshInstance3D

@export var MOUSE_SENSITIVITY := 0.35
@export var DRAG_WEIGHT := 20
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)

var _mouse_rotation : Vector3
var _rotation_input : float
var _tilt_input : float
var _mouse_velocity : Vector2

var hovering : bool = false

func _ready() -> void:
	Global.disable_all.connect(disable)
	
	if camera == null:
		for x in get_children():
			if x is PhantomCamera3D:
				camera = x
	if area == null:
		for x in get_children():
			if x is Area3D:
				area = x
	if col == null:
		for x in get_children():
			if x is CollisionShape3D:
				col = x
	
	area.top_level = true
	
	if active:
		camera.priority = 1
		mesh.hide()
	else:
		area.monitoring = true
		area.monitorable = true
		col.disabled = false
		mesh.show()

func _input(event: InputEvent) -> void:
	#Determine mouse movement
	var _mouse_input := event is InputEventMouseMotion && Input.is_action_pressed("click")
	if _mouse_input:
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		if Vector2(_tilt_input, _rotation_input).length() > 1 && active:
			Global.view.desirable_bit = _mouse_velocity.length() * 4
	elif active:
		Global.view.desirable_bit = 1
	

func _physics_process(delta: float) -> void:
	
	#MOUSE MOVING
	#Get Look Velocity
	var _pre_mouse_velocity := Vector2(_tilt_input, _rotation_input)
	_mouse_velocity = lerp(_mouse_velocity, _pre_mouse_velocity, delta * DRAG_WEIGHT)

	#_mouse_velocity = _pre_mouse_velocity

	
	#Set Rotation
	_mouse_rotation.x += _mouse_velocity.x  * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _mouse_velocity.y * delta
	
	global_transform.basis = Basis.from_euler(Vector3(_mouse_rotation.x, _mouse_rotation.y, 0))
	
	#Reset Mouse Inputs
	_rotation_input = 0.0
	_tilt_input = 0.0
	
	#MOUSE CLICKED
	if hovering && Input.is_action_just_pressed("click"):
		Global.disable_all.emit()
		Global.view.desirable_bit = 8
		Engine.max_fps = 7
		camera.priority = 1
		area.monitoring = false
		area.monitorable = false
		col.disabled = true
		await camera.tween_completed
		active = true
		mesh.hide()
		Global.view.desirable_bit = 1
		Engine.max_fps = Global.def_framerate

func disable() -> void:
	camera.priority = 0
	active = false
	area.monitoring = true
	area.monitorable = true
	col.disabled = false
	mesh.show()

func _on_area_3d_mouse_entered() -> void:
	hovering = true
	mesh.scale = Vector3.ONE * 0.7

func _on_area_3d_mouse_exited() -> void:
	hovering = false
	mesh.scale = Vector3.ONE
