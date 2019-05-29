extends Control

func _process(delta):
	$Label.text = str(game.modules.energe.point)

func _on_add_pressed():
	(game.modules.energe as GamePoint).charge(10)


func _on_minus_pressed():
	(game.modules.energe as GamePoint).cost(10)
