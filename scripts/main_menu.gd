extends Node2D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_styles_pressed() -> void:
	pass # Replace with function body.
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
func _on_monster_style1_pressed() -> void:
	global.monster_bg_color = Color("0a0a0a")
	global.monster_border_color = Color("8a1f1f")
func _on_monster_style2_pressed() -> void:
	global.monster_bg_color = Color("0a0d0a")
	global.monster_border_color = Color("4a5c2e")
func _on_monster_style3_pressed() -> void:
	global.monster_bg_color = Color("0a0c0d")
	global.monster_border_color = Color("3d5a66")
func _on_monster_style4_pressed() -> void:
	global.monster_bg_color = Color("08070a")
	global.monster_border_color = Color("3d1f5c")

func _on_player_style1_pressed() -> void:
	global.player_bg_color = Color("dcbe95")
	global.player_border_color = Color("000000ff")
func _on_player_style2_pressed() -> void:
	global.player_bg_color = Color("c4c4c0")
	global.player_border_color = Color("000000ff")
func _on_player_style3_pressed() -> void:
	global.player_bg_color = Color("d97a4a")
	global.player_border_color = Color("000000ff")
func _on_player_style4_pressed() -> void:
	global.player_bg_color = Color("b8d4dc")
	global.player_border_color = Color("0a1416ff")
