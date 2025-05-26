extends Node
enum semana {
	LUNES = 1,
	MARTES = 2,
	MIERCOLES = 3,
	JUEVES = 4,
	VIERNES = 5,
	SABADO = 6,
	DOMINGO = 7
}
func _ready():
	var weekday:int = 5
	var nameDay:String = ""
	match weekday:
		semana.LUNES:
			nameDay = "Lunes"
		semana.MARTES:
			nameDay = "Martes"
		semana.MIERCOLES:
			nameDay = "Miercoles"
		semana.JUEVES:
			nameDay = "Jueves"
		semana.VIERNES:
			nameDay = "Viernes"
		semana.SABADO:
			nameDay = "Sabado"
		semana.DOMINGO:
			nameDay = "Domingo"
		_:
			nameDay = "Inexistente"
	print("Nombre del dia: %s" % nameDay)

# EJERCICIO EXTRA
	ejercicio()

enum StatusProduct {
	PENDIENTE,
	ENVIADO,
	ENTREGADO,
	CANCELADO
}

class Product:

	var id:int
	var status:StatusProduct

	func _init(_id:int, _status:StatusProduct = StatusProduct.PENDIENTE):
		self.id = _id
		self.status = _status

	func send():
		if status == StatusProduct.PENDIENTE: 
			status = StatusProduct.ENVIADO
			print("El producto %03d se esta enviando" % id)
		elif status == StatusProduct.ENTREGADO:
			print("El producto %03d ya se envio" % id)
		elif status == StatusProduct.ENVIADO:
			print("El producto %03d ya se envio" % id)
		else:
			print("El producto %03d se encuentra cancelado" % id)

	func deliver():
		if status == StatusProduct.ENVIADO: 
			status = StatusProduct.ENTREGADO
			print("El producto %03d se esta entregando" % id)
		elif status == StatusProduct.ENTREGADO:
			print("El producto %03d ya se entrego" % id)
		elif status in [StatusProduct.ENVIADO, StatusProduct.PENDIENTE]:
			print("El producto %03d ya se entrego" % id)
		else:
			print("El producto %03d se encuentra cancelado" % id)

	func cancel():
		if status != StatusProduct.CANCELADO: 
			status = StatusProduct.CANCELADO
			print("El producto %03d se cancelo" % id)
		else:
			print("El producto %03d ya estaba cancelado" % id)

	func resume():
		if status == StatusProduct.CANCELADO: 
			status = StatusProduct.ENVIADO
			print("El producto %03d se reenviara" % id)
		else:
			print("El producto %03d no esta cancelado" % id)

func ejercicio():
	var apple:Product = Product.new(0)
	var rice:Product = Product.new(1, StatusProduct.CANCELADO)
	var bread:Product = Product.new(2, StatusProduct.ENTREGADO)
	var coffee:Product = Product.new(3, StatusProduct.ENVIADO)
	apple.send()
	rice.resume()
	bread.cancel()
	coffee.deliver()
	apple.cancel()
	rice.deliver()
	bread.resume()
	coffee.send()
