import React, { useContext } from 'react';
import { FormContext } from './Form';

export default (props)=>{
    const context = useContext(FormContext);

    const addToList = (value, list) =>{
        console.log(":0");
        context.setLikes([value].concat(context.likes));
    }

    const removeFromList = (value, list) => context.setLikes(context.likes.filter(v => v !== value))

    return(
        <div>
        <p>Email: {context.email}</p>
            <label>
                <input
                    type="checkbox"
                    name="likes[]"  
                    onChange={(ev) => ev.target.checked ? addToList("Ruby") : removeFromList("Ruby")}  >
                </input>
                Ruby
            </label>
            <label>
                <input
                    type="checkbox"
                    name="likes[]"    
                    onChange={(ev) => ev.target.checked ? addToList("JavaScript") : removeFromList("JavaScript")}  >
                </input>
                JavaScript
            </label>
        </div>
    )
}