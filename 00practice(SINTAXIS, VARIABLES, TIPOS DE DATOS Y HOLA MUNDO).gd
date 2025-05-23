extends Node

# //gdscript.com/

# Comentario de una sola linea

"""
Comentario
De
Varias
lineas
"""

# Variables y Constantes
var variable = 1 # Variable
const constante = 2 # Constante

# Tipos de Datos Primitivos
# Enteros(int)
var a:int = 10
var b:int = -6

# Flotantes(floot)
var c:float = 3.1416

# Buleanos(bool)
var d:bool = false
var e:bool = true
var f:bool = 64 # Cualquier numero que sea diferente de 0, sera verdadero
var g:bool = 0

# Cadena de Caracteres(String)
var h:String = "Hola mundo!"
var i:String = "Hola Godot!"

# Ejecucion
func _ready(): # Necesario para imprimir o ejecutar una funcion o String
	var j:String = "GDscript"
	print("Hola, " + j)
