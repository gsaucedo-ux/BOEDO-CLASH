const express = require('express');//se imoporta express
const app = express();//aca tengo mi aplicacion
const cors = require('cors'); 
const { dbclient } = require('./db');
const port = 3000; //puerto donde va a correr mi aplicacion

const {getallcartas,
     getcarta,
     getcartasbycalidad,
     create_carta,
      } = require ('./dbase/cartas');
const {getAllMazosConComentarios,
      } = require ('./dbase/comentarios');
const {getallusuarios,
        getusuario,
        create_usuario,
        update_usuario,
        verificacion_correo,
        verificacion_correo_otros,
        alias_usuario,
        alias_usuario_otros,
remove_usuario,
update_visibilidad_mazo} = require ('./dbase/usuarios');//importa todas las funcionesque estanen esa ruta

app.use(express.json());
app.use(cors()); // <--- CORS reubicado aquí

// Ruta de prueba
app.get("/", (req, res) => {
  res.json({ message: "Backend funcionando" });
});
// ----------------------------------------------------
// endpoints de USUARIOS
// ----------------------------------------------------
// Ruta para obtener todos los usuarios
app.get("/usuarios", async (req, res) => {
    try {
        const usuarios = await getallusuarios();
        res.json(usuarios);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "DB error", details: err.message });
    }
});
//ruta para obtener un usuario por id
app.get('/usuario/:id',async (req, res) => {
        try{
                const usuario= await getusuario(req.params.id);
                res.json(usuario);
        }catch(err){
                res.sendStatus(404);
        }
});
//ruta para crear un usuario
app.post('/usuario', async (req, res) => {

  // 1️⃣ Validar body
  if (req.body === undefined) {
    return res.status(400).send("no se ha proveído el cuerpo");
  }

  const nombre = req.body.nombre;
  const correo = req.body.correo;
  const contraseña = req.body.contraseña;
  const alias = req.body.alias;
  const carta_favorita = req.body.carta_favorita;

  // 2️⃣ Validaciones obligatorias
  if (nombre === undefined) {
    return res.status(400).send("no se ha proveído el nombre");
  }

  if (correo === undefined) {
    return res.status(400).send("no se ha proveído el correo");
  }

  if (contraseña === undefined) {
    return res.status(400).send("no se ha proveído la contraseña");
  }

  if (alias === undefined) {
    return res.status(400).send("no se ha proveído el alias");
  }

  try {
    // 3️⃣ Verificar si ya existe el correo
    const existe_correo=await verificacion_correo(correo);
    const usuario=await alias_usuario(alias); // Corregido: para registro nuevo se usa alias_usuario
    if (existe_correo.rowCount !== 0) {
      return res.status(409).send("ya existe un usuario con ese correo");
    }
     if (usuario.rowCount !== 0) {
      return res.status(409).send("ya existe un usuario con ese alias");
    }

    const crear_usuario=await create_usuario(nombre, correo, contraseña, alias, carta_favorita);
    if(crear_usuario===undefined){
        return res.status(500).send("no se pudo crear el usuario");
    }
    res.status(201).json(crear_usuario);

  } catch (error) {
    console.error(error);
    res.status(500).send("error interno del servidor");
  }
});
//ruta para actualizar datos de usuario
app.put('/usuarios/:id', async(req, res) => {
        const id_usuario=req.params.id;
        let usuario=await getusuario(id_usuario);
        if(usuario==undefined){
         return res.sendStatus(404);
         };
// 1️⃣ Validar body
  if (req.body === undefined) {
    return res.status(400).send("no se ha proveído el cuerpo");
  }

  const nombre = req.body.nombre;
  const correo = req.body.correo;
  const contraseña = req.body.contraseña;
  const alias = req.body.alias;
  const carta_favorita = req.body.carta_favorita;

  // 2️⃣ Validaciones obligatorias
  if (nombre === undefined) {
    return res.status(400).send("no se ha proveído el nombre");
  }

  if (correo === undefined) {
    return res.status(400).send("no se ha proveído el correo");
  }

  if (contraseña === undefined) {
    return res.status(400).send("no se ha proveído la contraseña");
  }

  if (alias === undefined) {
    return res.status(400).send("no se ha proveído el alias");
  }
if (carta_favorita === undefined) {
    return res.status(400).send("no se ha proveído la carta favorita");
  }
  try {
    // 3️⃣ Verificar si ya existe el correo
    const existe_correo=await verificacion_correo_otros(correo, id_usuario);
    const usuario=await alias_usuario_otros(alias, id_usuario);
    if (existe_correo.rowCount !== 0) {
      return res.status(409).send("ya existe un usuario con ese correo");
    }
     if (usuario.rowCount !== 0) {
      return res.status(409).send("ya existe un usuario con ese alias");
    }

    const actualizar_usuario=await update_usuario(id_usuario, nombre, correo, contraseña, alias, carta_favorita);
    if(actualizar_usuario===undefined){
        return res.status(500).send("no se pudo actualizarel usuario");
    }
    res.status(200).json(actualizar_usuario);

  } catch (error) {
    console.error(error);
    res.status(500).send("error interno del servidor");
  }
});
app.delete('/usuario/:id', async(req, res) => {
        const id_usuario=req.params.id;
        let usuario=await getusuario(id_usuario);
        if(usuario==undefined){
         return res.sendStatus(404);
         };
         try{remove_usuario(id_usuario);
        res.json(usuario);
        }catch{
         console.error(error);
    res.status(500).send("error interno del servidor");
        }
 });

