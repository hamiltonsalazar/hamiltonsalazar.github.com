// Contula #11
// _design/viewSales/_view/sales_products_count
// Reduce: _count

function (doc) {
    if (doc.sales) {
        for (var sale in doc.sales) {
            if (doc.sales[sale].products) {
                for (var product in doc.sales[sale].products) {
                    if (doc.secondName) {
                        emit([doc.sales[sale].products[product].name, doc._id, doc.name + " " + doc.secondName + " " + doc.lastName + " " + doc.secondLastName], null);
                    } else {
                        emit([doc.sales[sale].products[product].name, doc._id, doc.name + " " + doc.lastName + " " + doc.secondLastName], null);
                    }
                }
            }
        }
    }
}