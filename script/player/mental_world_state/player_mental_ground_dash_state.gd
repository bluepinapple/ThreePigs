extends PlayerMentalGroundState
@onready var idle_state: Node = %IdleState
@export var dash_speed : float = 250.0
@export var dash_duration : float = .4

func enter():
	get_tree().create_timer(dash_duration).timeout.connect(on_dash_time_out)
	
	
	super.enter()
	player.play_animation("dash")
	player.dash_cooling_down()


func physics_update(_delta : float):
	if player.is_facing_right:
		player.velocity.x = dash_speed
	else :
		player.velocity.x = -dash_speed
	
	super.physics_update(_delta)
	
	player.velocity.y = 0


func on_dash_time_out():
	change_state(idle_state)
	
