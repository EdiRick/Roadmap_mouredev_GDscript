extends Node

# 	LOGICA

var eventos: Array[Evento] = []
var participantes: Array[Participante] = []

func jugar_eventos() -> Dictionary[Evento, Dictionary]:
	var jugados: Dictionary[Evento, Dictionary]
	for idx in len(eventos):
		var evento: Evento = eventos[randi() % len(eventos)]
		while jugados.has(evento):
			evento = eventos[randi() % len(eventos)]
		jugados.set(evento, evento.jugar(participantes))
	return jugados

class Evento:
	var nombre: StringName
	
	func _init(_nombre: StringName) -> void:
		nombre = _nombre
		
	func jugar(participantes: Array[Participante]) -> Dictionary[StringName, Participante]:
		var medallas: Dictionary[StringName, Participante] = {
			&"oro": null,
			&"plata": null,
			&"bronce": null
		}
		for idx in 3:
			var ganador: Participante = participantes[randi() % len(participantes)]
			while medallas.values().has(ganador):
				ganador = participantes[randi() % len(participantes)]
			medallas[medallas.keys()[idx]] = ganador
			ganador.ganar_medalla(medallas.keys()[idx])
		return medallas

class Participante:
	var nombre: StringName
	var pais: StringName
	var medallas: Dictionary[StringName, int] = {
		&"oro": 0,
		&"plata": 0,
		&"bronce": 0,
	}

	func _init(_nombre: StringName, _pais: StringName) -> void:
		nombre = _nombre
		pais = _pais
	
	func ganar_medalla(medalla: StringName) -> void:
		medallas[medalla] += 1

	func total_de_medallas() -> int:
		var total: int = 0
		for idx in medallas:
			total += medallas[idx]
		return total

# 	INTRERFAZ

var inicio: HBoxContainer = HBoxContainer.new()
var informe: HBoxContainer = HBoxContainer.new()

var caja_de_eventos: VBoxContainer = VBoxContainer.new()
var caja_de_participantes: VBoxContainer = VBoxContainer.new()
var caja_de_ganadores: VBoxContainer = VBoxContainer.new()
var caja_de_paises: VBoxContainer = VBoxContainer.new()

var node_input0: LineEdit = LineEdit.new()
var node_input1: LineEdit = LineEdit.new()
var node_input2: LineEdit = LineEdit.new()

var alert: Label = Label.new()
var timer: Timer = Timer.new()

func _ready() -> void:
	var panel
	var comps: Array[Control]
	var txt: Array[String]

#	Inicio
	inicio.name = &"inicio"
	add_child(inicio)
	panel = crear_caja(inicio, "JUEGOS OLIMPICOS", 35)
	panel.set("size_flags_vertical", Control.SIZE_EXPAND_FILL)
	comps = [
		Label.new(),
		node_input0,
		Button.new(),
		Label.new(),
		node_input1,
		Label.new(),
		node_input2,
		Button.new(),
		Button.new(),
		Button.new()]
	txt = [
		"Registrar un evento nuevo:",
		"",
		"REGISTRAR EVENTO",
		"Registrar nuevo participante:",
		"",
		"Pais del nuevo participante:",
		"",
		"REGISTRAR PARTICIPANTE",
		"EMPEZAR\nJUEGOS!",
		"SALIR"]
	for idx in len(comps):
		config_text(panel, comps[idx], txt[idx], 17.5 if comps[idx] is Label else 20.0)
	panel = crear_caja(inicio, "Participantes", 35, [15, 40, 20, 0], 2)
	crear_seccion(panel, caja_de_participantes)
	panel = crear_caja(inicio, "Eventos", 35, [15, 40, 20, 0], 2)
	crear_seccion(panel, caja_de_eventos)

	comps[2].pressed.connect(registrar_evento)
	comps[7].pressed.connect(registrar_participante)
	comps[8].pressed.connect(cambiar_nodo.bind(inicio, informe, verificar_y_calificar))
	comps[9].pressed.connect(get_tree().quit)

#	Informe
	informe.name = &"informe"
	panel = crear_caja(informe, "GANADORES", 40)
	comps = [
		Button.new(),
		Button.new()]
	txt = [
		"EMPEZAR DE NUEVO",
		"SALIR"]
	for idx in len(comps):
		config_text(panel, comps[idx], txt[idx], 17.5 if comps[idx] is Label else 20.0)
	panel = crear_caja(informe, "Participantes", 35, [15, 40, 20, 0], 3)
	crear_seccion(panel, caja_de_ganadores)
	panel = crear_caja(informe, "Paises", 35, [15, 40, 20, 0], 3)
	crear_seccion(panel, caja_de_paises)

	comps[0].pressed.connect(cambiar_nodo.bind(informe, inicio, reiniciar))
	comps[1].pressed.connect(get_tree().quit)

