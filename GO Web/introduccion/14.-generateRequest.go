package main

import(
	"net/http"
	"net/url"
	"fmt"
	"io/ioutil"
)

func createURL() string {
	u, err := url.Parse("/params")
	if err != nil {
		panic(err)
	}

	u.Host = "localhost:3000"
	u.Scheme = "http" 	// protocolo a usar http o https

	query := u.Query() // Nos regresa un mapa
	// query.Add("nombre", "valor")

	u.RawQuery = query.Encode()

	return u.String()
}


func main(){
	url := createURL()
	request, err := http.NewRequest("GET", url, nil)
	if err != nil{
		fmt.Println("Error1")
		panic(err)
	}
	request.Header.Set("Encabezado", "valor")

	client := &http.Client{}
	response, err := client.Do(request)
	if err != nil{
		fmt.Println("Error2")
		panic(err)
	}

	fmt.Println("El header es: ", response.Header)
	body, err := ioutil.ReadAll(response.Body)
	if err != nil{
		fmt.Println("Error3")
		panic(err)
	}
	fmt.Println("El body es: ", string(body))
	fmt.Println("El status es: ", response.Status)

	fmt.Println("La URL final es: "+url)
}