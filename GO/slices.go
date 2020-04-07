package main

import "fmt"

func main () {


	/*
	// var slice [] int  // No asignar tamaño y se crea tipo slice, cuando no se incializa a diferencia de los vectores se les asigna nil

	matriz := [] int  {1, 2, 3}  

	fmt.Println(matriz);

	fmt.Println("Tamaño del slice: ",len(matriz))
	*/

	// Puntero al arreglo
	// Longitud del arreglo al que apunto
	// Capacidad

	arreglo := [3] int {1,2,3}
	slice := arreglo[:2]
	fmt.Println(slice)

	slice = arreglo[1:2] 
	fmt.Println(slice)

	slice = arreglo[1:]
	fmt.Println(slice)

	slice = arreglo[:]
	fmt.Println(slice)
}