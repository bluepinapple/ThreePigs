extends PlayerHomeState
@onready var move_state: Node = %MoveState
@onready var check_state: Node = %CheckState
@onready var check_controller: Node = %CheckController


func enter():
	check_controller.check_interface_entered.connect(on_check_interface_entered)
	
	super.enter()
	if !player.is_node_ready():
		await player.ready
		player.play_animation("idle")
	
	else :
		player.play_animation("idle")


func exit():
	check_controller.check_interface_entered.disconnect(on_check_interface_entered)
	
	super.enter()


func physics_update(_delta : float):
	if player:
		if player.velocity != Vector2.ZERO:
			player.velocity = player.velocity.lerp(Vector2.ZERO,1-exp(-_delta*acceleration_smoothing))
	
	
	if get_move_dir() != Vector2.ZERO:
		get_parent().change_state(move_state)

	
	super.physics_update(_delta)


func on_check_interface_entered():
	get_parent().change_state(check_state)
