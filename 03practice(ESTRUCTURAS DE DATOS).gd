extends Node

func _ready():
# ESTRUCTURAS DE DATOS
	# Arreglo
	var animales:Array = [
		"perro",
		"gato",
		"loro"
	]
	print(animales)
		# Agregar
	animales.append("tigre")
	print(animales)
		# Eliminar
	animales.erase("loro")
	print(animales)
		#Actualizar
	animales[0] = "lobo"
	print(animales)
		#Ordenar
	animales.sort()
	print(animales)

	# Diccionario
	var datos:Dictionary = {
		"nombre" : "Carlos",
		"apellido" : "Torres",
		"edad" : 26
	}
	prints(datos.keys(), datos.values()) # Claves y Valores
		# Agregar Claves y Valores
	datos.set("altura", 1.64)
	prints(datos.values(), datos.keys())
		# Agregar Claves
	datos.get_or_add("peso")
	print(datos.keys())
		# Agregar o Actualizar Valores
	datos.altura = 1.74 # Estas 2 formas son validades para agregar o actualizar valores
	datos["peso"] = 75
	print(datos.values())
		# Eliminar Claves con su Valor
	datos.erase("edad")
	prints(datos.keys(), datos.values())
		# Eliminar Valores
	datos["apellido"] = null
	print(datos.values())
		# Ordenar
	datos.sort()
	print(datos)
	
# EJERCICIO EXTRA
	contactosApp()

var nombres:Array = [
	"pepe",
]
var numeros:Array = [
	"2731813",
]
var textos:Array = [
	"Introduce un Contacto o Numero",
	"Introduce el nuevo numero",
	"Elige un Contacto o Numero para eliminarlo",
	"Elige un Contacto para editarlo",
]

# Ejecutores
var terminal:Node = Node2D.new()
var next:Node = Button.new()
var entrada:Node = TextEdit.new()
var notificador:Node = Label.new()
 
	# Variables Generales
var lugar:int
var propiedad

	# Funcion Buscar
var buscar:Node = Node2D.new()
var contactoEncontrado:Node = Label.new()

	# Funcion Agregar
var agregar:Node = Node2D.new()
var nuevoContacto:Node = Label.new()

	# Funcion Eliminar
var eliminar:Node = Node2D.new()
var contactoEliminado:Node = Label.new()

	# Funcion Editar
var editar:Node = Node2D.new()
var contactoEditado:Node = Label.new()

	# Funcion Extra 
var edit:Node = Node2D.new()
var contactoEdit:Node = Label.new() 

func contactosApp():
	add_child(terminal)

	notificador.text = "Inserte un comando:"
	terminal.add_child(notificador)

	entrada.size = Vector2(150, 30)
	entrada.position.y = 35
	terminal.add_child(entrada)

	next.text = "Aceptar"
	next.position.y = 70
	next.connect("pressed", selector)
	terminal.add_child(next)

	contactoEncontrado.position.x = 150
	buscar.add_child(contactoEncontrado)

	nuevoContacto.position.x = 150
	agregar.add_child(nuevoContacto)

	contactoEliminado.position.x = 150
	eliminar.add_child(contactoEliminado)

	contactoEditado.position.x = 150
	editar.add_child(contactoEditado)

func selector():
	match entrada.text:
		"1", "Buscar":
			conector(buscador, buscar, contactoEncontrado, 0)
		"2", "Agregar":
			conector(agregador, agregar, nuevoContacto, 1)
		"3", "Eliminar":
			conector(eliminador, eliminar, contactoEliminado, 2)
		"4", "Editar":
			conector(editador, editar, contactoEditado, 3)
		"5", "Salir":
			get_tree().quit()
		_:
			notificador.text = "Inserte un comando valido!"
			entrada.text = ""

func conector(funcion:Callable, nodo:Node, texto:Label, numeroDelTexto:int):
	texto.text = textos[numeroDelTexto]
	entrada.text = ""
	next.connect("pressed", funcion)
	next.disconnect("pressed", selector)
	terminal.remove_child(notificador)
	add_child(nodo)

