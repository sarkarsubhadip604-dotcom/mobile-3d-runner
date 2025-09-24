extends Node3D

@onready var player = $Player
@onready var score_label = $GameUI/Control/ScoreLabel

var score = 0
var obstacle_scene = preload("res://scenes/Obstacle.tscn")
var collectible_scene = preload("res://scenes/Collectible.tscn")

var spawn_timer = 0.0
var spawn_interval = 2.0

func _ready():
    # Initialize mobile-specific settings
    if OS.has_feature("mobile"):
        # Enable touch controls
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    
    update_score_display()

func _process(delta):
    # Handle spawning obstacles and collectibles
    spawn_timer += delta
    if spawn_timer >= spawn_interval:
        spawn_timer = 0.0
        spawn_random_object()

func spawn_random_object():
    var spawn_position = Vector3(
        randf_range(-8, 8),  # Random X position
        1,                    # Y position
        player.global_position.z - 20  # Ahead of player
    )
    
    # 70% chance for obstacle, 30% for collectible
    if randf() < 0.7:
        var obstacle = obstacle_scene.instantiate()
        obstacle.global_position = spawn_position
        add_child(obstacle)
    else:
        var collectible = collectible_scene.instantiate()
        collectible.global_position = spawn_position
        add_child(collectible)
        # Connect the collectible signal
        collectible.collected.connect(_on_collectible_collected)

func _on_collectible_collected():
    score += 10
    update_score_display()

func update_score_display():
    score_label.text = "Score: " + str(score)

func game_over():
    # Handle game over logic
    print("Game Over! Final Score: ", score)
    # Here you could add a game over screen or restart functionality