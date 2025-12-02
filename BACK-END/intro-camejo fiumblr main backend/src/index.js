import express from "express";
import cors from "cors";
import { pool } from "./db.js";

const app = express();
app.use(express.json());
app.use(cors());

// Ruta de prueba
app.get("/", (req, res) => {
    res.json({ message: "Backend funcionando" });
});

app.get("/usuarios", async (req, res) => {
    try {
        const result = await pool.query("SELECT * FROM usuarios");
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "DB error" });
    }
});

app.get("/posts", async (req, res) => {
    try {
        const result = await pool.query("" +
            "SELECT contenido, usuarios.nickname as nickname, tags, multimedia " + 
            "FROM posts, usuarios " + 
            "WHERE id_usuario = usuarios.id " +
            "ORDER BY posts.fecha_creacion LIMIT 50"
        );
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "DB error" });
    }
});

app.get("/posts/:id", async (req, res) => {
    try {
        const result = await pool.query(`SELECT * FROM posts where id = ${req.params.id}`);
        res.json(result.rows[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "DB error" });
    }
});

app.post("/posts", async (req, res) => {
    try {
        // Ustedes tienen que chequear que lo que van a inserta sea valido!!
        // por ejemplo, 
        // si van a insertar una edad -> CHEQUEAR QUE NO SEA NEGATIVA!
        // si van a insertar plata -> QUE NO SEA NEGATIVA
        // si van a insertar una fecha en el futuro -> QUE SEA EN EL FUTURO
        // si van a inserta una puntuacion -> QUE ESTE DENTRO DEL RANGO
        const query = `
        insert into posts (contenido, multimedia, tags, id_usuario) 
        values ('${req.body.contenido}', '${req.body.multimedia}', '${req.body.tags}', ${req.body.id_usuario})`;
        
        await pool.query(query);
        res.json();
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "DB error" });
    }
})

app.delete("/posts", async (req, res) => {
    try {
        const id_a_borrar = req.body.id;
        const query = `delete from posts where id = ${id_a_borrar}`;

        await pool.query(query);
        res.json(`id ${id_a_borrar} borrado exitosamente`);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "DB error" });
    }
})

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log("Servidor corriendo en http://localhost:" + PORT);
});
