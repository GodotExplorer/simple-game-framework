extends SimpleGameFramework
const TestModule = preload("TestModule.gd")

func _init():
	add_module('test', TestModule.new())
	add_module('utils', UtilsModule.new())
	

func _process(dt):
	logic_update(dt)
	