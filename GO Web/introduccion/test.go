package main

import(
	"net/http"
	"log"
	"fmt"
)

func main() {
	http.HandleFunc("/params", func(w http.ResponseWriter, r *http.Request){
		fmt.Fprintf(w, "Hola Mundo.")
	})
	log.Fatal(http.ListenAndServe("localhost:3000",nil))
}