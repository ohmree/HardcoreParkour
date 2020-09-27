extends KinematicBody
class_name Player

export(int) var gravity := -30

onready var camera := $RotationHelper/Camera
onready var rotation_helper := $RotationHelper

var max_speed := 8
var mouse_sensitivity := 0.002  # radians/pixel
var velocity := Vector3.ZERO

func get_input():
	var input_dir := Vector3.ZERO
	# desired move in camera direction
	if Input.is_action_pressed("forward"):
		input_dir += -camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += camera.global_transform.basis.x
	
	input_dir = input_dir.normalized()
	return input_dir
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: #and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_y(event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		rotation_helper.rotation.x = clamp(rotation_helper.rotation.x, -1.2, 1.2)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed

	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = 15 # start jump

	if velocity.y > 1:
		velocity.y -= 1* delta # 1 is air friction
	
	velocity = move_and_slide(velocity, Vector3.UP, true)
