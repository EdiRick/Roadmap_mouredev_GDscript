extends Node

# CLASES
class type:
	var dispositivo:String = "Ninguno"
	var motor:String
	var version:float
	func _init(engine:String = "Ninguno", update:float = 0.0):
		motor = engine
		version = update
	func thisprint():
		print("Motor: {0} | version: {1} | Dispositivo: {2} ".format([motor, version, dispositivo]))

func _ready():
	var tipo:Object = type.new("Godot", 4.4)
	tipo.dispositivo = "Android"
	tipo.thisprint()
	tipo.version = 4.3
	tipo.thisprint()

# EJERCICIO EXTRA
	ejercicio()

class stacks:
	var stack:Array
	func _init(_stack:Array):
		self.stack = _stack

	func add(element:String = ""):
		if element.is_empty():
			print("Ningun elemento se añadio a la pila")
		else:
			print("Se añadio el elemento {0} a la pila".format([element]))
			self.stack.append(element)

	func delete():
		print("Se elimino el elemento {0} de la cola".format([self.stack.pop_back()]))

	func allprint():
		print("Elementos de la pila son: {0}".format([str(self.stack)]))

	func count() -> int:
		return len(self.stack)

class queues:
	var queue:Array
	func _init(_queue:Array):
		self.queue = _queue

	func add(element:String = ""):
		if element.is_empty():
			print("Ningun elemento se añadio a la cola")
		else:
			print("Se añadio el elemento {0} a la cola".format([element]))
			self.queue.append(element)

	func delete():
		print("Se elimino el elemento {0} de la cola".format([self.queue.pop_front()]))

	func allprint():
		print("Elementos de la cola son: {0}".format([str(self.queue)]))

	func count() -> int:
		return len(self.queue)

func ejercicio():
	var Engines:Array = [
		"Godot",
		"Unity",
		"Unreal",
		"GameMaker"
	]
	var Lenguajes:Array = [
		"C",
		"C#",
		"Python",
		"JavaScript",
		"GDscript"
	]

	var pila:Object = stacks.new(Engines)
	pila.add("Cocos2D")
	pila.allprint()
	pila.delete()
	pila.allprint()
	print(pila.count())

	var cola:Object = queues.new(Lenguajes)
	cola.add("Java")
	cola.allprint()
	cola.delete()
	cola.allprint()
	print(cola.count())
