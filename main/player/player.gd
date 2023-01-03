extends CharacterBody3D


const speed: float = 7.0
const jump_velocity: float = 4.5

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_position: Vector2 = Vector2(0, 0)

@onready var screen_size: Vector2 = get_viewport().get_visible_rect().size

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if get_parent().interactive:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity
		if Input.is_action_pressed("walk_forward"):
			velocity -= Vector3(sin(rotation.y) * speed, 0, cos(rotation.y) * speed) * delta
		if Input.is_action_pressed("walk_backward"):
			velocity += Vector3(sin(rotation.y) * speed, 0, cos(rotation.y) * speed) * delta
		rotation.y -= (mouse_position.x - (screen_size.x / 2)) * delta * 0.5
		get_viewport().warp_mouse(screen_size / 2)
	velocity.x = lerp(velocity.x, 0.0, 4 * delta)
	velocity.z = lerp(velocity.z, 0.0, 4 * delta)
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.position
