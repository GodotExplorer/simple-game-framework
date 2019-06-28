# 条件类，表示一些条件
# 如任务是否完成、条件是否能够解锁等

tool
extends EventEmitter
class_name Condition

# Array<Value> 条件的参数
var params = []

# 寄存取值器**引用**， 用于从取参数的具体值
# 默认为 框架中提供的 `evaluator` 取值器
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
		return (SimpleGameFramework.get_singeleton() as SimpleGameFramework).evaluator.evalute(raw)
