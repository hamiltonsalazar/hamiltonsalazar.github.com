//insertOne
var user1 = {
    name: 'Oscar',
    last_name: 'Rodriguez',
    age: 22,
    email: 'Oscar22@gmail.com'
}

var user2 = {
    name: 'Hamilton',
    last_name: 'Carvajal',
    age: 23,
    email: 'hamiltonsalazar22@gmail.com'
}

db.users.insertOne(user2)

//insertMany

var user3 = {
    name: 'Smith',
    last_name: 'Salazar',
    age: 21,
    email: 'hamiltonsalazar@gmail.com'
}

var user4 = {
    name: 'Alejandro',
    last_name: 'Gutierrez',
    age: 26,
    email: 'alejandro@hotmail.com',
    suport: true,
    createdAt: new Date()
}
var user5 = {
    name: 'Pedro',
    last_name: 'Martinez',
    age: 21,
    email: 'hamiltonsalazar@gmail.com'
}


db.users.insertMany(
    [user3, user4]
)


db.users.find(
    { age: 23 }, //Criterios -> Where
    { name: true, email: true, _id: false } // Atributos a visualizar -> Select
).pretty()

// Obtener todos los usaurios cuya edad sea diferente a 23
// $ne- diferente a
db.users.find(
    {
        age: {
            $ne: 23
        }
    }
).pretty()

// $eq -> igual a
db.users.find(
    {
        age: {
            $eq: 23
        }
    }
).pretty()


// find -> +1 documento
// findOne -> 1ro

db.users.findOne(
    {
        age: {
            $eq: 23
        }
    }
)

db.users.findOne()

// Obtener todos los usuarios cuya edad sea mayor a 20
db.users.find(
    {
        age: {
            $gt: 20 // Mayor que
        }
    }
)

db.users.find(
    {
        age: {
            $gte: 23 // Mayor igual que
        }
    }
)

// $lte menor o igual que
// $lt menor que
// $gt mayor que
// $gte mayor igual que
// $eq igual
// $ne diferente

// Operadores lógicos
// $and y $or

// Obtener todos los usuarios cuya edad sea mayor a 20 y menor a 23
db.users.find(
    {
        $and: [
            {
                age: { $gt: 20 }
            },
            {
                age: { $lt: 23 }
            }
        ]
    }
)

// Obtener todos los usuarios cuyo nombre sea Smith o Hamilton
db.users.find(
    {
        $or: [
            {
                name: 'Hamilton Smith'
            },
            {
                name: 'Smith'
            },
            {
                $and: [
                    { age: { $gt: 20 } },
                    { age: { $lt: 23 } },
                ]
            }
        ]
    }
).pretty()



db.books.insertMany(
    [
        { title: 'Don Quijote de la Mancha', sales: 500 },
        { title: 'Historia de dos ciudades', sales: 200 },
        { title: 'El señor de los anillos', sales: 150 },
        { title: 'El principito', sales: 140 },
        { title: 'El hobbit', sales: 100 },
        { title: 'Alicia en el país de las maravillas', sales: 100 },
        { title: 'El código Da Vinci', sales: 80 },
        { title: 'El alquimista', sales: 65 }
    ]
)


// like -> expresión regular


// Obtener todos los libros cuyo titulo comience con "El"
// WHERE title LIKE 'El%'
db.books.find(
    {
        title: /^El/
    }
)

// Obtener todos los libros cuyo titulo termine con "s"
// WHERE title LIKE '%s'
db.books.find(
    {
        title: /s$/
    }
)

// Obtener todos los libros cuyo titulo posea la palabra "la"
// WHERE title LIKE '%la%'
db.books.find(
    {
        title: /la/
    }
)


// Obtener todos los usuarios cuyos nombres sea Hamilton o Smith
db.users.find(
    {
        $or: [
            {
                name: 'Hamilton'
            },
            {
                name: 'Smith'
            }
        ]
    }
)
// $in buscar valor dentro de una lista
db.users.find(
    {
        name: {
            $in: ['Hamilton', 'Smith']
        }
    }
).pretty()
// $nin buscar los qu no esten.
db.users.find(
    {
        name: {
            $nin: ['Hamilton']
        }
    }
).pretty()

db.users

// Obtener todos los usuarios que posean edad
db.users.find(
    {
        age: {
            $exists: true
        }
    }
)

// Obtener todos los usuarios cuyo atributo createdAt sea de tipo date
db.users.find(
    {
        createdAt: {
            $type: 'date'
        }
    }
)
db.users.find(
    {
        $and: [
            {
                createdAt: { $exists: true }
            },
            {
                createdAt: { $type: 'date' }
            }
        ]
    }
)


var alejandro = db.users.findOne(
    {
        name: 'Alejandro'
    }
)

alejandro.suport = false
// argumento un documento, si l documento posee el attr id -> update si no -> create
db.users.save(alejandro)

var hamilton = db.users.findOne(
    {
        $and: [
            {
                name: 'Hamilton'
            },
            {
                age: { $exists: false }
            }
        ]
    }
)
hamilton.age = 22
db.users.save(hamilton)

// updateOne o updateMany

