extends Node

#	Personajes

var Deadpool: Dictionary[StringName, Variant] = {
	&"nombre": "Deadpool",
	&"estado": "Bien",
	&"vida": null,
	&"ataque": Vector2i(10, 100),
	&"esquivar": .25
}
var Wolverine: Dictionary[StringName, Variant] = {
	&"nombre": "Wolverine",
	&"estado": "Bien",
	&"vida": null,
	&"ataque": Vector2i(10, 120),
	&"esquivar": .2
}

#	IU y LOGICA

var inicio: VBoxContainer = crear_contenedor(3)
var lucha: VBoxContainer = crear_contenedor(5)

var info: Label = Label.new()

var deadpool_input: LineEdit = LineEdit.new()
var deadpool_estado: Label = Label.new()
var deadpool_vida: ProgressBar = ProgressBar.new()
var deadpool_vida_text: Label = Label.new()

var wolverine_input: LineEdit = LineEdit.new()
var wolverine_estado: Label = Label.new()
var wolverine_vida: ProgressBar = ProgressBar.new()
var wolverine_vida_text: Label = Label.new()

var boton_reinicio: Button = Button.new()

var alert:Label = Label.new()
var tiempo: Timer = Timer.new()

func _ready():
	var elems: Array[Control]

#		Inicio
	add_child(inicio)
	elems = [
		crear_contenedor(2, true),
		Button.new(),
		Button.new()]
	config(inicio, elems, [null, "¡A luchar!", "Salir"])
	config(
		elems.front(),
		[Label.new(), Label.new(), deadpool_input, wolverine_input],
		[Deadpool.nombre, Wolverine.nombre, null, null])

	deadpool_input.set_virtual_keyboard_type(LineEdit.KEYBOARD_TYPE_NUMBER)
	deadpool_input.set_placeholder("Introduzca la vida")
	wolverine_input.set_virtual_keyboard_type(LineEdit.KEYBOARD_TYPE_NUMBER)
	wolverine_input.set_placeholder("Introduzca la vida")

	elems[1].pressed.connect(empezar)
	elems.back().pressed.connect(get_tree().quit)

#		Lucha
	elems = [
		info,
		crear_contenedor(3, true),
		boton_reinicio,
		Button.new()]
	config(lucha, elems, [null, null, "Reiniciar", "Salir"])
	var temp: Array[Control] = [
		Label.new(),
		Label.new(),
		deadpool_estado,
		wolverine_estado,
		MarginContainer.new(),
		MarginContainer.new()]
	config(
		elems[1],
		temp,
		[Deadpool.nombre, Wolverine.nombre, null, null, null, null])

	deadpool_vida.set_show_percentage(false)
	config(temp[4], [deadpool_vida, deadpool_vida_text])
	wolverine_vida.set_show_percentage(false)
	config(temp[5], [wolverine_vida , wolverine_vida_text])

	boton_reinicio.set_disabled(true)
	boton_reinicio.pressed.connect(reinicio)
	elems.back().pressed.connect(get_tree().quit)

	var caja: PanelContainer = PanelContainer.new()
	caja.set_size(Vector2(500, 150))
	caja.set_anchors_preset(Control.PRESET_CENTER_BOTTOM)
	caja.position.x -= caja.size.x / 2
	add_child(caja)
	tiempo.set_wait_time(1)
	caja.add_child(tiempo)
	config(caja, [alert], [null])
	alert.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
	alert.set_vertical_alignment(VERTICAL_ALIGNMENT_CENTER)

func crear_contenedor(elementos: int, person: bool = false) -> Container:
	var temp: Container
	if person:
		temp = GridContainer.new()
		temp.set_columns(2)
		temp.set_stretch_ratio(elementos)
	else:
		temp = VBoxContainer.new()
		temp.set_size(Vector2(510, 50 * elementos))
		temp.set_anchors_preset(Control.PRESET_CENTER)
		temp.set_position(temp.get_position() - (temp.size / 2.0))
	return temp

