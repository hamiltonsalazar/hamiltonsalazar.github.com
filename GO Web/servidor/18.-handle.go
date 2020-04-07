package main

import(
	"net/http"
	"fmt"
	"log"
)

/*
type Handler interface{
	ServeHTTP(ResponseWriter, *Request)
}
*/

type User struct{
	name string
}

func (this *User) ServeHTTP(w http.ResponseWriter, r *http.Request){
	fmt.Fprintf(w, "Hola: "+this.name)
}


func main(){
	smith := &User{name: "Smith"}

	mux := http.NewServeMux()
	mux.Handle("/smith", smith) // remplaza la función HandlerFunc que asigna el Mux 
	
	server := &http.Server{
		Addr : "localhost:3000",
		Handler: mux,  
	}

	log.Fatal(server.ListenAndServe())
}