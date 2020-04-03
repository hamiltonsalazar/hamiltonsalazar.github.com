fn main() {

    //let mut vector = vec![1, 2, 3];
    let mut vector: Vec<i32> = Vec::new(); // [] -> String::new()
    println!("El valor del vector es: {:?}", vector);

    vector.push(1);
    vector.push(2);
    vector.push(3);
    vector.push(4);
    vector.push(5);
    println!("El valor del vector es: {:?}", vector);

    vector.insert(0, 1);
    vector.insert(0, -2);
    vector.insert(2, 0);
    println!("El valor del vector es: {:?}", vector);

    vector.remove(vector.len()-1);
    println!("El valor del vector es: {:?}", vector);

    vector[0]=-10;

    let primer_elemento = vector[0];
    //let ultimo_elemento = vector[vector.len()-1];
    let ultimo_elemento = vector.pop().unwrap(); // Return un Option, elimina el último número y lo retorna en un Option
    println!("El primer elemento es: {}.\nEl último elemento es: {}", primer_elemento, ultimo_elemento);
    println!("El valor del vector es: {:?}", vector);


}
