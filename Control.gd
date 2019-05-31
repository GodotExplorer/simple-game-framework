extends Control

func _ready():
	var condi = BuiltinConditions.BoolCondition.new()
	condi.params = [1]
	print(condi.is_true())
	var condi2 = BuiltinConditions.EqualCondition.new()
	condi2.params = [1.1, 1]
	print(condi2.is_true())
	var condi_or = BuiltinConditions.LogicOrCondition.new()
	condi_or.sub_conditions = [condi, condi2]
	print(condi_or.is_true())
	var condi_and = BuiltinConditions.LogicAndCondition.new()
	condi_and.sub_conditions = [condi, condi2]
	print(condi_and.is_true())
	var condi_not = BuiltinConditions.LogicNotCondition.new()
	condi_not.sub_conditions = [condi]
	print(condi_not.is_true())
	

func _process(delta):
	$Label.text = str(game.modules.energe.point)

func _on_add_pressed():
	(game.modules.energe as GamePoint).charge(10)


func _on_minus_pressed():
	(game.modules.energe as GamePoint).cost(10)

func _on_click_pressed():
	game.messenger.emit("click")
