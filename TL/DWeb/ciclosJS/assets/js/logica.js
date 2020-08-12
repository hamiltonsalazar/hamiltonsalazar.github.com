
var students = new Array(); 

function loadStudents(){	
	//debugger;
	if(students.length>=10){
		alert("Ya ha llenado los 10 estudiantes");
	}else{
		students.push(document.getElementById("student").value);
	}
	console.log("Load:"+students.length);
}

function showStudents(){
	debugger;
	
	for(student in students)	{
		alert(students[student]);	
	}

	console.log(students.length);
}

