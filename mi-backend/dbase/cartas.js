const { dbclient } = require("../db");

// obtener todas las cartas
async function getallcartas() {
    const respuesta = await dbclient.query('SELECT * FROM cartas ORDER BY nombre ASC');
    return respuesta.rows;
}

// obtener carta por ID
async function getcarta(id) {
    const respuesta = await dbclient.query('SELECT * FROM cartas WHERE carta_id = $1', [id]);
    return respuesta.rows[0];
}

// cartas por calidad
async function getcartasbycalidad(calidad) {
    const respuesta = await dbclient.query('SELECT * FROM cartas WHERE calidad = $1', [calidad]);
    return respuesta.rows;
}

// Crear carta 
async function create_carta(datos) {
    const { 
        nombre, imagen, calidad, costo_elixir, 
        tipo_ataque, tipo_carta, puntos_de_vida, daño, 
        rol_combate 
    } = datos;

    const query = `
        INSERT INTO cartas (
            nombre, imagen, calidad, costo_elixir, 
            tipo_ataque, tipo_carta, puntos_de_vida, daño, 
            rol_combate
        ) 
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) 
        RETURNING *`;

    const valores = [
        nombre, imagen, calidad, costo_elixir, 
        tipo_ataque, tipo_carta, puntos_de_vida, daño, 
        rol_combate
    ];
    
    const respuesta = await dbclient.query(query, valores);
    return respuesta.rows[0];
}

module.exports = {
    getallcartas,
    getcarta,
    getcartasbycalidad,
    create_carta,
};