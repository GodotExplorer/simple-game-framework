# 简单的游戏框架

一个模块化的GDScript游戏逻辑框架。

## 现在支持的模块：
* 游戏存档/读档
* 游戏点数（可用于体力、游戏中的金币）
* Buff
* 成就
* 每日任务（可用于登陆奖励）
* 定时器

## 今后还会支持的功能
* 道具模块
* 背包模块
* 任务模块
* 带分支剧情

所有提供的内置模块功能都可以扩展和替换。

## 如何搭建框架
1. 拷贝 `simple-game-framework` 目录到 `res://addons` 内
2. 创建一个继承自 `SimpleGameFramework` 的脚本类，并将其添加为 `autoload` 单例。
3. 添加所需的内置模块
4. 实现你自己的`Module`并添加到框架中

如下为一个`game.gd`示例，可将其添加为全局单例 `game`
```gdscript
extends SimpleGameFramework
func _init():
	add_module('daily', DailyTask.new())
	add_module('timer', TimerModule.new())
	add_module('energe', GamePoint.new())
	add_module('buff', BuffModule.new())
	add_module('achievement', AchievementModule.new())

func _process(dt):
	logic_update(dt)
```

这样你就可以在任何地方使用框架和各个模块

```gdscript
# 每60秒存档一次
game.modules.timer.loop(60, game, "save")
```