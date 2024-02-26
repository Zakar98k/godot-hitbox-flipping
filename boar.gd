extends RigidBody2D


func die():
	get_parent().remove_child(self)
	queue_free()
