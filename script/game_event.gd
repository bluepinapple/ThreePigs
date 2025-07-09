extends Node
signal can_be_checked_item_clicked
signal player_captured
signal player_saved

var can_double_jump : bool = true

func emit_can_be_checked_item_clicked(item_id : int):
	can_be_checked_item_clicked.emit(item_id)


func emit_player_captured():
	player_captured.emit()


func emit_player_saved():
	player_saved.emit()
