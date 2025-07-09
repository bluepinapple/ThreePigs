extends PlayerState
class_name PlayerHomeState

@export var max_speed : float
@export var acceleration_smoothing : float

var is_facing_right : bool = true


func physics_update(_delta:float):
	var move_dir = get_move_dir()
	var target_velocity = move_dir * max_speed
	
	if player:
		player.velocity = player.velocity.lerp(target_velocity,1-exp(-_delta*acceleration_smoothing))
	
	
	super.physics_update(_delta)


func update(_delta : float):
	
	super.update(_delta)

func get_move_dir():
	var x_movement = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	var dir = Vector2(x_movement,y_movement).normalized()
	
	return dir


func flip():
	var x_movement = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	
	if x_movement < 0 && is_facing_right:
		is_facing_right = false
		player.flip(is_facing_right)
	elif x_movement > 0 && !is_facing_right:
		is_facing_right = true
		player.flip(is_facing_right)