#	Alerta
	panel = PanelContainer.new()
	panel.set_size(Vector2(400, 100))
	panel.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	add_child(panel)
	timer.set_one_shot(true)
	panel.add_child(timer)
	alert.set_autowrap_mode(TextServer.AUTOWRAP_WORD)
	alert.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
	alert.set_vertical_alignment(VERTICAL_ALIGNMENT_CENTER)
	alert.set("size_flags_vertical", Control.SIZE_EXPAND_FILL)
	alert.set("size_flags_horizontal", Control.SIZE_EXPAND_FILL)
	config_text(panel, alert, "", 25)

func crear_caja(padre: Control, titulo: String, tamaño: float, medidas4: Array[int] = [15, 20, 20, 0], espacio: float = 1):
	if [&"inicio", &"informe"].has(padre.name):
		padre.size = get_viewport().get_visible_rect().size

	var panel: MarginContainer = MarginContainer.new()
	panel.set("size_flags_horizontal", Control.SIZE_EXPAND_FILL)
	panel.set_stretch_ratio(espacio)
	panel.add_theme_constant_override("margin_left", medidas4[0])
	panel.add_theme_constant_override("margin_top", medidas4[1])
	panel.add_theme_constant_override("margin_right", medidas4[2])
	panel.add_theme_constant_override("margin_bottom", medidas4[3])
	padre.add_child(panel)

	var caja_temp: VBoxContainer = VBoxContainer.new()
	caja_temp.set("theme_override_constants/separation", 10)
	panel.add_child(caja_temp)

	var temp: Label = Label.new()
	temp.text = titulo
	temp.set("theme_override_font_sizes/font_size", tamaño)
	caja_temp.add_child(temp)

	return caja_temp

func crear_seccion(padre: Control, nodo: VBoxContainer):
	var panel_scroll: ScrollContainer = ScrollContainer.new()
	panel_scroll.set("size_flags_vertical", Control.SIZE_EXPAND_FILL)
	padre.add_child(panel_scroll)
	panel_scroll.add_child(nodo)

func config_text(padre: Control, nodo: Control, texto: String, size: float):
	nodo.text = texto
	nodo.set("theme_override_font_sizes/font_size", size)
	padre.add_child(nodo)

func cambiar_nodo(actual: Control, cambio: Control, funcion: Callable):
	if funcion.call():
		remove_child(actual)
		add_child(cambio)

func verificar_y_calificar() -> bool:
	if len(eventos) < 3:
		alertar("¡Agrega mas eventos!")
		return false
	elif len(participantes) < 3:
		
		alertar("!Agrega mas participantes!")
		return false
	else:
		for idx in [node_input0, node_input1, node_input2]:
			idx.clear()
		var ganadores: Dictionary[Evento, Dictionary] = jugar_eventos()
		var paises: Dictionary[StringName, int] = {}
		for event: Evento in ganadores:
			var caja: VBoxContainer = crear_caja(caja_de_ganadores, event.nombre.to_upper(), 18, [5, 5 ,5, 15])
			config_text(caja, Label.new(), "-> 1º " + ganadores[event].oro.nombre, 17.5)
			config_text(caja, Label.new(), "-> 2º " + ganadores[event].plata.nombre, 17.5)
			config_text(caja, Label.new(), "-> 3º " + ganadores[event].bronce.nombre, 17.5)
		for part: Participante in participantes:
			if !paises.has(part.pais):
				paises[part.pais] = 0
			paises[part.pais] += part.total_de_medallas()
		for pais: StringName in paises:
			config_text(caja_de_paises, Label.new(), pais + "(%d)" % paises[pais], 17.5)
		return true

func reiniciar() -> bool:
	for caja: VBoxContainer in [caja_de_participantes, caja_de_eventos, caja_de_ganadores, caja_de_paises]:
		for hijo: Control in caja.get_children():
			hijo.queue_free()
	participantes.clear()
	eventos.clear()
	return true

func registrar_evento():
	if !node_input0.text.is_empty():
		eventos.append(Evento.new(node_input0.text.capitalize()))
		config_text(caja_de_eventos, Label.new(), eventos.back().nombre, 17.5)
	else: alertar("¡Rellena la casilla!")
	node_input0.clear()

func registrar_participante():
	if !node_input1.text.is_empty() && !node_input2.text.is_empty():
		participantes.append(Participante.new(node_input1.text.capitalize(), node_input2.text.capitalize()))
		config_text(caja_de_participantes, Label.new(), \
		"%s (%s)" % [participantes.back().nombre, participantes.back().pais], 17.5)
	else: alertar("¡Falta Informacion!")
	node_input1.clear()
	node_input2.clear()

func alertar(mensaje: String):
	var cambiar: bool = !timer.is_stopped()
	var marge: float = get_viewport().get_visible_rect().size.y
	var tween: Tween
	timer.start(1)
	alert.set_text(mensaje)
	if alert.visible_ratio != 1: alert.set_visible_ratio(1)
	tween = create_tween()
	tween.set_parallel(false)
	tween.tween_property(alert.get_parent(), "position:y", marge - 100, 0.1)
	await timer.timeout
	if cambiar:
		timer.stop()
		alertar(mensaje)
	else:
		tween = create_tween()
		tween.set_parallel()
		tween.tween_property(alert.get_parent(), "position:y", marge, 1)
		tween.tween_property(alert, "visible_ratio", 0, 1)
