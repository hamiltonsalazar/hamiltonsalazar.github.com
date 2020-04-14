import React, { useContext } from 'react';
import {ThemeContext} from './App.js'

export default (props) =>{
    const context = useContext(ThemeContext);
    return(
        <div
            style={{
                backgroundColor: context.backgroundColor,
                color: context.color
            }}
        >
            <p>Hola mundo</p>
        </div>
    );
}