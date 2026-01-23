const express = require('express');//se imoporta express
const app = express();//aca tengo mi aplicacion
const cors = require('cors'); 
const port = 3000; //puerto donde va a correr mi aplicacion
const {getallusuarios,getusuario,create_usuario,verificacion_correo,alias_usuario} = require ('./dbase/usuarios');//importa todas las funcionesque estanen esa ruta
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
    const usuario=await alias_usuario(alias);
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

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log("Servidor corriendo en http://localhost:" + PORT);
});

