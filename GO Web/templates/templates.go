package main

import (
	"net/http"
	"log"
	"fmt"
	"html/template"
)

func main(){
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		template, err := template.New("Hola").Parse("Hola Mundo")
		if err != nil{
			panic(err)
		}
		template.Execute(w, nil)
	})

	fmt.Println("El servidor a la escucha en el puerto :3000")
	log.Fatal(http.ListenAndServe(":3000", nil))
}