extends Node2D


func _ready() -> void:
	start_game()

func start_game():
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
	
	if ($cam.position.y - $player.position.y) > 100:
		good = 1
		var temp = $cam.position.y
		var tween = create_tween()
		tween.tween_property($cam, "position:y", temp-70, 0.3)
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
	game_running = 0

var cur_y = 180

# panel pos.x -480:125
# panel size.y 325:540



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
	#cam_move_speed += 0.4
	pass
