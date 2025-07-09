extends PlayerMentalState
@onready var idle_state: Node = %IdleState
@onready var label_2: Label = $"../../CanvasLayer/Label2"

@export var jump_count_num : int = 10
var jump_count : int

func enter():
	label_2.visible = true
	jump_count = 0
	get_tree().create_timer(3).timeout.connect(on_timer_time_out)
	
	player.velocity = Vector2.ZERO
	
	super.enter()
	
	player.play_animation("crouch")


func exit():
	label_2.visible = false
	
	super.exit()


func update(_delta : float):
	if Input.is_action_just_pressed("interact"):
		jump_count += 1
		if jump_count == jump_count_num:
			GameEvent.emit_player_saved()
			change_state(idle_state)
	
	super.update(_delta)


func on_timer_time_out():
	if jump_count < jump_count_num:
		player.play_animation("death")
		
	
	
