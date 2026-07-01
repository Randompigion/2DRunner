extends CharacterBody2D
var can_animate = true

const SPEED = 1000.0
const JUMP_VELOCITY = -1200.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if is_on_floor():
		velocity.x = SPEED
		%Sprites.play("Run")
		can_animate = true
	else:
		if can_animate == true:
			%Sprites.play("Jump")
			if %Sprites.animation_finished:
				%Sprites.play("Fall")
				can_animate = false
	move_and_slide()
