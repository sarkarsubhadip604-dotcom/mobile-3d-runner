extends Control

@onready var play_button = $VBoxContainer/PlayButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var high_score_label = $VBoxContainer/HighScoreLabel

func _ready():
    play_button.pressed.connect(_on_play_button_pressed)
    quit_button.pressed.connect(_on_quit_button_pressed)
    
    # Update high score display
    high_score_label.text = "High Score: " + str(GameManager.high_score)

func _on_play_button_pressed():
    get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_quit_button_pressed():
    get_tree().quit()