extends CanvasLayer

@onready var label := $Label

func _ready():
	print("Label encontrado:", label)

func _process(delta):
	if label:
		label.text = "Monedas: %d / 10" % Global.moneda
