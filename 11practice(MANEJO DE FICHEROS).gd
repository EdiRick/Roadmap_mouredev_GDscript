extends Node

# MANEJO DE FICHEROS

func _ready():
	var fichero = FileAccess.open("res://EdiRick.txt", FileAccess.WRITE)
	fichero.store_line("Nombre: EdiRick\nEdad: 17\nLenguaje: GDscript")
	fichero = FileAccess.open("res://EdiRick.txt", FileAccess.READ)
	print(fichero.get_as_text())
	fichero.close()
	DirAccess.open("res://").remove("EdiRick.txt")

# EJERCICIO EXTRA
	storeApp()

# UI
var app:Node2D = Node2D.new()
var UI:Array[Node] = [
	LineEdit.new(),
	Button.new(),
	Label.new(),
	Label.new(),
	Label.new(),
	Label.new(),
	Label.new(),
	Timer.new()
]
var UIcon:Array[LabelSettings] = [
	LabelSettings.new(),
	LabelSettings.new(),
	LabelSettings.new(),
	LabelSettings.new()
]
var txts:Array[String] = [
	"Elige una opcion:",
	"Elige un producto de la tienda:",
	"Elige un producto de la canasta:",
	"Elige un producto para devolverlo:",
	"Elige una cantidad(max. 15):"
]
var messages:Array[String] = [
	"Bienvenido",
	"Productos:",
	"Mi canasta:",
	"¿Aumentar?",
	"¿Devolver?",
	"¿Si?"
]
var option:Node2D = Node2D.new()
var stack:Array[Node2D] = [
	Node2D.new(),
	Node2D.new(),
	Node2D.new()
]
var foradd:Callable = func(on:bool = true, optionList:Array =[], menu:Node = option):
	var num:int = 0
	if menu.get_child_count(true) > 0:
		for child in menu.get_children(true):
			menu.remove_child(child)
	if on:
		for suboption in optionList:
			num += 1
			var child:Label = Label.new()
			menu.add_child(child)
			child.position.y = 25 * num
			if suboption == optionList[-1] && menu == option:
				child.text = "0. {0}".format([suboption])
			elif optionList == product.values():
				child.text = "{0}$".format([suboption])
			elif [value.call(1), value.call(2)].has(optionList):
				child.text = "{0}".format([suboption])
			else:
				child.text = "{0}. {1}".format([str(num), suboption])
	else:
		pass
var txtinput:Callable = func() -> int:
	var num = UI[0].text
	UI[0].clear()
	if num.is_valid_int():
		return int(num)
	else:
		return -1

# Funciones
var everyOptions:Array[Array] = [
	[
		"Consultar y Agregar al carrito",
		"Ver canasta",
		"Salir"
	],
	[
		"Modificar cantidad",
		"Devolver producto",
		"Regresar"
	],
	[
		"Regresar"
	]
]
var change:Callable = func(on:Callable = enter, off:Callable = enter, txt:int = 0, msg:int = 0, options:int = 2):
	UI[3].text = txts[txt]
	UI[5].text = messages[msg]
	foradd.call(true, everyOptions[options])
	UI[1].disconnect("pressed", off)
	UI[1].connect("pressed", on)
var back:Callable = func(off:Callable = enter, on:Callable = enter, optn:int = 0):
	if UI[1].is_connected("pressed", enter):
		UI[3].text = "Pasando por caja"
		UI[6].text = ""
		UI[4].visible = false
		UI[5].text = messages[2]
		UI[6].visible = true
		UI[6].position = Vector2(300, 60)
		app.remove_child(UI[0])
		app.remove_child(UI[1])
		foradd.call(false)
		loadtxt(len(UI[3].text))
		exitAndPay()
	else:
		UI[4].position = Vector2(300, 60)
		UI[4].visible = true
		UI[4].text = "¿Que desea comprar?"
		change.call(on, off, 0, -1,optn)
var funcion:bool = true
const space:StringName = " | "

