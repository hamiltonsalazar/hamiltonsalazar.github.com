package main

import "fmt"

func main () {
	
	//Unico ciclo existete en GO es for

	/*
	for i:=0; i<10; i++ {	
		fmt.Printf("I=%d\n",i+1)

	}
	*/

	// tipo while
	/* 
	i:=0
	for i<10 {	
		fmt.Printf("I=%d\n",i+1)
		i++
	}
	*/

	// ciclo infinito
	i:=0
	for {	
		if i == 2{
			i++
			continue
		}

		fmt.Printf("I=%d\n",i+1)
		i++
		//instrucciones para romper el ciclo infinito
		if i > 10 {
			break
		}
	}

}