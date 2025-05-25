extends Node

func _ready():
	var regex:RegEx = RegEx.new()
	var num:String = ""
	regex.compile(r"\d")
	var search = regex.search_all("1b3bu45")
	for element in search:
		num += element.get_string() + " "
	print(num)

# EJERCICIO EXTRA
	verification("edirick16@gmail.com", 0)
	verification("927283528", 1)
	verification("https://google.com/", 2)
	verification("edirick16#gmail.xyz", 0)
	verification("92728", 1)
	verification("https:/gdscript.zzz", 2)

func verification(contend:String, type:int):
	var typeverification:Array[String] = [
		r"^\w+@.mail\.com$",
		r"^\d{9}$",
		r"^(http(s?)://)(www\.)?\w+\.((com|xyz)|(com|xyz)/)$"
	]
	var messenges:Array[String] = [
		"Email",
		"Numero de telefono",
		"URL"
		
	]
	var check:RegEx = RegEx.new()
	check.compile(typeverification[type])
	if check.search(contend) != null:
		print("%s(%s) Valido" % [messenges[type], contend])
	else:
		print("%s(%s) NO Valido" % [messenges[type], contend])
