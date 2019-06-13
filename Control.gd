extends Control

func _ready():
	pass

func _process(delta):
	$Label.text = str(game.modules.energe.point)

func _on_add_pressed():
	game.modules.energe.charge(10)

func _on_minus_pressed():
	game.modules.energe.cost(10)

func _on_click_pressed():
	game.modules.energe.fill()

