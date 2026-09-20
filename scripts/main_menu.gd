extends Node2D

func _ready() -> void:
	
	$CanvasLayer/shop/player.visible = 1
	$CanvasLayer/shop/monster.visible = 0DDDD
	var buttons = [
	$CanvasLayer/shop/player/control/button,
	$CanvasLayer/shop/player/control2/button,
	$CanvasLayer/shop/player/control3/button,
	$CanvasLayer/shop/player/control4/button,
	]
	
	for i in buttons.size():
		buttons[i].toggled.connect(_on_player_style_toggled.bind(i))
	
	buttons = [
	$CanvasLayer/shop/monster/control/button,
	$CanvasLayer/shop/monster/control2/button,
	$CanvasLayer/shop/monster/control3/button,
	$CanvasLayer/shop/monster/control4/button,
	]
	for i in buttons.size():
		buttons[i].toggled.connect(_on_monster_style_toggled.bind(i))
	
	
	var temp = 0
	for i in $CanvasLayer/shop/player.get_children():
		i.get_child(2).set_style(temp)
		temp += 1
	$CanvasLayer/shop/player/control/button.button_pressed = 1
	temp = 0
	for i in $CanvasLayer/shop/monster.get_children():
		i.get_child(2).set_style(temp)
		temp += 1
	$CanvasLayer/shop/monster/control/button.button_pressed = 1
	

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


func _on_player_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$CanvasLayer/shop/player.visible = 1
	else:
		$CanvasLayer/shop/player.visible = 0
func _on_monster_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$CanvasLayer/shop/monster.visible = 1
	else:
		$CanvasLayer/shop/monster.visible = 0

func _on_player_style_toggled(toggled_on, index) -> void:
	global.player_style = index

func _on_monster_style_toggled(toggled_on, index) -> void:
	global.monster_style = index
