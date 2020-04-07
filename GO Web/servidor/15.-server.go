package main

import(
	"net/http"
	"fmt"
	"log"
)

// Handler
func Hola (w http.ResponseWriter, r *http.Request){
		fmt.Fprintf(w, "Hola Mundo.")
	}


func main(){
				// Ruta // Handler
	http.HandleFunc("/", Hola) // DefaultServeMux

	server := &http.Server{
		Addr : "localhost:3000",
		Handler: nil,  // Si es nil utilizamos DefaultServeMux
	}

	log.Fatal(server.ListenAndServe())
}