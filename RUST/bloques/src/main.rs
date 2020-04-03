fn main() {
    /*
    let mensaje = "Hola, soy una variable en el bloque main.";

    let resultado = {
        println!("Hola desde un segundo bloque.");

        /*
        let mensaje="Hola, soy una variable en un bloque anidado.";
        println!("{}", mensaje);
        */

        let variable: i32 = 200;
        println!("Variable: {}", variable);
        
        variable // Return  el valor de "variable"
    }; // Uso de ";" solo cuando hay retorno y lo que se desea retornar no lleva ";"


   println!("{}", mensaje);


   println!("El valor de resultado es: {}.", resultado);
    */

    let claificacion: i8 = 10;

    let mensaje = if claificacion == 10 {
        String::from("Felicitaciones aprobaste.")
    }else {
        String::from("Necesitas estudiar más.")
    };

    println!("{}", mensaje);  

} 
