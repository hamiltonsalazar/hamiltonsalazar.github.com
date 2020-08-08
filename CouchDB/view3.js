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

function (keys, values, rereduce) {
    var results = [];
    if (rereduce) {
        if (Array.isArray(values)) {
            for (indx in values) {
                if (Array.isArray(values[indx])) {
                    for (ind in values[indx]) {
                        if (!results.includes(values[indx][ind])) {
                            results.push([values[indx][ind], results.includes(values[indx][ind])]);
                        }
                    }
                } 
            }
            return results;
        }
    } else {
        return values;
    }
}