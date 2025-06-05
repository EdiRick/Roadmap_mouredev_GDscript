extends Node

func llamador_erroneo(funcion:Callable, a:Variant, b:Variant):
	print(funcion.call(a, b))
	print("Hola mundo!")

func llamador_correcto(funcion:Callable, a:Variant, b:Variant):
	print(funcion.call(a, b))

func suma(a:float, b:float) -> float: return a + b
func resta(a:float, b:float) -> float: return a - b

func _ready():
	llamador_erroneo(suma, 12, 43)
	llamador_erroneo(resta, 45, 5)
	llamador_correcto(suma, 2, 87)
	llamador_correcto(resta, 12, 65)

# EJERCICIO EXTRA

	GestionDeLibrosErroneo.registrar_libro("Toda las sangres", "Jose Maria Arguedas", 100)
	GestionDeLibrosErroneo.registrar_libro("La Odisea", "Homero", 50)
	GestionDeLibrosErroneo.registrar_libro("La Metamorfosis", "Franz Kafka", 50)
	print("")
	GestionDeLibrosErroneo.registrar_usuario("Carlos", "carlos32@gmail.com")
	GestionDeLibrosErroneo.registrar_usuario("Mary", "maryluz@gmail.com")
	print("")
	GestionDeLibrosErroneo.prestar_libro("Toda las sangres", 0)
	GestionDeLibrosErroneo.prestar_libro("La Odisea", 1)
	GestionDeLibrosErroneo.prestar_libro("La Metamorfosis", "Mary")
	print("")
	GestionDeLibrosErroneo.devolver_libro("La Odisea", "Mary")
	print("")
	var user1 = Usuario.new("Carlos", "carlos234@gmail.com")
	var user2 = Usuario.new("Mary", "maryluz@gmail.com")
	print("")
	var libroA = Libro.new("Toda las sangres", "Jose Maria Arguedas", 10)
	var libroB = Libro.new("La Odisea", "Homero", 5)
	var libroC = Libro.new("La Metamorfosis", "Franz Kafka", 5)
	print("")
	GestionDeLibros.prestar_libro(user1, libroA)
	GestionDeLibros.prestar_libro(user1, libroC)
	GestionDeLibros.prestar_libro(user2, libroA)
	GestionDeLibros.prestar_libro(user2, libroB)
	print("")
	GestionDeLibros.devolver_libro(user1, libroB)
	GestionDeLibros.devolver_libro(user2, libroA)

class GestionDeLibrosErroneo:
	static var libros:Array[Dictionary]
	static var usuarios:Array[Dictionary]

	static func registrar_libro(titulo:StringName, autor:StringName, copias:int):
		if libros.map(func(libro):return libro["titulo"]).has(titulo):
			print("El libro %s ya esta registrado" % titulo)
		else:
			libros.append({
				"titulo": titulo,
				"autor": autor,
				"copias": copias
			})
			print("Se registro \"{titulo}\" de {autor}. Copias disponibles: {copias}".format(libros.back()))

	static func registrar_usuario(nombre:StringName, correo:String):
		if usuarios.map(func(usuario): return usuario["nombre"]).has(nombre):
			print("El usuario %s ya esta registrado" % nombre)
		else:
			usuarios.append({
				"nombre": nombre,
				"id": len(usuarios),
				"correo": correo
			})
			print("Se registro \"%s\"[Nº%04d] con Correo %s" % usuarios.back().values())

	static func prestar_libro(libro:StringName, usuario_id:Variant):
		var functions:Array[Callable] = [
			func(user): return [user["nombre"], user["id"]].has(usuario_id),
			func(lib): return lib["titulo"] == libro and lib["copias"] > 0
		]
		if usuarios.any(functions.front()):
			if libros.any(functions.back()):
				var index:Array = [usuarios.find_custom(functions.front()), libros.find_custom(functions.back())]
				usuarios[index.front()].get_or_add("libros", []).append(libro)
				libros[index.back()].set("copias", libros[index.back()].get("copias") - 1)
				print("Se presto el libro \"%s\" a %s[Nº%04d]" % [libro, usuarios[index.front()]["nombre"], usuarios[index.front()]["id"]])
			else:
				print("No existe el libro \"%s\" o se acabaron" % libro)
		else:
			print("Usuario Inexistente")

	static func devolver_libro(libro:StringName, usuario_id:Variant):
		var functions:Array[Callable] = [
			func(user): return [user["nombre"], user["id"]].has(usuario_id),
			func(lib): return lib["titulo"] == libro and lib["copias"] > 0
		]
		if usuarios.any(functions.front()):
			if libros.any(functions.back()):
				var index:Array = [usuarios.find_custom(functions.front()), libros.find_custom(functions.back())]
				usuarios[index.front()].get("libros").erase(libro)
				libros[index.back()].set("copias", libros[index.back()].get("copias") + 1)
				print("Se devolvio el libro \"%s\" por %s[Nº%04d]" % [libro, usuarios[index.front()]["nombre"], usuarios[index.front()]["id"]])
			else:
				print("No tienes el libro \"%s\"" % libro)
		else:
			print("Usuario Inexistente")

class Usuario:

	static var _num:int = 0
	var nombre:StringName
	var correo:String
	var id:int
	var libros:Array[StringName]

	func _init(_nombre:StringName, _correo:String):
		nombre = _nombre
		correo = _correo
		id = Usuario._num
		Usuario._num += 1
		print("Te Registraste con Exito:\n\tNombre: %s | Correo: %s | ID: Nº%04d" % [nombre, correo, id])

class Libro:

	var titulo:StringName
	var autor:StringName
	var copias:int

	func _init(_titulo:StringName, _autor:StringName, _copias:int):
		titulo = _titulo
		autor = _autor
		copias = _copias
		print("Libro registrado:\n\tNombre del Libro: %s | Autor: %s | Copias disponibles: %d" % [titulo, autor, copias])

class GestionDeLibros:

	static func prestar_libro(usuario:Usuario, libro:Libro):
		if libro.copias <= 0:
			print("NO hay copias disponibles")
		else:
			usuario.libros.append(libro.titulo)
			libro.copias -= 1
			print("%s llevo el libro %s\n\tCopias restantes: %d" % [usuario.nombre, libro.titulo, libro.copias])

	static func devolver_libro(usuario:Usuario, libro:Libro):
		if !usuario.libros.has(libro.titulo):
			print("No tienes el libro %s" % libro.titulo)
		else:
			usuario.libros.erase(libro.titulo)
			libro.copias += 1
			print("%s regreso el libro %s\n\tCopias restantes: %d" % [usuario.nombre, libro.titulo, libro.copias])
