extends Module

func initialize():
	game.modules.daily.add_daliy_task(self, 'once_a_day')

func start():
	print("Test module started")
	
func once_a_day():
	print("hello today is ", OS.get_date())

func save():
	return {
		'TestData': 'Hello save Data'
	}

func load(data):
	pass