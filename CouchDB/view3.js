// Consulta #8
// _design/viewTexts/_view/textsGroup

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

function (keys, values, rereduce) {
    if (rereduce) {
        function organizarArray(obj){
            if (Array.isArray(obj)) {
                for (ind in obj) {
                    organizarArray(obj[ind]);
                }
            } else{
                results.push(obj);
            }
        }
        organizarArray(values);
        let sinRepetidos = results.filter((valorActual, indiceActual, arreglo) => {
            return arreglo.findIndex(valorDelArreglo => JSON.stringify(valorDelArreglo) === JSON.stringify(valorActual)) === indiceActual
        });
        return sinRepetidos;
    } else {
            return values;
    }
}
