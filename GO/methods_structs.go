package main

import "fmt"

type User struct{
		nombre, apellido string
		edad int
		
	}

func (user User) nombre_completo() string{
	return user.nombre + " " + user.apellido
}

func (user *User) set_nombre(nombre string){
	user.nombre = nombre
}

func main() {
	
	user := new (User) 

	user.nombre = "Smith"
	user.apellido = "Carvajal"
	user.edad = 23;

	user.set_nombre("Hamilton")

	fmt.Println(user.nombre_completo())

}