class_name XML extends XMLParser

func comentary(text: String) -> String:
	return "<!-- %s -->" % text

func hasgtag(tag:String, info:Array[String] = [], atributes:Dictionary = {}) -> String:
	var atribute_string:String = ""
	if !atributes.is_empty():
		for atribute in atributes:
			atribute_string += " %s=\"%s\"" % [atribute, atributes[atribute]]
	if len(info) > 0 and (info[0].contains("/>") or info[0].contains("</")):
		var nesteds:String = ""
		for nested in len(info):
			nesteds += "\t%s\n" % info[nested]
		return "<%s%s>\n%s</%s>" % [tag, atribute_string, nesteds, tag]
	else:
		if info.is_empty() and !atributes.is_empty():
			return "<%s%s/>" % [tag, atribute_string]
		else:
			return "<%s%s>%s</%s>" % [tag, atribute_string, info[0], tag]

func write(file:String, contend:String, version:int = 0):
	var text:String = "<?xml version=\"%s\" encoding=\"UTF-8\"?>\n"
	if version == 0:
		text = text % "1.0"
	else:
		text = text % "1.1"
	var _open:FileAccess = FileAccess.open(file, FileAccess.WRITE)
	_open.store_string(text + contend)
	_open.close()