db.users.updateMany(
    {
        support: {
            $exists: false
        }
    },
    {
        $set: {
            support: false
        }
    }
)

db.users.updateOne(
    {
        name: 'Alejandro'
    },
    {
        $set: {
            support: true
        }
    }
)

db.users.updateOne(
    {
        name: 'Alejandro'
    },
    {
        $unset: { 'suport': "" }
    }
)
db.users.updateOne(
    {
        createdAt: { $exists: true }
    },
    {
        $unset: { 'createdAt': "" }
    }
)

// $inc -> incrementar el valor de un atributo (enteros)
db.users.updateOne(
    {
        name: 'Alejandro'
    },
    {
        $inc: {
            age: 1
        }
    }
)

// upsert -> updat
db.users.updateOne(
    {
        name: 'Luis'
    },
    {
        $set: { age: 28 }
    },
    {
        upsert: true
    }
)

// remove({})
db.users.remove(
    {
        name: 'Luis'
    }
)

db.books.remove({}) // elimina todos los documentos

dropDatabase() // eliminar una base de datos
drop() // elimina una colección

for (i = 0; i < 100; i++) {
    db.demo.insert(
        { name: 'user' + i }
    )
}

db.demo.find()
// find() retorna un cursor
// findOne() retorna un documento
// pretty() cambia la vista
// count() Obtiene la cantidad

db.users.find(
    {
        email: /hotmail/
    }
).count()

// limit(i)  limita la cantidad de resultados
db.users.find().limit(2)
// skip(i) Salta la cantidad indicada
db.users.find().skip(2).limit(1)
// sort() Ordenar documentos
db.users.find(
    {}, // Todos los documntos
    {
        _id: false, name: true
    },
).sort(
    {
        name: -1
    }
)
// 1 ASC, -1 DESC

//Obtener el tercer usuario ordenado por su nombre
db.users.find(
    {},
    {
        _id: false, name: true
    }
).sort(
    {
        name: 1
    }
).skip(2).limit(1)


// findAndModify()
db.users.findAndModify(
    {
        // sort, remove, upsert
        query: {
            name: 'Alejandro'
        },
        update: {
            $inc: {
                age: 1
            }
        },
        new: true
    }
)

db.users.updateMany(
    {},
    {
        $rename: {
            last_name: 'lastName'
        }
    }
)


db.users.updateOne(
    {
        name: 'Hamilton'
    },
    {
        $set: {
            courses: ['Python', 'MongoDB', 'SQL', 'Java']
        }
    }
)

db.users.updateOne(
    {
        name: 'Smith'
    },
    {
        $set: {
            courses: ['Git', 'Escritura para programadores', 'Redes']
        }
    }
)

// Obtener al usuario que posea a los cursos de Python, MongoDB, SQL y Java
db.users.findOne(
    {
        courses: ['Python', 'MongoDB', 'SQL', 'Java']
    }
)
db.users.findOne(
    {
        courses: {
            $eq: ['Python', 'MongoDB', 'SQL', 'Java']
        }
    }
)

// $all
// Obtener todos los usuarios que posean un curso MongoDB y SQL
db.users.find(
    {
        courses: {
            $all: ['MongoDB', 'SQL'] // No importa el orden, funciona como and
        }
    }
).pretty()

db.users.find(
    {
        courses: 'SQL'
    }
).pretty()

db.users.find(
    {
        $and: [
            {
                courses: 'SQL'
            },
            {
                courses: 'MongoDB'
            }
        ]
    }
).pretty()

// Obtener todos los usuarios que posean un curso MongoDB o Git
db.users.find(
    {
        $or: [
            {
                courses: 'Git'
            },
            {
                courses: 'MongoDB'
            }
        ]
    }
).pretty()

db.users.updateOne(
    {
        name: 'Alejandro'
    },
    {
        $set: {
            scores: [9, 8, 9, 5, 10]
        }
    }
)
db.users.updateOne(
    {
        name: 'Oscar'
    },
    {
        $set: {
            scores: [10, 9, 9, 8, 10]
        }
    }
)

// Obtener todos los usuarios que posean por lo menos una calificación de 10.
db.users.find(
    {
        scores: 10
    }
).pretty()

// Obtener todos los usuarios que hayan reprobado por lo menos una calificación., (<6)
db.users.find(
    {
        scores: {
            $lt: 6
        }
    }
).pretty()

// $push $pull $pop
db.users.updateOne(
    {
        name: 'Smith'
    },
    {
        $push: {
            courses: 'Python'
        }
    }
)

// $push $each
db.users.updateOne(
    {
        name: 'Hamilton'
    },
    {
        $push: {
            courses: {
                $each: ['Django', 'Rails', 'Rust']
            }
        }
    }
)

// $position
db.users.updateOne(
    {
        name: 'Smith'
    },
    {
        $push: {
            courses: {
                $each: ['Base de datos'],
                $position: 0
            }
        }
    }
)

db.users.updateOne(
    {
        name: 'Smith'
    },
    {
        $push: {
            courses: {
                $each: ['Javascript'],
                $position: 1
            }
        }
    }
)

