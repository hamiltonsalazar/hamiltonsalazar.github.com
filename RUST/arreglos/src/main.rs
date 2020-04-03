fn main() {

    let numeros = [5, 4, 3, 2, 1];
    println!("El valor del arreglo es: {:?}", numeros);
    
    let mut numeros: [i32; 6] = [1, 2, 3, 4, 5, 6];
    println!("El valor del arreglo es: {:?}", numeros);

    let valores = ["true"; 10];
    println!("El valor del arreglo es: {:?}", valores);
    
    let primer_elemento = numeros[0];
    let ultimo_elemento = numeros[numeros.len()-1];

    numeros[2] =30;
    
    println!("El primer elemento es: {}.\nEl último elemento es: {}", primer_elemento, ultimo_elemento);
    println!("El valor del arreglo es: {:?}", numeros);

    

}
