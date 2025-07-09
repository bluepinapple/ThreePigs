extends PlayerMentalAirState
@onready var idle_state: Node = %IdleState
@onready var jump_state: Node = %JumpState
@onready var air_dash_state: Node = %AirDashState


func enter():
	
	
	super.enter()
	
	player.play_animation("fall")


func physics_update(_delta:float):
	#print(player.coyote_time.time_left)
	
	if player.is_on_floor():
		change_state(idle_state)
	elif player.coyote_time.time_left > 0:
		if Input.is_action_just_pressed("jump"):
			player.velocity.y = JUMP_VELOCITY
			change_state(jump_state)
	
	elif Input.is_action_just_pressed("dash")  and player.can_dash and player.is_dash_ability_enable:
		change_state(air_dash_state)
	
	super.physics_update(_delta)
