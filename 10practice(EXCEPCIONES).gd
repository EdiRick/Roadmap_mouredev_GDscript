extends Node

"""
EXCEPCIONES:
En este ejercicio se hara de una manera diferente que en otros lenguajes,
ya que en GDscript NO existe una estructura como tal para controlar errores, solo prevenirlas.
En este caso usaremos las estructuras que tenemos en el lenguaje para evitar estos errores
"""
func dividir(a:int, b:int):
	if a == 0 or b == 0:
		printerr("No se puede dividir")
		return null
	else:
		return float(a)/b

func indexList(list:Array, index:int):
	if len(list) <= index:
		printerr("No existe el elemento")
		return null
	else:
		return list[index]

func _ready():
	print(dividir(1, 0))
	print(dividir(40, 8))
	print(indexList([1, 2, 3], 2))
	print(indexList(["Swift", "Python", "C+", "Java"], 5))

# EJERCICIO EXTRA
	ejercicio()

func ejercicio():
	print(parammeters([2, 5, 1, 10], 3, 1))
	print(parammeters([7.5, 3.14159, 1.5, 112.2], 0, 2))
	print(parammeters([35, 23, 76], 4, 1))
	print(parammeters([2, "GDscript"], 0, 1))
	print(parammeters([2, 0], 0, 1))
	print("Programa Finalizado")

func parammeters(list:Array, x:int, y:int):
	if len(list) <= x or len(list) <= y:
		printerr("Elemento inexistente")
		return null
	elif verificador(list):
		printerr("NO es un numero")
		return null
	elif list[x] == 0 or list[y] == 0:
		printerr("Indivisible")
		return null
	else:
		print("No ocurrio ningun error")
		return float(list[x])/(list[y])

func verificador(list:Array) -> bool:
	for element in list:
		if typeof(element) in [TYPE_INT, TYPE_FLOAT]:
			pass
		else:
			return true
	return false
