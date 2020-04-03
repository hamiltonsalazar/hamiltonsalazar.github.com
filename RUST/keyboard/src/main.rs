use std::io;

fn main() {

    println!("Ingresa el nombre de usuario.");

    let mut username = String::new();  // Static -> ""

    // Result -> Exito o Error
    io::stdin().read_line(&mut username);  // referencia
    
    let username = username.trim();

    let mut edad = String::new();

    println!("Ingresa la edad del usuario:");
    
    io::stdin().read_line(&mut edad);

    let edad = edad.trim();

    // Result 
    let edad: i32 = edad.parse().unwrap();

    println!("Nombre de usuario: {}. \nEdad: {}", username, edad);


}
