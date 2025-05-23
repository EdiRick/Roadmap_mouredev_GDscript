extends Node

# HERENCIA Y POLIMORFISMO
class animal:
	var name
	func _init(_name = ""):
		self.name = _name
	func sonido():
		print("*Sonido del animal*")

class dog extends animal:
	func sonido():
		print("Guau Guau!")
 
class cat extends animal:
	func sonido():
		print("Miau Miau!")

func _ready():
	var animals = [
		animal.new("//Animal//"),
		dog.new("Firulais"),
		cat.new("Michifuz")
	]
	for _animal in animals:
		_animal.sonido()

# EJERCICIO EXTRA
	ejercicio()

class employee:
	var ID
	var datos
	var list:Array = []
	func _init(id:int = 0, name:String = "Sin nombre"):
		ID = id
		datos = name

	func add(support:Object):
		print("{0} esta trabajando para {1}".format([support.datos, self.datos]))
		list.append(support)

class manager extends employee:
	func coordinateProjects():
		print("Coordina los proyectos de la empresa")

class projectManager extends employee:
	var proyect
	func _init(id:int = 0, name:String = "Sin nombre", work:int = 0):
		super(id, name)
		proyect = work

	func coordinateProject():
		print("Coordina el proyecto {0}".format([str(proyect)]))

class programmer extends employee:
	var lenguaje
	func _init(id:int = 0, name:String = "Sin nombre", _lenguaje:String = "Sin identificar"):
		super(id, name)
		self.lenguaje = _lenguaje

	func programming():
		print("{0} programa en {1}".format([self.datos, lenguaje]))

	func add(support:Object):
		print("Este empleado no puede reclutar a otros empleados. {0} no se agrego".format([support.datos]))

func ejercicio():
	var manager00:Object = manager.new(00, "Carlos")
	var projectManager01:Object = projectManager.new(01, "Mari", 1)
	var projectManager02:Object = projectManager.new(02, "Pedro", 1)
	var projectManager03:Object = projectManager.new(03, "Alex", 2)
	var programmer04:Object = programmer.new(04, "Andres", "C#")
	var programmer05:Object = programmer.new(05, "Karol", "Java")
	var programmer06:Object = programmer.new(06, "Matias", "R")
	var programmer07:Object = programmer.new(07, "Laura", "Python")

	manager00.coordinateProjects()
	projectManager01.coordinateProject()
	projectManager01.coordinateProject()
	programmer04.programming()

	manager00.add(projectManager01)
	manager00.add(projectManager02)
	projectManager01.add(programmer04)
	projectManager02.add(programmer05)
	projectManager03.add(programmer06)
	projectManager03.add(programmer07)
	programmer04.add(programmer07)

	for i in manager00.list:
		print(i.datos)
