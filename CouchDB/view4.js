// Consulta #9
// _design/viewAddress/_view/address_references:age

function (doc) {
    if (doc.address.references) {
        for (var reference in doc.address.references) {
            if (doc.secondName) {
                emit(doc.address.references[reference], { id: doc._id, fullName: doc.name + " " + doc.secondName + " " + doc.lastName + " " + doc.secondLastName, age: doc.age, address: doc.address });
            } else {
                emit(doc.address.references[reference], { id: doc._id, fullName: doc.name + " " + doc.lastName + " " + doc.secondLastName, age: doc.age, address: doc.address });
            }
        }
    }
}

var results = [];
function organizarArray(obj) {
    if (Array.isArray(obj)) {
        for (var ind in obj) {
            organizarArray(obj[ind]);
        }
    } else {
        results.push(obj);
    }
}
function ordenarAsc(arrayJson, key) {
    arrayJson.sort(function (a, b) {
        return a[key] > b[key];
    });
}

function (keys, values, rereduce) {
    if (rereduce) {

        organizarArray(values);
        let sinRepetidos = results.filter((valorActual, indiceActual, arreglo) => {
            return arreglo.findIndex(valorDelArreglo => JSON.stringify(valorDelArreglo) === JSON.stringify(valorActual)) === indiceActual
        });
        ordenarAsc(sinRepetidos, 'age');
        sinRepetidos.reverse();
        return sinRepetidos;
    } else {
        return { 'values': values, };
    }
}