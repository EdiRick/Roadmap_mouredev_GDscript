extends Node

func _ready():
	# VALORES Y REFERENCIAS
		# Tipos de Datos por Valores (int, float, bool, String, StringName)
	var e1 = 32
	var e2 = e1 + 16
	prints(e1, e2)
	var s1: = "Godot"
	var s2 = s1 + " Engine"
	prints(s1, s2)

		# Tipos de Datos por Referencia (Array, Dictionary, Object, Node, Resource, RefCounted, Callable, Signal)
	var a1 = [
		"up",
		"down",
	]
	var a11 = a1
	a11.append("right")
	prints(a1, a11)

	example1()
	example2()

# Modifcar por Valores
func example1():
	var e3 = 8
	mod1.call(e3)
	print(e3)
var mod1 = func(valor):
	valor = 16
	print(valor)

# Modificar por Referencia
func example2():
	var a2 = ["Godot", "Unity"]
	mod2.call(a2)
	a2.append("Unreal")
	print(a2)
var mod2 = func(datos):
	var datos1 = datos.duplicate()
	datos1.append("GameMaker")
	print(datos1)

# EJERCICIO EXTRA
	ejercicio()

var v1 = "GDscript"
var v2 = "C++"
var v1_1 = values(v1, v2)[0]
var v2_1 = values(v1, v2)[1]
var r1 = ["C", "Java", "Python"]
var r2 = ["Unity", "Cocos2D", "GameMaker"]
var r1_1 = reference(r1, r2)[0]
var r2_1 = reference(r1, r2)[1]

func ejercicio():
	prints(v1, v2, v1_1, v2_1)
	prints(r1, r2, r1_1, r2_1)

func values(valor1, valor2) -> Array:
	var block = valor1
	valor1 = valor2
	valor2 = block
	return [valor1, valor2]

func reference(referencia1:Array, referencia2:Array) -> Array:
	var block = referencia1.duplicate()
	referencia1 = referencia2.duplicate()
	referencia1.append("Godot")
	referencia2 = block.duplicate()
	referencia2.append("GDscript")
	return [referencia1, referencia2]