func reconector(funcion: Callable, nodo:Node):
	notificador.text = "Inserte un comando:"
	terminal.add_child(notificador)
	remove_child(nodo)
	entrada.text = ""
	next.disconnect("pressed", funcion)
	next.connect("pressed", selector)

func buscador():
	match entrada.text:
		"":
			pass
		"0", "Atras":
			reconector(buscador, buscar)
		_:
			if entrada.text in nombres:
				lugar = nombres.find(entrada.text)
				contactoEncontrado.text = nombres[lugar] + " : " + numeros[lugar]
			elif entrada.text in numeros:
				lugar = numeros.find(entrada.text)
				contactoEncontrado.text = nombres[lugar] + " : " + numeros[lugar]
			else:
				contactoEncontrado.text = "Este contacto no existe"
			entrada.text = ""

func agregador():
	match entrada.text:
		"":
			pass
		"0":
			reconector(agregador, agregar)
		_:
			if entrada.text[-1] in "1234567890" and entrada.text[0] in "1234567890":
				if len(entrada.text) <= 11:
					numeros.append(entrada.text)
					nuevoContacto.text = " * Agrega un Nombre : * " + numeros[-1]
				else:
					nuevoContacto.text = "Numero invalido"
			else:
				nombres.append(entrada.text)
				nuevoContacto.text = "Contacto guardado con exito: " + nombres[-1] + " : " + numeros[-1]
			entrada.text = ""

func eliminador():
	match entrada.text:
		"":
			pass
		"0", "Atras":
			reconector(eliminador, eliminar)
		_:
			if entrada.text in nombres:
				lugar = nombres.find(entrada.text)
				contactoEliminado.text = "El contacto: " + nombres[lugar] + ", de numero: " + numeros[lugar] + ". Ha sido elimando con exito"
				nombres.erase(nombres[lugar])
				numeros.erase(numeros[lugar])
			elif entrada.text in numeros:
				lugar = numeros.find(entrada.text)
				contactoEliminado.text = "El contacto: " + nombres[lugar] + ", de numero: " + numeros[lugar] + ". Ha sido elimando con exito"
				nombres.erase(nombres[lugar])
				numeros.erase(numeros[lugar])
			else:
				contactoEliminado.text = "Este contacto no existe"
			entrada.text = ""

func editador():
	match entrada.text:
		"":
			pass
		"0", "Atras":
			reconector(editador, editar)
		_:
			if entrada.text in nombres:
				lugar = nombres.find(entrada.text)
				contactoEditado.text = "Editar el contacto: " + nombres[lugar] + ", de numero: " + numeros[lugar]
				next.disconnect("pressed", editador)
				next.connect("pressed", editor)
			elif entrada.text in numeros:
				lugar = nombres.find(entrada.text)
				contactoEditado.text = "Editar el contacto: " + nombres[lugar] + ", de numero: " + numeros[lugar]
				next.disconnect("pressed", editador)
				next.connect("pressed", editor)
			else:
				contactoEditado.text = "Este contacto no existe"
			entrada.text = ""

func editor():
	match entrada.text:
		"":
			pass
		"0", "Atras":
			reconector(editor, editar)
		"1", "Nombre":
			propiedad = nombres
			contactoEditado.text = "Editar el contacto: " + nombres[lugar]
			next.disconnect("pressed", editor)
			next.connect("pressed", editorDePropiedades)
		"2", "Numero":
			propiedad = numeros
			contactoEditado.text = "Editar el numero: " + numeros[lugar]
			next.disconnect("pressed", editor)
			next.connect("pressed", editorDePropiedades)
		_:
			contactoEditado.text = "Comando Invalido"
	entrada.text = ""

func editorDePropiedades():
	match entrada.text:
		"":
			pass
		"0", "Atras":
			reconector(editor, edit)
		_:
			propiedad[lugar] = entrada.text
			contactoEditado.text = "Editar el contacto: " + nombres[lugar] + ", de numero: " + numeros[lugar]
			next.disconnect("pressed", editorDePropiedades)
			next.connect("pressed", editor)
