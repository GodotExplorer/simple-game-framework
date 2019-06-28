# 内置条件模块，提供基础的逻辑运算条件检查

tool
extends Reference
class_name BuiltinConditions

class BoolCondition extends Condition:
	func is_true():
		var input = get_param(0)
		if input:
			return true
		return false

class EqualCondition extends Condition:
	func is_true():
		var p0 = get_param(0)
		var p1 = get_param(1)
		return p0 == p1

class NotEqualCondition extends Condition:
	func is_true():
		var p0 = get_param(0)
		var p1 = get_param(1)
		return p0 != p1

class GreaterCondition extends Condition:
	func is_true():
		var p0 = get_param(0)
		var p1 = get_param(1)
		return p0 > p1

class GreaterEqualCondition extends Condition:
	func is_true():
		var p0 = get_param(0)
		var p1 = get_param(1)
		return p0 >= p1

class LessCondition extends Condition:
	func is_true():
		var p0 = get_param(0)
		var p1 = get_param(1)
		return p0 < p1

class LessEqualCondition extends Condition:
	func is_true():
		var p0 = get_param(0)
		var p1 = get_param(1)
		return p0 <= p1

class InContainerCondition extends Condition:
	func is_true():
		var p0 = get_param(0)
		var p1 = get_param(1)
		return p0 in p1

class ConditionBlock extends Condition:
	var sub_conditions = []
	func is_true():
		return false

class LogicAndCondition extends ConditionBlock:
	func is_true():
		for condi in sub_conditions:
			if not condi.is_true():
				return false
		return true

class LogicOrCondition extends ConditionBlock:
	func is_true():
		for condi in sub_conditions:
			if condi.is_true():
				return true
		return false

class LogicNotCondition extends ConditionBlock:
	func is_true():
		for condi in sub_conditions:
			return not condi.is_true()
		if OS.is_debug_build():
			assert(false) # 子条件为空
		return false
