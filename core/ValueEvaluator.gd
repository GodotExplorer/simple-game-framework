# 数值取值器

tool
extends EventEmitter
class_name ValueEvaluator

const utils = preload("../utils.gd")

# 求值公式接口
class IEvolutor:
	func has_value(prop) -> bool:
		return false
	func get_value(prop):
		return null

# 寄存器
class Register extends IEvolutor:
	var values = {}
	func has_value(prop) -> bool:
		return prop in values
	func get_value(prop):
		return values[prop]

# 求值公式表
# Array<IEvolutor>
var evolutors = []

# 计算值
func evalute(input):
	for e in evolutors:
		if e.has_value(input):
			return e.get_value(input)
	return input

# 添加公式
func add_evolutor(evolutor):
	if utils.implements(evolutor, IEvolutor):
		evolutors.append(evolutor)
