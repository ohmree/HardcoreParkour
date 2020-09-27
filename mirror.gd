extends MeshInstance

onready var dummy_cam := $DummyCam
onready var mirror_cam := $Viewport/Camera

func _ready() -> void:
	add_to_group("mirrors")
	$Viewport.size = Vector2(
		ProjectSettings.get_setting("display/window/size/width"), 
		ProjectSettings.get_setting("display/window/size/height")
	)

func update_camera(main_cam_transform: Transform) -> void:
	scale.y *= -1
	dummy_cam.global_transform = main_cam_transform
	scale.y *= -1
	mirror_cam.global_transform = dummy_cam.global_transform
	mirror_cam.global_transform.basis.x *= -1
