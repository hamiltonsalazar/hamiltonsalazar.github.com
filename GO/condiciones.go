package main

import (
	"fmt"
)

func main () {

	x := 10
	y := 10

	if x > y {
		fmt.Printf("El valor %d es mayor que %d", x, y)
	}else if y > x{
		fmt.Printf("El valor %d es mayor que  %d", y, x)
	} else { 
		fmt.Println("Los valores son iguales.")
	}
}