/*
enum Result<T, E>{
    Ok(T),
    Err(E)
}
*/

#[derive(Debug)]
enum ErrorDivision {
    DivisionPorCero, 
    DivisionNegativos
}

fn division(numero1: i32, numero2: i32) -> Result<i32, ErrorDivision>{
    if numero2 == 0{
        return Err(ErrorDivision::DivisionPorCero);
    }
    if numero1 < 0 || numero2 < 0 {
        return Err(ErrorDivision::DivisionNegativos);
    }

    Ok(numero1 / numero2)
}

fn main() {
   
    //Result

    let resultado = division(10, 0); 

    // unwrap (ejecuta el panic! si no hay valor)
    //let valor = resultado.unwrap();

     // unwrap_or si hay error podemos enviar un valor por defecto, debe ser del mismo tipo del correcto
     //let valor = resultado.unwrap_or(0);

     // expect se ejecuta el panic! pero permite especificar el error.
    let valor = resultado.expect("No esposible dividir por 0");
    println!("El resultado es {}", valor);

    /*
    match resultado {
        Ok(valor) => println!("El resultado es: {}", valor),
        Err(ErrorDivision::DivisionPorCero) => {
            println!("El error es por intentar dividir por cero");
        },
        Err(ErrorDivision::DivisionNegativos) => {
            panic!("El error es por dividir negativos.");
        }
    }
    */

    

}
