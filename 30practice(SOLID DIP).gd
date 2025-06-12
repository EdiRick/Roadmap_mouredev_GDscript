extends Node

class InterruptorError:
	func encender():
		print("Se encendio el foco")

	func apagar():
		print("Se apago el foco")

class FocoError:
	var interruptor = InterruptorError.new()

	func operar(valor:bool):
		if valor:
			interruptor.encender()
		else:
			interruptor.apagar()

class Interruptor:
	func encender():
		pass

	func apagar():
		pass

class InterruptorFoco extends Interruptor:
	func encender():
		print("Se encendio el foco")

	func apagar():
		print("Se apago el foco")

class Foco:
	var interruptor:Interruptor = InterruptorFoco.new()

	func operar(valor:bool):
		if valor:
			interruptor.encender()
		else:
			interruptor.apagar()

func _ready():
	var foco = FocoError.new()
	foco.operar(true)
	foco.operar(false)

	foco = Foco.new()
	foco.operar(true)
	foco.operar(false)

# EJERCICIO EXTRA

	var notificacion = SistemaNotificacion.new(EmailNoti)
	notificacion.enviar_notificacion("Hola Mundo!")
	
	notificacion = SistemaNotificacion.new(PUSHNoti)
	notificacion.enviar_notificacion("Hola Mundo!")
	
	notificacion = SistemaNotificacion.new(SMSNoti)
	notificacion.enviar_notificacion("Hola Mundo!")

class Notificacion:
	func notificar(_mensaje:String):
		assert(false, "No se agrego un mensaje")

class EmailNoti extends Notificacion:
	func notificar(mensaje:String):
		print("Se esta enviando un Email con el mensaje: %s" % mensaje)

class PUSHNoti extends Notificacion:
	func notificar(mensaje:String):
		print("Se esta enviando un PUSH con el mensaje: %s" % mensaje)

class SMSNoti extends Notificacion:
	func notificar(mensaje:String):
		print("Se esta enviando un SMS con el mensaje: %s" % mensaje)

class SistemaNotificacion:
	var noti:Notificacion
	func _init(_notificacion):
		noti = _notificacion.new()
	
	func enviar_notificacion(mensaje:String):
		noti.notificar(mensaje)
