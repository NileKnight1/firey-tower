extends Node2D


func _ready() -> void:
	start_game()

func start_game():
	spawn_apply()

func spawn_apply():
	if $platforms.get_child_count():
		pass
	

func _process(delta: float) -> void:
	$cam.position.y -= 0.2
	
	if ($cam.position.y - $player.position.y) > 100:
		$cam.position.y -= 70
	
	#print(cur_y)
	#print($cam.position.y)
	
	if abs(cur_y-$cam.position.y) < 500:
		spawn_platform()
	print($platforms.get_child_count())
	if $platforms.get_child_count() > 10:
		$platforms.get_child(0).queue_free()
	
	pass

var cur_y = 180

# panel pos.x -480:125
# panel size.y 325:540


@onready var ref: Panel = $refs/Panel

func spawn_platform():
	#var temp = randi_range(0, $refs.get_child_count()-1)
	#temp = $refs.get_child(temp).duplicate()
	
	var temp = ref.duplicate()
	temp.position.x = randf_range(-480, 125)
	temp.size.y = randf_range(325, min(540, 450-temp.position.x))
	#print(temp.position.x)
	#print(540-temp.position.x)
	
	temp.get_child(0).get_child(0).shape.b.x = temp.size.y 
	
	temp.position.y = cur_y
	cur_y -= 180
	
	$platforms.add_child(temp)
	
