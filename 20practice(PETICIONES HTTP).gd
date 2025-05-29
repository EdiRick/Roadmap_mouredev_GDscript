extends Node

func request_confirm(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray):
	if response_code == 200:
		print("Peticion confirmada\n")
		print("Contenido: ", JSON.parse_string(body.get_string_from_utf8())["body"])
	else:
		print("Peticion negada")

func _ready():
	var request:HTTPRequest = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", request_confirm)
	request.request("https://jsonplaceholder.typicode.com/posts/1")

# EJERCICIO EXTRA
	PokeID()

var UI:Control = Control.new()
var search:Button = Button.new()
var input:LineEdit = LineEdit.new()
var title:Label = Label.new()
var settingsTitle:LabelSettings = LabelSettings.new()
var reference:Label = Label.new()
var settingsReference:LabelSettings = LabelSettings.new()
var subTitles:Label = Label.new()
var settingsSubTitles:LabelSettings = LabelSettings.new()
var content:Label = Label.new()
var settingsContent:LabelSettings = LabelSettings.new()
var infoRequest:HTTPRequest = HTTPRequest.new()
var subTitlesTXTs:Array[String] = [
	"¡ BUSCALO a TODOS !",
	"Nombre:\nID:\nPeso:\nAltura:\n%s:\nCadena Evolutiva:\nApariciones en Juegos:",
	"Error al conectar a la red",
	"Intentalo de nuevo",
	"Buscando %s",
	"Intentalo de nuevo"
]
var contentTXTs:Array[String] = [
	"¡ Busca Tu Pokemon Favorito !",
	"%s\n%s\n%s\n%s\n%s\n%s\n%s",
	"Verifica tu Red",
	"Error Desconocido",
	"Buscando informacion del Pokemon",
	"¡ Pokemon Inexistente !"
]
var info:Dictionary[StringName, Variant] = {
	"name": null,
	"id": null,
	"weight": null,
	"height": null,
	"types": null,
	"evolutions": null,
	"games": []
}
enum type_body {
	FEATURES,
	TYPES,
	EVOLUTIONS,
	GAMES
}
var type:type_body = type_body.FEATURES
var inputTXT

func clearTXT():
	var verify:RegEx = RegEx.new()
	var temp:String = input.text.to_lower().strip_edges().replace(" ","-")
	verify.compile(r"(^\d+$)|(^\w\D+$)")
	input.clear()
	if verify.search(temp):
		return temp
	else:
		return null

func error(txt:int):
	subTitles.text = subTitlesTXTs[txt]
	content.text = contentTXTs[txt]
	await get_tree().create_timer(3).timeout
	content.text = subTitlesTXTs[0]
	subTitles.text = contentTXTs[0]
	cancel_request(false)

func input_pressed():
	for data:Variant in info:
		if data == "games":
			info[data] = []
		elif typeof(info[data]) == TYPE_STRING and info[data] != null:
			info[data] = null
	inputTXT = clearTXT()
	if inputTXT != null:
		infoRequest.request("https://pokeapi.co/api/v2/pokemon/%s/" % inputTXT)
		load_txt(subTitlesTXTs[-2] % "Caracteristicas", 0)
		load_txt(contentTXTs[-2], 1)
		search.pressed.disconnect(input_pressed)
		search.pressed.connect(cancel_request)
		search.text = "CANCELAR"
	else:
		error(-1)

func cancel_request(active:bool = true):
	search.text = "BUSCAR"
	type = type_body.FEATURES
	search.pressed.disconnect(cancel_request)
	search.pressed.connect(input_pressed)
	if active:
		infoRequest.cancel_request()
		subTitles.text = subTitlesTXTs[0]
		content.text = contentTXTs[0]
		for data:Variant in info:
			if info[data] == info["games"]:
				info[data] = []
			elif typeof(info[data]) == TYPE_STRING and info[data] != null:
				info[data] = null