db.users.updateOne(
    {
        name: 'Smith'
    },
    {
        $push: {
            courses: {
                $each: ['C#', 'Python'],
                $position: 1
            }
        }
    }
)

// $sort
db.users.updateOne(
    {
        name: 'Alejandro'
    },
    {
        $push: {
            scores: {
                $each: [10, 10],
                $sort: 1
            }
        }
    }
)

db.users.updateOne(
    {
        name: 'Oscar'
    },
    {
        $push: {
            scores: {
                $each: [7, 7],
                $sort: -1
            }

        }
    }
)

// $pull
db.users.updateMany(
    {
        courses: { $exists: true }
    },
    {
        $pull: {
            courses: 'Python'
        }
    }
)

db.users.updateMany(
    {
        courses: { $exists: true }
    },
    {
        $pull: {
            courses: {
                $in: ['Javascript', 'Django']
            }
        }
    }
)

db.users.updateOne(
    {
        name: 'Oscar'
    },
    {
        $push: {
            scores: {
                $each: [],
                $sort: 1
            }

        }
    }
)

// Actualizar lista cuando conocemos el indice
db.users.updateMany(
    {
        scores: { $exists: true }
    },
    {
        $set: {
            'scores.0': 4
        }
    }
)

// Actualizar lista cuando no conocemos el indice
db.users.updateMany(
    {
        scores: { $exists: true },
        scores: 9
    },
    {
        $set: {
            'scores.$': 6
        }
    }
)

db.users.updateMany(
    {
        scores: { $exists: true },
        scores: 15
    },
    {
        $set: {
            'scores.$': 10
        }
    }
)

// $slice ->position o index
db.users.findOne(
    {
        name: 'Hamilton'
    },
    {
        _id: false,
        name: true,
        courses: {
            $slice: 1 // int posición (-1 último)
        }
    }
)
db.users.findOne(
    {
        name: 'Hamilton'
    },
    {
        _id: false,
        name: true,
        courses: {
            $slice: [0, 3] // []  index (limites, fin no incluido)
        }
    }
)

// Obtener todos los usuarios con 5 cursos.
// $size no se pueden usar operadores relacionales.
db.users.find(
    {
        courses: {
            $size: 5
        }
    }
).pretty()


// Obtener todos los usuarios con 3 o más cursos
// $where
db.users.find(
    {
        $and: [
            {
                courses: { $exists: true }
            },
            {
                $where: 'this.courses.length >= 3'
            }
        ]
    }
).pretty()

// Documentos anidados
db.users.updateOne(
    {
        name: 'Hamilton'
    },
    {
        $set: {
            address: {
                state: 'Meta',
                city: 'Villavicencio',
                postalCode: 1

            }
        }
    }
)

db.users.updateOne(
    {
        name: 'Pedro'
    },
    {
        $set: {
            address: {
                state: 'Meta',
                city: 'Villavicencio',
                number: 10,
                street: 'Calle # 1',
                postalCode: 1,
                references: ['Casa color azul', 'a un costado de la tienda']
            }
        }
    }
)


// Obtener todos los usuarios que posean una direción postal

db.users.find(
    {
        address: { $exists: true }
    }
).pretty()

// Obtener todos los usuarios que posean un código postal 1 y un número mayor o igual a 10
db.users.find(
    {
        $and: [
            { 'address.postalCode': 1 },
            {
                'address.number': { $exists: true }
            },
            {
                'address.number': {
                    $gte: 10
                }
            }
        ]
    }
).pretty()

// Obtener la primera referencia de los usuarios con código postal y la primer referencia
db.users.find(
    {
        $and: [
            {
                address: { $exists: true }
            },
            {
                'address.references': { $exists: true }
            }
        ]
    },
    {
        _id: false,
        name: true,
        'address.references': {
            $slice: 1
        }
    }
).pretty()


db.users.updateOne(
    {
        name: 'Hamilton'
    },
    {
        $set: {
            'address.number': 20,
            'address.references': [
                'Fuera de la casa se encuentra un parque',
                'Fuera de la casa se encuentra un pino (árbol)'
            ]
        }
    }
)

db.users.updateOne(
    {
        name: 'Hamilton'
    },
    {
        $set: {
            'address.number': 25
        }
    }
)

db.users.updateOne(
    {
        name: 'Pedro'
    },
    {
        $push: {
            'address.references': {
                $each: [
                    'Fuea de la casa hay un río',
                    'En la esquina hay un campo de tenis'
                ]
            }
        }
    }
)

db.users.updateOne(
    {
        name: 'Pedro',
        'address.references': 'a un costado de la tienda'
    },
    {
        $set: {
            'address.references.$': 'A un costado de la tienda'
        }
    }
)

db.users.updateMany(
    {
        courses: { $exists: true }
    },
    {
        $unset: {
            courses: true
        }
    }
)

db.users.updateOne(
    {
        name: "Smith"
    },
    {
        $set: {
            courses: [
                {
                    title: "MongoDB",
                    progress: 50,
                    completed: false
                },
                {
                    title: "Base de datos",
                    progress: 100,
                    completed: true
                },
                {
                    title: "Git",
                    progress: 100,
                    completed: true
                }
            ]
        }
    }
)

