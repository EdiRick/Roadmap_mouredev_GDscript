extends Node

class AnimalMal:
	var nombre:StringName

	func _init(_nombre:StringName):
		nombre = _nombre

	func caminar():
		printerr("No puede")

	func volar():
		printerr("No puede")

	func nadar():
		printerr("No puede")

class MalTerrestre extends AnimalMal:
	func caminar():
		print("el %s camina" % nombre)

class MalAcuatico extends AnimalMal:
	func nadar():
		print("el %s nada" % nombre)

class MalAereo extends AnimalMal:
	func volar():
		print("el %s vuela" % nombre)

# |-------------------------------------------|

class Animal:
	var nombre:StringName
	func _init(_nombre:StringName):
		nombre = _nombre

class Aereo extends Animal:
	func volar():
		print("El %s vuela" % nombre)

class Terrestre extends Animal:
	func caminar():
		print("El %s camina" % nombre)

class Acuantico extends Animal:
	func nadar():
		print("El %s nada" % nombre)

func _ready():
	var pez = MalAcuatico.new("Pez")
	pez.caminar()
	pez.nadar()
	pez.volar()
	var ave = MalAereo.new("Ave")
	ave.caminar()
	ave.nadar()
	ave.volar()
	var perro = MalTerrestre.new("Perro")
	perro.caminar()
	perro.nadar()
	perro.volar()
# |-------------------------------------------|
	pez = Acuantico.new("Pez")
	pez.nadar()
	ave = Aereo.new("Ave")
	ave.volar()
	perro = Terrestre.new("Perro")
	perro.caminar()

# EJERCICIO EXTRA

	var impresora_bn = ImpresoraBYN.new()
	impresora_bn.imprimir("doc.pdf")

	var impresora_color = ImpresoraColor.new()
	impresora_color.imprimir("doc.pdf")

	var impresora_multi = ImpresoraMulti.new()
	impresora_multi.imprimirBN("doc.pdf")
	impresora_multi.imprimirColor("doc.pdf")
	impresora_multi.escanear("doc.pdf")
	impresora_multi.enviar_fax("doc.pdf")

class BlancoYNegro:
	static func imprimir(documento:StringName):
		print("Se esta imprimiendo en N/B: %s" % documento)

class color:
	static func imprimir(documento:StringName):
		print("Se esta imprimiendo en color: %s" % documento)

class Escaner:
	static func escanear(documento:StringName):
		print("Se esta escaneando: %s" % documento)

class Fax:
	static func enviar_fax(documento:StringName):
		print("Se esta enviando: %s" % documento)

class ImpresoraBYN:
	func imprimir(documento:StringName):
		BlancoYNegro.imprimir(documento)

class ImpresoraColor:
	func imprimir(documento:StringName):
		color.imprimir(documento)

class ImpresoraMulti:
	func imprimirBN(documento:StringName):
		BlancoYNegro.imprimir(documento)

	func imprimirColor(documento:StringName):
		color.imprimir(documento)

	func escanear(documento:StringName):
		Escaner.escanear(documento)

	func enviar_fax(documento:StringName):
		Fax.enviar_fax(documento)
