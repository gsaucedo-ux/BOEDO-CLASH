create table usuario ( 
    id serial primary key,
    nombre varchar(100) not null,
    correo varchar(100) not null,
    contraseña varchar(100) not null,
    nivel int not null,
    trofeos int not null,
    alias varchar(100) not null,
    carta_favorita varchar(100) not null,
);

create table cartas (
    carta_id serial primary key,
    nombre  varchar(100) not null,
    imagen varchar(100),
    calidad varchar(100) not null,
    costo_elixir int not null,
    tipo_ataque varchar(100) not null,
    tipo_carta varchar(100) not null,
    puntos_de_vida int not null,
    daño int not null,
    fuerte_contra varchar(100),
    debil_contra varchar(100),
);

create table mazos (
    mazo_id serial primary key,
    nombre varchar(100) not null,
    promedio_elixir int not null,
    victorias_totales  int not null,
    nivel int not null,
);

create table comentarios (
    comentario_id serial primary key,
    mazo_id int REFERENCES mazos (mazo_id),
    usuario_id REFERENCES usuario (id),
    texto   varchar(100) not null,
    puntuacion int not null,
);