const { validar_login } = require('./dbase/usuarios'); 

app.post('/login', async (req, res) => {
    const { correo, contraseña } = req.body;
    
    try {
        const usuario = await validar_login(correo, contraseña);
        
        if (usuario) {
            // Si existe, mandamos los datos del usuario logueado
            res.json({ 
                message: "Login exitoso", 
                usuarioId: usuario.id,
                alias: usuario.alias 
            });
        } else {
            res.status(401).json({ error: "Correo o contraseña incorrectos" });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Error en el servidor" });
    }
});

// ----------------------------------------------------
// endpoints de cartas
// ----------------------------------------------------

app.get("/cartas", async (req, res) => {
    try {
        const cartas = await getallcartas();
        res.json(cartas);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Error al obtener cartas" });
    }
});

// obtener una carta especifica
app.get("/carta/:id", async (req, res) => {
    try {
        const carta = await getcarta(req.params.id);
        if (!carta) return res.status(404).send("Carta no encontrada");
        res.json(carta);
    } catch (err) {
        res.status(500).json({ error: "Error de servidor" });
    }
});

// filtrar cartas por calidad
app.get("/cartas/calidad/:tipo", async (req, res) => {
    try {
        const cartas = await getcartasbycalidad(req.params.tipo);
        res.json(cartas);
    } catch (err) {
        res.status(500).json({ error: "Error al filtrar" });
    }
});


// ----------------------------------------------------
// endpoints de comentarios
// ----------------------------------------------------
app.get('/mazos', async (req, res) => {
  
try{
        const comentarios= await getAllMazosConComentarios();
        res.json(comentarios);
} catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al obtener comentarios' });
  }
});

// endpoint para cambiar visibilidad del mazo
app.patch('/mazos/:id/visibilidad', async (req, res) => {
    const id = req.params.id;
    const es_publico = req.body.es_publico;

    try {
        const mazoActualizado = await update_visibilidad_mazo(id, es_publico);
        if (!mazoActualizado) {
            return res.status(404).json({ error: "Mazo no encontrado" });
        }
        res.json(mazoActualizado);
    } catch (err) {
        console.error(err);
        res.status(500).send("Error al actualizar visibilidad");
    }
});
app.post('/mazos', async (req, res) => {
    const { nombre, usuario_id, es_publico, cartas } = req.body;
    console.log("Recibido:", nombre);

    try {
        await dbclient.query('BEGIN');

        // 1. Buscamos los IDs de las cartas basándonos en sus nombres
        const idsCartas = [];
        for (const nombreCarta of cartas) {
            const resCarta = await dbclient.query('SELECT carta_id FROM cartas WHERE nombre = $1', [nombreCarta]);
            if (resCarta.rows.length > 0) {
                idsCartas.push(resCarta.rows[0].carta_id);
            }
        }

        if (idsCartas.length !== 8) {
            throw new Error(`Solo encontramos ${idsCartas.length} de las 8 cartas. ¡Revisá los nombres!`);
        }

        // 2. Insertar mazo (OJO: Asegurate que el ID de usuario exista)
        // Usamos un ID que sepamos que existe (cambia el 1 por el que encontraste en el Paso A)
        const mazoQuery = 'INSERT INTO mazos (nombre, usuario_id, es_publico) VALUES ($1, $2, $3) RETURNING mazo_id';
        const mazoResult = await dbclient.query(mazoQuery, [nombre, usuario_id || 1, es_publico]);
        const nuevoMazoId = mazoResult.rows[0].mazo_id;

        // 3. Insertar en mazo_cartas
        for (let i = 0; i < idsCartas.length; i++) {
            await dbclient.query(
                'INSERT INTO mazo_cartas (mazo_id, carta_id, posicion) VALUES ($1, $2, $3)',
                [nuevoMazoId, idsCartas[i], i + 1]
            );
        }

        await dbclient.query('COMMIT');
        res.status(201).json({ message: "¡Mazo guardado!" });

    } catch (err) {
        await dbclient.query('ROLLBACK');
        console.error("ERROR REAL:", err.message);
        res.status(500).json({ error: err.message });
    }
});

