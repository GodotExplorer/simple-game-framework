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
class_name AchievementModule

# Array<Achievement>
var active_achievements = []
var accomplished_achievements = []

# 达成成就
signal accomplish(achievement)

# 添加成就
func add_achivement(achiv: Achievement):
	if achiv.accomplished:
		accomplished_achievements.append(achiv)
	else:
		achiv.once("accomplish", self, "on_achievement_accomplished", [achiv])
		achiv.watch_events()
		active_achievements.append(achiv)

func update(dt):
	for a in active_achievements:
		a.update(dt)

func on_achievement_accomplished(a: Achievement):
	active_achievements.erase(a)
	accomplished_achievements.append(a)
	emit("accomplish", a)
	emit_signal("accomplish", a)
	

func save() -> Dictionary:
	var achievements = active_achievements + accomplished_achievements
	var data = Serializer.serialize_instances(achievements)
	return data

func load(data: Dictionary):
	var achievements = Serializer.unserialize_instances(data)
	for a in achievements:
		add_achivement(a)