db.users.updateOne(
    {
        name: 'Smith'
    },
    {
        $set: {
            name: 'Rafael',
            lastName: 'Alvaréz',
            email: 'rafa@codigofacilito.com',
            age: 29,
        }
    }
)

db.users.updateOne(
    {
        name: 'Pedro'
    },
    {
        $set: {
            name: 'Marines',
            lastName: 'Méndez',
            email: 'marines@codigofacilito.com',
            age: 25,
            'address.state': 'CDMX',
            'address.city': 'CDMX',
            'address.street': 'Calle número 1'
        }
    }
)

db.users.updateOne(
    {
        name: 'Hamilton'
    },
    {
        $set: {
            name: 'Uriel',
            lastName: 'Camacho',
            email: 'uriel@codigofacilito.com',
            age: 27,
            'address.state': 'CDMX',
            'address.city': 'CDMX',
            scores: [5, 6, 8, 7]
        }
    }
)

db.users.updateOne(
    {
        name: 'Oscar'
    },
    {
        $set: {
            name: 'Fernando',
            lastName: 'García',
            email: 'fernando@codigofacilito.com',
            age: 24,
            scores: [5, 6, 10, 10]
        }
    }
)

db.users.updateOne(
    {
        name: 'Alejandro'
    },
    {
        $set: {
            name: 'Eduardo',
            lastName: 'García',
            email: 'eduardo@codigofacilito.com',
            age: 26
        },
        $unset: {
            scores: true
        }
    }
)

db.users.updateOne(
    {
        name: "Eduardo"
    },
    {
        $set: {
            courses: [
                {
                    title: "MongoDB",
                    progress: 50,
                    completed: false
                },
                {
                    title: "Python",
                    progress: 100,
                    completed: true
                },
                {
                    title: "Ruby",
                    progress: 80,
                    completed: false
                }
            ]
        }
    }
)

db.users.updateOne(
    {
        name: "Fernando"
    },
    {
        $set: {
            courses: [
                {
                    title: "Vue",
                    progress: 50,
                    completed: false
                },
                {
                    title: "Docker",
                    progress: 50,
                    completed: false
                }
            ]
        }
    }
)

// $elemMatch

// Obtener todos los usuarios que hayan compleatado por lo menos un curso.
db.users.find(
    {
        courses: {
            $elemMatch: {
                completed: true
            }
        }
    }
).pretty()

// Obtener todos los usuarios con un progreso mayor a 80
db.users.find(
    {
        courses: {
            $elemMatch: {
                progress: { $gte: 80 }
            }
        }
    }
).pretty()

// Obtener el nombre del usuario junto con el titulo de cada uno de sus cursos
db.users.find(
    {
        courses: { $exists: true }
    },
    {
        _id: false,
        name: true,
        'courses.title': true
    }
).pretty()

db.users.updateOne(
    {
        name: 'Fernando'
    },
    {
        $set: {
            'courses.0.progress': 100,
            'courses.0.completed': true
        }
    }
)

db.users.updateOne(
    {
        name: 'Fernando',
        'courses.title': 'Docker'
    },
    {
        $set: {
            'courses.$.progress': 100,
            'courses.$.completed': true,
            'courses.$.tutor': {
                name: 'Cody'
            }
        }
    }
)

db.users.updateOne(
    {
        name: 'Fernando',
        'courses.title': 'Docker'
    },
    {
        $set: {
            'courses.$.tutor.name': 'CodigoFacilito'
        }
    }
)


// aggregate([ tareas ])
db.users.find(
    {
        age: {
            $gt: 25
        }
    }
).pretty()

db.users.aggregate(
    [
        {
            $match: {
                age: { $gt: 25 }
            }
        }
    ]
).pretty()

db.users.aggregate(
    [
        {
            $match: {
                age: { $gt: 25 }
            }
        },
        {
            $match: {
                courses: { $exists: true }
            }
        },
        {
            $match: {
                lastName: 'Alvaréz'
            }
        }
    ]
).pretty()

// $project
db.users.aggregate(
    [
        {
            $match: {
                age: { $gt: 25 }
            }
        },
        {
            $match: {
                courses: { $exists: true }
            }
        },
        {
            $project: {
                _id: false,
                name: true,
                courses: true,
                age: true
            }
        }
    ]
).pretty()

// $slice
db.users.aggregate(
    [
        {
            $match: {
                age: { $gt: 25 }
            }
        },
        {
            $match: {
                courses: { $exists: true }
            }
        },
        {
            $project: {
                _id: false,
                name: true,
                courses: true,
                age: true
            }
        },
        {
            $project: {
                name: true,
                firstCourses: {
                    $slice: ['$courses', 2] //primer parámetro: atributo a trabajar; segundo parámetro, cantidad a mostrar
                }
            }
        }
    ]
).pretty()


