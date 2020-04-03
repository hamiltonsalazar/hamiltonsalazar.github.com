fn main() {
    // slices -> Heap
    // Arrays -> Stack

    let mensaje = String::from("Hola mundo, desde el curso de Rust");

    let hola = &mensaje[..4];  // Otra opción [0..4]
    let resto_mensaje = &mensaje[4..];  // Otra opción [4..mensaje.len()-1]
    let mensaje_completo = &mensaje[..];

    println!("El mensaje es: {}", mensaje);
    println!("El slice es: {}", hola);
    println!("El slice es: {}", resto_mensaje);
    println!("El slice es: {}", mensaje_completo);

}
