extends Node
class_name MemoryGameGlobal

static var instance:
	get:
		if(instance == null):
			instance = MemoryGameGlobal.new()
		return instance

var iq = 100