// $arrayElemAt
db.users.aggregate(
    [
        {
            $match: {
                age: { $gt: 25 }
            }
        },
        {
            $match: {
                courses: { $exists: true }
            }
        },
        {
            $project: {
                _id: false,
                name: true,
                courses: true,
                age: true
            }
        },
        {
            $project: {
                name: true,
                firstCourses: {
                    $slice: ['$courses', 2]
                }
            }
        },
        {
            $project: {
                name: true,
                course: {
                    $arrayElemAt: ['$firstCourses', 0] // primer parámetro: lista sobre la que se trabajará; segundo parámetro index del elemento a visualizar.
                }
            }
        }
    ]
).pretty()


// $addFields
db.users.aggregate(
    [
        {
            $match: {
                age: { $gt: 25 }
            }
        },
        {
            $match: {
                courses: { $exists: true }
            }
        },
        {
            $project: {
                _id: false,
                name: true,
                courses: true,
                age: true
            }
        },
        {
            $project: {
                name: true,
                firstCourses: {
                    $slice: ['$courses', 2]
                }
            }
        },
        {
            $project: {
                name: true,
                course: {
                    $arrayElemAt: ['$firstCourses', 0]
                }
            }
        },
        {
            $addFields: {
                currentDate: new Date(),
                newName: '$name'
            }
        }
    ]
).pretty()

// $set
db.users.aggregate(
    [
        {
            $match: {
                scores: { $exists: true }
            }
        },
        {
            $project: {
                _id: false,
                name: true,
                scores: true
            }
        },
        {
            $set: {
                sum: {
                    $sum: '$scores'
                }
            }
        },
        {
            $set: {
                avg: { $avg: '$scores' }
            }
        },
        {
            $match: {
                avg: { $gt: 7 }
            }
        }
    ]
).pretty()

// $concat
db.users.aggregate(
    [
        {
            $match: {
                $and: [
                    { name: { $exists: true } },
                    { lastName: { $exists: true } }
                ]
            }
        },
        {
            $project: {
                _id: false,
                name: true,
                lastName: true
            }
        },
        {
            $project: {
                fullName: {
                    $concat: ['$name', ' ', '$lastName']
                }
            }
        }
    ]
).pretty()

db.items.insertMany(
    [
        { type: 'Camera', colo: 'Red', price: 120 },
        { type: 'Laptop', colo: 'White', price: 400 },
        { type: 'Laptop', colo: 'Black', price: 600 },
        { type: 'Camera', colo: 'Silver', price: 200 },
        { type: 'Microphone', colo: 'Silver', price: 200 },
        { type: 'Mouse', colo: 'White', price: 50 },
        { type: 'Monitor', colo: 'White', price: 50 }
    ]
)

// $group
// Agrupar y contar la cantidad de items con respecto a su tipo
db.items.aggregate(
    [
        {
            $group: {
                _id: '$type',
                total: { $sum: 1 }
            }
        }
    ]
).pretty()

// Agrupar y contar la cantidad de items con respecto a su tipo, mostrando los que hayan más de uno
db.items.aggregate(
    [
        {
            $group: {
                _id: '$type',
                total: { $sum: 1 }
            }
        },
        {
            $match: {
                total: { $gt: 1 }
            }
        }
    ]
).pretty()

// $limit y $sort
// Obtener al usuario más joven
db.users.aggregate(
    [
        {
            $sort: {
                age: 1
            }
        },
        {
            $limit: 1
        },
        {
            $project: {
                _id: false, name: true, age: true
            }
        }
    ]
).pretty()

// $map
db.users.aggregate(
    [
        {
            $match: {
                scores: { $exists: true }
            }
        },
        {
            $project: {
                _id: false, name: true, scores: true
            }
        },
        {
            $project: {
                name: true,
                scores: true,
                newListScores: {
                    $map: {
                        input: '$scores',
                        as: 'calificación',
                        in: {
                            $multiply: ['$$calificación', 10]
                        }
                    }
                }
            }
        }
    ]
).pretty()

db.users.aggregate(
    [
        {
            $match: {
                courses: { $exists: true }
            }
        },
        {
            $project: {
                _id: false, name: true, courses: true
            },

        },
        {
            $project: {
                newList: {
                    $map: {
                        input: '$courses',
                        as: 'course',
                        in: {
                            $multiply: ['$$course.progress', 10]
                        }
                    }
                }
            }
        }
    ]
).pretty()

// Relación uno a uno
// Relación uno a muchos
// Relación muchos a muchos

// Relación uno a uno
var usuarios = {
    nombre: 'Raquel',
    apellido: 'Dominguez',
    edad: 27,
    correo: 'raquel@example.com',
    direccionPostal: {
        calle: 'calle',
        ciudad: 'ciudad',
        estado: 'estado',
        codigoPostal: 1,
        numeroExt: 10,
    }
}

db.users.insertOne(usuarios)

// Relación uno a muchos
// Opcion 1
var autor = {
    nombre: 'Stephen King',
    nacionalidad: 'Estadounidense'
    libros: [
        {
            titulo: 'it',
            fechaLanzamiento: 1986
        },
        {
            titulo: 'El resplandor',
            fechaLanzamiento: 1997
        },
        {
            titulo: 'Misery',
            fechaLanzamiento: 1987
        }
    ]
}

// Opcion 2 "Llaves foraneas" -> ObjectsId
var autor = {
    nombre: 'Stephen King',
    nacionalidad: 'Estadounidense'
}

