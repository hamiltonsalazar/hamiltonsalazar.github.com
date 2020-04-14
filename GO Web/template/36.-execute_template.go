package main

import (
	"net/http"
	"log"
	"fmt"
	"html/template"
)

var templates = template.Must( template.New("T").ParseFiles("index.html", "footer.html", "header.html", "registro.html") )


func main(){
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		err := templates.ExecuteTemplate(w, "registro", nil)
		if err != nil{
			panic(err)
		}
		
	})

	fmt.Println("El servidor a la escucha en el puerto :3000")
	log.Fatal(http.ListenAndServe(":3000", nil))
}