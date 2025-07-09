extends StateMachine

@onready var player: CharacterBody2D = %Player

func _ready() -> void:
	if !player.is_node_ready():
		await player.ready
	
	super._ready()