// Obtener mazos de un usuario con sus cartas
app.get('/usuarios/:id/mazos', async (req, res) => {
    const usuario_id = req.params.id;
    try {
        const query = `
            SELECT 
                m.mazo_id, 
                m.nombre AS mazo_nombre, 
                m.es_publico,
                c.nombre AS carta_nombre, 
                c.imagen, 
                mc.posicion
            FROM mazos m
            JOIN mazo_cartas mc ON m.mazo_id = mc.mazo_id
            JOIN cartas c ON mc.carta_id = c.carta_id
            WHERE m.usuario_id = $1
            ORDER BY m.mazo_id, mc.posicion;
        `;
        const result = await dbclient.query(query, [usuario_id]);
        
        // Agrupamos las cartas por mazo para que el Front lo lea fácil
        const mazos = result.rows.reduce((acc, row) => {
            const { mazo_id, mazo_nombre, es_publico, carta_nombre, imagen, posicion } = row;
            if (!acc[mazo_id]) {
                acc[mazo_id] = { id: mazo_id, nombre: mazo_nombre, es_publico, cartas: [] };
            }
            acc[mazo_id].cartas.push({ nombre: carta_nombre, imagen, posicion });
            return acc;
        }, {});

        res.json(Object.values(mazos));
    } catch (err) {
        console.error(err);
        res.status(500).send("Error al obtener los mazos del perfil");
    }
});

// Ruta para cambiar la visibilidad del mazo (Público/Privado)
app.patch('/mazos/:id/visibilidad', async (req, res) => {
    const { id } = req.params;
    const { es_publico } = req.body;

    try {
        const query = 'UPDATE mazos SET es_publico = $1 WHERE mazo_id = $2';
        await dbclient.query(query, [es_publico, id]);
        
        console.log(`Mazo ${id} actualizado a: ${es_publico ? 'Público' : 'Privado'}`);
        res.json({ message: "Visibilidad actualizada correctamente" });
    } catch (err) {
        console.error("Error al actualizar visibilidad:", err.message);
        res.status(500).json({ error: "No se pudo actualizar la visibilidad" });
    }
});

// Obtener datos básicos de un usuario
app.get('/usuarios/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const query = 'SELECT nombre, nivel, trofeos, alias, carta_favorita FROM usuario WHERE id = $1';
        const result = await dbclient.query(query, [id]);

        if (result.rows.length === 0) {
            return res.status(404).json({ error: "Usuario no encontrado" });
        }

        res.json(result.rows[0]);
    } catch (err) {
        console.error("Error al obtener usuario:", err.message);
        res.status(500).json({ error: "Error del servidor" });
    }
});

// RUTA PARA EL FORO: Trae los mazos públicos con sus cartas y autor
app.get('/mazos/publicos', async (req, res) => {
    try {
        // 1. SELECT principal usando tus nombres: mazo_id, id (de usuario), promedio_elixir
        const query = `
            SELECT m.mazo_id, m.nombre, m.promedio_elixir, m.victorias_totales, 
                   u.alias as autor_nombre, u.trofeos as autor_trofeos
            FROM mazos m
            JOIN usuario u ON m.usuario_id = u.id
            WHERE m.es_publico = true
            ORDER BY m.mazo_id DESC`; 

        const result = await dbclient.query(query);
        const mazos = result.rows;

        // 2. Buscamos las 8 cartas de cada mazo
        for (let mazo of mazos) {
            const cartasQuery = `
                SELECT c.nombre, c.imagen 
                FROM cartas c
                JOIN mazo_cartas mc ON c.carta_id = mc.carta_id
                WHERE mc.mazo_id = $1
                ORDER BY mc.posicion ASC`;
            
            const cartasResult = await dbclient.query(cartasQuery, [mazo.mazo_id]);
            mazo.cartas = cartasResult.rows;
        }

        res.json(mazos);
    } catch (err) {
        console.error("Error real en el servidor:", err);
        res.status(500).json({ error: "Error interno del servidor" });
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log("Servidor corriendo en http://localhost:" + PORT);
});