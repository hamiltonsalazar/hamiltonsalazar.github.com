fn main() {

    let tupla = (10, false, 5.5);
    println!("El valor de la tupla es: {:?}", tupla);

    let mut tupla: (i32, bool, f64, i32) = (10, false, 5.0, 99);
    println!("El valor de la tupla es: {:?}", tupla);

    let primer_elemento = tupla.0;
    let ultimo_elemento = tupla.3;

    tupla.1 = true;

    println!("El primer elemento es: {}.\nEl último elemento es: {}", primer_elemento, ultimo_elemento);
    println!("El valor de la tupla es: {:?}", tupla);
}
