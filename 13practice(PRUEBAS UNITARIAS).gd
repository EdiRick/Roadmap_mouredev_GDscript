extends Node

func suma(a:float, b:float) -> float:
	return a + b

func test_sum():
	assert(suma(4, 3) == 7)
	assert(suma(3, -5) == -2)

func _ready():
	test_sum()

# EJERCICIO EXTRA
	ejercicio()

var datos:Dictionary = {
	"nombre" : "EdiRick",
	"edad" : 18,
	"fecha de nacimiento" : "**/**/07",
	"lenguajes" : ["GDscript", "Python", "JavaScript"]
}

func ejercicio():
	test_dict()

func test_dict():
	assert(typeof(datos["nombre"]) == TYPE_STRING and !datos["nombre"].is_empty(), "No se agrego un nombre")
	assert(typeof(datos["edad"]) == TYPE_INT and datos["edad"] > 0, "No se agrego una edad")
	assert(typeof(datos["fecha de nacimiento"]) == TYPE_STRING and !datos["fecha de nacimiento"].is_empty(), "No se agrego una fecha de nacimiento")
	assert(typeof(datos["lenguajes"]) == TYPE_ARRAY and !datos["lenguajes"].is_empty(), "No se agrego lenguajes")
