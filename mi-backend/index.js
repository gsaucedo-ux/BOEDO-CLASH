import express from "express";
import { pool } from "./db.js";
import cors from "cors"; // <--- ¡Importación de CORS agregada!

const app = express();

// Configuración de Middlewares (Deben ir antes de las rutas)
app.use(express.json());
app.use(cors()); // <--- CORS reubicado aquí

// ----------------------------------------------------
// RUTAS
// ----------------------------------------------------

// Ruta de prueba
app.get("/", (req, res) => {
  res.json({ message: "Backend funcionando" });
});

// Ruta para obtener todos los usuarios
app.get("/users", async (req, res) => {
    try {
        const result = await pool.query("SELECT * FROM users");
        res.json(result.rows);
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