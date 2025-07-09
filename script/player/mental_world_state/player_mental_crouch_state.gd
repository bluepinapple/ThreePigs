extends PlayerMentalGroundState
@onready var idle_state: Node = %IdleState
@onready var fall_state: Node = %FallState


func enter():
	
	
	super.enter()

	player.play_animation("crouch")

func physics_update(_delta:float):
	if ! is_zero_approx(player.velocity.x):
		player.velocity.x = move_toward(player.velocity.x,0,FLOOR_ACCELERATION * _delta) 
	
	
	if player.velocity.y >0 and !player.is_on_floor():
		change_state(fall_state)
	
	elif Input.is_action_just_released("crouch"):
		change_state(idle_state)
	
	super.physics_update(_delta)
