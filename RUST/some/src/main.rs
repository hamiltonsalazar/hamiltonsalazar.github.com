fn main() {

    let mensaje = None;

    match mensaje {
        Some("Hola mundo") => println!("El mensaje es: Hola mundo."),
        Some("Adios") => println!("El mensaje es: Adiós."),
        Some(_) => println!("El mensaje es: Es otro mensaje."),   
        None => println!("No existe valor alguno.")
    }

}
