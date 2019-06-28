# 游戏点数，可用于如 体力 金币 等相关的数值记录
# 支持按固定时间间隔自动获得奖励

tool
extends GamePoint
class_name AutoIncreasedGamePoint

signal point_filled()					# 充满点数
var point_max = 100						# 设计最大点数
var auto_charge_interval: float = 10	# 点数自动恢复的时间间隔
var auto_charge_amount: float = 2		# 自动恢复点数量
var auto_charge_on_paused = true		# 暂停游戏时是否允许自动加点数
var _last_auto_charge_time = 0

var _initialized = false
func initialize():
	_last_auto_charge_time = now()
	_initialized = true

func process(dt):
	if auto_charge_on_paused and (SimpleGameFramework.get_singeleton() as SimpleGameFramework).paused:
		_frame_auto_charge()

func update(dt):
	_frame_auto_charge()

func now() -> float:
	return OS.get_system_time_msecs() / 1000.0


# 充值点数，不会超过上限
func charge(amount):
	set_point(min(point_max, point + amount))

# 重置为最大值
func fill():
	set_point(max(point_max, point))
	emit_signal("point_filled")

# 自动奖励点数的速度
func get_auto_charge_speed() -> float:
	return auto_charge_amount / auto_charge_interval

# 获取下一次自动获得收益的时刻
func get_next_auto_charge_time() -> float:
	return _last_auto_charge_time + auto_charge_interval

# 获取下一次自动收益的时间间隔
func get_next_auto_charge_duration() -> float:
	return get_next_auto_charge_time() - now()

# 获得指定时间的收益
func _charge_for_duration(duration):
	var auto_charge_count = floor(duration / auto_charge_interval)
	var amount = auto_charge_count * auto_charge_amount
	charge(amount)
	var uncounted_duration = duration - auto_charge_count * auto_charge_interval
	_last_auto_charge_time = now() - uncounted_duration

# 离线收益
func _offline_point_reward(duration):
	_charge_for_duration(duration)

func _frame_auto_charge():
	if not _initialized: return
	var now = now()
	var duration = now - _last_auto_charge_time
	if duration >= auto_charge_interval:
		_charge_for_duration(duration)

func save() -> Dictionary:
	var data = .save()
	data.last_charge_time = _last_auto_charge_time
	return data

func load(data: Dictionary):
	.load(data)
	_offline_point_reward(now() - data.last_charge_time)
