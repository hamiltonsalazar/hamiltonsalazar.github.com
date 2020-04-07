package main

import (
	"fmt"
	"bufio"
	"os"
)

func main () {

	/*
	precio := 14.3
	fmt.Printf("El valor de la variable es: %v", precio) // %d => int, %t => boolean, %v => cualquier tipo de dato, %e-%f => float, %s => string
	*/

	/*
	var variable string
	fmt.Println("Ingrese el texto: ")
	fmt.Scanf("%s\n", &variable)
	fmt.Printf("El valor de la variable es: %s", variable)
	*/

	reader := bufio.NewReader(os.Stdin)
	fmt.Println("Ingrese su nombre: ")
	texto, err := reader.ReadString('\n')

	if err != nil {
		fmt.Println(err)
	} else{
		fmt.Println ("Nombre: "+texto)
	}

}