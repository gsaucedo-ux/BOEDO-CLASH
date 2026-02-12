#  Boedo-Clash

Boedo-Clash es un **foro social inspirado en Clash Royale**, donde los usuarios pueden **crear y publicar mazos**, compartir estadísticas, y **realizar comentarios y valoraciones sobre los mazos de otros jugadores**.

La plataforma está pensada como un espacio colaborativo para debatir estrategias, mejorar el rendimiento en combate y descubrir nuevas combinaciones de cartas.

 El contenido multimedia (imágenes o videos de cartas y mazos) **no se almacena en la aplicación**, sino que se referencia mediante **links externos**.

---

##  Entidades del Sistema

###  Usuarios
Representa a los jugadores registrados en la plataforma.

- id  
- nombre  
- alias (nombre visible en el foro)  
- correo  
- contraseña  
- nivel  
- trofeos  
- victorias_totales  
- carta_favorita  

---

###  Cartas
Define las cartas disponibles para la creación de mazos.

- carta_id  
- nombre  
- imagen (link externo)  
- calidad  
- costo_elixir  
- tipo_ataque  
- tipo_carta  
- puntos_de_vida  
- daño  
- rol_combate  

---

###  Mazos
Conjunto de cartas creadas por un usuario para compartir y analizar estrategias.

- mazo_id  
- usuario_id (FK → usuario.id)  
- nombre  
- promedio_elixir  
- victorias_totales  
- es_publico  

---

###  Mazo_Cartas
Tabla intermedia que relaciona cartas con mazos y define su posición.

- mazo_id (FK → mazos.mazo_id)  
- carta_id (FK → cartas.carta_id)  
- posicion (1 a 8)  

---

### Comentarios
Permite a los usuarios comentar y puntuar mazos de otros jugadores.

- comentario_id  
- mazo_id (FK → mazos.mazo_id)  
- usuario_id (FK → usuario.id)  
- texto  
- puntuacion (1 a 5)  
- creado_en  

---

##  Frontend – Páginas y Funcionalidades

###  Navbar
- Lado izquierdo:
  - Nombre de la aplicación **Boedo-Clash**
- Lado derecho:
  - Alias del usuario (redirige al perfil)
  - Botón **Nuevo Mazo**

---

###  Home
- Muestra los **últimos 50 mazos públicos**
- Cada mazo muestra:
  - Nombre
  - Autor
  - Promedio de elixir
  - Cantidad de comentarios
  - Puntuación promedio
- Buscador con filtros por:
  - Alias de usuario
  - Nombre del mazo
  - Carta incluida en el mazo

---

###  Crear / Editar Usuario
- Formulario para:
  - Nombre
  - Alias
  - Email
  - Contraseña
  - Carta favorita

---

###  Perfil de Usuario
- Información del usuario:
  - Alias
  - Nivel
  - Trofeos
  - Victorias totales
  - Carta favorita
- Listado de:
  - Mazos creados por el usuario
  - Comentarios realizados

---

###  Crear / Editar Mazo
- Formulario para:
  - Nombre del mazo
  - Selección de 8 cartas
- Visualización automática de:
  - Promedio de elixir
- Opciones:
  - Editar solo mazos propios

---

###  Ver Mazo
- Información del mazo:
  - Nombre
  - Autor
  - Promedio de elixir
  - Cartas con sus estadísticas
  - Victorias totales
- Sección de comentarios:
  - Publicar comentario
  - Puntuar el mazo (1 a 5)
  - Ver comentarios existentes

---


## 📌 Inspiración

Este proyecto está inspirado en **Clash Royale**, adaptando sus conceptos de cartas, mazos y estadísticas a un entorno de foro social orientado al análisis y la interacción entre jugadores.
