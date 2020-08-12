function validateAge(){
	var age=document.getElementById("age").value;		
	if(age >= 18){
		alert("La persona es mayor de edad");
	}else{
		alert("La persona es menor de edad");
	}
}

function sum(){
	var a=parseInt(document.getElementById("numberA").value);
	var b=parseInt(document.getElementById("numberB").value);

	var c=a+b;
	alert("El resultado de sumar "+a+"+"+b+" es: "+c);
}

function substract(){
	var a=parseInt(document.getElementById("numberA").value);
	var b=parseInt(document.getElementById("numberB").value);

	var c=a-b;
	alert("El resultado de restar "+a+"-"+b+" es: "+c);
}

function multiply(){
	var a=parseInt(document.getElementById("numberA").value);
	var b=parseInt(document.getElementById("numberB").value);

	var c=a*b;
	alert("El resultado de muliplicar "+a+"X"+b+" es: "+c);
}

function divide(){
	var a=parseInt(document.getElementById("numberA").value);
	var b=parseInt(document.getElementById("numberB").value);

	if(b==0){
		alert("No se puede dividir por 0");
	}else{
		var c=a/b;
		alert("El resultado de dividir "+a+" entre "+b+" es: "+c);
	}
}
