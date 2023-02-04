extends CharacterBody2D


const SPEED = 300.0
@export var HOOKSHOT_SPEED = 350.0
@export var ROTATION_VELOCITY = 10.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var shot_position = null

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Shoot"):
		shoot()
#		$AnimatedSprite2D.play("active")
		
	if Input.is_action_just_released("Shoot"):
#		$AnimatedSprite2D.play("passive")
		shot_position = null
	
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
		

