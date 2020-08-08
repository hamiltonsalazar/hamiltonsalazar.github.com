
function hidetTitle(){
	//debugger;
	document.getElementById("titulo").style.display = "none";
}

function showTitle(){
	//debugger;
	document.getElementById("titulo").style.display = "block";
}

function changeTitle(){
	document.getElementById("titulo").innerHTML = "Bienvenido";
}

function changeBackground(){
	document.body.style.backgroundColor = "blue";
}

function newUser(){
	var table = document.getElementById("tableUsers");

	var row =  table.insertRow(1);

	var cellName = row.insertCell(0);
	var cellEmail = row.insertCell(1);
	var cellAge = row.insertCell(2);


	var userName = document.getElementById("userName").value;
	var userEmail = document.getElementById("userEmail").value;
	var userAge = document.getElementById("userAge").value;

	cellName.innerHTML=userName;
	cellEmail.innerHTML=userEmail;
	cellAge.innerHTML=userAge;
}