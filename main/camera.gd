extends Camera3D

@onready var player: CharacterBody3D = get_node("../Player")

func _process(delta):
	var point: Vector3 = Vector3(sin(player.rotation.y), 0, cos(player.rotation.y))
	var y_axis: Vector3 = point.rotated(Vector3.UP, PI / 2)
	rotation.x = clamp(PI / -2, rotation.x - (player.mouse_position.y - (player.screen_size.y / 2)) * delta * 0.5, PI / 2)
	point = point.rotated(y_axis, rotation.x) * 1.5 + player.position
	rotation.y = player.rotation.y
	position = point
