function (doc) {
    if (doc.sales) {
        for (var sale in doc.sales) {
            if (doc.sales[sale].articulos) {
                for (var articulo in doc.sales[sale].articulos) {
                    if (doc.secondName) {
                        emit([doc._id, doc.sales[sale].articulos[articulo].name], { fehca: doc.sales[sale].fecha, full_name: doc.name + " " + doc.secondName + " " + doc.lastName + " " + doc.secondLastName });
                    }
                }
            }
        }
    }
}


function (doc) {
    if (doc.sales) {
        for (var sale in doc.sales) {
            if (doc.sales[sale].articulos) {
                for (var articulo in doc.sales[sale].articulos) {
                    if (doc.secondName) {
                        emit([doc._id, doc.sales[sale].articulos[articulo].name], [doc.sales[sale].fecha, { id: doc._id, full_name: doc.name + " " + doc.secondName + " " + doc.lastName + " " + doc.secondLastName }]);
                    } else {
                        emit([doc._id, doc.sales[sale].articulos[articulo].name], [doc.sales[sale].fecha, { id: doc._id, full_name: doc.name + " " + doc.lastName + " " + doc.secondLastName, sale: doc.sales[sale] }]);
                    }
                }
            }
        }
    }
}


