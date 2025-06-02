extends Node

# > Para crear un Sigleton en Godot tienes que agregar un script a
# > Proyecto > Configuracion del Proyecto > Globales > Autoload y agregas tu script como global
# > En este caso crearemos una clase como Sigleton

class Sigleton: # -> Todo el contenido de la clase sera como el contenido del script
	static var puntos:int = 0 # -> La palabra reservada "static" la usaremos para simular un Sigleton y asi no crear un Objeto

	static func aumentar_puntos(mas:int = 1):
		puntos += mas

func _ready():
	Sigleton.aumentar_puntos(5)
	print(Sigleton.puntos)

# EJERCICIO EXTRA

	print(Usser_new.iniciar(112, "Carlos213", "Carlos", "carlos332@gmail.com"))
	print(Usser_new.obtener_datos())
	print(Usser_new.eliminar_datos())
	print(Usser_new.obtener_datos())

class Usser_new:
	static var id:int
	static var nombre_de_usuario:StringName
	static var nombre:StringName
	static var email:String

	static func iniciar(_id:int, _nombre_de_usuario:StringName, _nombre: StringName, _email:String):
		id = _id
		nombre_de_usuario = _nombre_de_usuario
		nombre = _nombre
		email = _email
		return "Se agrego al usuario: %s (%s) | ID: %03d | Correo: %s" % [nombre, nombre_de_usuario, id, email]

	static func obtener_datos():
		if id > 0 and !nombre_de_usuario.is_empty() and !nombre.is_empty() and !email.is_empty():
			return "Nombre: %s | Nombre de usuario: %s | ID: %03d | Correo: %s" % [nombre, nombre_de_usuario, id, email]
		else:
			return "No hay datos"

	static func eliminar_datos():
		id = 0
		nombre_de_usuario = ""
		nombre = ""
		email = ""
		return "Datos eliminados"
