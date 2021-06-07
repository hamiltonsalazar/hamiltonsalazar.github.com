// Consulta #8
// _design/viewTexts/_view/textsGroup:count

function (doc) {
    if (doc.texts) {
        for (var text in doc.texts) {
            if (doc.secondName) {
                emit(doc.texts[text], { id: doc._id, fullName: doc.name + " " + doc.secondName + " " + doc.lastName + " " + doc.secondLastName });
            } else {
                emit(doc.texts[text], { id: doc._id, fullName: doc.name + " " + doc.lastName + " " + doc.secondLastName });
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

function (keys, values, rereduce) {
    if (rereduce) {
        organizarArray(values);
        let sinRepetidos = results.filter((valorActual, indiceActual, arreglo) => {
            return arreglo.findIndex(valorDelArreglo => JSON.stringify(valorDelArreglo) === JSON.stringify(valorActual)) === indiceActual
        });
        return sinRepetidos;
    } else {
        return values;
    }
}
