fn main() {

    const VALOR: i32 = 10; //tambien se puede usar "static" en reemplazo de "const"

    let mut numero_uno = 10;
    let numero_dos: i32 = 20;
    
    numero_uno = 100;
    
    let mut resultado = numero_uno + numero_dos + VALOR;


    println!("El valor de la operación ({} + {} + {}) es: {}", numero_uno, numero_dos, VALOR, resultado);

}
