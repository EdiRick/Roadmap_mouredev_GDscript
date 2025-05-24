extends Node

func task(_name:StringName, time:float):
	print("Tarea en ejecucion: %s | Duracion: %.0fs" % [_name, time])
	await get_tree().create_timer(time).timeout
	print("Tarea %s finalizada" % _name)

func _ready():
	task("async", 3.0)

# EJERCICIO EXTRA
	task("A", 1)
	task("B", 2)
	await task("C", 3)
	task("D", 1)
