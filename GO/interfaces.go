package main

import "fmt"

type User interface {
	Permisos() int // 1 - 5 
	Nombre() string
}

type Admin struct{
	nombre string
}

func (this Admin) Permisos() int{
	return 5
}
func (this Admin) Nombre() string{
	return this.nombre
}


type Editor struct{
	nombre string
}

func (this Editor) Permisos() int{
	return 3
}
func (this Editor) Nombre() string{
	return this.nombre
}


func auth(user User) string{
	if user.Permisos() >= 5 {
		return user.Nombre() + " tiene permisos de administrador."
	}
	return user.Nombre() + " no tiene permisos de administrador."
}

func main() {
	admin := Admin{"Smith"}
	fmt.Println(auth(admin))

	editor := Editor{"Hamilton"}
	fmt.Println(auth(editor))

	usuarios := []User{Admin{"Admin2"}, Editor{"Editor2"}}

	for _, usuario := range usuarios {
		fmt.Println(auth(usuario))
	}


}