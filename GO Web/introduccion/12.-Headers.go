ackage main

import(
	"net/http"
	"log"
	"fmt"
)

func main(){
	http.HandleFunc("/params", func(w http.ResponseWriter, r *http.Request){
		
		fmt.Println(r.Header) // obtiene todos los encabezados => r.Header

		accessToken := r.Header.Get("access_token")
		if len(accessToken) != 0 {
			fmt.Println(accessToken)
		}

		r.Header.Set("nombre", "valor") // Agregar encabezado, puede ser usado en redireccionamiento

		fmt.Println(r.Header)
		fmt.Fprintf(w, "Hola mundo")
	})

	log.Fatal(http.ListenAndServe("localhost:3000", nil))
}