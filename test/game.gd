extends SimpleGameFramework
const TestModule = preload("TestModule.gd")
var timer = TimerModule.new()
func _init():
	add_module('daily', DailyTask.new())
	add_module('timer', timer)
	add_module('test', TestModule.new())
	add_module('energe', GamePoint.new())
	add_module('buff', BuffModule.new())
	add_module('achievement', AchievementModule.new())
	timer.once(3, self, 'timer_func_once')
	timer.loop(2, self, 'timer_func_loop')


func _ready():
	# var TestBuff = preload("res://test/test_buff.gd")
	var TestBuff = preload("res://test/test_buff.gd")
	# game.modules.achievement.add_achivement(ClickAchievement.new())
	# self.modules.buff.add_buff(Buff.new())
	# self.modules.buff.add_buff(TestBuff.MyBuff.new())
	# self.modules.buff.add_buff(TimeOutBuff.new())
	# self.modules.buff.add_buff(TimerBuff.new())

func timer_func_loop(handler):
	printt('timer loop', handler.repeat)
	if handler.repeat >= 5:
		timer.cancel(handler)

func timer_func_once(handler):
	printt('timer once')

func _process(dt):
	logic_update(dt)

class ClickAchievement extends Achievement:
	func _init():
		condition = BuiltinConditions.GreaterEqualCondition.new()
		condition.register = self.register
		condition.params = ['click_count', 5]
		self.register.values.click_count = 0
	func watch_events():
		game.messenger.on('click', self, "_on_click")
	func _on_click():
		self.register.values.click_count += 1
		self._check_condition()