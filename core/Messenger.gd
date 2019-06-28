# 消息调度器，允许添加监听所有类型事件的监听器

tool
extends EventEmitter
class_name Messenger
const utils = preload("../utils.gd")

# 监听器接口类
class IMessageListerner:
	# 时间监听回调
	func on_event(type: String, data):
		pass

# 监听器列表 Array<IMessageListerner>
var _listeners = []

# 添加监听器  
# - - - - - - - - - -  
# *Parameters*  
# * [lisener: Object] 监听器，实现了 IMessageListerner 的类对象  
func add_lisener(lisener: Object):
	if utils.implements(lisener, IMessageListerner):
		_listeners.append(lisener)

# 移除监听器
func remove_lisener(lisener: Object):
	if lisener in _listeners:
		_listeners.erase(lisener)

# 移除所有监听器	
func remove_all_liseners():
	self._listeners = []

# 派发事件  
# - - - - - - - - - -  
# *Parameters*  
# * [type: String] 事件类型  
# * [params: Variant = null] 事件参数  
#
func emit(type: String, params = []):
	for listener in _listeners:
		listener.on_event(type, params)
	.emit(type, params)
