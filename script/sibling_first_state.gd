extends SiblingState
@onready var player_check_area: Area2D = %PlayerCheckArea
@onready var player_check_area_colli: CollisionShape2D = %PlayerCheckAreaColli
@onready var idle_state: Node = %idleState
@onready var sibling: CharacterBody2D = $"../.."


func enter():
	sibling.velocity.x = 0
	player_check_area.body_entered.connect(on_body_entered)
	player_check_area.set_collision_mask_value(1<<0,true)
	super.enter()


func exit():
	player_check_area.body_entered.disconnect(on_body_entered)
	player_check_area.call_deferred("set_collision_mask_value",1<<0,false)
	
	
	super.exit()


func on_body_entered(body : Node2D):
	if body.is_in_group("player"):
		change_state(idle_state)
