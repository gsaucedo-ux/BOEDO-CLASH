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
async function verificacion_correo_otros(correo, id_usuario) {
  return dbclient.query(
    'SELECT 1 FROM usuario WHERE correo = $1 AND id <> $2',
    [correo, id_usuario]
  );
}
async function alias_usuario_otros(alias, id_usuario) {
  return dbclient.query(
    'SELECT 1 FROM usuario WHERE alias = $1 AND id <> $2',
    [alias, id_usuario]
  );
}
async function alias_usuario(alias) {
        const respuesta=await dbclient.query('SELECT * FROM usuario WHERE alias=$1', [alias]);
        return respuesta;
}

async function update_usuario(id_usuario, nombre, correo, contraseña, alias, carta_favorita){
        const respuesta=await dbclient.query('UPDATE usuario SET nombre=$1, correo=$2, contraseña=$3, alias=$4, carta_favorita=$5 WHERE id=$6 RETURNING *', [nombre, correo, contraseña, alias, carta_favorita,id_usuario]);
        if (respuesta.rowCount===0){
                return undefined;
        }
        return respuesta.rows[0];
}

module.exports={
        getallusuarios,getusuario,create_usuario,update_usuario,verificacion_correo,verificacion_correo_otros,alias_usuario,alias_usuario_otros,
};