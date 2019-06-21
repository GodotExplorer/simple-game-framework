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

# @class `TimerBuff`
# TimerBuff 类
# 限时Buff， 指定时刻之前有效，超时自动停止效果
# 时间指的是真实时间，因此不受游戏暂停或玩家离线等条件的影响，超过指定时间后失效

tool
extends Buff
class_name TimerBuff

# 剩余时间(秒)
var time_left = 0 setget set_time_left, get_time_left

# 设定时长，启动后修改无效
var duration = 5

# 结束时刻
var _timeout: float = 0

# 设置剩余时间(秒)
func set_time_left(v: float):
	self._timeout = now() + v

# 获取剩余时间(秒)
func get_time_left() -> float:
	return self._timeout - now()

func on_start():
	self.time_left = duration

func update(dt: float):
	if now() >= self._timeout:
		stop()

# 当前时间点（秒）
func now() -> float:
	return OS.get_system_time_msecs() / 1000.0

func save() -> Dictionary:
	return { timeout = self._timeout }

func load(data: Dictionary):
	self._timeout = data.timeout
