extends Control

func _ready():
	var condi = BoolCondition.new()
	condi.params = [1]
	print(condi.is_true())
	var condi2 = EqualsCondition.new()
	condi2.params = [1.1, 1]
	print(condi2.is_true())
	var condi_or = LogicOrCondition.new()
	condi_or.condition1 = condi
	condi_or.condition2 = condi2
	print(condi_or.is_true())
	var condi_and = LogicAndCondition.new()
	condi_and.condition1 = condi
	condi_and.condition2 = condi2
	print(condi_and.is_true())
	var condi_not = LogicNotCondition.new()
	condi_not.sub_condition = condi
	print(condi_not.is_true())
	

func _process(delta):
	$Label.text = str(game.modules.energe.point)

func _on_add_pressed():
	(game.modules.energe as GamePoint).charge(10)


func _on_minus_pressed():
	(game.modules.energe as GamePoint).cost(10)
