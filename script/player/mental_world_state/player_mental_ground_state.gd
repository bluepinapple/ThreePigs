extends PlayerMentalMoveState
class_name PlayerMentalGroundState


func enter():
	GameEvent.can_double_jump = true
	
	super.enter()


func physics_update(_delta : float):
	
	
	
	super.physics_update(_delta)
