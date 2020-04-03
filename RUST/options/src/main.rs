/*
enum Option<T>{
    Some(T), -> El valor
    Nome -> La ausencia de algún valor
}
*/


/*
fn obtene_valor(bandera: bool) -> Option<String> {
    if bandera {
        Some(String::from("Soy un mensaje para tupla some."))
    }else {
        None
    }
}
*/

#[derive(Debug)]
struct User {
    username: String,
    password: String,
    email: String,
    edad: Option<u32>
}

fn main() {
    
    // Option -> Si existe o no algún valor.
    // Result -> Errors -> panic!

    // let resultado = obtene_valor(false); // Option

    /*
    match resultado {
        Some(valor) => println!("El valor es: {}.", valor),
        None => println!("No existe valor alguno.")
    }
    */


    /*
    // unwrap -> Intenta obtener lo que la tula Some almacena
    // let valor = resultado.unwrap(); // Sin valor acude a panic!
    // let valor = resultado.unwrap_or("La tupla no almaena valor alguno".to_string());  // Para no ejecutar el panic!
    
    // expect -> Ejecuta el panic! pero con el mensaje.
    let valor = resultado.expect("Se esperaba un String");

    println!("El valor es: {}", valor);
    */

    let usuario1 = User{
        username: String::from("Smith"),
        password: String::from("password"),
        email: String::from("hamiltonsmith@hotmail.es"),
        edad: None //Some(26)
    };

    println!("El usuario es: {:?}", usuario1);

    //let edad = usuario1.edad.unwrap();

    match usuario1.edad {
        Some(edad) => println!("La edad es: {}", edad),
        None => {},
    }

    

}
