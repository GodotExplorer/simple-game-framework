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

# @class `Achievement`
# 成就

tool
extends EventEmitter
class_name Achievement

signal accomplish()

const Events = {
	ACCOMPLISH =  "accomplish",
}

enum CheckType { FRAME, EVENT }

var check_type = CheckType.EVENT	# 检查条件的时机
var accomplished = false			# 是否已经完成
var condition: Condition = null		# 完成条件
# 寄存器
var register: ValueEvaluator.Register = ValueEvaluator.Register.new()

func update(dt):
	if check_type == CheckType.FRAME:
		_check_condition()

# 绑定要监听的事件
func start_listen_events():
	pass

# 解绑监听的事件
func stop_listen_events():
	pass

func _check_condition():
	if not accomplished:
		if condition.is_true():
			accomplished = true
			emit(Events.ACCOMPLISH)
			emit_signal(Events.ACCOMPLISH)

func save() -> Dictionary:
	return {
		'accomplished': self.accomplished,
		'register': self.register.values,
	}

func load(data: Dictionary):
	accomplished = data.accomplished
	register.values = data.register
