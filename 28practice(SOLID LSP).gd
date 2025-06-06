extends Node

class operedor:
	func _init():
		if ![TYPE_FLOAT, TYPE_INT].has(typeof(operacion(1, 1))):
			push_error("Funcion invalida")

	func operacion(_a, _b): return null

class error extends operedor:
	func operacion(_a = null, _b = null) -> String:
		return "Hola mundo"

class suma extends operedor:

	func operacion(a:float , b:float) -> float: return a + b

func _ready():
	var operacionErronea = error.new()
	print(operacionErronea.operacion())
	print("")
	var sum = suma.new()
	print(sum.operacion(10, 4))

# EJERCICIO EXTRA

	var bici = Bicicleta.new(3)
	bici.acelerar()
	bici.acelerar()
	bici.frenar()
	bici.frenar()
	var carro = Auto.new(2)
	carro.acelerar()
	carro.frenar()
	carro.frenar()
	var moto = Motocicleta.new(4)
	moto.acelerar()
	moto.acelerar()
	moto.acelerar()
	moto.frenar()

class vehiculo:
	var aranque:int
	var velocidad:int = 0
	var movimiento:bool = false

	func _init(_aranque):
		aranque = _aranque

	func acelerar(ac:int):
		if !movimiento:
			movimiento = true
		velocidad += ac * aranque
		print("En movimiento a %dkm/h" % velocidad)

	func frenar(ac:int):
		if movimiento and velocidad > 0:
			velocidad -= ac * aranque
			print("Bajando la velocidad a %dkm/h" % velocidad)
		else:
			print("Esta quieto")

class Bicicleta extends vehiculo:
	func acelerar(_ac:int = 2):
		super(_ac)

	func frenar(_ac:int = 2):
		super(_ac)

class Auto extends vehiculo:
	func acelerar(_ac:int = 3):
		super(_ac)

	func frenar(_ac:int = 3):
		super(_ac)

class Motocicleta extends vehiculo:
	func acelerar(_ac:int = 4):
		super(_ac)

	func frenar(_ac:int = 4):
		super(_ac)
