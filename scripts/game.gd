extends Node2D


var sound_click = preload("res://audio/buttonpress.mp3")
var sound_bite = preload("res://audio/bite.mp3")
var sound_hit = preload("res://audio/hit.mp3")
var sound_screech = preload("res://audio/53439420-flying-monster-screech-02-461220.mp3")
var sound_scream1 = preload("res://audio/dragon-studio-deep-sea-monster-roar-329857.mp3")
var sound_scream2 = preload("res://audio/dragon-studio-creepy-monster-growling-472378.mp3")
var sound_scream3 = preload("res://audio/dragon-studio-deep-sea-alien-sound-487681.mp3")
var sound_scream4 = preload("res://audio/dragon-studio-monster-growl-376892.mp3")
var sound_scream0 = preload("res://audio/u_kse9ncnirq-sea-monster-screaming-loudly-414878.mp3")



func play_sound(sound, vol = 0.0):
	var temp = AudioStreamPlayer.new()
	temp.stream = sound
	temp.volume_db = vol
	add_child(temp)
	
	temp.finished.connect(temp.queue_free)
	temp.play()

func scream_sounds():
	var temp = randi_range(0,4)
	match temp:
		0: temp = sound_scream0
		1: temp = sound_scream1
		2: temp = sound_scream2
		3: temp = sound_scream3
		4: temp = sound_scream4
	
	if game_running:
		play_sound(temp)
		scream_sounds() 


var score = 0
func _ready() -> void:
	#perfect()
	start_game()

var tween_monster: Tween
func start_game():
	var tween = create_tween()
	tween.tween_property($CanvasLayer/black, "modulate:a", 0.0, 0.1)
	
	$CanvasLayer/red.visible = 0
	
	 
	
	$bg.play()
	var temp = $monster.position.x
	tween_monster = create_tween()
	tween_monster.set_loops()
	tween_monster.tween_property($monster, "position:x", temp-100, 1)
	tween_monster.tween_property($monster, "position:x", temp+100, 1)
	
	$CanvasLayer/prog.max_value = global.highest_score
	$CanvasLayer/highest.text = "Highest: " + str(global.highest_score)
	$player.move = 1
	$CanvasLayer/vig.visible = 1
	$CanvasLayer/restart.visible = 0
	$monster.position.y = 917.0
	$cam.position = Vector2(-19.0, 66)
	$player.position = Vector2(-42, 143)
	
	Engine.time_scale = 1 
	perfect_multi = 1
	score = 0
	score_rate = 1
	cam_move_speed = 0.2
	good = 0
	cur_y = 180
	
	for i in $platforms.get_children():
		i.queue_free()
		
	
	game_running = 1
	spawn_apply()


var cam_move_speed = 0.2

func spawn_apply():
	if $platforms.get_child_count():
		pass
	
var good = 0
func _process(delta: float) -> void:
	if !game_running: return
	$cam.position.y -= cam_move_speed
	$monster.position.y -= cam_move_speed*2
	
	
	
	if ($cam.position.y - $player.position.y) > 100:
		good = 1
		if Input.is_action_just_pressed("jump"):
			perfect()
			
		var temp = $cam.position.y
		
		var tween = create_tween()
		tween.tween_property($cam, "position:y", temp-70, 0.3)
	else:
		good = 0
		cur_perfect = 0
		perfect_multi = 1
	
	

	
	if ($monster.position.y - $player.position.y) > 1000:
		good = 1
		var temp = $monster.position.y
		
		var tween = create_tween()
		tween.tween_property($monster, "position:y", temp-260, 0.4)
	else:
		good = 0
	
	
	#print(good)
	#print(cur_y)
	#print($cam.position.y)
	
	if abs(cur_y-$cam.position.y) < 500:
		spawn_platform()
	#print($platforms.get_child_count())
	if $platforms.get_child_count() > 10:
		$platforms.get_child(0).queue_free()
	
	if ( $player.position.y - $cam.position.y) >= 290:
		print("dead")
		game_over()
	
	#print($cam.position.y)
	#print($player.position.y)

