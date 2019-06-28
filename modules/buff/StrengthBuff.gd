# 带强度的 Buff， `strength` 衰减小于等于0时失效

tool
extends Buff
class_name StrengthBuff

# 强度值
var strength = 0

# 衰减强度
func attenuate(amount = 1):
	self.strength -= amount
	if strength <= 0:
		stop()

func update(dt):
	if strength <= 0:
		stop()
