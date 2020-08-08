var cont = 0;
var aprovatedStudents=0;
var failedStudents=0;



function addStudent(){

	var fullName = document.getElementById("fullName").value;

	var mark1 = parseFloat(document.getElementById("mark1").value);
	var mark2 = parseFloat(document.getElementById("mark2").value);
	var mark3 = parseFloat(document.getElementById("mark3").value);


	if(!validateFields(fullName, mark1, mark2, mark3)){
		return;
	}

	var table = document.getElementById("table").getElementsByTagName('tbody')[0];

	var row = table.insertRow();

	var cellStudent = row.insertCell(0);
	var cellMark1 = row.insertCell(1);
	var cellMark2 = row.insertCell(2);
	var cellMark3 = row.insertCell(3);
	var cellAvg = row.insertCell(4);
	var cellState = row.insertCell(5);

	cellStudent.innerHTML = fullName;
	cellMark1.innerHTML = mark1;
	cellMark2.innerHTML = mark2;
	cellMark3.innerHTML = mark3;	
	cellAvg.innerHTML = average(mark1, mark2, mark3);	

	if(average(mark1, mark2, mark3)>=3){
		cellState.innerHTML = "Aprobado";
		cellState.style.color = "green";
		cont++;
		aprovatedStudents++;
	}else{
		cellState.innerHTML = "Reprobado";
		cellState.style.color = "red";
		cont++;
		failedStudents++;
	}


	document.getElementById("approved").innerHTML = "Estudiantes aprobados: " + aprovatedStudents;
	document.getElementById("failed").innerHTML = "Estudiantes reprobados: " + failedStudents;
	document.getElementById("total").innerHTML = "Total de estudiantes: " + cont;


	document.getElementById("fullName").value = "";
	document.getElementById("mark1").value = "";
	document.getElementById("mark2").value = "";
	document.getElementById("mark3").value = "";

}



function average(mark1, mark2, mark3){
	return (mark3+mark2+mark1)/3;
}




function validateFields(fullName, mark1, mark2, mark3){

	if(fullName == "" || isNaN(mark1) || isNaN(mark2) ||  isNaN(mark3))
	{
		alert("Por favor complete todos los campos de registro.");
		return false;
	}

	if(mark1 > 5 || mark2 > 5 ||  mark3 > 5 || mark1 < 0 || mark2 < 0 ||  mark3 < 0)
	{
		alert("Las notas deben ser entre 0 y 5");
		return false;
	}

	return true;
}