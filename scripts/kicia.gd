extends CharacterBody2D


@export var SPEED = 55.0
var sprint
@export var DECELERATION = 15.0
var character_direction : Vector2
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	if Input.is_action_pressed("shift"):
		sprint = 1.5
	else:
		sprint = 1.0
	character_direction.x = Input.get_axis("a_movement", "d_movement")
	character_direction.y = Input.get_axis("w_movement", "s_movement")
	if character_direction.x > 0:
		animated_sprite.flip_h = false
	elif character_direction.x < 0:
		animated_sprite.flip_h = true
	
	
	if character_direction != Vector2.ZERO:
		if character_direction.x != 0:
			animated_sprite.animation = "walking"
		elif character_direction.y < 0:
			animated_sprite.animation = "walking_up"
		elif character_direction.y > 0:
			animated_sprite.animation = "walking_down"
		character_direction = character_direction.normalized()
		velocity = character_direction * SPEED * sprint
	else:
		animated_sprite.animation = "idle"
		velocity = velocity.lerp(Vector2.ZERO, DECELERATION * delta)
	move_and_slide()
