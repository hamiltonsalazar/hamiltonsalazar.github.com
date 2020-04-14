// DOM
// querySelector=>1  querySelectorAll

/*
let links = document.querySelectorAll("a");

links.forEach(function(link){
  console.log(link);
})
*/

/*
let celdas = document.querySelectorAll("td");

celdas.forEach(function(td){
  td.addEventListener('click',function(){
    console.log(this);
  })
});
*/

// Obtener los elementos de la clase .close

let links = document.querySelectorAll(".close");

// Recorrerlos.

links.forEach(function(link){
// Agregar un evento click a cada uno de ellos.
  link.addEventListener('click',function(ev){
    ev.preventDefault();

    let content = document.querySelector(".content");

    // Quitarle las clases de animación que ya Tiene

    content.classList.remove("fadeInDown");
    content.classList.remove("animated");

    // Agregar clases par aanimar su salida
    content.classList.add("fadeOutUp");
    content.classList.add("animated");

    setTimeout(function(){
      location.href = "/boletines";
    }, 600);

    //return false;
  });
});

/*
let iconos = document.querySelectorAll("i");

iconos.forEach(function(icono){
    icono.classList.remove("fa-star-half-alt");
});
*/
