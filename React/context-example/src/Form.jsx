import React, { useState } from 'react';
import MainInfo from './MainInfo';
import Skills from './Skills';

export const FormContext = React.createContext();

export default (props)=>{

    const [email, setEmail] = useState(""); 
    const [password, setPassword]=useState("");
    const [likes, setLikes]=useState("");

    return(
        <form>
            <FormContext.Provider value={ {email, password, likes, setEmail, setPassword, setLikes} }>
                <MainInfo></MainInfo>
                <Skills></Skills>
            </FormContext.Provider>
            <div>
                <p>Email: {email}</p>
                <p>Contraseña: {password}</p>
                <p>Lenguajes: {likes}</p>
            </div>
        </form>
    )
}