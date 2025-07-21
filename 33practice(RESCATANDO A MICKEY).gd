extends Node

var plantilla: Array[Array] =[
	["🚪", "⬛️", "⬜️", "⬛️", "⬛️", "⬜️"],
	["⬜️", "⬛️", "⬜️", "⬜️", "⬛️", "⬜️"],
	["⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬜️"],
	["⬛️", "⬜️", "⬜️", "⬛️", "⬜️", "⬛️"],
	["⬜️", "⬛️", "⬜️", "⬛️", "⬜️", "⬛️"],
	["⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️"]
]

var laberinto: Array[Array] = plantilla.duplicate()

var mickey: String = "🐭"
var sitio: Vector2i = Vector2i(5, 0)

var laberinto_texto: Label = Label.new()

func _ready() -> void:
	var panel: HBoxContainer = HBoxContainer.new()
	var subpanel: VBoxContainer = VBoxContainer.new()
	var botones: Array[Button] = [Button.new(), Button.new(), Button.new(), Button.new()]
	var direcciones: Dictionary[StringName, Vector2i] = {
		&"UP": Vector2i.UP,
		&"RIGHT": Vector2i.RIGHT,
		&"DOWN": Vector2i.DOWN,
		&"LEFT": Vector2i.LEFT
	}
	for idx: int in len(botones):
		subpanel.add_child(botones[idx])
		botones[idx].set_text(direcciones.keys()[idx])
		botones[idx].set("theme_override_font_sizes/font_size", 20)
		botones[idx].pressed.connect(mover.bind(direcciones.values()[idx]))
	panel.add_child(subpanel)
	panel.add_child(laberinto_texto)
	add_child(panel)
	laberinto[sitio.y][sitio.x] = mickey
	var temp: String = ""
	for idx in laberinto:
		temp += " ".join(idx) + "\n"
	laberinto_texto.set("theme_override_font_sizes/font_size", 30)
	laberinto_texto.set_text(temp)

func mover(direccion: Vector2i):
	var nuevo_sitio: Vector2i = direccion + sitio
	if verificar(nuevo_sitio) && plantilla[nuevo_sitio.y][nuevo_sitio.x] != "⬛️":
		if plantilla[nuevo_sitio.y][nuevo_sitio.x] == "🚪": get_tree().quit()
		laberinto[sitio.y][sitio.x] = "⬜️"
		sitio = nuevo_sitio
		laberinto[sitio.y][sitio.x] = mickey
		var temp: String = ""
		for idx in laberinto:
			temp += " ".join(idx) + "\n"
		laberinto_texto.set_text(temp)

func verificar(valor: Vector2i) -> bool:
	return valor.x >= 0 && valor.y >= 0 && valor.x < 6 && valor.y < 6
