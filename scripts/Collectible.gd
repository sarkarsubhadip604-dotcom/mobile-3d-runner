extends Area3D

signal collected

var move_speed = 5.0
var rotation_speed = 2.0

func _ready():
    # Connect the body_entered signal
    body_entered.connect(_on_body_entered)

func _process(delta):
    # Move collectible towards player
    global_position.z += move_speed * delta
    
    # Rotate for visual appeal
    rotation.y += rotation_speed * delta
    
    # Remove collectible when it's far behind player
    if global_position.z > 10:
        queue_free()

func _on_body_entered(body):
    if body.is_in_group("player"):
        emit_signal("collected")
        queue_free()