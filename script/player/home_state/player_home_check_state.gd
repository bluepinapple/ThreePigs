extends PlayerHomeState
@onready var check_controller: Node = %CheckController
@onready var idle_state: Node = %IdleState


func enter():
	if player:
		player.set_collision_layer_value(1, false)
	else :
		print("没有player")
	check_controller.check_interface_exited.connect(on_check_interface_exited)
	
	super.enter()
	
	player.play_animation("idle")


func exit():
	if player:
		player.set_collision_layer_value(1, true)
	else :
		print("没有player")
	
	check_controller.check_interface_exited.disconnect(on_check_interface_exited)
	
	super.enter()


func physics_update(_delta : float):
	if player:
		if player.velocity != Vector2.ZERO:
			player.velocity = player.velocity.lerp(Vector2.ZERO,1-exp(-_delta*acceleration_smoothing))
	
	super.physics_update(_delta)


func on_check_interface_exited():
	get_parent().change_state(idle_state)
