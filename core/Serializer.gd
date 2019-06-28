# 数据序列化相关模块

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
