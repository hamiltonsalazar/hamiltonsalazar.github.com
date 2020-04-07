package main

import(
	"net/http"
	"io"
	"fmt"
)


func main(){
	http.HandleFunc("/holamundo", func (w http.ResponseWriter, r *http.Request){
		fmt.Println("Hay una nueva petición2")
		io.WriteString(w, "Hola solito")
	})


	http.HandleFunc("/",handler)
	http.ListenAndServe(":8000", nil)
}

func handler (w http.ResponseWriter, r *http.Request){
	fmt.Println("Hay una nueva petición")
	io.WriteString(w, "Hola Mundo")
}