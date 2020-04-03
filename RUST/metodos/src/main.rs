#[derive(Debug)]
struct User {
    username: String,
    password: String,
}

impl User {
    fn saluda(& self) {
        println!("Hola, soy el usuario {}.", self.username);
    }

    fn change_password(&mut self, new_password: String) {
        self.password = new_password;
    }
}

fn main() {
    let mut usuario1 = User {
        username: String::from("Smith"),
        password: String::from("password123"),
    };

    usuario1.saluda();
    usuario1.change_password("New password".to_string());

    println!("El usuario es: {:?}", usuario1);
}
