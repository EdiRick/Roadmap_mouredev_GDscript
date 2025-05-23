extends Node

# Variables que nos serviran como ejemplos
var e1:String = "24"
var e2:String = "3.14159"
var e3:String = "Godot"
var e4:String = "GDscript"
var e5:String = "hola GODOT"
var e6:Array[String] = [
	"Godot",
	"GDscript",
]
var e7:Dictionary = {
	"motor" : "Godot",
	"lenguaje" : "GDscript"
}

func _ready():
# CADENA DE CARACTERES (String)
	# Concadenacion
	print(e6[0] + " " + e6[1])

	# Igualdad
	print("GDscript" == e4)

	# Desigualdad
	print("Godot" != e4)

	# Indexacion
	print(e4[0] + e4[1] + e4[2] + e4[3] + e4[4] + e4[5] + e4[6] + e4[7])

	# Tamaño de la Cadena
	print(len(e4))

	# Slicing desde la izquierda y derecha
	print(e4.left(2))
	print(e4.right(6))

	# Busqueda
	print(e4[2])

	# Reemplazar
	print(e5.replace("Godot", "GDscript"))

	# Division
	print(e5.split(" ", false, 2))

	# Mayusculas y Minusculas
	print(e5.to_upper())
	print(e5.to_lower())
	print(e5.capitalize())

	#Eliminacion de espacios
	print(" Nodo ".strip_edges(true ,true))

	# Busqueda por Posicion
	print(e4.find("s"))

	# Formateo
	print("Estamos usando el motor: {0} Engine, y el lenguaje: {1}".format(e6))
	print("Motor: {motor} Engine, Lenguaje: {lenguaje}".format(e7))

	# Transformacion de Arreglo a Cadena
	print(" - ".join(e6))

	# Transformadores
	print(e1.to_int())
	print(int(e1))
	print(e2.to_float())
	print(float(e2))

	# Verificadores
	print(e1.is_valid_int())
	print(e2.is_valid_float())
	print(e3.is_valid_ascii_identifier())
	print("Ñandu".is_valid_unicode_identifier())

# EJERCICIO EXTRA:
	verificadorDePalabras("radar", "Tango")

func verificadorDePalabras(word1:String, word2:String):
	
	print("¿{0} es Palindroma? {1}".format([word1, word1.to_lower() == word1.to_lower().reverse()]))
	print("¿{0} es Palindroma? {1}".format([word2, word2.to_lower() == word2.to_lower().reverse()]))
	print("¿{0} y {1} son Anagramas entre si? {2}".format([word1, word2, Convert(word1) == Convert(word2)]))
	print("¿{0} es Isograma? {1}".format([word1, Contador(word1)]))
	print("¿{0} es Isograma? {1}".format([word2, Contador(word2)]))

func Convert(word:String) -> String:
	var wordConvert:Array = word.to_lower().split("", false)
	wordConvert.sort()
	return "".join(wordConvert)

func Contador(word:String) -> bool:
	for letter in word.to_lower():
		if word.count(letter) > 1:
			return false
		else:
			pass
	return true
