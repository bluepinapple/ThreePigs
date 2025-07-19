extends Sprite2D
@onready var label: Label = $Label

func set_label_text(type : Vector2):
	label.text = str(int(type[0])) + "," + str(int(type[1]))
