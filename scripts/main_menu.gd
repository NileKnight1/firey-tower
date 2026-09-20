extends Node2D


var sound_click = preload("res://audio/buttonpress.mp3")

func play_sound(sound, vol = 0.0):
	var temp = AudioStreamPlayer.new()
	temp.stream = sound
	temp.volume_db = vol
	add_child(temp)
	
	temp.finished.connect(temp.queue_free)
	temp.play()


func _ready() -> void:
	
	$CanvasLayer/shop/player.visible = 1
	$CanvasLayer/shop/monster.visible = 0
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


func _on_player_toggled(toggled_on: bool) -> void:
	if toggled_on:
		play_sound(sound_click)
		$CanvasLayer/shop/player.visible = 1
	else:
		$CanvasLayer/shop/player.visible = 0
func _on_monster_toggled(toggled_on: bool) -> void:
	if toggled_on:
		play_sound(sound_click)
		$CanvasLayer/shop/monster.visible = 1
	else:
		$CanvasLayer/shop/monster.visible = 0

func _on_player_style_toggled(toggled_on, index) -> void:
	play_sound(sound_click)
	global.player_style = index

func _on_monster_style_toggled(toggled_on, index) -> void:
	play_sound(sound_click)
	global.monster_style = index

func _on_play_pressed() -> void:
	play_sound(sound_click)
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_shop_pressed() -> void:
	play_sound(sound_click)
	$CanvasLayer/shop.visible = !$CanvasLayer/shop.visible
