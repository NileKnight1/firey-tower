extends Node2D


func _ready() -> void:
	spawn_platform()


func _process(delta: float) -> void:
	$cam.position.y -= 0.2
	
	if ($cam.position.y - $player.position.y) > 100:
		$cam.position.y -= 70
	
	
	pass

var cur_y = 180

func spawn_platform():
	var temp = randi_range(0, $refs.get_child_count()-1)
	temp = $refs.get_child(temp).duplicate()
	temp.position.y = cur_y
	cur_y -= 180
	
	$platforms.add_child(temp)
	
