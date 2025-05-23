extends Node

var time_now = Time.get_datetime_dict_from_system()
var time = {
	"year": 2009,
	"month": 1,
	"day": 1,
	"weekday": 1,
	"hour": 1,
	"minute": 00,
	"second": 00,
}

func _ready():
	print(time_now["year"] - time["year"] -1)

# EJERCICIO EXTRA
	
