CREATE TABLE usuario ( 
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    nivel INT DEFAULT 1,
    trofeos INT DEFAULT 0,
    victorias_totales INT DEFAULT 0,
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
    rol_combate VARCHAR(100) NOT NULL
);

CREATE TABLE mazos (
    mazo_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuario(id) ON DELETE CASCADE,
    nombre VARCHAR(100) NOT NULL,
    promedio_elixir DECIMAL(3,2),
    victorias_totales INT DEFAULT 0,
    es_publico BOOLEAN DEFAULT TRUE 
);

CREATE TABLE mazo_cartas (
    mazo_id INT REFERENCES mazos(mazo_id) ON DELETE CASCADE,
    carta_id INT REFERENCES cartas(carta_id),
    posicion INT CHECK (posicion BETWEEN 1 AND 8),
    PRIMARY KEY (mazo_id, carta_id),
    UNIQUE (mazo_id, posicion)
);

CREATE TABLE comentarios (
    comentario_id SERIAL PRIMARY KEY,
    mazo_id INT REFERENCES mazos(mazo_id) ON DELETE CASCADE,
    usuario_id INT REFERENCES usuario(id) ON DELETE CASCADE,
    texto TEXT NOT NULL,
    puntuacion INT CHECK (puntuacion >= 1 AND puntuacion <= 5),
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO cartas (nombre, imagen, calidad, costo_elixir, tipo_ataque, tipo_carta, puntos_de_vida, daño, rol_combate)
VALUES 
-- 1. T (Tanque Lento): Unidades de alta salud que marcan el ritmo
('Caballero', 'https://cdn.royaleapi.com/static/img/cards/knight.png', 'comun', 3, 'terrestre', 'tropa', 1450, 160, 'T'),
('Gigante', 'https://cdn.royaleapi.com/static/img/cards/giant.png', 'especial', 5, 'terrestre', 'tropa', 3300, 210, 'T'),
('Gigante Noble', 'https://cdn.royaleapi.com/static/img/cards/royal-giant.png', 'comun', 6, 'terrestre', 'tropa', 2500, 250, 'T'),
('Gólem', 'https://cdn.royaleapi.com/static/img/cards/golem.png', 'epica', 8, 'terrestre', 'tropa', 4200, 260, 'T'),
('Mega Caballero', 'https://cdn.royaleapi.com/static/img/cards/mega-knight.png', 'legendaria', 7, 'terrestre', 'tropa', 3300, 220, 'T'),
('Esqueleto Gigante', 'https://cdn.royaleapi.com/static/img/cards/giant-skeleton.png', 'epica', 6, 'terrestre', 'tropa', 3000, 170, 'T'),
('Rey Esqueleto', 'https://cdn.royaleapi.com/static/img/cards/skeleton-king.png', 'campeon', 5, 'terrestre', 'tropa', 2300, 180, 'T'),
('Monje', 'https://cdn.royaleapi.com/static/img/cards/monk.png', 'campeon', 5, 'mixto', 'tropa', 2000, 150, 'T'),
('Goblinstein', 'https://cdn.royaleapi.com/static/img/cards/goblinstein.png', 'legendaria', 5, 'mixto', 'tropa', 2000, 140, 'T'),
('Máquina de Duendes', 'https://cdn.royaleapi.com/static/img/cards/goblin-machine.png', 'legendaria', 5, 'mixto', 'tropa', 2200, 180, 'T'),

-- 2. B (Tanque Rápido): Movilidad y presión inmediata
('Montapuercos', 'https://cdn.royaleapi.com/static/img/cards/hog-rider.png', 'especial', 4, 'terrestre', 'tropa', 1400, 260, 'B'),
('Príncipe', 'https://cdn.royaleapi.com/static/img/cards/prince.png', 'epica', 5, 'terrestre', 'tropa', 1600, 320, 'B'),
('Bárbaros de Élite', 'https://cdn.royaleapi.com/static/img/cards/elite-barbarians.png', 'especial', 6, 'terrestre', 'tropa', 1100, 320, 'B'),
('Puercos Reales', 'https://cdn.royaleapi.com/static/img/cards/royal-hogs.png', 'especial', 5, 'terrestre', 'tropa', 700, 60, 'B'),
('Bandida', 'https://cdn.royaleapi.com/static/img/cards/bandit.png', 'legendaria', 3, 'terrestre', 'tropa', 750, 160, 'B'),
('Leñador', 'https://cdn.royaleapi.com/static/img/cards/lumberjack.png', 'legendaria', 4, 'terrestre', 'tropa', 1060, 200, 'B'),
('Ariete de Batalla', 'https://cdn.royaleapi.com/static/img/cards/battle-ram.png', 'especial', 4, 'terrestre', 'tropa', 750, 250, 'B'),
('Barril de Esqueletos', 'https://cdn.royaleapi.com/static/img/cards/skeleton-barrel.png', 'comun', 3, 'terrestre', 'tropa', 440, 0, 'B'),
('Caballero Dorado', 'https://cdn.royaleapi.com/static/img/cards/golden-knight.png', 'campeon', 4, 'terrestre', 'tropa', 1800, 160, 'B'),
('Bandida Líder', 'https://cdn.royaleapi.com/static/img/cards/boss-bandit.png', 'campeon', 6, 'terrestre', 'tropa', 2500, 200, 'B'),

-- 3. DM (Daño de Muerte): Unidades de alto impacto o salpicadura
('Valquiria', 'https://cdn.royaleapi.com/static/img/cards/valkyrie.png', 'especial', 4, 'terrestre', 'tropa', 1650, 220, 'DM'),
('Bebé Dragón', 'https://cdn.royaleapi.com/static/img/cards/baby-dragon.png', 'epica', 4, 'mixto', 'tropa', 950, 130, 'DM'),
('Mago', 'https://cdn.royaleapi.com/static/img/cards/wizard.png', 'especial', 5, 'mixto', 'tropa', 600, 230, 'DM'),
('Bruja', 'https://cdn.royaleapi.com/static/img/cards/witch.png', 'epica', 5, 'mixto', 'tropa', 700, 110, 'DM'),
('Príncipe Oscuro', 'https://cdn.royaleapi.com/static/img/cards/dark-prince.png', 'epica', 4, 'terrestre', 'tropa', 1000, 200, 'DM'),
('Princesa', 'https://cdn.royaleapi.com/static/img/cards/princess.png', 'legendaria', 3, 'mixto', 'tropa', 216, 140, 'DM'),
('Fantasma Real', 'https://cdn.royaleapi.com/static/img/cards/royal-ghost.png', 'legendaria', 3, 'terrestre', 'tropa', 1000, 216, 'DM'),
('Arquero Mágico', 'https://cdn.royaleapi.com/static/img/cards/magic-archer.png', 'legendaria', 4, 'mixto', 'tropa', 440, 110, 'DM'),
('Chispitas', 'https://cdn.royaleapi.com/static/img/cards/sparky.png', 'legendaria', 6, 'terrestre', 'tropa', 1200, 1100, 'DM'),
('Verdugo', 'https://cdn.royaleapi.com/static/img/cards/executioner.png', 'epica', 5, 'mixto', 'tropa', 1000, 140, 'DM'),
('Duende Demoledor', 'https://cdn.royaleapi.com/static/img/cards/goblin-demolisher.png', 'epica', 4, 'terrestre', 'tropa', 1000, 150, 'DM'),
('Lanzafuegos', 'https://cdn.royaleapi.com/static/img/cards/firecracker.png', 'comun', 3, 'mixto', 'tropa', 250, 50, 'DM'),
('Espíritu Ígneo', 'https://cdn.royaleapi.com/static/img/cards/fire-spirit.png', 'comun', 1, 'mixto', 'tropa', 190, 150, 'DM'),
('Bola de Fuego', 'https://cdn.royaleapi.com/static/img/cards/fireball.png', 'especial', 4, 'hechizo', 'hechizo', 0, 570, 'DM'),
('Flechas', 'https://cdn.royaleapi.com/static/img/cards/arrows.png', 'comun', 3, 'hechizo', 'hechizo', 0, 300, 'DM'),
('Cohete', 'https://cdn.royaleapi.com/static/img/cards/rocket.png', 'epica', 6, 'hechizo', 'hechizo', 0, 1200, 'DM'),
('Barril de Bárbaro', 'https://cdn.royaleapi.com/static/img/cards/barbarian-barrel.png', 'epica', 2, 'hechizo', 'hechizo', 0, 200, 'DM'),

-- 4. DS (Área Sostenida): Hechizos o efectos de daño en el tiempo
('Veneno', 'https://cdn.royaleapi.com/static/img/cards/poison.png', 'epica', 4, 'hechizo', 'hechizo', 0, 600, 'DS'),
('Terremoto', 'https://cdn.royaleapi.com/static/img/cards/earthquake.png', 'especial', 3, 'hechizo', 'hechizo', 0, 200, 'DS'),

-- 5. AS (Soporte Aéreo): Unidades voladoras que apoyan el empuje
('Megaesbirro', 'https://cdn.royaleapi.com/static/img/cards/mega-minion.png', 'especial', 3, 'mixto', 'tropa', 700, 260, 'AS'),

-- 6. TS (Tiradores): Daño a distancia constante
('Arqueras', 'https://cdn.royaleapi.com/static/img/cards/archers.png', 'comun', 3, 'mixto', 'tropa', 250, 80, 'TS'),
('Mosquetera', 'https://cdn.royaleapi.com/static/img/cards/musketeer.png', 'especial', 4, 'mixto', 'tropa', 600, 180, 'TS'),
('Trío de Mosqueteras', 'https://cdn.royaleapi.com/static/img/cards/three-musketeers.png', 'especial', 9, 'mixto', 'tropa', 600, 180, 'TS'),
('Lanzarrocas', 'https://cdn.royaleapi.com/static/img/cards/bowler.png', 'epica', 5, 'terrestre', 'tropa', 1600, 240, 'TS'),
('Duende Lanzadardos', 'https://cdn.royaleapi.com/static/img/cards/dart-goblin.png', 'especial', 3, 'mixto', 'tropa', 216, 100, 'TS'),
('Máquina Voladora', 'https://cdn.royaleapi.com/static/img/cards/flying-machine.png', 'especial', 4, 'mixto', 'tropa', 500, 140, 'TS'),
('Carro Cañón', 'https://cdn.royaleapi.com/static/img/cards/cannon-cart.png', 'epica', 5, 'terrestre', 'tropa', 700, 170, 'TS'),
('Reina Arquera', 'https://cdn.royaleapi.com/static/img/cards/archer-queen.png', 'campeon', 5, 'mixto', 'tropa', 1000, 225, 'TS'),

-- 7. EM (Enjambre Terrestre): Cantidad masiva para distracción
('Duendes', 'https://cdn.royaleapi.com/static/img/cards/goblins.png', 'comun', 2, 'terrestre', 'tropa', 160, 90, 'EM'),
('Duendes con Lanza', 'https://cdn.royaleapi.com/static/img/cards/spear-goblins.png', 'comun', 2, 'mixto', 'tropa', 110, 60, 'EM'),
('Esqueletos', 'https://cdn.royaleapi.com/static/img/cards/skeletons.png', 'comun', 1, 'terrestre', 'tropa', 67, 67, 'EM'),
('Bárbaros', 'https://cdn.royaleapi.com/static/img/cards/barbarians.png', 'comun', 5, 'terrestre', 'tropa', 550, 160, 'EM'),
('Ejército de Esqueletos', 'https://cdn.royaleapi.com/static/img/cards/skeleton-army.png', 'epica', 3, 'terrestre', 'tropa', 67, 67, 'EM'),
('Guardias', 'https://cdn.royaleapi.com/static/img/cards/guards.png', 'epica', 3, 'terrestre', 'tropa', 200, 100, 'EM'),
('Pandilla de Duendes', 'https://cdn.royaleapi.com/static/img/cards/goblin-gang.png', 'comun', 3, 'mixto', 'tropa', 160, 90, 'EM'),
('Reclutas Reales', 'https://cdn.royaleapi.com/static/img/cards/royal-recruits.png', 'comun', 7, 'terrestre', 'tropa', 500, 110, 'EM'),
('Barril de Duendes', 'https://cdn.royaleapi.com/static/img/cards/goblin-barrel.png', 'epica', 3, 'hechizo', 'hechizo', 0, 0, 'EM'),
('Cementerio', 'https://cdn.royaleapi.com/static/img/cards/graveyard.png', 'legendaria', 5, 'hechizo', 'hechizo', 0, 0, 'EM'),

-- 8. HD (Destructor de Tanques): Especialistas en daño a un solo objetivo
('P.E.K.K.A.', 'https://cdn.royaleapi.com/static/img/cards/pekka.png', 'epica', 7, 'terrestre', 'tropa', 3400, 670, 'HD'),
('Mini P.E.K.K.A.', 'https://cdn.royaleapi.com/static/img/cards/mini-pekka.png', 'especial', 4, 'terrestre', 'tropa', 1100, 600, 'HD'),
('Bruja Nocturna', 'https://cdn.royaleapi.com/static/img/cards/night-witch.png', 'legendaria', 4, 'terrestre', 'tropa', 750, 260, 'HD'),
('Dragón Infernal', 'https://cdn.royaleapi.com/static/img/cards/inferno-dragon.png', 'legendaria', 4, 'mixto', 'tropa', 1000, 350, 'HD'),
('Cazador', 'https://cdn.royaleapi.com/static/img/cards/hunter.png', 'epica', 4, 'mixto', 'tropa', 700, 70, 'HD'),
('Gran Minero', 'https://cdn.royaleapi.com/static/img/cards/mighty-miner.png', 'campeon', 4, 'terrestre', 'tropa', 2400, 400, 'HD'),

-- 9. M (Control/Mecánica): Utilidad, aturdimiento o efectos especiales
('Minero', 'https://cdn.royaleapi.com/static/img/cards/miner.png', 'legendaria', 3, 'terrestre', 'tropa', 1000, 160, 'M'),
('Montacarneros', 'https://cdn.royaleapi.com/static/img/cards/ram-rider.png', 'legendaria', 5, 'terrestre', 'tropa', 1450, 220, 'M'),
('Pescador', 'https://cdn.royaleapi.com/static/img/cards/fisherman.png', 'legendaria', 3, 'terrestre', 'tropa', 720, 160, 'M'),
('Mago de Hielo', 'https://cdn.royaleapi.com/static/img/cards/ice-wizard.png', 'legendaria', 3, 'mixto', 'tropa', 590, 75, 'M'),
('Mago Eléctrico', 'https://cdn.royaleapi.com/static/img/cards/electro-wizard.png', 'legendaria', 4, 'mixto', 'tropa', 590, 93, 'M'),
('Bruja Madre', 'https://cdn.royaleapi.com/static/img/cards/mother-witch.png', 'legendaria', 4, 'mixto', 'tropa', 560, 110, 'M'),
('Espíritu de Hielo', 'https://cdn.royaleapi.com/static/img/cards/ice-spirit.png', 'comun', 1, 'mixto', 'tropa', 190, 90, 'M'),
('Dragón Eléctrico', 'https://cdn.royaleapi.com/static/img/cards/electro-dragon.png', 'epica', 5, 'mixto', 'tropa', 800, 160, 'M'),
('Arbusto Sospechoso', 'https://cdn.royaleapi.com/static/img/cards/suspicious-bush.png', 'especial', 2, 'terrestre', 'estructura', 400, 100, 'M'),
('Congelar', 'https://cdn.royaleapi.com/static/img/cards/freeze.png', 'epica', 4, 'hechizo', 'hechizo', 0, 0, 'M'),
('Descarga', 'https://cdn.royaleapi.com/static/img/cards/zap.png', 'comun', 2, 'hechizo', 'hechizo', 0, 160, 'M'),
('Rayo', 'https://cdn.royaleapi.com/static/img/cards/lightning.png', 'epica', 6, 'hechizo', 'hechizo', 0, 800, 'M'),
('Tornado', 'https://cdn.royaleapi.com/static/img/cards/tornado.png', 'epica', 3, 'hechizo', 'hechizo', 0, 0, 'M'),
('Clon', 'https://cdn.royaleapi.com/static/img/cards/clone.png', 'epica', 3, 'hechizo', 'hechizo', 0, 0, 'M'),
('Espejo', 'https://cdn.royaleapi.com/static/img/cards/mirror.png', 'epica', 0, 'hechizo', 'hechizo', 0, 0, 'M'),
('Furia', 'https://cdn.royaleapi.com/static/img/cards/rage.png', 'epica', 2, 'hechizo', 'hechizo', 0, 0, 'M'),

-- 10. TA (Tanque Aéreo): Tanques que vuelan e ignoran tierra
('Sabueso de Lava', 'https://cdn.royaleapi.com/static/img/cards/lava-hound.png', 'legendaria', 7, 'aereo', 'tropa', 3150, 45, 'TA'),
('Globo Bombástico', 'https://cdn.royaleapi.com/static/img/cards/balloon.png', 'epica', 5, 'terrestre', 'tropa', 1400, 800, 'TA'),

-- 11. EA (Enjambre Aéreo): Hordas voladoras
('Esbirros', 'https://cdn.royaleapi.com/static/img/cards/minions.png', 'comun', 3, 'mixto', 'tropa', 190, 84, 'EA'),
('Horda de Esbirros', 'https://cdn.royaleapi.com/static/img/cards/minion-horde.png', 'comun', 5, 'mixto', 'tropa', 190, 84, 'EA'),
('Murciélagos', 'https://cdn.royaleapi.com/static/img/cards/bats.png', 'comun', 2, 'mixto', 'tropa', 67, 67, 'EA'),

-- 12. ED (Estructura Daño Área): Defensa de salpicadura
('Torre Bombardera', 'https://cdn.royaleapi.com/static/img/cards/bomb-tower.png', 'especial', 4, 'terrestre', 'estructura', 1100, 180, 'ED'),
('Mortero', 'https://cdn.royaleapi.com/static/img/cards/mortar.png', 'comun', 4, 'terrestre', 'estructura', 1200, 230, 'ED'),

-- 13. ET (Estructura Objetivo Único): Defensa pesada
('Torre Infernal', 'https://cdn.royaleapi.com/static/img/cards/inferno-tower.png', 'especial', 5, 'mixto', 'estructura', 1450, 1000, 'ET'),
('Cañón', 'https://cdn.royaleapi.com/static/img/cards/cannon.png', 'comun', 3, 'terrestre', 'estructura', 740, 180, 'ET'),

-- 14. EC (Estructura Control): Defensas versátiles o de asedio
('Torre Tesla', 'https://cdn.royaleapi.com/static/img/cards/tesla.png', 'especial', 4, 'mixto', 'estructura', 950, 190, 'EC'),
('Ballesta', 'https://cdn.royaleapi.com/static/img/cards/x-bow.png', 'epica', 6, 'mixto', 'estructura', 1380, 30, 'EC'),

-- 15. EG (Estructura Generación): Producción de valor o tropas
('Choza Bárbara', 'https://cdn.royaleapi.com/static/img/cards/barbarian-hut.png', 'especial', 7, 'terrestre', 'estructura', 1100, 0, 'EG'),
('Recolector de Elixir', 'https://cdn.royaleapi.com/static/img/cards/elixir-collector.png', 'especial', 6, 'n/a', 'estructura', 900, 0, 'EG'),
('Horno', 'https://cdn.royaleapi.com/static/img/cards/furnace.png', 'especial', 4, 'terrestre', 'estructura', 850, 0, 'EG'),
('Choza de Duendes', 'https://cdn.royaleapi.com/static/img/cards/goblin-hut.png', 'especial', 5, 'mixto', 'estructura', 800, 0, 'EG'),
('Lápida', 'https://cdn.royaleapi.com/static/img/cards/tombstone.png', 'especial', 3, 'terrestre', 'estructura', 440, 0, 'EG'),
('Excavadora de Duendes', 'https://cdn.royaleapi.com/static/img/cards/goblin-drill.png', 'epica', 4, 'terrestre', 'estructura', 950, 0, 'EG'),

-- DOCENTES
('Camejo', 'https://intro-camejo.github.io/web/assets/images/manu1-43964b1b104fa4143a0a9308d942328c.jpeg', 'campeon', 7, 'terrestre', 'tropa', 2500, 600, 'B'),
('Gonza Gigachad', 'https://intro-camejo.github.io/web/assets/images/gonza-d1358d1c4d46ee9a6af0b0f72ef01994.jpeg', 'campeon', 4, 'terrestre', 'tropa', 950, 600, 'TS'),
('Nico', 'https://intro-camejo.github.io/web/assets/images/nico2-49b155c5a4d8bcbbf3642c51d5d888ec.jpg', 'campeon', 5, 'mixto', 'tropa', 1000, 50, 'DS'),
('Peke', 'https://intro-camejo.github.io/web/assets/images/peke2-feed2a15d3236b206bae68054a2c0d1d.jpeg', 'campeon', 2, 'terrestre', 'tropa', 1250, 14, 'EM'),
('Sofi', 'https://intro-camejo.github.io/web/assets/images/sofi2-73de966792e70f2f8e28f9207bef7b58.jpeg', 'campeon', 4, 'terrestre', 'tropa', 50, 500, 'M'),
('Pedro', 'https://intro-camejo.github.io/web/assets/images/pedroimg-7d47e7e3a381e3620fcb963c397e2a93.jpeg', 'campeon', 4, 'mixto', 'tropa', 1400, 25, 'DS'),
('Bilbao Pro', 'https://intro-camejo.github.io/web/assets/images/manub-070116722104de66d4a17ad59a38195f.jpg', 'campeon', 6, 'terrestre', 'mixto', 700, 823, 'TS'),
('Manu R', 'https://intro-camejo.github.io/web/assets/images/manur-f5bbdf84b7e5a56b17f8776d0c7c01be.jpeg', 'campeon', 7, 'terrestre', 'tropa', 400, 1000, 'HD'),
('Lara', 'https://intro-camejo.github.io/web/assets/images/lara-959bf9854ae0bd276ffc4badd3392ca0.jpeg', 'campeon', 3, 'terrestre', 'tropa', 800, 250, 'M'),
('Perro de Peke', 'https://intro-camejo.github.io/web/assets/images/peke-a4f60f70ff3b8c2d57578e5146db200d.jpeg', 'campeon', 10, 'terrestre', 'tropa', 9999, 999, 'T'),
('Brazo de Gonza', 'https://thumbs.dreamstime.com/b/brazo-herido-40022554.jpg', 'epica', 10, 'terrestre', 'tropa', 9999, 9999, 'DM');

-- =================================================================
-- 1. USUARIOS (Tus originales, victorias en 0)
-- =================================================================
INSERT INTO usuario (nombre, correo, contraseña, nivel, trofeos, victorias_totales, alias, carta_favorita)
VALUES
('Gustavo Saucedo', 'gus@gmail.com', '123', 6, 420, 0, 'GusPro', 'Mega Caballero'),
('Tobias Costanzo', 'tobi@gmail.com', '123', 4, 260, 0, 'KoalaFeo', 'Camejo'),
('Santiago Cucchiaro', 'santi@gmail.com', '123', 8, 680, 0, 'Cukero', 'Chispitas'),
('El Carreador 3000', 'promastercheff@gmail.com', '123', 99, 999, 0, 'El Carreador 3000', 'Monje');

-- =================================================================
-- 2. MAZOS (Tus 2 originales + 10 nuevos para completar 3 c/u)
-- =================================================================
-- 3. INSERT DE MAZOS (3 por usuario = 12 mazos)
INSERT INTO mazos (mazo_id, usuario_id, nombre, promedio_elixir)
VALUES 
(1, 1, 'Tanques Pesados', 5.6),
(2, 2, 'Ataque Rápido', 4.2),
(3, 1, 'Mega-Docente Heavy', 5.2),
(4, 1, 'Bridge Spam Docente', 3.8),
(5, 2, 'Log Bait Clásico', 3.3),
(6, 2, 'Camejo-Control Pro', 3.6),
(7, 3, 'Chispitas Explosivo', 4.5),
(8, 3, 'Torre Infernal Bait', 3.4),
(9, 3, 'Peke-Defensa Sólida', 3.2),
(10, 4, 'Hog Cycle 2.6 Clásico', 2.6),
(11, 4, 'Pekka Bridge Spam', 3.9),
(12, 4, 'LavaLoon Docente', 4.3);

-- 4. INSERT UNIFICADO DE CARTAS (Corregido con tus IDs reales)
INSERT INTO mazo_cartas (mazo_id, carta_id, posicion) VALUES
-- Mazo 1: Tanques Pesados (Gustavo)
(1,2,1), (1,4,2), (1,5,3), (1,3,4), (1,6,5), (1,7,6), (1,8,7), (1,1,8),
-- Mazo 2: Ataque Rápido (Tobias)
(2,10,1), (2,4,2), (2,5,3), (2,3,4), (2,6,5), (2,7,6), (2,8,7), (2,1,8),
-- Mazo 3: Mega-Docente Heavy (Corregido: Camejo 98, Gonza 99, Perro Peke 107)
(3,5,1), (3,98,2), (3,99,3), (3,107,4), (3,23,5), (3,34,6), (3,53,7), (3,75,8),
-- Mazo 4: Bridge Spam Docente (Camejo 98, Gonza 99)
(4,98,1), (4,15,2), (4,17,3), (4,27,4), (4,99,5), (4,32,6), (4,75,7), (4,38,8),
-- Mazo 5: Log Bait (Barril 57, Princesa 26, T. Infernal 88)
(5,57,1), (5,26,2), (5,55,3), (5,88,4), (5,1,5), (5,71,6), (5,36,7), (5,35,8),
-- Mazo 6: Camejo-Control (Camejo 98, Peke 101, Lara 106)
(6,98,1), (6,101,2), (6,106,3), (6,62,4), (6,15,5), (6,77,6), (6,40,7), (6,32,8),
-- Mazo 7: Chispitas (Santiago)
(7,29,1), (7,2,2), (7,69,3), (7,75,4), (7,23,5), (7,40,6), (7,1,7), (7,34,8),
-- Mazo 8: Torre Infernal Bait (T. Infernal 88)
(8,88,1), (8,57,2), (8,26,3), (8,55,4), (8,1,5), (8,36,6), (8,75,7), (8,71,8),
-- Mazo 9: Peke-Defensa (Peke 101, Cañón 89)
(9,101,1), (9,1,2), (9,42,3), (9,89,4), (9,51,5), (9,71,6), (9,34,7), (9,35,8),
-- Mazo 10: Hog Cycle 2.6 (Monta 11, Cañón 89)
(10,11,1), (10,42,2), (10,1,3), (10,89,4), (10,71,5), (10,51,6), (10,34,7), (10,75,8),
-- Mazo 11: Pekka Bridge Spam (Pekka 59)
(11,59,1), (11,17,2), (11,15,3), (11,61,4), (11,27,5), (11,34,6), (11,75,7), (11,28,8),
-- Mazo 12: LavaLoon Docente (Perro Peke 107, Sofi 102, Manu R 105)
(12,81,1), (12,82,2), (12,107,3), (12,102,4), (12,105,5), (12,34,6), (12,75,7), (12,77,8);

-- 5. INSERT UNIFICADO DE COMENTARIOS
INSERT INTO comentarios (mazo_id, usuario_id, texto, puntuacion)
VALUES
(1, 1, 'Este mazo es durísimo, llegué a liga maestro fácil 💪', 5),
(1, 2, 'Buen mazo, pero sufre bastante contra ciclo rápido', 4),
(1, 3, 'Mega Caballero + Gólem es caro pero demoledor', 5),
(2, 2, 'Muy divertido de jugar, ideal para presionar', 5),
(2, 4, 'Le falta un poco de defensa aérea para mi gusto', 3),
(2, 1, 'Buen promedio de elixir, se siente fluido', 4),
(10, 1, 'El Carreador es un pro, no le puedo entrar a ese 2.6', 5),
(10, 2, 'Aprendí a usar el cañón mirando este mazo.', 4),
(5, 3, 'Tobias me ganó 3 veces seguidas con el Log Bait, increíble.', 5),
(3, 4, 'Gustavo lleva a Camejo y a Gonza, es un mazo de puro respeto.', 5),
(7, 1, 'Chispitas con Gigante es una pesadilla si no tienes rayo.', 4),
(12, 3, 'El mazo de Manu R y Sofi está rotísimo por aire.', 5),
(6, 1, 'Tobias, ese combo de Camejo con Peke es imbatible en defensa.', 5),
(11, 1, 'Pekka Bridge Spam es mi debilidad, muy bien jugado.', 4),
(3, 2, 'Gus, el Perro de Peke tiene demasiada vida, ¡nerfeen eso! 😂', 4),
(8, 2, 'Santiago, tu torre infernal me arruinó el ataque de tanques.', 5),
(4, 3, 'Me encanta como Gustavo integró a Gonza Gigachad en el Bridge Spam.', 5),
(10, 3, 'El 2.6 es un clásico, pero hay que tener manos para jugarlo como El Carreador.', 4),
(9, 4, 'Santi, probé tu mazo de Peke-Defensa y es sólido contra montas.', 4),
(12, 4, 'Este mazo con Manu R y Sofi es el verdadero meta de este año.', 5);