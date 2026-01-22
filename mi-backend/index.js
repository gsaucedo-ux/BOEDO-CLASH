const express = require('express');//se imoporta express
const app = express();//aca tengo mi aplicacion
const cors = require('cors'); 
const port = 3000; //puerto donde va a correr mi aplicacion
app.use(express.json());
app.use(cors()); // <--- CORS reubicado aquí

// Ruta de prueba
app.get("/", (req, res) => {
  res.json({ message: "Backend funcionando" });
});

// Ruta para obtener todos los usuarios
app.get("/usuarios", async (req, res) => {
    try {
        res.json({
  "id": 1,
  "nombre": "fede herrera",
  "correo": "fde@example.com",
  "contraseña": "hashed_password_123",
  "nivel": 1,
  "trofeos": 0,
  "alias": "BoedoKing",
  "carta_favorita": "Dragón Rojo"
});
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "DB error", details: err.message });
    }
});

// ----------------------------------------------------
// INICIO DEL SERVIDOR (Debe ser la última acción)
// ----------------------------------------------------

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log("Servidor corriendo en http://localhost:" + PORT);
});

