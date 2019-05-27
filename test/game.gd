extends SimpleGameFramework
const TestModule = preload("TestModule.gd")
var timer = TimerModule.new()
func _init():
	add_module('utils', UtilsModule.new())
	add_module('timer', timer)
	add_module('test', TestModule.new())
	timer.once(3, self, 'timer_func_once')
	timer.loop(2, self, 'timer_func_loop')

func timer_func_loop(handler):
	printt('timer loop', handler.repeat)
	if handler.repeat >= 5:
		timer.cancel(handler)

func timer_func_once(handler):
	printt('timer once')

func _process(dt):
	logic_update(dt)
	