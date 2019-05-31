tool
extends EventEmitter
class_name Condition

# Array<Value>
var params = []
var register: ValueEvaluator.Register = null

func is_true():
	return false

# 获取参数值
func get_param(idx: int):
	if idx >= len(params):
		if OS.is_debug_build():
			assert(false) # 参数数量不足
		return null
	else:
		var raw = self.params[idx]
		if register and register.has_value(raw):
			return register.get_value(raw)
		return game.evaluator.evalute(raw)
