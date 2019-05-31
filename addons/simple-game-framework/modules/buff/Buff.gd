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

# @class `Buff`
# Buff 类
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
