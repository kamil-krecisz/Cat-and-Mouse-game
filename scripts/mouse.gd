extends CharacterBody2D

var stamina = 100.0
var stamina_max = 100.0
@export var stamina_drain_rate = 25.0
@export var stamina_regen_rate = 5.0
var can_move = true
var can_sprint = true

@export var SPEED = 25.0
@export var RUN_SPEED = 60
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

func _physics_process(delta):
	if can_move == false:
		RUN_SPEED = 0
		SPEED = 0
		animated_sprite.animation = "trapped"
	elif can_move == true:
		RUN_SPEED = 60
		SPEED = 25
		animated_sprite.animation = "run"
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	if player:
		var distance_to_cat = global_position.distance_to(player.global_position)

		if distance_to_cat < run_radius:
			is_running = true
			direction = (global_position - player.global_position).normalized()
			if can_sprint:
				velocity = direction * RUN_SPEED
				stamina -= stamina_drain_rate * delta
				if stamina <= 0:
					can_sprint = false # Blocking the ability to sprint
			else:
				velocity = direction * SPEED
				stamina += stamina_regen_rate * delta
				if stamina > stamina_drain_rate:
					can_sprint = true # Unlocking the ability to sprint because the stamina is greater than stamina drain rate
		else:
			if is_running:
				set_random_direction()
				is_running = false
			stamina += stamina_regen_rate * delta
			velocity = direction * SPEED
	stamina = clamp(stamina, 0, stamina_max)
	#print(stamina)
			

	move_and_slide()


func _on_direction_timer_timeout():
	if is_running == false:
		set_random_direction()
