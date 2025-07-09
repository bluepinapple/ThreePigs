extends Node
const MENTAL_WORLD = "res://scene/mental_world.tscn"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.call_deferred("queue_free")
		get_tree().change_scene_to_file(MENTAL_WORLD)
