import React, { useState } from 'react';
import Button from './Button';
import Card from './Card';

const themes = {
  'dark':{
    backgroundColor: 'black',
    color: 'white'
  },
  'light':{
    backgroundColor: 'white',
    color: 'black'
  }
}

export const ThemeContext = React.createContext();


function App() {
  const [ theme, setTheme] = useState(themes.light);
  return (
    <div>
      <ThemeContext.Provider value= {theme}>
        <Button></Button>
        <Card></Card>
        <button onClick={ ()=> setTheme(themes.light)}>Modo claro</button>
        <button onClick={ ()=> setTheme(themes.dark)}>Modo oscuro</button>
      </ThemeContext.Provider>
    </div>
  );
}

export default App;