var game_running = 0

func game_over():
	$bg.stop()
	$CanvasLayer/red.visible = 1
	play_sound(sound_screech)
	tween_monster.kill()
	var temp = $monster.position.y
	var tween = create_tween()
	tween.tween_property($monster, "position:y", temp-310, 0.4)
	temp = $monster.position.x
	var tween2 = create_tween()
	tween2.set_loops()
	tween2.tween_property($monster, "position:x", temp-100, 0.4)
	tween2.tween_property($monster, "position:x", temp+100, 0.4)
	#Engine.time_scale = 0.3
	
	var tween3 = create_tween()
	tween3.tween_property($player, "position:y", $player.position.y+500,1)
	
	play_sound(sound_bite)
	$player.move = 0
	global.highest_score = max(global.highest_score, score)
	$CanvasLayer/restart.visible = 1
	game_running = 0
	
	await get_tree().create_timer(1.0).timeout
	tween2.kill()

var cur_y = 180

# panel pos.x -480:125
# panel size.y 325:540

var cur_perfect = 0

func perfect():
	cur_perfect += 1
	if !(cur_perfect % 2):
		perfect_multi += 1
	
	var temp = $CanvasLayer/perfect.duplicate()
	
	temp.visible = 1
	$CanvasLayer.add_child(temp)
	var pos_y = temp.position.y
	var tween = create_tween()
	tween.tween_property(temp, "position:y", pos_y-25, 0.5)
	
	
	tween.tween_property(temp, "modulate:a", 0, 0.5)
	await get_tree().create_timer(1.0).timeout
	temp.queue_free()
	


@onready var ref_scene = preload("res://scenes/panel.tscn")
func spawn_platform():
	#var temp = randi_range(0, $refs.get_child_count()-1)
	#temp = $refs.get_child(temp).duplicate()
	
	
	var temp = ref_scene.instantiate()
	temp.position.x = randf_range(-480, 125)
	temp.size.y = randf_range(325, min(540, 450-temp.position.x))
	#print(temp. position.x)
	#print(540-temp.position.x)
	
	var collision_shape = temp.get_child(0).get_child(0)
	collision_shape.shape = collision_shape.shape.duplicate()
	collision_shape.shape.b.x = temp.size.y
	
	temp.position.y = cur_y
	cur_y -= 260
	
	$platforms.add_child(temp)
	

func _on_dif_timeout() -> void:
	if !game_running: return
	cam_move_speed += 0.4
	score_rate += 1

func _on_restart_pressed() -> void:
	var tween = create_tween()
	tween.tween_property($CanvasLayer/black, "modulate:a", 1.0, 0.1)
	await get_tree().create_timer(1.0).timeout
	
	play_sound(sound_click)
	start_game()

var score_rate = 1
var perfect_multi = 1
var was_multi = 1

func score_update():
	score += score_rate * perfect_multi
	if score <= global.highest_score:
		$CanvasLayer/prog_ind.position.x = remap(score, 0, $CanvasLayer/prog.max_value, 28.0, 327.0)
		$CanvasLayer/prog.value = score
	$CanvasLayer/score.text = "Height: " + str(score)
	$CanvasLayer/multi.text = "x" + str(perfect_multi) + ".0"
	
	if was_multi != perfect_multi:
		var tween2 = create_tween()
		tween2.tween_property($CanvasLayer/multi, "scale", Vector2(1.025,1.025), 0.1)
	elif perfect_multi == 1:
		$CanvasLayer/multi.scale = Vector2(1,1)
	
	was_multi = perfect_multi
	var tween = create_tween()
	tween.tween_property($CanvasLayer/score, "scale", Vector2(1.025,1.025), 0.1)
	tween.tween_property($CanvasLayer/score, "scale", Vector2(1,1), 0.1)
	#
	
	if score > global.highest_score:
		$CanvasLayer/highest.text = "Highest: " + str(score)

func _on_score_timeout() -> void:
	if !game_running: return
	score_update()

func _on_bg_finished() -> void:
	if game_running:
		$bg.play()
