package main

import "fmt"

type Human struct{
	name string
}

type Tutor struct{
	Human
	Dummy
}

type Dummy struct{
	name string
}

func (human Human) hablar() string{
	return "Bla bla bla"
}

func (tutor Tutor) hablar() string{
	return "Bienvenidos a CF"
}



func main() {

	tutor := Tutor {Human{"Smith"}, Dummy{"Hamilton"}}

	// fmt.Println(tutor.name) // cuando no existe ambigüedad.
	fmt.Println(tutor.Human.name)
	fmt.Println(tutor.Dummy.name)
	fmt.Println(tutor.Human.hablar())
	fmt.Println(tutor.hablar())



}