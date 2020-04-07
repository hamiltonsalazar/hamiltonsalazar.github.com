package main

import(
	"fmt"
	"time"
	"strings"
)

func main() {
	go mi_nombre_lentooo("Hamilton Carvajal")
	fmt.Println("Queee aburridoooo.")
	var wait string
	fmt.Scanln(&wait)
}

func mi_nombre_lentooo (name string){
	letras := strings.Split(name, "") // el segundo parámetro es el criterio de división, en este caso por cada caracter

	for _, letra := range(letras){
		time.Sleep(500 * time.Millisecond)
		fmt.Println(letra)
	}
}