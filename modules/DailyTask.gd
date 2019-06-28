# 每日任务模块， 所有注册的回调函数会在每天第一次运行游戏时被执行一次

tool
extends Module
class_name DailyTask

var last_run_task_time = 0

# Array<Handler> 回调函数
var tasks = []
# Array<Date> 执行记录
var records = []

func now():
	return OS.get_unix_time()

func _daily_check():
	var date = OS.get_datetime_from_unix_time(last_run_task_time)
	var today = OS.get_datetime()
	return date.year != today.year or date.month != today.month or date.day != today.day

func _run_tasks():
	for fun in tasks:
		fun.call_func()
	last_run_task_time = now()
	records.append(last_run_task_time)

func start():
	if _daily_check():
		_run_tasks()
	
# 添加每天执行一次的任务
func add_daliy_task(target: Object, method: String, arguments = []):
	var handler: Handler = Handler.new()
	handler.target = target
	handler.method = method
	handler.arguments = arguments
	tasks.append(handler)

# 一共运行过多少天（累计启动游戏的天数）
func get_total_run_count() -> int:
	return records.size()

# 最近连续运行多少天(连续进入游戏的天数)
func get_continuous_run_count() -> int:
	var ret = 1
	if records.size() > 1:
		var next_day = records[-1]
		for i in range(2, records.size() + 1):
			var cur_day = records[-i]
			var duration = next_day - cur_day
			if duration > 60 * 60 * 24:
				break
			else:
				ret += 1
				next_day = cur_day
	return ret
	
func save() -> Dictionary:
	return { records = records }

func load(data: Dictionary):
	records = data.records
	if records.size() > 0:
		last_run_task_time = records[-1]
