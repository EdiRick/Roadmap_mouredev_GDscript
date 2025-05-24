extends Node

var time_now = Time.get_datetime_dict_from_system()
var time = Time.get_datetime_dict_from_datetime_string("2007-02-15T12:36:53", true)

func _ready():
	print(time_now["year"] - time["year"])

# EJERCICIO EXTRA
	print("Dia: %d | Mes: %d | Año: %d" % [time["day"], time["month"], time["year"]])
	print("Año: %d" % time["year"])
	print("Dia de la semana: %d" % time["weekday"])
	print("Nombre del Mes: %s" % get_name_month(time["month"]))
	print("Nombre del Dia: %s" % get_name_day(time["weekday"]))
	print("Hora: %d" % time["hour"])
	print("Minuto: %d" % time["minute"])
	print("Segundo: %d" % time["second"])
	print("Hora: %d | Minuto: %d | Segundo: %d" % [time["hour"], time["minute"], time["second"]])
	print("Año: %d | Nombre del Mes: %s | Nombre del Dia: %s" % [time["year"], get_name_month(time["month"]), get_name_day(time["weekday"])])

func get_name_month(mounth:int) -> String:
	var name_mounth:Array[String] = [
		"Enero",
		"Febrero",
		"Marzo",
		"Abril",
		"Mayo",
		"Junio",
		"Julio",
		"Agosto",
		"Setiembre",
		"Octubre",
		"Noviembre",
		"Diciembre"
	]
	return name_mounth[mounth - 1]

func get_name_day(day:int) -> String:
	var name_day:Array[String] = [
		"Domingo",
		"Lunes",
		"Martes",
		"Miercoles",
		"Jueves",
		"Viernes",
		"Sabado"
	]
	return name_day[day - 1]
