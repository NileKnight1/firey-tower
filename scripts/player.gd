extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -1300
const GRAVITY_UP = 3.0
const GRAVITY_DOWN = 6.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0:
			velocity += get_gravity() * delta * GRAVITY_UP
		else:
			velocity += get_gravity() * delta * GRAVITY_DOWN
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
