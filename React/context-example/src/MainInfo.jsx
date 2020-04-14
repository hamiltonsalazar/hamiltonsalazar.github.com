import React, { useContext } from 'react';
import { FormContext } from './Form';

export default (props)=>{
    const ctx = useContext(FormContext);
    return(
        <div>
            <input 
            onChange={(ev)=>ctx.setEmail(ev.target.value)}
            type="email" value={ctx.email}></input>
            <input type="password"></input>
        </div>
    )
}