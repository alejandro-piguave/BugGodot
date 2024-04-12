extends Control

func _ready():
	if not FileAccess.file_exists("user://score.save"):
		return # 
	var save_game = FileAccess.open("user://score.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()
		
		var score = node_data.get("score", 0)
		var best = node_data.get("best", 0)
		
		var format_str = tr("score_text_key") % [score, best]
		$ColorRect/ScoreLabel.text = format_str
		

func _on_menu_button_button_down():
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_play_again_button_button_down():
		get_tree().change_scene_to_file("res://scenes/main.tscn")
