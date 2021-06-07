// Consulta #4
// _design/viewTexts/_view/textsGroup:repeticiones

function (doc) {
  var results = [];
  var jsonResults = {};
  var jsonSol = [{
    'text': '',
    'repeticiones': 0,
  }];

  if (doc.texts) {
    for (var text in doc.texts) {

      results.push(doc.texts[text]);
    }


    for (var val in results) {
      if (jsonResults.hasOwnProperty(results[val])) {
        jsonResults[results[val]] = jsonResults[results[val]] + 1;
      } else {
        jsonResults[results[val]] = 1;
      }
      if (jsonResults[results[val]] > jsonSol[0].repeticiones) {

        jsonSol = [{
          'text': results[val],
          'repeticiones': jsonResults[results[val]],
        }];
      } else if (jsonResults[results[val]] === jsonSol[0].repeticiones) {
        jsonSol.push({
          'text': results[val],
          'repeticiones': jsonResults[results[val]],
        });
      }
    }
    if (doc.secondName) {
      emit({ id: doc._id, fullName: doc.name + " " + doc.secondName + " " + doc.lastName + " " + doc.secondLastName }, jsonSol);
    } else {
      emit({ id: doc._id, fullName: doc.name + " " + doc.lastName + " " + doc.secondLastName }, jsonSol);
    }


  }
}
