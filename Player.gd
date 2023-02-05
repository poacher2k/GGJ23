extends CharacterBody2D


const SPEED = 300.0
@export var HOOKSHOT_SPEED = 350.0
@export var ROTATION_VELOCITY = 10.0
@export var FLOOR_FRICTION = 0.01
@export var level_images : Array[PackedScene]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var shot_position = null
@onready var score = 0

var levels = []

var currentLevel : CharacterLevel
@onready var texture = $Sprite2D.texture

var currentLevelIndex : int

var start_time = Time.get_ticks_msec()
var last_shot_time = start_time
@export var TIME_BETWEEN_SHOTS = 250

var has_control = true

var start_shot_pos : Vector2

func _ready():
	print($Sprite2D.get_canvas_item())
	for levelScene in level_images:
		var level = levelScene.instantiate()
		levels.append(level)
	
	currentLevelIndex = 0
	currentLevel = levels[0]
	

func _physics_process(delta):
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, FLOOR_FRICTION)
	else:
		# Add the gravity.
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Shoot") && can_shoot():
		shoot()
		set_active()
		
	if Input.is_action_just_released("Shoot") && has_control:
		shot_position = null
		set_passive()
	
	if shot_position:
		var posDiff : Vector2 = shot_position - start_shot_pos
		velocity = posDiff.normalized() * HOOKSHOT_SPEED
	else:
		rotate(0.01 * ROTATION_VELOCITY)
	
	move_and_slide()
	
	var collision = get_last_slide_collision()
	
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Obstacle"):
			get_tree().reload_current_scene()

func can_shoot():
	if not has_control:
		return false
	
	var now = Time.get_ticks_msec()
	return now - last_shot_time > TIME_BETWEEN_SHOTS

func shoot():
	var point = $RayCast2D.get_collider()
	if point and not point.is_in_group("Obstacle"):
		shot_position = $RayCast2D.get_collision_point()
		last_shot_time = Time.get_ticks_msec()
		start_shot_pos = global_position
		
		var diff = shot_position - start_shot_pos
		
		
		if Global.end_time and diff.y < 0:
			has_control = false
#			$CollisionShape2D.disabled = true
			set_collision_layer_value(0, false)
			set_collision_mask_value(0, false)
			set_collision_mask_value(1, false)
			set_collision_mask_value(2, false)
			set_collision_mask_value(2, false)
			set_collision_mask_value(3, false)
			
#		var posDiff : Vector2 = shot_position - global_position
#		velocity += posDiff.normalized() * HOOKSHOT_SPEED
		

func pickup():
	score = score + 1
	print("Pickup!")
	get_tree().call_group("UI", "set_score_text", score)
	check_if_new_level()
	
func check_if_new_level():
	for i in range(currentLevelIndex + 1, levels.size()):
		var checkLevel = levels[i]
		print(checkLevel.level)
		if score >= checkLevel.level:
			currentLevelIndex = i
			currentLevel = checkLevel
			init_level()
			
			if i == levels.size() - 1:
				Global.end_time = Time.get_ticks_msec() - Global.start_time
	

func init_level():
	set_passive()

func set_passive():
	texture.diffuse_texture = currentLevel.passive
	texture.normal_texture = currentLevel.passive_n

func set_active():
	texture.diffuse_texture = currentLevel.active
	texture.normal_texture = currentLevel.active_n
	


	
