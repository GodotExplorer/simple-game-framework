# 代表游戏中的一种状态、如 中毒、短暂的攻击力加强效果 等

tool
extends EventEmitter
class_name Buff

signal started()
signal stopped()

const Events = {
	STARTED = "started",
	STOPPED = "stopped",
}

# 外部 read only 是否已经开始
var _started = false

# 是否正在运行
func is_running() -> bool:
	return _started

# 获取 Buff 类型
func get_type():
	return get_script()

# 开始
func start():
	if not _started:
		on_start()
		_started = true
		emit("started")
		emit_signal("started")

# 停止
func stop():
	if _started:
		on_stop()
		_started = false
		emit("stopped")
		emit_signal("stopped")

# Buff 启动回调
func on_start():
	pass

# Buff 结束回调
func on_stop():
	pass

# 逻辑帧更新
func update(dt):
	pass

func save() -> Dictionary:
	return {}
	
func load(data: Dictionary):
	pass