#Productos
const product:Dictionary = {
	"Picafresa" : 1,
	"Bebida" : 3,
	"Emperator Cokie" : 8,
	"Prince Cokie" : 8,
	"Triki Trakes" : 8,
	"Pizza" : 25,
	"Cake" : 45,
	"Chicken n Papas" : 50
}
var myBasket:Array = []
var alone:int
var value:Callable = func(vlr:int) -> Array:
	var namesProducts:Array = []
	for thing in myBasket:
		var cut = thing.split(space, false)
		namesProducts.append(cut[vlr])
	return namesProducts
var read:Callable = func():
	var check = FileAccess.open("res://myBasket.txt", FileAccess.READ)
	while !check.eof_reached():
		var temp1 = check.get_line()
		if !temp1.is_empty():
			myBasket.append(temp1)
	check.close()
var list:Callable = func():
	for num in range(3):
		foradd.call(true, value.call(num), stack[num])
	UI[4].position.y = stack[0].get_children()[-1].get("position").y + 70
	var temp:int = 0
	for sum in value.call(2):
		temp += int(sum)
	UI[4].text = "Gasto Total: {0}$".format([str(temp)])
	myBasket.clear()

func storeApp():
	UI[0].max_length = 15
	UI[0].size = Vector2(200, 30)
	UI[0].position.y = 75
	app.add_child(UI[0])

	UI[1].connect("pressed", enter)
	UI[1].text = "Aceptar"
	UI[1].position.y = 110
	app.add_child(UI[1])

	UI[2].text = "TIENDA"
	UI[2].label_settings = UIcon[0]
	UIcon[0].font_size = 35
	app.add_child(UI[2])

	UI[3].text = txts[0]
	UI[3].position.y = 45
	app.add_child(UI[3])

	UI[4].text = "¿Que desea comprar?"
	UI[4].position = Vector2(300, 60)
	UI[4].label_settings = UIcon[1]
	UIcon[1].font_size = 20
	app.add_child(UI[4])

	UI[5].position = Vector2(300, 10)
	UI[5].text = messages[0]
	UI[5].label_settings = UIcon[2]
	UIcon[2].font_size = 30
	app.add_child(UI[5])

	UI[6].position.x = 300
	UI[6].visible = false
	UI[6].label_settings = UIcon[3]
	UIcon[3].font_size = 20
	app.add_child(UI[6])

	option.position.y = 135
	app.add_child(option)

	stack[0].position = Vector2(300, 30)
	app.add_child(stack[0])

	stack[1].position = Vector2(500, 30)
	app.add_child(stack[1])

	stack[2].position = Vector2(625, 30)
	app.add_child(stack[2])

	app.scale = Vector2(1.75, 1.75)
	app.position = Vector2(100, 100)
	add_child(app)

	foradd.call(true, everyOptions[0])

	var _file:FileAccess = FileAccess.open("res://myBasket.txt", FileAccess.WRITE)
	_file.close()

func enter():
	match txtinput.call():
		1:
			change.call(buy, enter, 1, 1)
			foradd.call(true, product.keys(), stack[0])
			foradd.call(true, product.values(), stack[1])
			UI[4].visible = false
			UI[4].position.y += stack[0].get_children()[-1].get("position").y + 10
		2:
			change.call(basket, enter, 0, 2, 1)
			read.call()
			if myBasket.is_empty():
				UI[4].text = "Compra algo, IDIOTA!!"
				await get_tree().create_timer(1).timeout
				for num in range(3):
					foradd.call(false, [], stack[num])
				back.call(basket)
			else:
				UI[4].visible = true
				list.call()
		0:
			back.call()
		_:
			UI[3].text = "Opcion INEXISTENTE, BABOSO!!"
			await get_tree().create_timer(1.25).timeout
			UI[3].text = txts[0]

