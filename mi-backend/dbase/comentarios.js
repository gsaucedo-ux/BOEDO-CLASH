const { dbclient } = require("../db");

async function getAllMazosConComentarios() {
  const respuesta = await dbclient.query(`
    SELECT
      m.mazo_id,
      m.nombre,
      m.promedio_elixir,
      m.victorias_totales,
      u.alias AS creador,

      json_agg(
        DISTINCT jsonb_build_object(
          'carta_id', c.carta_id,
          'nombre', c.nombre,
          'imagen', c.imagen,
          'posicion', mc.posicion
        )
      ) AS cartas,

      json_agg(
        DISTINCT jsonb_build_object(
          'comentario_id', co.comentario_id,
          'texto', co.texto,
          'puntuacion', co.puntuacion,
          'alias', u2.alias,
          'fecha', co.creado_en
        )
      ) FILTER (WHERE co.comentario_id IS NOT NULL) AS comentarios

    FROM mazos m
    JOIN usuario u ON u.id = m.usuario_id
    LEFT JOIN mazo_cartas mc ON mc.mazo_id = m.mazo_id
    LEFT JOIN cartas c ON c.carta_id = mc.carta_id
    LEFT JOIN comentarios co ON co.mazo_id = m.mazo_id
    LEFT JOIN usuario u2 ON u2.id = co.usuario_id
    GROUP BY
      m.mazo_id,
      m.nombre,
      m.promedio_elixir,
      m.victorias_totales,
      u.alias
    ORDER BY m.mazo_id DESC
  `);

  return respuesta.rows;
}

module.exports = {
  getAllMazosConComentarios
};