db.autores.insertOne(autor)
// ObjectId("5ec1d11cc153c45f1b91ee3d")

var libro1 = {
    titulo: 'it',
    fechaLanzamiento: 1986,
    autor_id: ObjectId("5ec1d11cc153c45f1b91ee3d") // "llave foranea"
}

var libro2 = {
    titulo: 'El resplandor',
    fechaLanzamiento: 1997,
    autor_id: ObjectId("5ec1d11cc153c45f1b91ee3d") // "llave foranea"
}

var libro3 = {
    titulo: 'Misery',
    fechaLanzamiento: 1987,
    autor_id: ObjectId("5ec1d11cc153c45f1b91ee3d") // "llave foranea"
}

db.libros.insertMany(
    [
        libro1, libro2, libro3
    ]
)

db.autores.find(
    {
        _id: ObjectId("5ec1d11cc153c45f1b91ee3d")
    }
).pretty()

db.users.createIndex(
    {
        autor_id: 1
    }
)

db.users.getIndexes()

// $lookup -> join

db.autores.insertMany(
    [
        { nombre: 'J.K Rowling', nacionalidad: 'Britanica' },
        { nombre: 'George R. R. Martin', nacionalidad: 'Estadounidense' }
    ]
)

db.libros.insertMany(
    [
        {
            titulo: 'Harry potter y la piedra filosofal',
            fechaLanzamiento: 1997,
            autor_id: ObjectId("5ec1d54253561c1cff50d56d")
        },
        {
            titulo: 'Harry potter y El prisionero de Azkaban',
            fechaLanzamiento: 1999,
            autor_id: ObjectId("5ec1d54253561c1cff50d56d")
        }
    ]
)

// Obtener todos los autores con su correspondiente listado de libros
db.autores.aggregate(
    [
        {
            $lookup: {
                from: 'libros',
                localField: '_id',
                foreignField: 'autor_id',
                as: 'listadoLibros'
            }
        }
    ]
).pretty()

// Obtener todos los autores que posean por lo menos un libro
db.autores.aggregate(
    [
        {
            $lookup: {
                from: 'libros',
                localField: '_id',
                foreignField: 'autor_id',
                as: 'listadoLibros'
            }
        },
        {
            $match: {
                listadoLibros: {
                    $ne: []
                }
            }
        },
        {
            $project: {
                _id: false, nombre: true
            }
        }
    ]
).pretty()

// $unwind
db.autores.aggregate(
    [
        {
            $lookup: {
                from: 'libros',
                localField: '_id',
                foreignField: 'autor_id',
                as: 'listadoLibros'
            }
        },
        {
            $unwind: '$listadoLibros'
        },
        {
            $project: {
                nombre: true,
                _id: false,
                libro: '$listadoLibros'
            }
        },
        {
            $project: {
                nombre: true,
                'libro.titulo': true,
                'libro.fechaLanzamiento': true
            }
        }
    ]
).pretty()

db.autores.find(
    {
        name: 'Stephen king'
    }
).explain()
db.autores.find(
    {
        name: 'Stephen king'
    }
).explain('executionStats')


    // mongodump
    // mongorestore

    // Hacer copia de seguridad db
    > $ mongodump--db cursoMongoDB

        // Restablecer desde una copia
        > $ mongorestore C: \Users\hamil\dump\cursoMongoDB

            // collections
            > $ mongodump--collection autores--db cursoMongoDB

                > $ mongorestore--collection autores--db cursoMongoDB C: \Users\hamil\dump\cursoMongoDB\autores.bson



db.ColeccionPrueba.find(
    {},
    {
        'sales.articulos': false
    }
).pretty().limit(1)


db.ColeccionPrueba.find(
    {
        'courses.progress': { $eq: 100 }
    },
    {
        'sales.articulos': false
    }
).pretty().count()

db.ColeccionPrueba.find(
    {
    },
    {
        'sales.articulos': false
    }
).pretty().limit(1)


db.ColeccionPrueba.findOne(
    {
        'courses.tutor.name': 'Codeacademy'
    },
    {
        'sales.articulos': false
    }
)

db.ColeccionPrueba.findOne(
    {
        'courses.tutor.name': 'Codeacademy'
    },
    {
        'sales.articulos': false
    }
)

db.ColeccionPrueba.find(
    {
        $and: [
            {
                'age': {
                    $gt: 50
                }
            },
            {
                'courses.completed': true
            },
            {
                'sex': 'M'
            }
        ]
    },
    {
        name: true,
        age: true,
        'courses.title': true
    }
).pretty()

db.ColeccionPrueba.find(
    {
        name: 'Hamilton'
    },
    {
        name: true,
        age: true
    }
).pretty()

db.ColeccionPrueba.aggregate(
    [
        {
            $match: {
                $and: [
                    {
                        scores: { $exists: true }
                    },
                    {
                        sex: 'M'
                    }
                ]
            }
        },
        {
            $project: {
                _id: false,
                name: true,
                scores: true
            }
        },
        {
            $set: {
                sum: {
                    $sum: '$scores'
                }
            }
        },
        {
            $set: {
                avg: { $avg: '$scores' }
            }
        },
        {
            $match: {
                avg: { $gt: 7 }
            }
        }
    ]
).pretty()