func buy():
	var out:int = txtinput.call()
	match out:
		0:
			foradd.call(false, [], stack[0])
			foradd.call(false, [], stack[1])
			back.call(buy)
		_:
			if out <= product.size() and out > 0:
				out -= 1
				read.call()
				var check = FileAccess.open("res://myBasket.txt", FileAccess.WRITE)
				var temp2 = "{0}{2}1 unidad{2}{1}$".format([product.keys()[out], product.values()[out], space])
				var temp3 = temp2.split(space, false)
				if value.call(0).has(temp3[0]):
					for thing:String in myBasket:
						if thing.contains(temp3[0]):
							var sitie:int = myBasket.find(thing)
							var cut:Array = myBasket[sitie].split(space, false)
							cut[1] = str(int(cut[1]) + 1) + " unidades"
							cut[2] = str(int(cut[2]) + int(temp3[2])) + "$"
							myBasket[sitie] = space.join(cut)
							UI[4].visible = true
							UI[4].text = "Se añadio un(a) {0} mas a la canasta\n{0}: +{1}".format([cut[0], cut[1]])
							break
				else:
					myBasket.append(temp2)
					UI[4].visible = true
					UI[4].text = "Un(a) {0} se añadio a la canasta\n{0}: +1 unidad".format([temp3[0]])
				myBasket.sort()
				for one in myBasket:
					check.store_line(one)
				myBasket.clear()
				check.close()
				await  get_tree().create_timer(1.0).timeout
				UI[4].visible = false
			else:
				UI[3].text = "NO vendemos eso, ACORNOQUE"
				await  get_tree().create_timer(1.25).timeout
				UI[3].text = txts[1]

func basket():
	match txtinput.call():
		1:
			change.call(editProduct, basket, 2, 3)
		2:
			change.call(backProduct, basket, 3, 4)
		0:
			for num in range(3):
				foradd.call(false, [], stack[num])
			back.call(basket)
		_:
			UI[3].text = "Opcion INVALIDO, PENDEJO!!"
			await get_tree().create_timer(1.25).timeout
			UI[3].text = txts[0]

func editProduct():
	var txt:String = UI[0].text
	var out = txtinput.call()
	match out:
		0:
			change.call(basket, editProduct, 0, 2, 1)
			funcion = true
		_:
			if funcion:
				read.call()
				if out <= myBasket.size() and out > 0:
					alone = out - 1
					var word:Array = myBasket[alone].split(space, false)
					UI[4].text += "\n¿Cuantos {0}(s) mas vas a llevar o cuantas dejaras?".format([word[0]])
					funcion = false
					UI[3].text = txts[4]
					myBasket.clear()
				else:
					myBasket.clear()
					UI[3].text = "NO tienes ese PRODUCTO, ESTUPIDO!!"
					await get_tree().create_timer(1.25).timeout
					UI[3].text = txts[2]
			else:
				read.call()
				if txt.is_valid_int():
					var word:Array = myBasket[alone].split(space, false)
					if out <= 15 && out >= -int(word[1]):
						UI[4].text = UI[4].text.erase(UI[4].text.find("$") + 1, len("\n¿Cuantos {0}(s) mas vas a llevar o cuantas dejaras?".format([word[0]])))
						var file:FileAccess = FileAccess.open("res://myBasket.txt",FileAccess.WRITE)
						var txtmore:String
						word[1] = str(int(word[1]) + out)
						if int(word[1]) == 0:
							myBasket.pop_at(alone)
							txtmore = "Se devolvio el(los) {0}(s) de la canasta".format([word[0]])
							UI[6].text += txtmore
						else:
							word[2] = str(int(word[2]) + (product.values()[product.keys().find(word[0])] * out)) + "$"
							if int(word[1]) == 1:
								word[1] += " unidad"
							else:
								word[1] += " unidades"
							if out > 0:
								txtmore = "Se agrego {0} {1}(s) a la canasta".format([out, word[0]])
							else:
								txtmore = "Se devolvio {0} {1}(s) de la canasta".format([out, word[0]])
							UI[6].text = txtmore
							myBasket[alone] = space.join(word)
						for one in myBasket:
							file.store_line(one)
						list.call()
						file.close()
						funcion = true
						UI[6].visible = true
						UI[6].position.y = UI[4].get("position").y + 30
						UI[3].text = txts[2]
						await get_tree().create_timer(1.4).timeout
						UI[6].visible = false
					else:
						myBasket.clear()
						UI[3].text = "NO EXAGERES!!, Lleva poco a poco"
						await get_tree().create_timer(1.25).timeout
						UI[3].text = txts[4]
				else:
					myBasket.clear()
					UI[3].text = "NO ES un NUMERO!!"
					await get_tree().create_timer(1.25).timeout
					UI[3].text = txts[4]

