package main

import (
    "net/http"
    "log"
    "github.com/gorilla/mux"
    "fmt"
)

func YourHandler(w http.ResponseWriter, r *http.Request) {

	vars := mux.Vars(r)
	nombre := vars["nombre"]
	id := vars["id"]

    //w.Write([]byte("Gorilla!\n"))
    fmt.Fprintf(w, "Los parametros son "+nombre+" y "+id)
}

func main() {
    r := mux.NewRouter()
    r.HandleFunc("/usuarios/{nombre}/{id:[0-9]+}", YourHandler)

    log.Fatal(http.ListenAndServe(":3000", r))
}