package main

import ( 
	"net/http"
	"encoding/json"
)


type Curso struct{ 
	Titulo string `json:"título"`// Importante que el nombre del atributo esté la primera en mayúscula para que sea leído por Json
	NumeroVideos int
}

type Cursos []Curso

func main(){
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		cursos := Cursos{
			Curso{"Curso de GO", 30},
			Curso{"Curso de Ruby", 20},
			Curso{"Curso de NodeJS", 50},
			}
		json.NewEncoder(w).Encode(cursos)
	})

	http.ListenAndServe(":8000",nil)
}