extends Node
@onready var entity: Node = %Entity

var monster = preload("res://scene/monster.tscn")


func _ready() -> void:
	
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_right"):
		on_monster_generater_pressed()



func on_monster_generater_pressed():
	print("111")
	var new_monster = monster.instantiate()
	
	entity.add_child(new_monster)
	
	new_monster.global_position = get_tree().get_first_node_in_group("player").global_position + Vector2(-300,0)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.call_deferred("queue_free")
		get_tree().change_scene_to_file("res://scene/home.tscn")
