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

# @class `Messenger`
# 消息调度器，允许添加监听所有时间的监听器

tool
extends EventEmitter
class_name Messenger
const utils = preload("res://addons/gdutils/utils/__init__.gd")

# 监听器接口类
class IMessageListerner:
	func on_event(type: String, data):
		pass

var _listeners = []

# 添加监听器  
# - - - - - - - - - -  
# *Parameters*  
# * [lisener: Object] 监听器，实现了 IMessageListerner 的类对象  
func add_lisener(lisener: Object):
	if utils.implements(lisener, IMessageListerner):
		_listeners.append(lisener)

# 移除监听器
func remove_lisener(lisener: Object):
	if lisener in _listeners:
		_listeners.erase(lisener)

# 移除所有监听器	
func remove_all_liseners():
	self._listeners = []

# 派发事件  
# - - - - - - - - - -  
# *Parameters*  
# * [type: String] 事件类型  
# * [params: Variant = null] 事件参数  
#
func emit(type: String, params = []):
	for listener in _listeners:
		listener.on_event(type, params)
	.emit(type, params)
