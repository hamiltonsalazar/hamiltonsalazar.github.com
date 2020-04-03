fn main() {

    // Enum -> CamelCase
    enum Response {
        Success,
        Error(u32, String), // 403, 403, 500
    }

    let respuesta = Response::Error(501, String::from("No es posible completar la operación."));

    match respuesta {
        Response::Success => println!("La petición se realizó exitosamente."),
        Response::Error(403, _) => println!("Forbidden."),
        Response::Error(404, _) => println!("Not Found."),
        Response::Error(500, _) => println!("Internal sever error."),
        Response::Error(_, mensaje) => println!("{}", mensaje)
    }

}
