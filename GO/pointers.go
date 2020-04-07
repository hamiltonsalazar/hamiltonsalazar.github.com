package main 

import "fmt"

func main () {
	/*
	1. Es una dirección de memoria.
	2. En lugar del valor, tenemos la dirección en la que está el valor.
	3. Su valor incial es nil
	*/

	var x,y *int

	entero := 5

	x = &entero 
	y = &entero

	fmt.Println(x)
	fmt.Println(y)

	*x = 8  // El asterios previo es para modificar el valor en la dirección de memoria asignada al puntero. 

	fmt.Println(*x)
	fmt.Println(*y)

}

