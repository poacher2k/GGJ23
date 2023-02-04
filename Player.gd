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

	if Input.is_action_just_pressed("Shoot"):
		shoot()
		set_active()
		
	if Input.is_action_just_released("Shoot"):
		shot_position = null
		set_passive()
	
	if shot_position:
		var posDiff : Vector2 = shot_position - global_position
		velocity = posDiff.normalized() * HOOKSHOT_SPEED
	else:
		rotate(0.01 * ROTATION_VELOCITY)
	
	move_and_slide()


func shoot():
	var point = $RayCast2D.get_collider()
	if point:
		shot_position = $RayCast2D.get_collision_point()
		

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
			return
	

func init_level():
	set_passive()

func set_passive():
	texture.diffuse_texture = currentLevel.passive
	texture.normal_texture = currentLevel.passive_n

func set_active():
	texture.diffuse_texture = currentLevel.active
	texture.normal_texture = currentLevel.active_n
	
