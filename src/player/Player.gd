extends KinematicBody2D

export (int) var speed = 700
export (int) var jump_speed = -800
export (int) var gravity = 2000

export (float, 0, 1.0) var friction = 0.2
export (float, 0, 1.0) var acceleration = 0.3

var dir = Vector2.ZERO
var velocity = Vector2.ZERO

func get_input():
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if dir.x != 0:
		velocity.x = lerp(velocity.x, dir.x * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
