fn main() {
    
    let mut contador = 0;
    
    // loop
    
    loop {
        contador += 1;
        
        println!("Contador: {}.", contador);

        if contador >= 10 {
            break;
        }
    }
}
