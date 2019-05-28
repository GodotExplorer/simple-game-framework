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
extends Reference
class_name Handler

# 回调方法
var method: String = ""
# 回调附加参数
var arguments = []
# 回调对象
var target: Object = null setget _set_target, _get_target
var _target_instance_id = 0
func _set_target(target: Object):
	_target_instance_id = 0 if target == null else target.get_instance_id()
func _get_target() -> Object:
	return instance_from_id(_target_instance_id)
	
# 调用回调函数，参数形式同 `callv`
func call_func(params = []):
	var args = []
	if typeof(params) == TYPE_ARRAY:
		for p in params: args.append(p)
	else:
		args.append(params)
	for p in self.arguments:
		args.append(p)
	var obj = self.target
	if obj:
		return obj.callv(self.method, args)
	elif OS.is_debug_build():
		assert(false) # The caller of this handler is already released
	return null