db.ColeccionPrueba.find(
    {
        'address.references': { $exists: true }
    },
    {
        'sales.articulos': false
    }
).pretty().count()


db.ColeccionPrueba.find(
    {
        texts: /Mongo/
    },
    {
        'sales.articulos': false
    }
).pretty().limit(1)


db.ColeccionPrueba.find(
    {
        _id: "292"
    },
    {
        'sales.products': true
    }
).pretty().limit(1)



// PROJECT:


// 5. ¿Cuáles personas tienen un texto específico y que tengan entre 5 y 10 calificaciones?

db.ColeccionPrueba.aggregate(
    [
        {
            $match: {
                scores: { $exists: true },
                texts: { $exists: true }
            }
        },
        {
            $match: {
                $and: [
                    {
                        $or: [
                            {
                                scores: { $size: 5 }
                            },
                            {
                                scores: { $size: 6 }
                            },
                            {
                                scores: { $size: 7 }
                            },
                            {
                                scores: { $size: 8 }
                            },
                            {
                                scores: { $size: 9 }
                            },
                            {
                                scores: { $size: 10 }
                            }
                        ]
                    },
                    {
                        texts: /verde valle rodeado de monta/
                    }
                ]
            }
        },
        {
            $project: {
                name: true,
                secondName: true,
                lastName: true,
                secondLastName: true,
                scores: true,
                texts: true
            }
        },
        {
            $sort: {
                _id: 1
            }
        }
    ]
)


db.ColeccionPrueba.find(
    {
        $and: [
            {
                $or: [
                    {
                        scores: { $size: 5 }
                    },
                    {
                        scores: { $size: 6 }
                    },
                    {
                        scores: { $size: 7 }
                    },
                    {
                        scores: { $size: 8 }
                    },
                    {
                        scores: { $size: 9 }
                    },
                    {
                        scores: { $size: 10 }
                    }
                ]
            },
            {
                texts: /verde valle rodeado de monta/
            }
        ]
    },
    {
        name: true,
        secondName: true,
        lastName: true,
        secondLastName: true,
        scores: true,
        texts: true
    }
).sort(
    {
        _id: 1
    }
)



// 5. ¿ Cuáles personas tienen un texto específico y que tengan un promedio mayor a X?

db.ColeccionPrueba.aggregate(
    [
        {
            $match: {
                scores: { $exists: true },
                texts: { $exists: true }
            }
        },
        {
            $project: {
                name: true,
                secondName: true,
                lastName: true,
                secondLastName: true,
                scores: true,
                texts: true
            }
        },
        {
            $set: {
                avg: { $avg: '$scores' }
            }
        },
        {
            $match: {
                $and: [
                    {
                        avg: { $gte: 7 }
                    },
                    {
                        texts: /verde valle rodeado de monta/
                    }
                ]
            }
        },
        {
            $project: {
                texts: false
            }
        },
        {
            $sort: {
                _id: 1
            }
        },
        {
            $limit: 20
        }
    ]
).pretty()



// 11. Mostrar la información de los clientes que han comprado más de X veces el producto XYZ.

db.ColeccionPrueba.aggregate(
    [
        {
            $match: {
                'sales.products': { $exists: true }
            }
        },
        {
            $unwind: '$sales'
        },
        {
            $project: {
                name: true,
                sales_Products: '$sales.products.name'
            }
        },
        {
            $unwind: '$sales_Products'
        },
        {
            $group: {
                _id: {
                    id: '$_id',
                    product: '$sales_Products'
                },
                total: { $sum: 1 }
            }
        },
        {
            $match: {
                total: {
                    $gt: 30
                },
                '_id.product': /Almohadilla Dactilar Artline X 1 Unidad Huellero 5000 Imps/
            }
        },
        {
            $sort: {
                '_id.product': 1
            }
        }
    ]
).pretty()



// 12. Mostrar la información de la última compra del producto XYZ de un cliente XYZ.

db.ColeccionPrueba.aggregate(
    [
        {
            $match: {
                _id: "345",
                sales: { $exists: true }
            }
        },
        {
            $unwind: '$sales'
        },
        {
            $match: {
                'sales.products': {
                    $elemMatch: {
                        name: /Velita Escarch/
                    }
                }
            }
        },
        {
            $project: {
                sales: true
            }
        },
        {
            $project: {
                'sales.products': false
            }
        },
        {
            $sort: {
                'sales.date': -1
            }
        },
        {
            $limit: 1
        }
    ]
).pretty()



// 8. Agrupar las personas que tenga texts de un tema en especifico

db.ColeccionPrueba.aggregate(
    [
        {
            $unwind: '$texts'
        },
        {
            $group: {
                _id: {
                    text: '$texts'
                },
                users: {
                    $addToSet: {
                        id: "$_id",
                        name: '$name',
                        secondName: "$secondName",
                        lastName: "$lastName",
                        secondLastName: "$secondLastName"
                    }
                }
            }
        },
        {
            $project: {
                _id: false,
                text: '$_id.text',
                users: true
            }
        },
        {
            $sort: {
                text: 1
            }
        }
    ]
).pretty()

