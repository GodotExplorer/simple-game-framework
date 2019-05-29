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

tool
extends Module
class_name TimerModule

class TimerHandler extends Handler:
	var check_time = 0.0
	var interval = 0.0
	var one_shot = false
	var repeat = 0
	func start():
		self.check_time = OS.get_system_time_msecs() / 1000.0 + self.interval

var _handlers = []

func loop(interval: float, target: Object, method: String, args = []) -> TimerHandler:
	var handler: TimerHandler = TimerHandler.new()
	handler.target = target
	handler.method = method
	handler.interval = interval
	handler.one_shot = false
	handler.start()
	_handlers.append(handler)
	return handler

func once(delay, target: Object, method: String, args = []) -> Handler:
	var handler: TimerHandler = loop(delay, target, method, args)
	handler.one_shot = true
	return handler
	
func cancel(timer: TimerHandler):
	if timer in _handlers:
		_handlers.erase(timer)

func clear():
	_handlers = []

# 恒更新，不考虑逻辑是否初始化完毕或暂停等逻辑，固定每帧调用
func process(dt: float) -> void:
	var removal_handlers = []
	var now = now()
	for h in _handlers:
		if h.check_time <= now:
			h.call_func(h)
			if h.one_shot:
				removal_handlers.append(h)
			else:
				h.repeat += 1
				h.start()
	for h in removal_handlers:
		_handlers.erase(h)

func now() -> float:
	return OS.get_system_time_msecs() / 1000.0
