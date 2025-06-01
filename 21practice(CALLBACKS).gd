extends Node

func callback(funcion: Callable, arg1: Variant, arg2: Variant):
	print(funcion.call(arg1, arg2))

func suma(num1: float, num2: float):
	return num1 + num2

func _ready():
	callback(suma, 7, 5)

# EJERCICIO EXTRA
	order("Arroz con pollo", confirm, done, delivered)
	order("Papas fritas", confirm, done, delivered)
	order("Pizza", confirm, done, delivered)
	order("Hamburguesa", confirm, done, delivered)

func order(plate: StringName, _confirm: Callable, _done: Callable, _delivered: Callable):
	print("Plato en preparacion: %s" % plate)
	for funcion in [_confirm, _done, _delivered]:
		await get_tree().create_timer(float(randi_range(1, 10))).timeout
		funcion.call(plate)

func confirm(plate: StringName): print("Plato listo: %s" % plate)

func done(plate: StringName): print("Plato entregandose a la mesa: %s" % plate)

func delivered(plate: StringName): print("Plato entregado con exito: %s" % plate)
