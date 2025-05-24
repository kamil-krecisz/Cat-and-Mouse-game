extends CharacterBody2D

@export var SPEED = 25.0
@export var RUN_SPEED = 40.0
@export var run_radius = 100.0
@onready var direction_timer: Timer = $DirectionTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction = Vector2.ZERO
var is_running = false

@onready var player = get_tree().get_first_node_in_group("Player")

func set_random_direction():
	var angle = randf() * TAU
	direction = Vector2(cos(angle), sin(angle)).normalized()

func _ready():
	direction_timer.start()
	set_random_direction()

func _physics_process(_delta):
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	if player:
		var distance_to_cat = global_position.distance_to(player.global_position)

		if distance_to_cat < run_radius:
			is_running = true
			direction = (global_position - player.global_position).normalized()
			velocity = direction * RUN_SPEED
		else:
			if is_running:
				set_random_direction()
				is_running = false
			velocity = direction * SPEED

	move_and_slide()


func _on_direction_timer_timeout():
	if is_running == false:
		set_random_direction()
