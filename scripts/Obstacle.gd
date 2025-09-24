extends StaticBody3D

var move_speed = 5.0

func _ready():
    # Add to obstacles group for collision detection
    add_to_group("obstacles")

func _process(delta):
    # Move obstacle towards player
    global_position.z += move_speed * delta
    
    # Remove obstacle when it's far behind player
    if global_position.z > 10:
        queue_free()