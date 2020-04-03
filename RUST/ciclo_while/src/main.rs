fn main() {

    let mut contador = 1;

    while contador < 10 {
        println!("Contador: {}", contador);
        contador += 1;
    }

    //123 -> 3
    //12345 -> 5
    //123456789 -> 9

    let mut numero = 123323223;
    contador = 0;

    while numero > 0 {
        numero = numero / 10;
        contador += 1;
    }   

    println!("La antidad de digitos son: {}.", contador);

}
