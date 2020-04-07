package main

import (
	"fmt" 
	"strconv"
)

func main() {
	edad := "22"

	edad_int, _ := strconv.Atoi(edad) // Atoi entrega dos resultados, se debe desprespreciar el segundo (En caso de error)
	
	fmt.Println(edad_int+10)


}