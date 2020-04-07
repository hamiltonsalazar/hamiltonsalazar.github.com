
package main

import(
	"net/http"
	"log"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		http.Redirect(w,r, "/redirect", http.StatusMovedPermanently)		
	})

	http.HandleFunc("/redirect", func(w http.ResponseWriter, r *http.Request){
		http.Redirect(w,r, "https://www.google.com.mx", http.StatusMovedPermanently) // El cuarto argumento podemos poner la constante o el número del error, se recomienda la constante		
	})
	
	log.Fatal( http.ListenAndServe("localhost:3000", nil))