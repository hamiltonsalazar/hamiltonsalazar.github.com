// Consulta #5
// _design/viewTexts/_view/textsGroup:repeticiones
// Reduce: _count

function (doc) {
    if (doc.texts) {
        for (var text in doc.texts) {
            if (doc.secondName) {
                emit({ id: doc._id, fullName: doc.name + " " + doc.secondName + " " + doc.lastName + " " + doc.secondLastName, texts: [doc.texts[text] ]}, null);
            } else {
                emit({ id: doc._id, fullName: doc.name + " " + doc.lastName + " " + doc.secondLastName, texts: [doc.texts[text] ]}, null);
            }
        }
    }
}
