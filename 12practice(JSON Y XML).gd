extends Node

var data:Array[String] = ["res://myXML.xml", "res://myJSON.json"]

func _ready():
# XML
	var xml = XML.new()
	var info:Array[String] = [
		xml.hasgtag("name", ["EdiRick"]),
		xml.hasgtag("age", ["18"]),
		xml.hasgtag("birth", ["**/**/07"]),
		xml.hasgtag("lenguages", ["JavaScript, Python, GDscript"])
	]
	xml.write(data[0], xml.hasgtag("user", info))
	xml.open(data[0])
	var datas:Array[String] = ["", "", "", ""]
	var node:String
	while xml.read() != ERR_FILE_EOF:
		match xml.get_node_type():
			xml.NODE_ELEMENT:
				node = xml.get_node_name()
			xml.NODE_TEXT:
				var txt:String = xml.get_node_data()
				if node == "name":
					datas[0] = txt
				elif node == "age":
					datas[1] = txt
				elif node == "birth":
					datas[2] = txt
				elif node == "lenguages":
					datas[3] = txt
	print("Nombre: %s | Edad: %s | Fecha de nacimiento: %s | Lenguajes: %s" % datas)

# JSON
	var datos:Dictionary = {
		"name" : "EdiRick",
		"age" : "18",
		"birth" : "**/**/07",
		"lenguages" : ["JavaScript", "Python", "GDscript"]
	}
	var varToJson:String = JSON.stringify(datos, "\t")
	var open:FileAccess = FileAccess.open(data[1], FileAccess.WRITE_READ)
	open.store_string(varToJson)
	var jsonAtTxt = open.get_as_text()
	var dates = JSON.parse_string(jsonAtTxt)
	open.close()
	print("Nombre: {name} | Edad: {age} | Fecha de nacimiento: {birth} | Lenguajes: {lenguages}".format(dates))


# EJERCICIO EXTRA
	ejercicio()

class DATA:
	func XMLandJSON() -> Array[String]:
		var template:String = "Nombre: {name} | Edad: {age} | Fecha de nacimiento: {birth} | Lenguajes: {lenguages}"
		var data:Array[String] = []
		var xml:XMLParser = XMLParser.new()
		xml.open("res://myXML.xml")
		var node:String
		var xmldata:Dictionary = {
			"name" : "",
			"age" : "",
			"birth" : "",
			"lenguages" : ""
		}
		while xml.read() != ERR_FILE_EOF:
			match xml.get_node_type():
				xml.NODE_ELEMENT:
					node = xml.get_node_name()
				xml.NODE_TEXT:
					var txt:String = xml.get_node_data()
					if node == "name":
						xmldata["name"] = txt
					elif node == "age":
						xmldata["age"] = txt
					elif node == "birth":
						xmldata["birth"] = txt
					elif node == "lenguages":
						xmldata["lenguages"] = txt
		data.append(template.format(xmldata))
		var open:FileAccess = FileAccess.open("res://myJSON.json", FileAccess.READ)
		var jsonAtTxt = open.get_as_text()
		var jsondata = JSON.parse_string(jsonAtTxt)
		open.close()
		data.append(template.format(jsondata))
		return data

func ejercicio():
	var _data = DATA.new()
	print(_data.XMLandJSON()[0])
	print(_data.XMLandJSON()[1])
	var delete:DirAccess = DirAccess.open("res://")
	for file in len(data):
		delete.remove(data[file])
