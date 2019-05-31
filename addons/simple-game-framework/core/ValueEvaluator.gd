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
extends EventEmitter
class_name ValueEvaluator

const utils = preload("res://addons/gdutils/utils/__init__.gd")

# 求值公式接口
class IEvolutor:
	func has_value(prop) -> bool:
		return false
	func get_value(prop):
		return null

# 寄存器
class Register extends IEvolutor:
	var values = {}
	func has_value(prop) -> bool:
		return prop in values
	func get_value(prop):
		return values[prop]

# 求值公式表
# Array<IEvolutor>
var evolutors = []

# 计算值
func evalute(input):
	for e in evolutors:
		if e.has_value(input):
			return e.get_value(input)
	return input

# 添加公式
func add_evolutor(evolutor):
	if utils.implements(evolutor, IEvolutor):
		evolutors.append(evolutor)
