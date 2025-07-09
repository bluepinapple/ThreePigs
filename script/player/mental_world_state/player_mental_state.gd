extends PlayerState
class_name PlayerMentalState

const RUN_SPEED = 160.0
const JUMP_VELOCITY = -300.0
const FLOOR_ACCELERATION := RUN_SPEED/.2
const AIR_ACCELERATION := RUN_SPEED/.02

var gravity : = ProjectSettings.get("physics/2d/default_gravity") as float
var is_facing_right : bool
@onready var captured_state: PlayerMentalState = %CapturedState


func enter():
	GameEvent.player_captured.connect(on_player_captured)
	
	
	super.enter()


func exit():
	GameEvent.player_captured.disconnect(on_player_captured)
	
	
	super.exit()


func physics_update(_delta:float):
	if player:
		player.velocity.y += gravity * _delta
		
		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			player.velocity.y = JUMP_VELOCITY 
		
	
	super.physics_update(_delta)


func update(_delta : float):
	#flip()
	
	super.update(_delta)



func get_x_movement():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	return x_movement


func get_y_movement():
	var y_movement = Input.get_action_strength("jump")
	
	return y_movement


func flip():
	var x_movement = get_x_movement()
	
	if x_movement < 0 && is_facing_right:
		is_facing_right = false
		player.flip(is_facing_right)
	elif x_movement > 0 && !is_facing_right:
		is_facing_right = true
		player.flip(is_facing_right)


func on_player_captured():
	change_state(captured_state)