func PokeID():
	add_child(UI)
	UI.position.y = 40
	UI.set_anchors_preset(Control.PRESET_CENTER_TOP, true)

	UI.add_child(input)
	input.set("theme_override_font_sizes/font_size", 25)
	input.alignment = HORIZONTAL_ALIGNMENT_CENTER
	input.max_length = 20
	input.position = Vector2(-400, 200)
	input.size = Vector2(800, 50)

	UI.add_child(search)
	search.set("theme_override_font_sizes/font_size", 20)
	search.size = Vector2(150, 50)
	search.position = Vector2(-75, 270)
	search.text = "BUSCAR"
	search.pressed.connect(input_pressed)

	UI.add_child(title)
	title.label_settings = settingsTitle
	settingsTitle.font_size = 70
	settingsTitle.outline_color = Color(0, 0, 0, 255)
	settingsTitle.outline_size = 10
	title.text = "||>  Poke  ID <||"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.autowrap_mode = TextServer.AUTOWRAP_WORD
	title.size.x = 2408
	title.position.x = -1204

	UI.add_child(reference)
	reference.label_settings = settingsReference
	settingsReference.font_size = 25
	reference.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	reference.autowrap_mode = TextServer.AUTOWRAP_WORD
	reference.position.y = 150
	reference.size.x = 2408
	reference.position.x = -1204
	reference.text = "Introduce el NOMBRE o ID de tu Pokemon que quieras buscar:"

	UI.add_child(subTitles)
	subTitles.label_settings = settingsSubTitles
	settingsSubTitles.font_size = 25
	settingsSubTitles.line_spacing = 65
	subTitles.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subTitles.autowrap_mode = TextServer.AUTOWRAP_WORD
	subTitles.position.y = 350
	subTitles.size.x = 2408
	subTitles.position.x = -1204
	subTitles.text = subTitlesTXTs[0]

	UI.add_child(content)
	content.label_settings = settingsContent
	settingsContent.font_size = 35
	settingsContent.line_spacing = 52
	content.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	content.autowrap_mode = TextServer.AUTOWRAP_WORD
	content.position.y = 380
	content.size.x = 2408
	content.position.x = -1204
	content.text = "¡ Busca Tu Pokemon Favorito !"

	UI.add_child(infoRequest)
	infoRequest.request_completed.connect(request_info)

func request_info(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray):
	if result == HTTPRequest.RESULT_SUCCESS:
		match response_code:
			200:
				request_poke(JSON.parse_string(body.get_string_from_utf8()))
			404:
				error(-1)
			_:
				error(3)
	else:
		error(2)

func request_poke(body:Dictionary):
	match type:
		type_body.FEATURES:
			info["name"] = body["name"].capitalize()
			info["id"] = "Nº %04d" % int(body["id"])
			info["weight"] = "%.1f kg" % [float(body["weight"]) / 10]
			info["height"] = "%.1f m" % [float(body["height"]) / 10]
			type = type_body.TYPES
			load_txt(subTitlesTXTs[-2] % "Tipos", 0)
			for a_type in body.types:
				infoRequest.request(a_type.type["url"])
				await infoRequest.request_completed
			infoRequest.request("https://pokeapi.co/api/v2/pokemon-species/%s/" % inputTXT)
			type = type_body.EVOLUTIONS
			load_txt(subTitlesTXTs[-2] % "Evoluviones", 0)
			for i in range(2):
				await infoRequest.request_completed
			type = type_body.GAMES
			load_txt(subTitlesTXTs[-2] % "Juegos", 0)
			if len(body.game_indices) > 0:
				for game in len(body.game_indices):
					infoRequest.request(body.game_indices[game].version["url"])
					await infoRequest.request_completed
				info["games"] = ", ".join(info["games"])
			type = type_body.FEATURES
			view()
			cancel_request(false)
		type_body.TYPES:
			var temp:Array = []
			for _name in body.names:
				if _name.language["name"] == "es":
					temp.append(_name["name"])
					break
			info["types"] = " - ".join(temp)
		type_body.EVOLUTIONS:
			if body.has("evolution_chain"):
				infoRequest.request(body.evolution_chain["url"])
			else:
				var temp:Dictionary = body.chain
				var temp1:Array = []
				while true:
					temp1.append(temp.species["name"].capitalize())
					if !temp.evolves_to.is_empty():
						temp = temp.evolves_to[0]
					else:
						break
				info["evolutions"] = " -> ".join(temp1)
		type_body.GAMES:
			for _name in body.names:
				if _name.language["name"] == "es":
					info["games"].append(_name["name"])

func view():
	subTitles.text = subTitlesTXTs[1] % ["Tipo" if len(info["types"]) == 1 else "Tipos"]
	content.text = contentTXTs[1] % info.values()

func load_txt(txt:String, num:int):
	var lbls:Array[Label] = [subTitles, content]
	lbls[num].text = txt
	while lbls[num].text.contains(txt):
		if lbls[num].text.count("º") > 6:
			lbls[num].text = txt
		elif lbls[num].text == txt:
			lbls[num].text = "º%sº" % txt
		else:
			lbls[num].text = lbls[num].text.replace("º","ºº")
		await get_tree().create_timer(0.2).timeout
