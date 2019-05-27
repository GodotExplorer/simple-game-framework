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

tool
extends Module
class_name UtilsModule

var last_daily_check_time = 0
var daily_tasks = []

# 现在时刻
func now() -> Dictionary:
	return OS.get_datetime()

func _daily_check():
	var date = OS.get_datetime_from_unix_time(last_daily_check_time)
	var now = now()
	if date.year != now.year or date.month != now.month or date.day != now.day:
		for fun in daily_tasks:
			fun.call_func()
	self.last_daily_check_time = OS.get_unix_time_from_datetime(now())

func start():
	_daily_check()
	
# 添加每天执行一次的任务
func add_daliy_task(task: FuncRef):
	daily_tasks.append(task)

func save() -> Dictionary:
	return {
		last_daily_check_time = self.last_daily_check_time
	}
	
func load(data: Dictionary):
	self.last_daily_check_time = data.last_daily_check_time
