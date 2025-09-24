extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = 8.0
@export var move_speed = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var is_mobile_device = false

func _ready():
    # Detect if we're on a mobile device
    is_mobile_device = OS.has_feature("mobile")

func _physics_process(delta):
    # Add gravity
    if not is_on_floor():
        velocity.y -= gravity * delta

    # Handle jump
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    # Handle movement
    var input_dir = Vector2.ZERO
    
    if is_mobile_device:
        # Mobile controls - use touch or accelerometer
        input_dir = get_mobile_input()
    else:
        # Desktop controls
        input_dir = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
    
    # Apply horizontal movement
    if input_dir != Vector2.ZERO:
        velocity.x = input_dir.x * move_speed
    else:
        velocity.x = move_toward(velocity.x, 0, move_speed * 2 * delta)
    
    # Constant forward movement
    velocity.z = -speed

    move_and_slide()
    
    # Keep player within bounds
    global_position.x = clamp(global_position.x, -8, 8)

func get_mobile_input() -> Vector2:
    var input = Vector2.ZERO
    
    # Check touch input
    if Input.is_action_pressed("move_left"):
        input.x = -1
    elif Input.is_action_pressed("move_right"):
        input.x = 1
    
    # You could also add accelerometer input here if needed
    # var accel = Input.get_accelerometer()
    # input.x = -accel.x * 2  # Tilt to move
    
    return input

func _on_body_entered(body):
    # Handle collision with obstacles
    if body.is_in_group("obstacles"):
        # Game over or take damage
        get_parent().game_over()