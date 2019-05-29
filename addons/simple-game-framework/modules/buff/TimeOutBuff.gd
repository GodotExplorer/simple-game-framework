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

# @class `TimeOutBuff`
# TimeOutBuff 类
# 限时Buff， `duration` 时间内有效，超时自动停止效果
# 时间限制指的是逻辑更新时间，因此游戏暂停或玩家离线时时间是静止的，逻辑恢复更新后继续计时

tool
extends Buff
class_name TimeOutBuff

# 超时时长(秒)
var duration = 5
# 剩余时间(秒)
var time_left = 0 setget set_time_left, get_time_left
# 已经开始的时间(秒)
var _started_duration = 0
# 设置剩余时间(秒)
func set_time_left(v: float):
	self._started_duration = duration - v
# 获取剩余时间(秒)
func get_time_left() -> float:
	return duration - self._started_duration

func on_start():
	self.time_left = duration

func update(dt: float):
	_started_duration += dt
	if _started_duration >= duration:
		stop()

func save() -> Dictionary:
	return { started_duration = self._started_duration }

func load(data: Dictionary):
	self._started_duration = data.started_duration
