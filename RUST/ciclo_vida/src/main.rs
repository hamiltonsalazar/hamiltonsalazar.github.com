fn main() {
    
    /*
    //Bloque limita el scope de una variable
    let mensaje = "Hola, soy una variable del bloque main.";

    println!("Bloque 1: {}", mensaje);

    {// Bloque 2
        
        let mensaje = "Hola soy una variable del bloque 2.";
        println!("Bloque 2: {}", mensaje);
        
        {// Bloque 3

            println!("Bloque 3: {}", mensaje);
            
            let resultado = 10 + 20;

            println!("Resultado: {}", resultado);

        }
    }
    */

    let mut mensaje = String::from("Hola, soy una variable para prestao.");

    {
        
        // let prestamo = mensaje; // prestamos -> se mueve
        let prestamo = &mensaje; // prestamos -> referencia
        mensaje.push_str("\nEstuve un bloque");

        // println!("{}", prestamo); // Freezing -> mensaje
    }

    println!("{}", mensaje);

}

