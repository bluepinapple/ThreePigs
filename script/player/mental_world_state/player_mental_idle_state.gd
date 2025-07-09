extends PlayerMentalGroundState
@onready var jump_state: Node = %JumpState
@onready var run_state: Node = %RunState
@onready var fall_state: Node = %FallState
@onready var ground_dash_state: Node = %GroundDashState
@onready var crouch_state: Node = %CrouchState


func enter():
	
	
	super.enter()

	player.play_animation("idle")
	


func physics_update(_delta:float):
	if ! is_zero_approx(player.velocity.x):
		player.velocity.x = move_toward(player.velocity.x,get_x_movement() * RUN_SPEED,FLOOR_ACCELERATION * _delta) 
	
	
	if !is_zero_approx(get_y_movement()) and !player.is_on_floor():
		change_state(jump_state)
	elif !is_zero_approx(get_x_movement()) and player.is_on_floor():
		change_state(run_state)
		
	elif !player.is_on_floor():
		change_state(fall_state)
		
	elif Input.is_action_just_pressed("dash") and player.can_dash and player.is_dash_ability_enable:
		change_state(ground_dash_state)
	
	elif Input.is_action_just_pressed("crouch"):
		change_state(crouch_state)
	
	
	
	super.physics_update(_delta)
