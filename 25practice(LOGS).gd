extends Node

func _ready():
	print_debug("Programa Funcional!")
	push_warning("PELIGRO")
	printerr("ERROR")
	push_error("CRITICAL")

# EJERCICIO EXTRA
	var lista:Object = GestionDeTareas.new()
	print(lista.ver_tareas())
	lista.eliminar_tarea("Cafe")
	lista.agregar_tarea("Helado", "Comprar helados")
	lista.agregar_tarea("Helado", "Comprar cafe")
	lista.eliminar_tarea("Helado")
	print(lista.ver_tareas())

class GestionDeTareas:

	static var log_debug:Callable = func(function:Callable, error:bool = false, message:String = ""):
		if error:
			printerr("%s %s %s" % [Time.get_time_string_from_system(), function.get_method(), message])
		else:
			print("Funcionando: %s %s" % [Time.get_time_string_from_system(), function.get_method()])
	var tareas:Dictionary[StringName, String] = {}

	func ver_tareas():
		if tareas.is_empty():
			log_debug.call(ver_tareas, true, "No hay tareas")
			return null
		else:
			log_debug.call(ver_tareas)
			return tareas

	func agregar_tarea(tarea:StringName, desc:String):
		if tareas.has(tarea):
			log_debug.call(agregar_tarea, true, "Ya existe la tarea")
		else:
			tareas.set(tarea, desc)
			log_debug.call(agregar_tarea)

	func eliminar_tarea(tarea:StringName):
		if tareas.has(tarea):
			tareas.erase(tarea)
			log_debug.call(eliminar_tarea)
		else:
			log_debug.call(eliminar_tarea, true, "NO existe la tarea")
