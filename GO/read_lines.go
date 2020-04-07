package main

import (
	"fmt"
	"bufio"
	"os"
)

func main(){
	excuteReadFile()
	fmt.Println("Panic me ignora")
}

func excuteReadFile(){
	ejecucion := read_line()
	fmt.Println(ejecucion)
}

func read_line() bool{
	archivo, err := os.Open("./holas.txt")

	// defer siempre cierra el archivo al finalizar la ejecución de la función.
	defer func(){
		archivo.Close()
		fmt.Println("Se ha cerrado.")


		r := recover() // recover() detiene el panic, si lo guardamos en una variable muestra el error 
		fmt.Println(r)
	}()

	if err != nil{
		// fmt.Printf("Hubo un error: %v\n\n\n\n",err) //panic realiza esto.
		panic(err)
	}else{
		scanner := bufio.NewScanner(archivo)
		var i int 
		for scanner.Scan() {
			i++
			linea := scanner.Text()
			fmt.Printf("I=%d Línea: %v\n", i, linea)
		}
	}

	// archivo.Close()  // defer hace que se cierre el archivo en cualquier momento que se cierre la función.
	return true

} 