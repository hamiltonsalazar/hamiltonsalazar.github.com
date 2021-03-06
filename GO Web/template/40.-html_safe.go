package main

import (
	"net/http"
	"log"
	"html/template"
)

type Comment struct{
	Title string
	Content template.HTML
}

var templates = template.Must( template.New("T").ParseGlob("templates/**/*.html") )
var error = template.Must( template.ParseFiles("templates/error.html"))

func handlerError(w http.ResponseWriter, r *http.Request, status int){
	w.WriteHeader(status)
	error.Execute(w, r.URL)
}

func renderTemplate(w http.ResponseWriter, r *http.Request, name string, data interface{}) {
	w.Header().Set("Content-Type", "text/html")
	err := templates.ExecuteTemplate(w, name, data)
	if err != nil{
		log.Println(err)
		handlerError(w, r, http.StatusInternalServerError)
	}
}

func comment(w http.ResponseWriter, r *http.Request){
	title := "Ejemplo."
	content := template.HTML("Este es el contenido del comentario <strong> Test </strong>")

	comment := Comment{ Title: title,
						Content: content,
						}

	renderTemplate(w, r, "comments/comment", comment)
}


func main(){

	mux := http.NewServeMux()
    mux.HandleFunc("/comment/", comment)
    
    log.Println("El servidor a la escucha en el puerto :3000")
    log.Fatal( http.ListenAndServe(":3000", mux))
}