extends Node

# En GDscript no hay forma de decorar funciones, solo simular

func decorador(funcion: Callable) -> Callable:
	
	return func():
		print("Se llamo a la funcion: %s" % funcion.get_method())
		funcion.call()

func funcion1():
	print("Ejecutando función 1")

func funcion2():
	print("Ejecutando función 2")

func funcion3():
	print("Ejecutando función 3")

func _ready():
	decorador(funcion1).call()
	decorador(funcion2).call()
	decorador(funcion3).call()

# EJERCICIO EXTRA
	counter(ejercicio1).call()
	counter(ejercicio1).call()
	counter(ejercicio1).call()
	counter(ejercicio1).call()
	counter(ejercicio2).call()
	counter(ejercicio2).call()
	counter(ejercicio2).call()
	counter(ejercicio3).call()
	counter(ejercicio3).call()

var funcion_counter:Dictionary[StringName, int] = {}

func counter(funcion:Callable) -> Callable:
	return func():
		funcion_counter[funcion.get_method()] += 1
		print("la funcion %s se llamo %d veces" % [funcion.get_method(), funcion_counter[funcion.get_method()]])
		funcion.call()

func ejercicio1(): pass
func ejercicio2(): pass
func ejercicio3(): pass
