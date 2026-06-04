// La URL de tu API en Spring Boot
const API_URL = 'http://localhost:8080/api/pacientes';

// Cuando la página carga, ejecutamos la función para traer los pacientes
document.addEventListener('DOMContentLoaded', cargarPacientes);

// Escuchamos el evento de "enviar" del formulario
document.getElementById('pacienteForm').addEventListener('submit', function(e) {
    e.preventDefault(); // Evita que la página parpadee o se recargue sola
    crearPaciente();
});

// Función para Consultar Todos (GET)
function cargarPacientes() {
    fetch(API_URL)
        .then(response => response.json()) // Convertimos la respuesta a JSON
        .then(data => {
            const tbody = document.querySelector('#pacientesTable tbody');
            tbody.innerHTML = ''; // Limpiamos la tabla antes de llenarla

            // Recorremos la lista de pacientes que nos dio Spring Boot
            data.forEach(paciente => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${paciente.id}</td>
                    <td>${paciente.nombre}</td>
                    <td>${paciente.edad}</td>
                    <td>${paciente.correo}</td>
                    <td>${paciente.telefono}</td>
                    <td>
                        <button class="btn-delete" onclick="eliminarPaciente(${paciente.id})">Eliminar</button>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        })
        .catch(error => console.error("Error al cargar pacientes:", error));
}

// Función para Crear Paciente (POST)
function crearPaciente() {
    // Armamos un objeto con los datos que el usuario escribió
    const nuevoPaciente = {
        nombre: document.getElementById('nombre').value,
        edad: parseInt(document.getElementById('edad').value),
        correo: document.getElementById('correo').value,
        telefono: document.getElementById('telefono').value
    };

    fetch(API_URL, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(nuevoPaciente) // Transformamos el objeto a texto JSON
    })
    .then(response => {
        if(response.ok) {
            cargarPacientes(); // Recargamos la tabla para ver el nuevo registro
            document.getElementById('pacienteForm').reset(); // Limpiamos las cajas de texto
        } else {
            alert("Error al guardar. Verifica que el correo no esté repetido.");
        }
    })
    .catch(error => console.error("Error al crear paciente:", error));
}

// Función para Eliminar Paciente (DELETE)
function eliminarPaciente(id) {
    if(confirm("¿Estás seguro de que deseas eliminar a este paciente?")) {
        fetch(`${API_URL}/${id}`, {
            method: 'DELETE'
        })
        .then(response => {
            if(response.ok) {
                cargarPacientes(); // Recargamos la tabla para ver que ya no está
            }
        })
        .catch(error => console.error("Error al eliminar:", error));
    }
}