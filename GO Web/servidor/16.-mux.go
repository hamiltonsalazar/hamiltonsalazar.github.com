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

func HolaDos (w http.ResponseWriter, r *http.Request){
		fmt.Fprintf(w, "Hola Mundo Dos.")
}


func main(){

	mux := http.NewServeMux()
	mux.HandleFunc("/", Hola)
	mux.HandleFunc("/dos", HolaDos)

				// Ruta // Handler
	http.HandleFunc("/", Hola) // DefaultServeMux

	server := &http.Server{
		Addr : "localhost:3000",
		Handler: mux,  // Si es nil utilizamos DefaultServeMux
	}

	log.Fatal(server.ListenAndServe())
}