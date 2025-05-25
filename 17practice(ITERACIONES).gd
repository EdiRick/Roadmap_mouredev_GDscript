extends Node

func iterator(from:int, to:int) -> int:
	if from >= to:
		return from
	print(from)
	return iterator(from + 1, 10)

func _ready():
	for i in 10:
		print(i + 1)

	var num:int = 0 
	while num < 10:
		num += 1
		print(num)

	print(iterator(1, 10))

# EJERCICIO EXTRA
	for i in "123":
		print(i)

	for i in range(1, 4):
		print(i)

	for i in [1, 2, 3]:
		print(i)

	for i in {1: "a", 2: "b", 3: "c"}:
		print(i)

	for i in range(1, 11): print(i)
