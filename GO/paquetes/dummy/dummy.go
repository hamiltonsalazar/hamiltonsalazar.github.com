package dummy // no necesariamente el archivo y 				el paquete deben llevar el mismo 				nombre

var hola_mundo string  // si tiene la incial en 					mayúscula se toma como 							pública.

func init(){  // función de arranque incial, 					"constuctor"
	hola_mundo = "Hola"
}


func HolaMundo() string{  // las funciones que 							empiezan con mínuscula 							son tomadas como 								privadas y no se pueden 						ejecutar desde otro 							paquete.
	return hola_mundo
}