// Consulta #12
// _design/viewSales/_view/sales_products_name:date

function (doc) {
    if (doc.sales) {
        for (var sale in doc.sales) {
            if (doc.sales[sale].products) {
                for (var product in doc.sales[sale].products) {
                    if (doc.secondName) {
                        emit([doc._id, doc.sales[sale].products[product].name], { date: doc.sales[sale].date, time: doc.sales[sale].date, paymentMethod: doc.sales[sale].paymentMethod, subTotal: doc.sales[sale].subTotal, iva: doc.sales[sale].iva, total: doc.sales[sale].total, typeOfSale: doc.sales[sale].typeOfSale, idCustomer: doc._id,  full_name: doc.name + " " + doc.secondName + " " + doc.lastName + " " + doc.secondLastName });
                    }else {
                        emit([doc._id, doc.sales[sale].products[product].name], { date: doc.sales[sale].date, time: doc.sales[sale].date, paymentMethod: doc.sales[sale].paymentMethod, subTotal: doc.sales[sale].subTotal, iva: doc.sales[sale].iva, total: doc.sales[sale].total, typeOfSale: doc.sales[sale].typeOfSale, idCustomer: doc._id,  full_name: doc.name  + " " + doc.lastName + " " + doc.secondLastName });
                    }
                }
            }
        }
    }
}
