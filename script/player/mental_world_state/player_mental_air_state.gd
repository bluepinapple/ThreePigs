extends PlayerMentalMoveState
class_name PlayerMentalAirState

func physics_update(_delta : float):
	var acceleration = FLOOR_ACCELERATION if player.is_on_floor() else AIR_ACCELERATION
	
	player.velocity.x = move_toward(player.velocity.x,get_x_movement() * RUN_SPEED,acceleration * _delta) 
	
	if Input.is_action_just_pressed("jump") and GameEvent.can_double_jump:
		GameEvent.can_double_jump = false
		player.velocity.y = JUMP_VELOCITY 
	
	super.physics_update(_delta)


func exit():
	
	super.exit()
