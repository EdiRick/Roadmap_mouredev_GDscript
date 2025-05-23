extends Node

# FUNCIONES
	# Funcion Ready
func _ready(): # Funcion necesaria para ejecutar algun codigo o funcion
	# Sin Parametros
	a()
	print(b())
	# Con Parametros
	c("Hola mundo!")
	print(d("Hola", "mundo!"))
	e()
	h(["mundo", "GDscript", "Godot"])
	# Funciones Existentes 
	identificador(true)
	contadorDeString("Godot")
	# Variables Globales y Locales
	imprimir()
	# EJERCICIO EXTRA
	print(ejercicio("Es multiplo de 3", "Es multiplo de 5"))
	

	# Funcion Sin Parametros
func a():
	print("Hola mundo!")

	# Funcion con retorno
func b():
	return "Hola mundo!"

	# Funcion con Parametro
func c(saludo):
	print(saludo)

	# Funcion con Parametros y Retorno
func d(hola, mundo):
	return hola + " " + mundo

	# Funcion con Parametros Predeterminados 
func e(hola = "Sin datos", mundo = "Sin datos"):
	prints(hola, mundo)

	# Funcion con Multiples Argumentos
func h(nombres):
	for nombre in nombres:
		print("Hola " + nombre + "!")

	# Algunas Funciones Existentes en el Propio Lenguaje
func identificador(valor): # typeof()
	if typeof(valor) == TYPE_INT:
		print("Entero")
	elif typeof(valor) == TYPE_FLOAT:
		print("Flotante")
	elif typeof(valor) == TYPE_STRING:
		print("Cadena de texto")
	elif typeof(valor) == TYPE_BOOL:
		print("Booleano")
	else:
		print("Valor nulo")

func contadorDeString(word:String): #len()
	print(len(word))

# Variables Globales y Locales
	#Globales
var x = true
var y = 32

	# Locales
func imprimir():
	var m = 4
	var n = "GDscript"
	prints(x, y, m, n)

# EJERCICIO EXTRA
func ejercicio(texto1:String, texto2:String) -> int:
	var z = 0
	for i in range(1, 101):
		if i % 3 == 0 and i % 5 == 0:
			prints(texto1, texto2)
		elif i % 3 == 0:
			print(texto1)
		elif i % 5 == 0:
			print(texto2)
		else:
			print(i)
			z += 1
	return z
