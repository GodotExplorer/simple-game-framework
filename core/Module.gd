# 逻辑模块
# 代表一个逻辑功能，例如成就、商店、战斗等

tool
extends EventEmitter
class_name Module

# 所有模块创建完毕后执行
func setup() -> void:
	pass

# 模块是否准备就绪
func is_ready() -> bool: 
	return true

# 初始化模块
func initialize() -> void:
	pass

# 模块开始
func start() -> void:
	pass

# 恒更新，不考虑逻辑是否初始化完毕或暂停等逻辑，固定每帧调用
func process(dt: float) -> void:
	pass

# 逻辑更新
func update(dt: float) -> void:
	pass

# 存档
func save() -> Dictionary :
	return {}

# 读档
func load(data: Dictionary) -> void:
	pass

