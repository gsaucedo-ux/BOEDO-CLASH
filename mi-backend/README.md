# Backend con Express + PostgreSQL + Docker Compose

## Descripción

Backend desarrollado con Node.js y Express, utilizando PostgreSQL como base de datos relacional.
El proyecto está dockerizado mediante Docker Compose, lo que permite levantar fácilmente el servidor y la base de datos en un entorno de desarrollo consistente.

Provee una API REST para la gestión de usuarios, cartas, mazos y comentarios, sirviendo como base del sistema del foro y la lógica principal de la aplicación.

## 1. PostgreSQL + Docker Compose

### 1.1 Levantar la base de datos

Comando:
docker compose up -d

### 1.2 Verificar funcionamiento

Comando:
docker ps

## 2. Tablas de ejemplo

Las tablas de ejemplo se encuentran en la carpeta script.
El archivo db.sql se carga automáticamente al levantar el contenedor.

## 3. Iniciar el backend

Comando:
npm run dev

Servidor disponible en:
http://localhost:3000

## 4. Probar rutas

GET http://localhost:3000/
GET http://localhost:3000/usuarios