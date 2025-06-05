extends Node

class SaludoErroneo:
	func _init():
		print("Hola mundo")

class _saludoErroneo extends SaludoErroneo:
	func _init():
		print("Hola GDscript")

class Saludo:
	func _init():
		print("Hello world")

class _Saludo extends Saludo:
	func language():
		print("Hello GDscript")

func _ready():
	var _saludoERROR = _saludoErroneo.new()
	print("")
	var saludo = _Saludo.new()
	saludo.language()

# EJERCICIO EXTRA:

	print(calculadora.operaciones())
	print(calculadora.operar("suma", 3, 6))
	print(calculadora.operar("resta", 34, 12))
	print(calculadora.operar("multiplicacion", 4, 7))
	print(calculadora.operar("division", 10, 2))
	print(calculadora.operar("potencia", 4, 2))
	calculadora.agregar_operacion("potencia", func(a:float, b:float): return a ** b)
	print(calculadora.operar("potencia", 4, 2))

class calculadora:

	static var _operaciones:Dictionary[StringName, Callable] = {
		"suma": func(a:float, b:float): return a + b,
		"resta": func(a:float, b:float): return a - b,
		"multiplicacion": func(a:float, b:float): return a * b,
		"division": func(a:float, b:float): return a / b,
	}

	static func agregar_operacion(operacion:StringName, funcion:Callable):
		_operaciones.set(operacion, funcion)

	static func operaciones() -> String:
		return JSON.stringify(_operaciones.keys(), "\t")

	static func operar(operacion:StringName, a:float, b:float):
		if _operaciones.has(operacion):
			return _operaciones[operacion].call(a, b)
		printerr("La operacion %s no existe" % operacion)
		return null