func config(padre: Control, nodos: Array[Control], text: Array = [null, null]):
	for idx: int in len(nodos):
		if text[idx]:
			nodos[idx].set_text(text[idx])
		if nodos[idx] is Label or nodos[idx] is LineEdit:
			nodos[idx].set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
		nodos[idx].set("theme_override_font_sizes/font_size", 20)
		nodos[idx].set_h_size_flags(Control.SIZE_EXPAND_FILL)
		nodos[idx].set_v_size_flags(Control.SIZE_EXPAND_FILL)
		padre.add_child(nodos[idx])

func empezar():
	if deadpool_input.text.is_empty() or wolverine_input.text.is_empty():
		alertar("¡¡COLOQUE UN VALOR!!")
	elif !deadpool_input.text.is_valid_int() or !wolverine_input.text.is_valid_int():
		alertar("¡¡SOLO NUMEROS!!")
	else:
		remove_child(inicio)
		add_child(lucha)
		Deadpool.vida = int(deadpool_input.text)
		deadpool_vida.set_max(Deadpool.vida)
		Wolverine.vida = int(wolverine_input.text)
		wolverine_vida.set_max(Wolverine.vida)
		actualizar_ui("Empezando")
		await get_tree().create_timer(1).timeout
		luchar()
	deadpool_input.clear()
	wolverine_input.clear()

func luchar():
	var turno: Dictionary[StringName, Variant] = Deadpool
	var espera: Dictionary[StringName, Variant] = Wolverine
	while Wolverine.vida > 0 && Deadpool.vida > 0:
		if turno.estado != "Noqueado":
			var ataque: int = randi_range(turno.ataque.x, turno.ataque.y)
			if randf() > espera.esquivar:
				espera.vida -= ataque
				espera.estado = "Noqueado" if ataque > turno.ataque.y * .8 else "Bien"
			else:
				espera.estado = "Esquivando"
		else: turno.estado = "Recuperandose"
		actualizar_ui("Turno de: %s" % turno.nombre)
		await get_tree().create_timer(1).timeout
		espera = turno
		turno = Deadpool if turno.nombre == "Wolverine" else Wolverine
	actualizar_ui("Gano %s" % espera.nombre.to_upper())
	boton_reinicio.set_disabled(false)

func actualizar_ui(estado: String, actualizar_vida: bool = true):
	info.set_text(estado)
	if actualizar_vida:
		deadpool_vida.set_value(Deadpool.vida)
		deadpool_estado.set_text(Deadpool.estado if Deadpool.vida > 0 else "MUERTO")
		deadpool_vida_text.set_text("%d / %.f" % [Deadpool.vida if Deadpool.vida > 0 else 0, deadpool_vida.get_max()])
		
		wolverine_vida.set_value(Wolverine.vida)
		wolverine_estado.set_text(Wolverine.estado if Wolverine.vida > 0 else "MUERTO")
		wolverine_vida_text.set_text("%d / %.f" % [Wolverine.vida if Wolverine.vida > 0 else 0, wolverine_vida.get_max()])

func reinicio():
	boton_reinicio.set_disabled(true)
	Wolverine.estado = "Bien"
	Wolverine.vida = null
	Deadpool.estado = "Bien"
	Deadpool.vida = null
	remove_child(lucha)
	add_child(inicio)

func alertar(mensaje: String):
	var cambiar: bool = !tiempo.is_stopped()
	var marge: float = get_viewport().get_visible_rect().size.y
	var tween: Tween
	tiempo.start(1)
	alert.set_text(mensaje)
	if alert.visible_ratio != 1: alert.set_visible_ratio(1)
	tween = create_tween()
	tween.set_parallel(false)
	tween.tween_property(alert.get_parent(), "position:y", marge - 150, 0.1)
	await tiempo.timeout
	if cambiar:
		tiempo.stop()
		alertar(mensaje)
	else:
		tween = create_tween()
		tween.set_parallel()
		tween.tween_property(alert.get_parent(), "position:y", marge, 1)
		tween.tween_property(alert, "visible_ratio", 0, 1)
