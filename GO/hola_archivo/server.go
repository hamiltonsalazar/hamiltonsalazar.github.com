package main 
import(
	"net/http"
)

func main(){
	/*
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		http.ServeFile(w, r, r.URL.Path[1:]) // con r.URL.Path[1:] todo lo que escribamos en el explorador a partir de /, buscando a partir de la ruta / en que está el ./server.go

	})
	*/

	fileServer := http.FileServer(http.Dir("public"))
	http.Handle("/", http.StripPrefix("/",fileServer))
	http.ListenAndServe(":8000", nil)
}