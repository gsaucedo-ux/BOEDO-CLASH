CREATE TABLE usuario ( 
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    nivel INT DEFAULT 1,
    trofeos INT DEFAULT 0,
    alias VARCHAR(100) NOT NULL,
    carta_favorita VARCHAR(100),
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
    usuario_id INT REFERENCES usuario(id) ON DELETE SET NULL,
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
('Excavadora de Duendes', 'https://cdn.royaleapi.com/static/img/cards/goblin-drill.png', 'epica', 4, 'terrestre', 'estructura', 950, 0, 'EG');

INSERT INTO mazos (usuario_id, nombre, promedio_elixir)
VALUES (1, 'Tanques Pesados', 5.6),
       (2, 'Ataque Rápido', 4.2),
       (3, 'Defensa Sólida', 5.0),
       (4, 'Control de Mapa', 4.8),
       (5, 'Enjambre Aéreo', 3.5);
INSERT INTO mazo_cartas (mazo_id, carta_id, posicion)
VALUES
  (1, 2, 1),  -- Gigante
  (1, 4, 2),  -- Gólem
  (1, 5, 3),  -- Mega Caballero
  (1, 3, 4),  -- Gigante Noble
  (1, 6, 5),  -- Esqueleto Gigante
  (1, 7, 6),  -- Rey Esqueleto
  (1, 8, 7),  -- Monje
  (1, 1, 8),  -- Caballero
 (2, 10, 1),  -- Gigante
  (2, 4, 2),  -- Gólem
  (2, 5, 3),  -- Mega Caballero
  (2, 3, 4),  -- Gigante Noble
  (2, 6, 5),  -- Esqueleto Gigante
  (2, 7, 6),  -- Rey Esqueleto
  (2, 8, 7),  -- Monje
  (2, 1, 8);  -- Caballero

INSERT INTO comentarios (mazo_id, usuario_id, texto, puntuacion)
VALUES
(1, 2, '¡Me encanta este mazo de tanques! Muy sólido en defensa y ataque.', 5),
(1, 3, 'Funciona bien, pero a veces me cuesta contra mazos rápidos.', 4),
(1, 1, 'El Montapuercos es mi carta favorita, ¡gran elección!', 5),
(2, 4, 'Me gusta la velocidad de este mazo, pero me falta algo de defensa.', 4),
(3, 5, 'Este mazo me ha salvado en muchas partidas',5);