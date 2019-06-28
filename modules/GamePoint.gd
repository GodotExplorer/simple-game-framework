# 游戏点数，可用于如 体力 金币 等相关的数值记录

tool
extends Module
class_name GamePoint

signal point_changed(amount)		# 点数变动
var point = 0 setget set_point		# 点数

# 消耗点数
func cost(amount) -> bool:
	if point >= amount:
		set_point(point - amount)
		return true
	return false

# 充值点数
func charge(amount):
	set_point(point + amount)

# 设置点数
func set_point(value):
	if value != point:
		var amount = value - point
		point = value
		emit_signal("point_changed", amount)

func save() -> Dictionary:
	return { "point": point }

func load(data: Dictionary):
	point = data.point
