const {dbclient}=require("../db");
async function getallcomentarios(mazoId) { // al poner async esperamos una promesa(la respuesta de la base de datos)
        const respuesta = await dbclient.query(
  `
  SELECT
    co.comentario_id,
    co.texto,
    co.puntuacion,
    co.creado_en,
    u.alias
  FROM comentarios co
  LEFT JOIN usuario u ON u.id = co.usuario_id
  WHERE co.mazo_id = $1
  ORDER BY co.creado_en DESC
  `,
  [mazoId]
);

       return respuesta.rows[0];
};
module.exports={
        getallcomentarios,
};