CREATE TABLE usuario ( 
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    nivel INT DEFAULT 1,
    trofeos INT DEFAULT 0,
    alias VARCHAR(100) NOT NULL,
    carta_favorita VARCHAR(100)
);

CREATE TABLE cartas (
    carta_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    imagen VARCHAR(255),
    calidad VARCHAR(50) NOT NULL,
    costo_elixir INT NOT NULL,
    tipo_ataque VARCHAR(50) NOT NULL,
    tipo_carta VARCHAR(50) NOT NULL,
    puntos_de_vida INT NOT NULL,
    daño INT NOT NULL,
    fuerte_contra VARCHAR(100),
    debil_contra VARCHAR(100)
);

CREATE TABLE mazos (
    mazo_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuario(id) ON DELETE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    promedio_elixir DECIMAL(3,2),
    victorias_totales INT DEFAULT 0,
    carta_1 INT REFERENCES cartas(carta_id),
    carta_2 INT REFERENCES cartas(carta_id),
    carta_3 INT REFERENCES cartas(carta_id),
    carta_4 INT REFERENCES cartas(carta_id),
    carta_5 INT REFERENCES cartas(carta_id),
    carta_6 INT REFERENCES cartas(carta_id),
    carta_7 INT REFERENCES cartas(carta_id),
    carta_8 INT REFERENCES cartas(carta_id)
);

CREATE TABLE comentarios (
    comentario_id SERIAL PRIMARY KEY,
    mazo_id INT REFERENCES mazos(mazo_id) ON DELETE CASCADE,
    usuario_id INT REFERENCES usuario(id) ON DELETE SET NULL,
    texto TEXT NOT NULL,
    puntuacion INT CHECK (puntuacion >= 1 AND puntuacion <= 5)
);

INSERT INTO usuario (nombre, correo, contraseña, nivel, trofeos, alias, carta_favorita)
VALUES ('STG', 'hola@gmail.com', '12345', 11, 15000, 'LaLeyenda', 'Platense');
