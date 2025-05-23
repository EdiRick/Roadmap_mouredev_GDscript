extends Node

func _ready():
	var x # -> Variable General

# OPERADORES
	# Operadores de Asignacion
		# Igualdad(=)
	x = 24
	print(x)

		# Adicion(+=)
	x = 12
	x += 12
	print(x)

		# Sustraccion(-=)
	x = 30
	x -= 6
	print(x)

		# Multiplicacion(*=)
	x = 8
	x *= 3
	print(x)

		# Division(/=)
	x = 48
	x /= 2
	print(x)

		# Resto(%=)
	x = 60
	x %= 36
	print(x)

		# Potencia(**=)
	x = 4.9
	x **= 2
	print(x)

	# Operadores Aritmeticos
		# Adicion(+)
	x = 8 + 16
	print(x)

		# Sustraccion(-)
	x = 30 - 6
	print(x)

		# Multiplicacion(*)
	x = 6 * 4
	print(x)

		# Division(/)
	x = 72 / 3.0 # Identificar como flotante o agregar .0 en cualquier numero para evitar una advertencia de error
	print(x)

		# Resto(%)
	x = 60 % 36
	print(x)

		# Potencia(**)
	x = 4.9 ** 2
	print(x)

	# Operadores de Comparacion
		# Mayor y Menor(> y <)
	x = 3 > 1
	print(x)
	x = 4 < 1
	print(x)

		# Igual o Mayor y Igual o Menor(>= y <=)
	x = 4 >= 4
	print(x)
	x = 3 <= 1
	print(x)

		# Igualdad y Desigualdad(== y !=)
	x = 2 == 2
	print(x)
	x = "e" != "e"
	print(x)

	# Operadores Logicos
		# Conjuncion(and o &&)
	x = 8 < 10 and 4 == 4
	print(x)
	x = 2 != 2 && "hello" == "hola"
	print(x)

		# Disyuncion(or o ||)
	x = 3 == 3 or 2 != 2
	print(x)
	x = 4 == 3 || 2 > 6
	print(x)

		# Negacion(not o !)
	x = not true == false
	print(x)
	x = !true != false
	print(x)

	# Operadores de Pertenencia
		# Pertenece(in)
	x = "Godot" in "Hola Godot!"
	print(x)

		# No Pertenece(not in)
	x = "4" not in "1024"
	print(x)

	# Operadores con Bits
		# Negacion(~)
	x = ~-25
	print(x)

		# Desplazamientos de Bits hacia la Izquierda y Derecha (<< y >>)
	x = 3 << 3
	print(x)
	x = 96 >> 2
	print(x)

		# Disyuncion o AND(&)
	x = 90 & 156
	print(x)

		# Conjuncion o OR(|)
	x = 24 | 0
	print(x)

		# Bicondicional o XOR(^)
	x = 105 ^ 113
	print(x)

		# Atajos de tareas(&=, |= y ^=) -> Estos atajos funcionan como los Operadores de Asignacion 
	x = 90
	x &= 156
	print(x)
	x = 24
	x |= 0
	print(x)
	x = 105
	x ^= 113
	print(x)

# ESTRUCTURAS DE CONTROL
	# Condicional
		# if(condicion)
	var edad = randi_range(1,70) # -> Genera un numero aleatorio desde el 1 hasta al 70
	if edad < 18:
		print("Es menor de edad")

		# elif(condicion) -> Solo se utiliza cuando quieres poner mas condiciones
	elif edad < 45:
		print("Es mayor de edad")

		# else
	else:
		print("Es de edad avanzada")

	# Bucles o Iteradores
		# for -> Solo itera listas o rangos 
	for i in 8:
		print(i)

		# while(condicion) -> Itera siempre cuando la condicion sea verdadera
	var a = 0
	while a < 4:
		print(a)
		a += 1

	# Control de Flujo
		# break
	for j in "GodotFalse":
		if j == "F":
			break
		print(j)

		# continue
	for k in "GDescript":
		if k == "e":
			continue
		print(k)

		#pass
	if "a" != "t":
		pass

	# Excepciones
		# match
	var b = ["Facebook", "Instagram", "x", "WhatsApp", 3 , true]
	var c = b[randi_range(0,5)]
	match c:
		"Facebook":
			print("Usas Facebook")
		"Instagram":
			print("Usas Instagram")
		"x":
			print("Usas X")
		"WhatsApp":
			print("Usas WhatsApp")
		_:
			print("No Registrado")

# EJERCICIO EXTRA
	for l in range(10, 56, 2):
		if l == 16 or l % 3 == 0:
			continue
		print(l)
