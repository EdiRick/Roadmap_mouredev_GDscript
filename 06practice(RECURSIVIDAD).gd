extends Node

func _ready():
	repeat(100)
	ejercicio()
# RECURSIVIDAD
func repeat(num:int):
	if num >= 0:
		print(num)
		repeat(num - 1)

# EJERCICIO EXTRA
func ejercicio():
	print(factory(3))
	print(fibonacci(5))

func factory(num:int) -> int:
	if num == 0:
		return 1
	elif num < 0:
		print("Es un numero negativo")
		return 0
	else:
		return num * factory(num - 1)

func fibonacci(num:int) -> int:
	if num <= 0:
		print("Es un menor o igual a 0")
		return 0
	elif num == 1:
		return 0
	elif num == 2:
		return 1
	else:
		return fibonacci(num - 2) + fibonacci(num - 1)
