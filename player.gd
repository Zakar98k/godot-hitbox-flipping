extends CharacterBody2D

@export var ACCELERATION: float
@export var FRICTION: float
@export var MAX_SPEED: float

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float = 0.0

@onready var sprite: FlippableSprite = %FlippableSprite
@onready var animation_tree: AnimationTree = %AnimationTree as AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	velocity.y += gravity * delta

	if not playback.get_current_node() == "attack":
		direction = Input.get_axis("ui_left","ui_right")

	calculate_movement()
	update_flip()
	update_animations()


	if Input.is_action_just_pressed("attack") and is_on_floor():
		direction = 0
		playback.travel("attack")

	move_and_slide()


func update_flip():
	if direction > 0:
		sprite.flipped = false
	elif direction < 0:
		sprite.flipped = true


func calculate_movement():
	if direction != 0:
		velocity.x = lerp(velocity.x, MAX_SPEED * direction, ACCELERATION)
	elif direction == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION)


func update_animations():
	if playback.get_current_node() != "attack":
		if direction > 0 or direction < 0:
			playback.travel("run")
		else:
			playback.travel("idle")


func _on_area_2d_body_entered(body):
	if body.has_method("die"):
		body.die()
