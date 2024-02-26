extends CollisionShape2D
class_name FlippableShape

@export var default_position: Vector2:
	set(new_position):
		default_position = new_position
		position = new_position

var current_flip_value: bool

func _on_sprite_flipped(flip_value):
	if current_flip_value != flip_value:
		default_position.x *= -1
		current_flip_value = flip_value
