import React from 'react';
import { Link } from 'gatsby';

export default ()=>(
    <div>
        <h1>Home</h1>
        <Link to="/about">Acerca de</Link>
        {/** <a href="/about">Lento</a> */ }
    </div>
)