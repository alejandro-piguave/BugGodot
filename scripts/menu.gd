extends Control


func _on_play_button_button_down():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_info_button_button_down():
	get_tree().change_scene_to_file("res://scenes/info.tscn")
