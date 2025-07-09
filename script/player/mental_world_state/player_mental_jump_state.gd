extends PlayerMentalAirState
@onready var fall_state: Node = %FallState
@onready var idle_state: Node = %IdleState
@onready var air_dash_state: Node = %AirDashState


func enter():
	
	super.enter()
	player.coyote_time.stop()
	
	player.play_animation("jump")

func physics_update(_delta:float):
	
	
	if player.velocity.y > 0:
		change_state(fall_state)
		
	elif player.is_on_floor():
		change_state(idle_state)
		
	elif Input.is_action_just_pressed("dash") and player.can_dash and player.is_dash_ability_enable:
		change_state(air_dash_state)
	
	super.physics_update(_delta)
