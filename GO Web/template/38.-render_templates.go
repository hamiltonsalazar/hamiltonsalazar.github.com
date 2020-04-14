package main

import (
	"net/http"
	"log"
	"fmt"
	"html/template"
)

type Usuario struct{
	Username string
}

var templates = template.Must( template.New("T").ParseGlob("templates/**/*.html") )

func renderTemplate(w http.ResponseWriter, name string, data interface{}) {
	w.Header().Set("Content-Type", "text/html")
	err := templates.ExecuteTemplate(w, name, data)
	if err != nil{
		http.Error(w, "No es posible retornar el template.", http.StatusInternalServerError)
	}
}


func main(){
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		renderTemplate(w, "Index", nil)			
	})

	http.HandleFunc("/usuario", func(w http.ResponseWriter, r *http.Request){
		usuario := Usuario{ "Smith" }
		renderTemplate(w, "usuario", usuario)			
	})

	fmt.Println("El servidor a la escucha en el puerto :3000")
	log.Fatal(http.ListenAndServe(":3000", nil))
}