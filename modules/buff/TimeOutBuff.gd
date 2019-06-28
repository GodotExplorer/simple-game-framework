# 限时Buff， `duration` 时间内有效，超时自动停止效果
# 时间限制指的是逻辑更新时间，因此游戏暂停或玩家离线时时间是静止的，逻辑恢复更新后继续计时

tool
extends Buff
class_name TimeOutBuff

# 超时时长(秒)
var duration = 5
# 剩余时间(秒)
var time_left = 0 setget set_time_left, get_time_left
# 已经开始的时间(秒)
var _started_duration = 0
# 设置剩余时间(秒)
func set_time_left(v: float):
	self._started_duration = duration - v
# 获取剩余时间(秒)
func get_time_left() -> float:
	return duration - self._started_duration

func on_start():
	self.time_left = duration

func update(dt: float):
	_started_duration += dt
	if _started_duration >= duration:
		stop()

func save() -> Dictionary:
	return { started_duration = self._started_duration }

func load(data: Dictionary):
	self._started_duration = data.started_duration