func backProduct():
	var out = txtinput.call()
	match out:
		0:
			change.call(basket, backProduct, 0, 2, 1)
		_:
			read.call()
			if out <= myBasket.size() and out > 0:
				out -= 1
				var thing:Array = myBasket[out].split(space, false)
				UI[4].visible = true
				myBasket.remove_at(out)
				var file:FileAccess = FileAccess.open("res://myBasket.txt", FileAccess.WRITE)
				for one in myBasket:
					file.store_line(one)
				file.close()
				list.call()
				var txtmore:String = "\nSe devolvio el(los) {0}(s) de la canasta".format([thing[0]])
				UI[4].text += txtmore
				await get_tree().create_timer(1.25).timeout
				UI[4].text = UI[4].text.erase(UI[4].text.find("$") + 1, len(txtmore))
			else:
				myBasket.clear()
				UI[3].text = "NO tienes ese PRODUCTO, IDIOTA!!"
				await get_tree().create_timer(1.25).timeout
				UI[3].text = txts[3]

func exitAndPay():
	read.call()
	UI[6].position.y += float(len(myBasket)) * 35
	if myBasket.size() > 0:
		var lbls = []
		for N in range(3):
			var names:Array = ["Producto:", "Cantidad:", "Total:"]
			var lbl:Label = Label.new()
			lbl.text = "\n" + names[N] + "\n"
			stack[N].add_child(lbl)
			lbls.append(stack[N].get_child(0))
		for thing:String in myBasket:
			await get_tree().create_timer(0.3).timeout
			lbls[0].text += thing.get_slice(space, 0) + "\n"
			var number = str(int(thing.get_slice(space, 1)))
			for quantity in number:
				await get_tree().create_timer(0.05).timeout
				var any = -1
				lbls[1].text += "0"
				for one in int(quantity) + 1:
					await get_tree().create_timer(0.05).timeout
					any += 1
					lbls[1].text[-1] = str(any)
			lbls[1].text += "\n"
			var cost = str(int(thing.get_slice(space, 2)))
			for numcost in cost:
				await get_tree().create_timer(0.05).timeout
				var rate = -1
				if lbls[2].text[-1] == "$":
					lbls[2].text =  lbls[2].text.left(-len(cost)) + lbls[2].text.right(len(cost)).replace("$", "0$")
				else:
					lbls[2].text += "0$"
				for one in int(numcost) + 1:
					await get_tree().create_timer(0.05).timeout
					rate += 1
					lbls[2].text[-2] = str(rate)
			lbls[2].text += "\n"
		UI[3].text = "Pagando"
		loadtxt(len(UI[3].text))
		UI[6].text = "Pago total: "
		var total = 0
		for sum in value.call(2):
			total += int(sum)
		for values in str(total):
			await get_tree().create_timer(0.05).timeout
			var rate:int = 0
			if UI[6].text[-1] == "$":
				UI[6].text =  UI[6].text.left(-len(str(total))) + UI[6].text.right(len(str(total))).replace("$", "0$")
			else:
				UI[6].text += "0$"
			for one in int(values):
				await get_tree().create_timer(0.05).timeout
				rate += 1
				UI[6].text[-2] = str(rate)
		UI[3].text = "Saliendo"
		loadtxt(len(UI[3].text))
		UI[6].text += "\n\nGracias por comprar :)"
	else:
		UI[3].text = "Sin contenido"
		loadtxt(0, false)
		UI[5].text = "Vuelva pronto :)"
	await get_tree().create_timer(2.25).timeout
	DirAccess.open("res://").remove("myBasket.txt")
	get_tree().quit()

func loadtxt(txt:int, val:bool = true):
	while val:
		await get_tree().create_timer(0.75).timeout
		if UI[3].text.contains("..."):
			UI[3].text = UI[3].text.erase(txt, 3)
		else:
			UI[3].text += "."
