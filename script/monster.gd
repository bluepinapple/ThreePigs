extends CharacterBody2D

var player : CharacterBody2D
var captured : bool = false

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	print("怪物生成了")
	player = get_tree().get_first_node_in_group("player")
	GameEvent.player_saved.connect(on_player_saved)


func _physics_process(_delta: float) -> void:
	if player and !captured:
		global_position = global_position.lerp(player.global_position,1-exp(-_delta*1))
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameEvent.emit_player_captured()
		captured = true

func on_player_saved():
	collision_shape_2d.disabled = true
	
	var tween = create_tween()
	
	tween.tween_property(self,"modulate", Color(1,1,1,0),.4).set_ease(Tween.EASE_OUT)
	
	await tween.finished
	queue_free()
