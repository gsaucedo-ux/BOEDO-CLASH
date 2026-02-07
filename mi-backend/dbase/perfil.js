document.addEventListener('DOMContentLoaded', () => {
    const usuarioId = localStorage.getItem("usuarioId"); 
    
    if (!usuarioId || usuarioId === "undefined") {
        window.location.href = "iniciarSesion.html";
        return;
    }
    
    cargarDatosUsuario(usuarioId);
    renderMazos(usuarioId);
});

// FUNCIÓN: Trae los datos de la tabla 'usuario' desde el Backend
async function cargarDatosUsuario(id) {
    try {
        const response = await fetch(`http://localhost:3000/usuarios/${id}`);
        
        if (!response.ok) {
            throw new Error("No se pudo obtener el usuario del servidor");
        }

        const data = await response.json();
        console.log("Datos de usuario recibidos correctamente:", data);

        // Referencias a los elementos del HTML
        const elNombre = document.getElementById("nombreUsuario");
        const elNivel = document.getElementById("nivelUsuario");
        const elTrofeos = document.getElementById("trofeosUsuario");

        // Actualizamos el contenido solo si los elementos existen
        if (elNombre) elNombre.textContent = data.alias || data.nombre;
        if (elNivel) elNivel.textContent = data.nivel;
        if (elTrofeos) elTrofeos.textContent = data.trofeos;
        
        // Guardamos el alias en el navegador para persistencia local
        localStorage.setItem("usuario", data.alias || data.nombre);

    } catch (error) {
        console.error("Error al cargar datos del usuario:", error);
    }
}

// FUNCIÓN DE MAZOS: Renderiza los mazos guardados en PostgreSQL
async function renderMazos(usuarioId) {
    const cont = document.getElementById("contenedorMazos"); 
    if (!cont) return;

    try {
        const response = await fetch(`http://localhost:3000/usuarios/${usuarioId}/mazos`);
        const mazos = await response.json();
        
        cont.innerHTML = ""; 

        if (mazos.length === 0) {
            cont.innerHTML = `<p class="texto-vacio">Todavía no creaste ningún mazo en la base de datos.</p>`;
            return;
        }

        mazos.forEach((m) => {
        cont.innerHTML += `
        <div class="publicacion">
            <h3>${m.nombre}</h3>
            <div class="publicacion-cartas">
                ${m.cartas.map(c => `
                    <div class="carta-m">
                        <img src="${c.imagen}" alt="${c.nombre}" title="${c.nombre}">
                    </div>
                `).join("")}
            </div>
            <div class="publicacion-botones">
                <button onclick="verComentarios(${m.id})" class="boton-com">Comentarios</button>
            </div>
        </div>
    `;
});
    } catch (e) {
        console.error("Error al cargar mazos:", e);
        cont.innerHTML = "<p>Error al conectar con el servidor para traer los mazos.</p>";
    }
}

function verComentarios(idMazo) { 
    window.location.href = "comentarios.html?mazo=" + idMazo; 
}

function crearMazo() { 
    window.location.href = "crearMazo.html"; 
}