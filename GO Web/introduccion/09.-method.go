package main

import(
	"net/http"
	"log"
	"fmt"
)

func main(){
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		fmt.Println("El método es "+ r.Method)
		switch r.Method {
		case "GET":
			fmt.Fprintf(w, "Hola Mundo con el método Get.")
		case "POST":
			fmt.Fprintf(w, "Hola Mundo con el método Post.")
		case "DELETE":
			fmt.Fprintf(w, "Hola Mundo con el método Delete.")
		default:
			http.Error(w, "Método no valido.", http.StatusBadRequest)
		}

		fmt.Fprintf(w, "Hola mundo")
	})

	log.Fatal(http.ListenAndServe("localhost:3000", nil))
}