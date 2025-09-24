extends Node

# Autoload singleton for managing game state across scenes

var current_score = 0
var high_score = 0
var game_settings = {}

func _ready():
    load_game_data()

func save_game_data():
    var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
    var save_data = {
        "high_score": high_score,
        "settings": game_settings
    }
    save_file.store_string(JSON.stringify(save_data))
    save_file.close()

func load_game_data():
    if FileAccess.file_exists("user://savegame.save"):
        var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
        var json_string = save_file.get_as_text()
        save_file.close()
        
        var json = JSON.new()
        var parse_result = json.parse(json_string)
        
        if parse_result == OK:
            var save_data = json.data
            high_score = save_data.get("high_score", 0)
            game_settings = save_data.get("settings", {})

func update_high_score(new_score: int):
    if new_score > high_score:
        high_score = new_score
        save_game_data()
        return true
    return false