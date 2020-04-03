struct User {
    username: String,
    password: String
}

fn create_user(username: String, password: String) -> User{
    User {username, password}
}


fn main() {
    
    /*
    let usuario = User {
        username: String::from("Smith."),
        password: String::from("password123."),
    }; 

    */

    let username = String::from("Smith.");
    let password = String::from("password123.");

    // let usuario = User { username, password};
    let mut usuario = create_user(username, password);

    usuario.username = String::from("Camibio de valor.");

    println!("El usuario es: {}.\nEl password es: {}.", usuario.username, usuario.password);

}
