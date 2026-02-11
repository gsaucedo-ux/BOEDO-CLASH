# Backend con Express + PostgreSQL + Docker Compose

## Descripción

Backend desarrollado con **Node.js y Express**, utilizando **PostgreSQL** como base de datos relacional.  
El proyecto está dockerizado mediante **Docker Compose**, lo que permite levantar fácilmente el servidor y la base de datos en un entorno de desarrollo consistente.

Provee una **API REST** para la gestión de usuarios, cartas, mazos y comentarios, sirviendo como base del sistema del foro y la lógica principal de la aplicación.

---

## 1️⃣ PostgreSQL + Docker Compose

### 1.1 Levantar la base de datos

```bash
docker compose up -d
```

### 1.2 Verificar funcionamiento

```bash
docker ps
```

---

## 2️⃣ Tablas de ejemplo

Las tablas de ejemplo se encuentran en la carpeta `script`.  
El archivo `db.sql` se carga automáticamente al levantar el contenedor.

### Ingresar a la base de datos

```bash
docker exec -it mi-backend-db-1 psql -U postgres
```
Selecciono mi db:
```bash
\c BoedoClash;
```
veo todas mis columas:
```bash
\dt
```
---

## 3️⃣ Iniciar el backend

```bash
npm run dev
```

Servidor disponible en:

```
http://localhost:3000
```

---

## 4️⃣ Probar rutas

```http
GET http://localhost:3000/
GET http://localhost:3000/usuarios
```

