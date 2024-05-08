extends Control

const language_map = {
	"es": "🇪🇸",
	"en": "🇺🇸"
}

var current_language = TranslationServer.get_locale()

func _ready():
	$LanguageButton.text = language_map[current_language]

func _on_play_button_button_down():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_info_button_button_down():
	get_tree().change_scene_to_file("res://scenes/info.tscn")

func _on_language_button_button_down():
	if current_language == "es":
		current_language = "en"
	elif current_language == "en":
		current_language = "es"
	TranslationServer.set_locale(current_language)	
	$LanguageButton.text = language_map[current_language]
