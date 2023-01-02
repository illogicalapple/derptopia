extends Camera3D

@onready var player: CharacterBody3D = get_node("../Player")

func _process(delta):
	position = Vector3(sin(player.rotation.y) * 1.5, 0, cos(player.rotation.y) * 1.5) + player.position
	rotation.y = player.rotation.y
	rotation.x -= (player.mouse_position.y - (player.screen_size.y / 2)) * delta * 0.5 # buggy x rotation script
