fn main() {
   // str -> No se puede modificar su longitud (Inmutable, Stack)
   // string -> Se puede modificar su longitud (Mutable, Head)

   // str
   let variable_str = "Hola, soy un tipo str";

   // String
   let mut variable_string = String::from("Hola soy un String");

   variable_string.push(',');
   variable_string.push(' ');
   variable_string.push('H');
   variable_string.push('O');
   variable_string.push('L');
   variable_string.push('A');
   variable_string.push(' ');

   variable_string.push_str("Estamos en el curso de CódigoFacilito");

   let nuevo_string = "Hola, soy una cadena.".to_string(); 

   let son_iguales = nuevo_string == "Hola, soy una cadena.".to_string();

   println!("El str es: {}.\nEl String es: {}", variable_str, variable_string);
   println!("Nueva cadena es: {}.\n¿Los Strings son iguales?: {}", nuevo_string, son_iguales);

}
