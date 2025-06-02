extends Node

func suma(a: float, b:float): return a + b
func resta(a: float, b:float): return a - b
func multiplicacion(a: float, b:float): return a * b
func division(a: float, b:float): return a / b

func operacion(operador: Callable, a: float, b: float): return operador.call(a, b)

func _ready():
	print(operacion(suma, 15, 12))
	print(operacion(resta, 53, 23))
	print(operacion(multiplicacion, 5, 12))
	print(operacion(division, 169, 13))

# EJERCICIO EXTRA

	print("\nPromedios:")
	for estudiante in estudiantes.map(info):
		print(plantilla % estudiante)

	print("\nMejores Estudiantes:")
	for estudiante in estudiantes.filter(func(estudiante): return estudiante["notas"].reduce(promedio) >= 9):
		print(plantilla % [estudiante["nombre"], estudiante["notas"].reduce(promedio)])

	estudiantes.sort_custom(func(a, b): return a["fecha de nacimiento"][0] > b["fecha de nacimiento"][0])
	print("\nMenor a Mayor:")
	for estudiante in estudiantes:
		print("\tAlumno: %s" % estudiante["nombre"])

	var alumnos = estudiantes.map(info)
	alumnos.sort_custom(func(a, b): return a[1] > b[1])
	print("\nMejor Alumno:")
	print(plantilla % alumnos[0])

var plantilla:String = "\tAlumno: %s | Promedio: %04.1f"
var info:Callable = func(estudiante): return [estudiante["nombre"], estudiante["notas"].reduce(promedio)]
var promedio:Callable = func(acum, nota): return nota if acum == null else (acum + nota) / 2.0

var estudiantes:Array[Dictionary] = [
	{
		"nombre": "Carlos",
		"fecha de nacimiento": [2005, 05, 12],
		"notas": [07, 10, 07, 08, 08]
	},
	{
		"nombre": "Manuel",
		"fecha de nacimiento": [2007, 12, 30],
		"notas": [09, 06, 08, 07, 05]
	},
	{
		"nombre": "Fabricio",
		"fecha de nacimiento": [2008, 01, 25],
		"notas": [09, 10, 08, 10, 09]
	},
	{
		"nombre": "Andrea",
		"fecha de nacimiento": [2004, 07, 19],
		"notas": [10, 10, 10, 09, 10]
	},
	{
		"nombre": "Roberto",
		"fecha de nacimiento": [2006, 11, 20],
		"notas": [07, 08, 06, 09, 08]
	},
	{
		"nombre": "Margot",
		"fecha de nacimiento": [2009, 03, 14],
		"notas": [08, 08, 08, 07, 09]
	}
]
