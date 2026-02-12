# ¿Cómo correr el Proyecto? (Full Docker, en la carpeta raiz del proyecto)
```bash
sudo docker compose up --build -d
```
# ¿Cómo acceder a la aplicación?
```bash
http://localhost:5500/FRONT-END/INICIO/index.html
```
(Servido por Nginx en el puerto 5500).
# Ruta de BackEnd (API)
```bash
    http://localhost:3000/mazos
```
NOTA: se puede ingresar a cualquiera de las tablas de la base de datos (no solo a mazos).

(Corriendo en Node.js sobre el puerto 3000).

# Gestión de Datos y Persistencia
La base de datos se inicia automáticamente con los datos de prueba del archivo db.sql.

Si necesitás reiniciar con datos limpios:
```bash
    sudo docker compose down -v
    sudo rm -rf mi-backend/.volumes
    sudo docker compose up -d
```

# INDEX (sin iniciar sesion)
![alt text](image.png)
![alt text](image-2.png)

# INDEX (con sesion iniciada)
![alt text](image-3.png)
![alt text](image-2.png)

# BUSQUEDA POR NOMBRE DE MAZO
![alt text](image-4.png)

# BUSQUEDA POR AUTOR DE MAZO
![alt text](image-5.png)

# PERFIL
![alt text](image-6.png)

# EDITAR CARTA FAVORITA
![alt text](image-7.png)

# EDITAR PERFIL
![alt text](image-8.png)

# EDITAR MAZO
![alt text](image-11.png)

# BORRO MAZO
![alt text](image-12.png)

# CAMBIOS CARTA FAVORITA, PERFIL NOMBRE, EDITAR MAZO, ELIMINO MAZO
![alt text](image-13.png)

# NUEVA CARTA
![alt text](image-14.png)

# BUSQUEDA CARTA EN CREAR MAZO
![alt text](image-15.png)

# CREANDO MAZO
#![alt text](image-16.png)

# MAZO CREADO
![alt text](image-17.png)

# CARTAS 
![alt text](image-18.png)

# FILTRO CAMPEON
![alt text](image-19.png)

# FILTROS ACTIVOS
![alt text](image-20.png)

# BUSQUEDA POR NOMBRE
![alt text](image-21.png)

# BATALLA PERSNALIZADO
![alt text](image-26.png)

# BATALLA COPIAR MAZOS
![alt text](image-25.png)

# NIVEL 1 TROFEOS 685
![alt text](image-28.png)

# GANA "TU MAZO" (NOSOTROS)
![alt text](image-27.png)

# SE SUBEN LOS TROFEOS PROGRESA UN POCO DE NIVEL 
![alt text](image-31.png)

# PERDEMOS
![alt text](image-32.png)

# SE BAJAN LOS TROFEOS
![alt text](image-33.png)


# EDITAR BORRAR CARTAS
![alt text](image-34.png)

# SELECCIONO MESSI
![alt text](image-35.png)

# CAMBIOS
![alt text](image-36.png)

# COMENTARIOS DE: CHISPITAS EXPLOSIVO 2.0
![alt text](image-37.png)

# COMENTANDO CUKERO
![alt text](image-38.png)

# COMENTARIO
![alt text](image-39.png)

# COMENTARIO EDITADO
![alt text](image-41.png)

# COMENTARIO ELIMINADO
![alt text](image-42.png)

# TAMBIEN FUNCIONA:
# ---
# OPCION DE ELIMINAR CARTAS: SOLO LAS QUE NO SE ENCUENTRAN DENTRO DE UN MAZO
# ---
# OPCION DE ELIMINAR PERFIL: SE ELIMINA EN CASCADA POR LO QUE TAMBIEN SE ELIMINAN SUS MAZOS Y COMENTARIOS
# ---
# PROGRESO DE NIVEL: CADA 3 VICTORIAS SUBES UN NIVEL HASTA LLEGAR AL NIVEL 10, LUEGO CADA 5 HASTA EL NIVEL 25 INCLUSIVE Y LUEGO 10 VICTORIAS HASTA LLEGAR A NIVEL 100 EL MAXIMO

