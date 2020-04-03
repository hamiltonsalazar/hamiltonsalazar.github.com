struct Rectangulo {
    ancho: u32,
    alto: u32
}

fn area (rectangulo: &Rectangulo) -> u32{
    rectangulo.ancho * rectangulo.alto
}

fn main() {

    //Ownership

    /*
    * Cada valor en Rust tiene su propio ownership.
    * Solo puede existir un ownership a la vez. 
    * Si un ownership sale del alcance, el valor se descartará. 
    */

    let rectangulo = Rectangulo { ancho:10, alto:20 };
    // Prestamo por referencia &
    let resultado = area(&rectangulo);

    // Funciona para los objetos presentes en HEAP
    let nuevo_rectangulo = rectangulo; //Movimiento y perdida de Ownership


    println!("El área del rectangulo es: {}.", resultado);
    println!("El ancho y el alto del rectangulo es: {} - {}, respectivamente.", nuevo_rectangulo.ancho, nuevo_rectangulo.alto);
    
}
