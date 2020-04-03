fn main() {

    /*
    let numero: i32 = 55;

    let mensaje = match numero {
        // valor => sentencia / tarea.
        1 => "El número es uno.",
        2 => "El número es dos.",
        3 => "El número es tres",
        4 | 5 | 6 => "El número se encuentra entre cuatro y seis",
        7..=100 => {
            let mensaje ="El número se evalua mediante un rango.";

            mensaje
        }
        _ => "numero" //Default sin ","
    };

    println!("El resultado es: {}.", mensaje);
    */

    for numero in 1..31 {
        match (numero % 3, numero % 5) {
            (0, 0) => println!("Fizz Buzz"),
            (0, _) => println!("Fizz"),
            (_, 0) => println!("Buzz"),
            _ => println!("{}", numero)
        }
    }
}
