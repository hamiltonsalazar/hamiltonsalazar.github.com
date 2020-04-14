import React, {useState, useEffect, Suspense} from 'react';
import logo from './logo.svg';
import './App.css';
//import Surprise from './Surprise';
//import hello from './hello.js';

const Surprise = React.lazy( ()=> import('./Surprise') );

function App() {
  const [showSurprise, setShowSurprise] =useState(false);
  
  return (
    <div>
      <button onClick={(ev)=>setShowSurprise(true)}>MostrarSorpresa</button>
      {
        showSurprise && <Suspense fallback={<p>Cargando...</p>}> <Surprise/> </Suspense> 
      }
    </div>
  );
} 

export default App;
