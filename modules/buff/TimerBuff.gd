# 限时Buff， 指定时刻之前有效，超时自动停止效果
# 时间指的是真实时间，因此不受游戏暂停或玩家离线等条件的影响，超过指定时间后失效

tool
extends Buff
class_name TimerBuff

# 剩余时间(秒)
var time_left = 0 setget set_time_left, get_time_left

# 设定时长，启动后修改无效
var duration = 5

# 结束时刻
var _timeout: float = 0

# 设置剩余时间(秒)
func set_time_left(v: float):
	self._timeout = now() + v

# 获取剩余时间(秒)
func get_time_left() -> float:
	return self._timeout - now()

func on_start():
	self.time_left = duration

func update(dt: float):
	if now() >= self._timeout:
		stop()

# 当前时间点（秒）
func now() -> float:
	return OS.get_system_time_msecs() / 1000.0

func save() -> Dictionary:
	return { timeout = self._timeout }

func load(data: Dictionary):
	self._timeout = data.timeout
