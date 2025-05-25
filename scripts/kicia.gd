extends CharacterBody2D

#stamina vars
var stamina = 100.0
var stamina_max = 100.0
@export var stamina_drain_rate = 20.0
@export var stamina_regen_rate = 10.0


@export var SPEED = 55.0
var can_sprint = true
var sprint = 1.0
@export var DECELERATION = 15.0
var character_direction : Vector2
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	if Input.is_action_pressed("shift") and can_sprint:
		stamina -= stamina_drain_rate * delta
		sprint = 1.5
		if stamina <= 0:
			sprint = 1
			can_sprint = false  # Block the ability to sprint
	else:
		stamina += stamina_regen_rate * delta
		if stamina >= stamina_regen_rate:
			can_sprint = true  # unlocking the ability sprint if stamina is greater than 10

	stamina = clamp(stamina, 0, stamina_max)
	#print(stamina) # debug printing
	#print("sprint: "+str(sprint))
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
