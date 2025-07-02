extends CharacterBody2D

## Movement Settings
@export var walk_speed: float = 35.0
@export var run_speed: float = 50.0
@export var acceleration: float = 15.0

## Stamina Settings
@export var max_stamina: float = 100.0
@export var stamina_drain: float = 25.0
@export var stamina_regen: float = 5.0

## Detection Ranges
@export var flee_range: float = 75.0
@export var cheese_detect_range: float = 350.0
@export var eat_range: float = 15.0

## Nodes
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var direction_timer: Timer = $DirectionTimer

## State Management
enum {WANDER, CHASE, FLEE, TRAPPED}
var current_state = WANDER
var current_target: Node2D = null
var can_move: bool = true
var can_sprint: bool = true
var stamina: float = max_stamina

func _ready():
	nav_agent.path_desired_distance = 8.0
	nav_agent.target_desired_distance = 8.0
	#direction_timer.timeout.connect(_on_direction_timer_timeout)
	direction_timer.start()
	find_cheese()  # Immediately look for cheese on spawn

func _physics_process(delta):
	if !can_move:
		handle_trapped()
		return
	
	# Always check for cheese first
	if !current_target or !is_instance_valid(current_target):
		find_cheese()
	
	var player = get_tree().get_first_node_in_group("Player")
	var target_speed = walk_speed
	
	# State transitions
	if player and global_position.distance_to(player.global_position) < flee_range:
		current_state = FLEE
		if can_sprint:
			target_speed = run_speed
			stamina -= stamina_drain * delta
			if stamina <= 0:
				can_sprint = false
	elif current_target:
		current_state = CHASE
	else:
		current_state = WANDER
	
	# Movement handling
	match current_state:
		FLEE:
			if player:
				var flee_dir = (global_position - player.global_position).normalized()
				nav_agent.target_position = global_position + flee_dir * 300
		CHASE:
			if current_target:
				nav_agent.target_position = current_target.global_position
				if global_position.distance_to(current_target.global_position) < eat_range:
					current_target.queue_free()
					find_cheese()
		WANDER:
			if nav_agent.is_navigation_finished():
				set_random_target()
	
	# Apply movement
	if !nav_agent.is_navigation_finished():
		var target_velocity = global_position.direction_to(nav_agent.get_next_path_position()) * target_speed
		velocity = velocity.lerp(target_velocity, acceleration * delta)
	
	# Stamina regen when not sprinting
	if current_state != FLEE or !can_sprint:
		stamina = min(stamina + stamina_regen * delta, max_stamina)
		if stamina > stamina_drain * 1.5:
			can_sprint = true
	
	update_animation()
	move_and_slide()

func handle_trapped():
	velocity = Vector2.ZERO
	sprite.play("trapped")

func find_cheese():
	var cheeses = get_tree().get_nodes_in_group("Cheese")
	current_target = null
	
	if cheeses.size() > 0:
		var closest_dist = INF
		for cheese in cheeses:
			var dist = global_position.distance_to(cheese.global_position)
			if dist < closest_dist and dist < cheese_detect_range:
				closest_dist = dist
				current_target = cheese
		
		if current_target:
			nav_agent.target_position = current_target.global_position

func set_random_target():
	var random_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	nav_agent.target_position = global_position + random_dir * 150.0

func update_animation():
	if !can_move: 
		sprite.play("trapped")
		return
	
	if velocity.length() > 10:
		sprite.play("run")
		sprite.flip_h = velocity.x < 0
	else:
		sprite.play("idle")

func _on_direction_timer_timeout():
	if current_state == WANDER:
		set_random_target()
	elif current_state == CHASE:
		find_cheese()  # Re-check for closer cheese periodically
