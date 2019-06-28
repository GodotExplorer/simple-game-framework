# 回调函数

tool
extends Reference
class_name Handler

var method: String = ""	# 回调方法
var arguments = []		# 回调附加参数
var target: Object = null setget _set_target, _get_target # 回调对象

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