// 6. ¿Cuántas personas mayores a una edad especifica viven en un lugar específico ('address.references' coincide con el texto de búsqueda)?

db.ColeccionPrueba.aggregate(
    [
        {
            $match: {
                'address.references': { $exists: true },
                texts: { $exists: true },
                age: { $gte: 50 }
            }
        },
        {
            $match: {
                'address.references': /calle sin pavi/,
                texts: /en la ciudad de El Cairo un hombre cansado de trabajar para ganarse el pan/
            }
        },
        {
            $project: {
                name: true,
                secondName: true,
                lastName: true,
                secondLastName: true,
                age: true,
                address: true,
                texts: true
            }
        }
    ]
).pretty()

// 9. Agrupar las personas por lugar de vivienda (references) y organizar por el riesgo de edad (De mayor a menor edad)
db.ColeccionPrueba.aggregate(
    [
        {
            $match: {
                'address.references': { $exists: true }
            }
        },
        {
            $unwind: '$address.references'
        },
        {
            $project: {
                name: true,
                secondName: true,
                lastName: true,
                secondLastName: true,
                age: true,
                address: true
            }
        },
        {
            $group: {
                _id: { reference: '$address.references' },
                users: {
                    $addToSet: {
                        id: "$_id", name: '$name', secondName: "$secondName", lastName: "$lastName", secondLastName: "$secondLastName", age: "$age", address: "$address"
                    }
                }
            }
        },
        {
            $project: {
                _id: false,
                reference: '$_id.reference',
                users: true
            }
        },
        {
            $project: {
                'users.address.references': false
            }
        }
    ]
).pretty()

// 4. ¿Cuál es el texto que más se repite en una misma persona? (Completo toda una posición del [])

db.ColeccionPrueba.aggregate(
    [
        {
            $project: {
                fullName: {
                    $concat: ['$name', " ", { $ifNull: ["$secondName", ""] }, ' ', '$lastName', ' ', '$secondLastName']
                },
                texts: true
            }
        },
        {
            $unwind: '$texts'
        },
        {
            $group: {
                _id: {
                    "_id": "$_id",
                    "text": "$texts",
                    "fullName": '$fullName'
                },
                total: { $sum: 1 }
            }
        },
        {
            $project: {
                _id: '$_id._id',
                fullName: "$_id.fullName",
                text: "$_id.text",
                total: true
            }
        },
        {
            $group: {
                _id: {
                    "_id": "$_id",
                    "fullName": "$fullName",
                    repeticiones: "$total"
                },
                texts: {
                    $addToSet: "$text"
                }
            }
        },
        {
            $project: {
                _id: '$_id._id',
                fullName: "$_id.fullName",
                masRepeticiones: {
                    texts: "$texts",
                    repeticiones: "$_id.repeticiones"
                }
            }
        },
        {
            $sort: {
                _id: 1, "masRepeticiones.repeticiones": -1
            }
        },
        {
            $group: {
                _id: { "_id": "$_id", "fullName": "$fullName" },
                masRepeticiones: { $first: '$masRepeticiones' }
            }
        },
        {
            $project: {
                _id: '$_id._id', fullName: "$_id.fullName", masRepeticiones: true
            }
        },
        {
            $sort: {
                _id: 1
            }
        }
    ]
).pretty()


// 10. Fidelización y premiación de clientes: Encontrar las personas con más de 35 años y hayan realizado al menos una compra en la última mitad año con un valor sin IVA mayor a 7.000.000

db.ColeccionPrueba.aggregate(
    [
        {
            $match: {
                $and: [
                    {
                        age: {
                            $gte: 35
                        }
                    },
                    {
                        sales: {
                            $elemMatch: {
                                $and: [
                                    {
                                        date: {
                                            $gte: ISODate("2020-07-01T00:00:00Z")
                                        }
                                    },
                                    {
                                        subTotal: {
                                            $gte: 70000000
                                        }
                                    }
                                ]
                            }
                        }
                    }
                ]
            }
        },
        {
            $project: {
                fullName: {
                    $concat: ['$name', " ", { $ifNull: ["$secondName", ""] }, ' ', '$lastName', ' ', '$secondLastName']
                },
                age: true,
            }
        },
        {
            $sort: {
                _id: 1
            }
        }
    ]
).pretty()



db.ColeccionPrueba.aggregate(
    [
        {
            $unwind: '$sales'
        },
        {
            $project: {
                name: true,
                sales_Products: '$sales.products.name',
                date: '$sales.date'
            }
        },
        {
            $unwind: '$sales_Products'
        },
        {
            $sort: {
                _id: 1,
                sales_Products: 1,
                date: -1
            }
        },
        {
            $limit: 10
        }
    ]
).pretty()


db.ColeccionPrueba.aggregate(
    [
        {
            $match: {
                name: "Marcos"
            }
        },
        {
            $project: {
                name: true,
                age: true
            }
        }
    ]
)

db.ColeccionPrueba.find(
    {
        name: "Marcos"
    },
    {
        name: true,
        age: true
    }
).explain("executionStats")
