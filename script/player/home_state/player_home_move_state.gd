extends PlayerHomeState
@onready var idle_state: Node = %IdleState
@onready var check_state: Node = %CheckState
@onready var check_controller: Node = %CheckController


func enter():
	check_controller.check_interface_entered.connect(on_check_interface_entered)
	
	super.enter()
	
	player.play_animation("running")


func exit():
	check_controller.check_interface_entered.disconnect(on_check_interface_entered)
	
	super.enter()




func physics_update(_delta : float):
	flip()
	
	if get_move_dir() == Vector2.ZERO:
		get_parent().change_state(idle_state)
	
	
	super.physics_update(_delta)


func on_check_interface_entered():
	get_parent().change_state(check_state)
