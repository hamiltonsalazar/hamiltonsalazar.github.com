package main

import(
	"net/http"
	"log"
	"fmt"
)

func main(){
	http.HandleFunc("/params", func(w http.ResponseWriter, r *http.Request){
		
		//fmt.Println(r.URL.RawQuery) // Separa los párametros del URL
		//fmt.Println(r.URL.Query()) //map

		name := r.URL.Query().Get("name")
		if len(name) != 0{
			fmt.Println(name)
		}

		parametro := r.URL.Query().Get("parametro")
		if len(parametro) != 0{
			fmt.Println(parametro)
		}


		fmt.Fprintf(w, "Hola mundo")
	})

	log.Fatal(http.ListenAndServe("localhost:3000", nil))
}