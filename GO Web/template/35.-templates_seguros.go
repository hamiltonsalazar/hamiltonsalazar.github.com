package main

import (
	"net/http"
	"log"
	"fmt"
	"html/template"
)

func main(){
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		
		template:= template.Must( template.New("index.html").ParseFiles("index.html", "footer.html", "header.html"))
		template.Execute(w, nil)
	})

	fmt.Println("El servidor a la escucha en el puerto :3000")
	log.Fatal(http.ListenAndServe(":3000", nil))
}