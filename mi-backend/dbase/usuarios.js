const {dbclient}=require("../db");
//const dbclient = new Pool({//con Client  tenes que hacer si o si connect y end
 //user: 'postgres',
  //password: 'postgres',
  //host: 'localhost',
  //port: 5432,
  //database: 'BoedoClash',
//}) no es necesario si se usa variables de entorno

async function getallusuarios() { // al poner async esperamos una promesa(la respuesta de la base de datos)
       const respuesta=await dbclient.query('SELECT * FROM usuario');
       return respuesta.rows;
};

async function getusuario(id) {
        const respuesta=await dbclient.query('SELECT * FROM usuario WHERE id=$1', [id]);
        return respuesta.rows[0];
};

module.exports={
        getallusuarios,getusuario,
};