import React from 'react';
import { Link, graphql } from 'gatsby';
import Img from 'gatsby-image';

export default (props)=>{
    console.log(props);
    return (
        <div>
            <h1>Home</h1>
            <Link to="/about">Acerca de</Link>
            <Img fluid={props.data.file.childImageSharp.fluid} alt="Fondo"></Img>
            {/** <Img fixed={props.data.file.childImageSharp.fixed} ></Img>*/}
            <picture></picture>
            {/** <img src={'../images/background.jpg'} ></img>*/ }
        </div>
    )
}

export const query = graphql`
    query {
        file(relativePath: {eq: "background.jpg"}) {
            childImageSharp{
                fluid(maxWidth: 1920){
                    ...GatsbyImageSharpFluid_withWebp
                }
            }
        }
    }
`;

                /*fixed(width: 1920, height: 1080){
                    ...GatsbyImageSharpFixed
                }*/