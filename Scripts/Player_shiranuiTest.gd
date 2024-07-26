extends CharacterBody3D
@onready var armture = $root
@onready var Anim_tree = $AnimationTree

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const Lerp_val = 0.15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _unhandled_input(event):
	if Input.is_action_just_pressed("Player_Interact"):
		get_tree().quit()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		#if moving
		velocity.x = lerp(velocity.x,direction.x * SPEED, Lerp_val)
		velocity.z = lerp(velocity.z,direction.z * SPEED, Lerp_val)
		armture.rotation.y = lerp_angle(armture.rotation.y, atan2(velocity.x, velocity.z), Lerp_val)
	else:
		#if not moving
		velocity.x = lerp(velocity.x,0.0, Lerp_val)
		velocity.z = lerp(velocity.z,0.0, Lerp_val)
		#armture.rotation.y = 180
	Anim_tree.set("parameters/BlendSpace1D/blend_position", velocity.length() / SPEED)
	move_and_slide()
