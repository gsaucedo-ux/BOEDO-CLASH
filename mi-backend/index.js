const express = require('express');//se imoporta express
const app = express();//aca tengo mi aplicacion
const cors = require('cors'); 
const port = 3000; //puerto donde va a correr mi aplicacion
const {getallusuarios,getusuario} = require ('./dbase/usuarios');//importa todas las funcionesque estanen esa ruta
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

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log("Servidor corriendo en http://localhost:" + PORT);
});

