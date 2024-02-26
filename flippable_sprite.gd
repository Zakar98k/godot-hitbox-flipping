extends Sprite2D
class_name FlippableSprite

signal sprite_flipped(flip_value)

var flipped: bool = false:
	set(new_value):
		if new_value != flipped:
			flipped = new_value
			flip_h = flipped
			sprite_flipped.emit(new_value)
