package main

import (
	"net/http"
	"log"
	"fmt"
	"html/template"
)

type Usuario struct{
	UserName string
	Edad int
}

func main(){
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		template, err := template.ParseFiles("index.html")
		if err != nil{
			panic(err)
		}

		usuario := Usuario{"Smith", 22}
		template.Execute(w, usuario)
	})

	fmt.Println("El servidor a la escucha en el puerto :3000")
	log.Fatal(http.ListenAndServe(":3000", nil))
}