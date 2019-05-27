##################################################################################
#                        Tool generated DO NOT modify                            #
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

# @class `EventEmitter`
# 基础事件管理器

tool
extends Reference
class_name EventEmitter

# 事件回调对象
class EventHandler:
	var type: String = ""
	var target: Object = null
	var method: String = ""
	var one_shot = false
	var arguments = []
	
	# 调用回调函数，参数形式同 `callv`
	func call_func(params = null):
		var args = []
		if typeof(params) == TYPE_NIL:
			args = self.arguments
		else:
			if typeof(params) == TYPE_ARRAY:
				for p in params: args.append(p)
			else:
				args.append(params)
			for p in self.arguments:
				args.append(p)
		return self.target.callv(self.method, args)

# 事件回调表
# Map<String, EventHandler[]>
var _event_handlers = {}

# 派发事件  
# - - - - - - - - - -  
# *Parameters*  
# * [type: String] 事件类型  
# * [params: Variant = null] 事件参数  
#
func emit(type: String, params = null):
	if type in _event_handlers:
		var remove_handlers = []
		var handlers = _event_handlers[type]
		for handler in handlers:
			handler.call_func(params)
			if handler.one_shot:
				remove_handlers.append(handler)
		for rh in remove_handlers:
			handlers.erase(rh)

# 添加事件侦听  
# - - - - - - - - - -  
# *Parameters*  
# * [type:String] 事件类型  
# * [target:Object] 回调对象  
# * [method: String] 回调方法  
# * [arguments: Array] 绑定的参数，会展开并传递到回调方法的末尾参数  
# - - - - - - - - - -  
# *Returns* EventHandler  
# * 返回事件回调对象，可用于取消回调
func on(type: String, target: Object, method: String, arguments = []) -> EventHandler:
	var handler = EventHandler.new()
	handler.type = type
	handler.target = target
	handler.method = method
	handler.one_shot = false
	handler.arguments = arguments
	if type in _event_handlers:
		_event_handlers[type].append(handler)
	else:
		_event_handlers[type] = [handler]
	return handler

# 添加只执行一次的回调事件  
# - - - - - - - - - -  
# *Parameters*  
# * [type:String] 事件类型  
# * [target:Object] 回调对象  
# * [method: String] 回调方法  
# * [arguments: Array] 绑定的参数，会展开并传递到回调方法的末尾参数  
# - - - - - - - - - -  
# *Returns* EventHandler  
# * 返回事件回调对象，可用于取消回调
func once(type: String, target: Object, method: String, arguments = []) -> EventHandler:
	var handler = self.on(type, target, method, arguments)
	handler.one_shot = true
	return handler

# 取消事件侦听  
# - - - - - - - - - -  
# *Parameters*  
# * [handler: EventHandler] 要取消的侦听器  
func off(handler: EventHandler):
	if handler.type in _event_handlers:
		var handlers = _event_handlers[handler.type]
		if handler in handlers:
			handlers.erase(handler)

# 取消所有事件侦听器  
func off_all():
	_event_handlers = {}
