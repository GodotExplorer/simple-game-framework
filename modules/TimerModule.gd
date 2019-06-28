# 定时器模块

tool
extends Module
class_name TimerModule

# 更新模式
enum UpdateMode {
	PROCESS,
	UPDATE,
}

# 定时器
class TimerHandler extends Handler:
	var check_time = 0.0		# 触发时间
	var interval = 0.0			# 时间间隔
	var max_repeat = 0xFFFFFF	# 最大循环次数
	var params = []				# 自定义参数
	var repeat = 0 				# 当前重复次数

# Array<TimerHandler> 定时器列表
var _handlers = []
# 更新模式（在 `process` 中或 `update` 中更新定时器）
var update_mode = UpdateMode.PROCESS

# 创建无限循环定时器
# 需要通过 `cancel` 方法手动停止
# - - - - - - - - - -  
# *Parameters*  
# * [interval: float] 时间间隔
# * [target: Object] 回调对象
# * [method: String] 回调方法
# * [params: Variant] 自定义参数
# - - - - - - - - - -  
# *Returns* TimerHandler  
# * Return 返回创建的定时器对象
func loop(interval: float, target: Object, method: String, params = []) -> TimerHandler:
	var handler: TimerHandler = TimerHandler.new()
	handler.target = target
	handler.method = method
	handler.interval = interval
	handler.params = params
	handler.check_time = interval
	_handlers.append(handler)
	return handler

# 创建循环定时器
# - - - - - - - - - -  
# *Parameters*  
# * [interval: int] 重复次数
# * [interval: float] 时间间隔
# * [target: Object] 回调对象
# * [method: String] 回调方法
# * [params: Variant] 自定义参数
# - - - - - - - - - -  
# *Returns* TimerHandler  
# * Return 返回创建的定时器对象
func repeat(repeat: int, interval: float, target: Object, method: String, params = []) -> TimerHandler:
	var handler = loop(interval, target, method, params)
	handler.max_repeat = repeat
	return handler

# 创建只执行一次的定时器  
# - - - - - - - - - -  
# * [delay: float] 延迟时间
# * [target: Object] 回调对象
# * [method: String] 回调方法
# * [params: Variant] 自定义参数
# - - - - - - - - - -  
# *Returns* TimerHandler  
# * Return 返回创建的定时器对象
func once(delay, target: Object, method: String, params = []) -> Handler:
	return repeat(delay, 0, target, method, params)

# 取消定时器  
# - - - - - - - - - -  
# *Parameters*  
# * [timer: TimerHandler] 要取消的定时器
func cancel(timer: TimerHandler):
	if timer in _handlers:
		_handlers.erase(timer)

# 清空所有定时器
func clear():
	_handlers = []

# 更新定时器
func update_timers(dt):
	var removal_handlers = []
	for h in _handlers:
		h.check_time -= dt
		if h.check_time <= 0:
			h.call_func(h)
			h.repeat += 1
			if h.repeat >= h.max_repeat:
				removal_handlers.append(h)
			else:
				h.check_time = h.interval
	for h in removal_handlers:
		_handlers.erase(h)

func process(dt: float) -> void:
	if update_mode == UpdateMode.PROCESS:
		update_timers(dt)

func update(dt: float):
	if update_mode == UpdateMode.UPDATE:
		update_timers(dt)
	
