package main

import (
	"fmt"
	"io/ioutil"
)

func main(){
	file_data, err := ioutil.ReadFile("./hola.txt")

	if err != nil{
		fmt.Printf("Hubo un error: %v",err)
	}else{
		fmt.Println(string(file_data))
	}

}