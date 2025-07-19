extends SiblingState
@onready var follow_state: State = %FollowState
@onready var sibling: CharacterBody2D = $"../.."

var player


func enter():
	if get_tree().get_first_node_in_group("player") != null:
		player = get_tree().get_first_node_in_group("player")
	
	super.enter()


func update(_delta):
	if player:
		var player_pos = player.get_sibling_sink_position()
		var pos = sibling.global_position
		
		var distance = pos.distance_to(player_pos)
		#print(distance,"distance_to_player")
		if distance > 60:
			change_state(follow_state)
		
	
	super.update(_delta)
