package main

import(
	"net/url"
	"fmt"
)

func createURL() string {
	
	// 	u, err := url.Parse("http://localhost:3000/params?nombre=valor") // Para crear de forma estática el URL, se debe ignorar todo después del if 
	u, err := url.Parse("/params")
	if err != nil {
		panic(err)
	}

	u.Host = "localhost:3000"
	u.Scheme = "http" 	// protocolo a usar http o https

	query := u.Query() // Nos regresa un mapa
	query.Add("nombre", "valor")

	u.RawQuery = query.Encode()

	return u.String()
}


func main(){
	url := createURL()
	fmt.Println("La URL final es: "+url)
}