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
class_name Serializer

# 序列化脚本对象数组
static func serialize_instances(arr_inst) -> Dictionary:
	# Map<GDScript, ID>
	var classes = {}
	# Map<ID, Dictionary>
	var classes_serialized = {}
	# 存档数据
	var item_list = []
	var idx = 0
	for item in arr_inst:
		var type = item.get_script()
		if not classes.has(type):
			var dict = inst2dict(item)
			classes[type] = idx
			classes_serialized[idx] = {
				"path": dict["@path"],
				"subpath": dict["@subpath"],
			}
			idx += 1
		var item_data = {
			"type": classes[type],
			"data": item.save()
		}
		item_list.append(item_data)
	return {
		"types": classes_serialized,
		"items": item_list
	}


# 实例化脚本对象数组
static func unserialize_instances(data: Dictionary):
	var insts = []
	var classes = {}
	for id in data.types:
		var base = load(data.types[id].path)
		var script = base
		if not data.types[id].subpath.empty():
			script = base.get(data.types[id].subpath)
		classes[int(id)] = script
	for conf in data.items:
		var inst = classes[int(conf.type)].new()
		inst.load(conf.data)
		insts.append(inst)
	return insts
