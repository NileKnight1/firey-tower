extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -1300
const GRAVITY_UP = 3.0
const GRAVITY_DOWN = 6.0
var move = 0

var sound_hit = preload("res://audio/hit.mp3")

func play_sound(sound, vol = 0.0):
	var temp = AudioStreamPlayer.new()
	temp.stream = sound
	temp.volume_db = vol
	add_child(temp)
	
	temp.finished.connect(temp.queue_free)
	temp.play()


var bg_colors = [
	["dcbe95","000000ff"],
	["c4c4c0","000000ff"],
	["d97a4a","000000ff"],
	["b8d4dc","000000ff"],
	
]

@export var style_num = global.player_style

func set_style(num):
	style_num = num
	for i in $sprite.get_children():
		var style = i.get_theme_stylebox("panel").duplicate()
		style.bg_color = Color(bg_colors[style_num][0])
		style.border_color = Color(bg_colors[style_num][1])
		i.add_theme_stylebox_override("panel", style)

func _ready() -> void:
	set_style(style_num)
	#print(bg_colors[style][0])
	#print(bg_colors)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0:
			velocity += get_gravity() * delta * GRAVITY_UP
		else:
			velocity += get_gravity() * delta * GRAVITY_DOWN
	
	if !move: return
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		play_sound(sound_hit)
		
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
