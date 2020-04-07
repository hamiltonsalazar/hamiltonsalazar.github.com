package main 

import "fmt"

func main () {

	slice := []int {1,2,3,4}
	copia := make([]int, len(slice))

	fmt.Println("Slice: ", slice)
	fmt.Println("Copia: ", copia)

	copy(copia, slice) // copy copia según la cantidad de espacios disponibles en el destino

	fmt.Println("Slice: ", slice)
	fmt.Println("Copia: ", copia)


}