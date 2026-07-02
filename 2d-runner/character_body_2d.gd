extends CharacterBody2D
var can_animate = true
var first_jump = false
var can_double_jump = true
signal kill

var SPEED = 1000.0
const JUMP_VELOCITY = -1200.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		first_jump = true
		velocity += get_gravity() * delta
	velocity.x = SPEED

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SPEED = SPEED + 5
		%jumpTimer.start(0.2)
	if Input.is_action_just_pressed("Jump") and not is_on_floor():
		if first_jump == true and can_double_jump ==  true:
			velocity.y = (JUMP_VELOCITY *0.75)
			SPEED = SPEED + 5
			first_jump = false
			can_double_jump = false
		
	if is_on_floor():
		%Sprites.play("Run")
		can_animate = true
	else:
		if can_animate == true:
			%Sprites.play("Jump")
			if %Sprites.animation_finished:
				%Sprites.play("Fall")
				can_animate = false
	move_and_slide()


func _on_kill_box_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()


func _on_jump_timer_timeout() -> void:
	can_double_jump = true

func _on_diebox_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()


func _on_spring_area_body_entered(body: Node2D) -> void:
	velocity.y = (JUMP_VELOCITY*3)
