package main

import(
	"net/http"
	"log"
	"fmt"
)

func main(){
	http.HandleFunc("/params", func(w http.ResponseWriter, r *http.Request){
		
		// r.URL.RawQuery => encontrar el Query
		// r.URL.Query() => encontrar el Map

		fmt.Println(r.URL)
		values := r.URL.Query()
		values.Del("otro")
		values.Add("name", "Smith")
		values.Add("course", "Go Web")
		values.Add("carrer", "Ing. de Sistemas")

		r.URL.RawQuery = values.Encode()

		fmt.Println(r.URL)
		fmt.Fprintf(w, "Hola mundo")
	})

	log.Fatal(http.ListenAndServe("localhost:3000", nil))
}