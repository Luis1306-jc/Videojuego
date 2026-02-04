extends TextureProgressBar

func disminuir_vida(cantidad: int) -> bool:
	value = max(value - cantidad, 0)
	return value == 0

func aumentar_vida(cantidad: int):
	value = min(value + cantidad, max_value)
