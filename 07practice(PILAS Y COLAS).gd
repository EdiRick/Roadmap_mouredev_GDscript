extends Node

func _ready():
# PILAS Y COLAS
	# Pilas o Stacks (LIFO)
	var stack:Array = []

		# Push
	stack.push_back(10)
	stack.push_back(20)
	stack.push_back(30)
	print(stack)

		# Pop
	print(stack.pop_back())
	print(stack)

	# Cola o Queue (FIFO)
	var queue:Array = []

		# Push
	queue.push_front(30)
	queue.push_front(20)
	queue.push_front(10)
	print(queue)

		# Pop
	print(queue.pop_front())
	print(queue)
	print("x{0}".format(["d".repeat(19)]))

# EJERCICIO EXTRA
	ejercicio()
var general:Node2D = Node2D.new()
var accept:Button = Button.new()
var input:TextEdit = TextEdit.new()
var txt:Label = Label.new()
var title:Label = Label.new()
var advertence:Label = Label.new()
var timeAdvertence:Timer = Timer.new()
var cases:Array = [
	[
		"Selector",
		"Abrir Navegador web(1) o Impresora(2). Salir(0)",
	],
	[
		"Navegador Web",
		"Agrega un Url, Siguiente(1), Atras(2). Regresar(0)"
	],
	[
		"Impresora",
		"Agrega un archivo, Imprimir(1). Regresar(0)"
	]
]
var corrector:Callable = func() -> String:
	var info:String = input.text
	input.text = ""
	if info.is_valid_int():
		return info
	elif info == "":
		return ""
	else:
		return (info[0].to_upper() + info.right(len(info) - 1).to_lower()).strip_edges()
var conexion:Callable = func(off:Callable, on:Callable, num:int = 0):
	title.text = cases[num][0]
	txt.text = cases[num][1]
	accept.disconnect("pressed", off)
	accept.connect("pressed", on)
var selector:Callable = func():
	match corrector.call():
		"1", "Navegador web":
			conexion.call(selector, navegadorWeb, 1)
		"2", "Impresora":
			conexion.call(selector, impresora, 2)
		"0", "Salir":
			inicio.call()
		_:
			advertence.visible = true
			timeAdvertence.start()
var inicio:Callable = func(present:Callable = selector):
	if accept.is_connected("pressed", selector):
		get_tree().quit()
	else:
		conexion.call(present, selector, 0)
var alert:Callable = func():
	advertence.visible = false
	timeAdvertence.stop()

func ejercicio():
	general.position = Vector2(200, 200)
	add_child(general)

	accept.connect("pressed", selector)
	timeAdvertence.connect("timeout", alert)

	title.text = cases[0][0]
	txt.text = cases[0][1]
	accept.text = "Aceptar"
	advertence.text = "Comando inexistente!"

	input.size = Vector2(250, 30)
	input.scale = Vector2(2,2)
	title.scale = Vector2(4,4)
	txt.scale = Vector2(2,2)
	accept.scale = Vector2(2,2)
	advertence.scale = Vector2(2,2)

	txt.position.y = 80
	accept.position.y = 210
	input.position.y = 140
	advertence.position = Vector2(510, 140)

	advertence.visible = false
	timeAdvertence.wait_time = 1.5

	general.add_child(title)
	general.add_child(advertence)
	general.add_child(timeAdvertence)
	general.add_child(accept)
	general.add_child(input)
	general.add_child(txt)

# Navegador Web
var pages:Array = []

func navegadorWeb():
	var data = "http://" + input.text.to_lower().replace(" ", "_") + "//"
	match corrector.call():
		"1", "Atras":
			pages.push_back(pages[0])
			txt.text = "Navegando en {0}".format([pages.pop_front()])
		"2", "Siguiente":
			pages.push_front(pages[-1])
			txt.text = "Navegando en {0}".format([pages.pop_back()])
		"0", "Regresar":
			inicio.call(navegadorWeb)
		_:
			txt.text = "Nueva pagina agregada: {0}".format([data])
			pages.append(data)

# Impresora
var pdfs:Array = []

func impresora():
	var data = input.text.to_lower().replace(" ", "_") + ".pdf"
	match corrector.call():
		"1", "Imprimir":
			if pdfs.is_empty():
				txt.text = "No hay mas archivos por imprimir"
			else:
				txt.text = "Imprimiendo: {0}".format([pdfs.pop_front()])
		"0", "Regresar":
			inicio.call(impresora)
		_:
			txt.text = "Archivo por imprimir: {0}".format([data])
			pdfs.append(data)
