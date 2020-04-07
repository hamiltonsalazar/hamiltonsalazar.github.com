package main

import "fmt"

type User struct{
		nombre, apellido string
		edad int
		
	}

func main() {

	// var user User{nombre: "Smith", apellido:"Carvajal", edad: 23}
	// var user User{nombre: "Smith", edad: 23}

	// user := User{nombre: "Smith", edad: 23, apellido:"Carvajal"}
	// user := User{nombre: "Smith", edad: 23}

	// user := User{"Smith", "Carvajal",23}
	// user := User{"Smith", "", 23}

	user := new (User) // new() crea un puntero
	user.nombre = "Smith"
	(*user).apellido = "Carvajal"
	//user.edad = 23

	fmt.Println(user)
	fmt.Println((*user).nombre)
	fmt.Println(*user)
	fmt.Println(user.nombre)

}