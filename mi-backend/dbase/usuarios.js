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
async function create_usuario(nombre, correo, contraseña, alias, carta_favorita){
        const respuesta=await dbclient.query('INSERT INTO usuario (nombre, correo, contraseña, alias, carta_favorita) VALUES ($1, $2, $3, $4, $5) RETURNING *', [nombre, correo, contraseña, alias, carta_favorita]);
        if (respuesta.rowCount===0){
                return undefined;
        }
        return respuesta.rows[0];
}
async function verificacion_correo(correo) {
        const respuesta=await dbclient.query('SELECT * FROM usuario WHERE correo=$1', [correo]);
        return respuesta;
}
async function alias_usuario(alias) {
        const respuesta=await dbclient.query('SELECT * FROM usuario WHERE alias=$1', [alias]);
        return respuesta;
}
module.exports={
        getallusuarios,getusuario,create_usuario,verificacion_correo,alias_usuario,
};