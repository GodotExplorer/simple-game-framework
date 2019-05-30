##################################################################################
#                            This file is part of                                #
#                                GodotExplorer                                   #
#                       https://github.com/GodotExplorer                         #
##################################################################################
# Copyright (c) 2019 Godot Explorer                                              #
#                                                                                #
# Permission is hereby granted, free of charge, to any person obtaining a copy   #
# of this software and associated documentation files (the "Software"), to deal  #
# in the Software without restriction, including without limitation the rights   #
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      #
# copies of the Software, and to permit persons to whom the Software is          #
# furnished to do so, subject to the following conditions:                       #
#                                                                                #
# The above copyright notice and this permission notice shall be included in all #
# copies or substantial portions of the Software.                                #
#                                                                                #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  #
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  #
# SOFTWARE.                                                                      #
##################################################################################

# @class `SimpleGameFramework`
# 模块化游戏逻辑框架

tool
extends Node
class_name SimpleGameFramework

var modules = {}						# 模块容器
var paused = false						# 游戏暂停标记
var initialized = false 				# 是否初始化完毕标记
var setuped = false						# 是否 setup 完成标记
var request_save = false				# 是否需要执行存档
var messenger = Messenger.new() 		# 消息中枢
var evaluator = ValueEvaluator.new() 	# 表达式计算器

# 检查是否存在模块
func has_module(name: String) -> bool:
	return modules.has(name)

# 添加模块
func add_module(name: String, module: Module) -> bool:
	if module and module is Module:
		self.modules[name] = module
		return true
	return false

# 获取模块
func get_module(name: String) -> Module:
	if modules.has(name):
		return modules[name]
	return null

# 建立逻辑框架
func setup():
	print("启动逻辑框架");
	for name in self.modules:
		var m = self.modules[name]
		m.setup()
	setuped = true

# 初始化所有已添加的模块
func initialize() -> void:
	print("始化逻辑框架");
	for name in self.modules:
		var m = self.modules[name]
		m.initialize()
	initialized = true
	print("逻辑框架初始化完毕")

# 检查所有模块是否已经准备就绪
func is_ready() -> bool:
	for name in self.modules:
		var m = self.modules[name]
		if not m.is_ready():
			return false
	return true

# 启动所有模块
func start() -> void:
	print("启动各个逻辑模块");
	for name in self.modules:
		var m = self.modules[name]
		m.start()
	print("逻辑框架启动完毕")

# 忽略准备就绪和游戏暂停等标记，每帧对所有模块进行更新
func process(dt: float) -> void:
	for name in self.modules:
		var m = self.modules[name]
		m.process(dt)

# 执行逻辑帧迭代
func update(dt: float) -> void:
	for name in self.modules:
		var m = self.modules[name]
		m.update(dt)

# 抽象帧迭代
func logic_update(dt: float):
	process(dt)
	if not paused and (initialized or is_ready()):
		if not initialized:
			initialize()
			self.load()
			start()
		update(dt)
	if request_save:
		save()
		request_save = false

# 请求执行存档操作
func queue_save():
	request_save = true;

# 读档
func load():
	var data = raw_load()
	for name in data:
		if self.modules.has(name):
			var m = self.modules[name]
			m.load(data[name])

# 存档
func save() -> Dictionary:
	var data: Dictionary = {}
	for name in self.modules:
		var m = self.modules[name]
		var module_data = m.save()
		if not module_data.empty():
			data[name] = module_data
	raw_save(data)
	return data

# 存档实现
func raw_save(data: Dictionary):
	var f = File.new()
	if OK == f.open("user://game.json", File.WRITE):
		f.store_string(JSON.print(data, "\t", true))
	f.close()

# 加载存档的实现
func raw_load() -> Dictionary:
	var result = {}
	var f = File.new()
	if OK == f.open("user://game.json", File.READ):
		var ret = JSON.parse(f.get_as_text())
		if ret.error == OK and ret.result is Dictionary:
			result = ret.result
	f.close()
	return result

func _ready():
	setup()

func _exit_tree():
	save()
