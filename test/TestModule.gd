extends Module

func initialize():
	game.modules.utils.add_daliy_task(funcref(self, 'once_a_day'))

func start():
	print("Test module started")
	
func once_a_day():
	print("hello today is ", game.modules.utils.now())

func save():
	return {
		'TestData': 'Hello save Data'
	}

func load(data):
	pass