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

var bg_color = global.player_bg_color
var border_color = global.player_border_color


func _ready() -> void:
	for i in $sprite.get_children():
		var style = i.get_theme_stylebox("panel")
		style.bg_color = bg_color
		style.border_color = border_color


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
