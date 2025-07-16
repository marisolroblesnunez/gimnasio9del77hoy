document.addEventListener('DOMContentLoaded', function() {
    const botonesReservar = document.querySelectorAll('.reservar-btn');

    botonesReservar.forEach(boton => {
        // Solo añadir el evento a los botones que no están deshabilitados (cupo lleno)
        if (!boton.disabled) {
            boton.addEventListener('click', function() {
                const claseId = this.getAttribute('data-clase-id');
                
                // Deshabilitar el botón para evitar múltiples clics
                this.disabled = true;
                this.textContent = 'Procesando...';

                // Llamada a la API para reservar
                fetch('api/index.php?resource=reservar', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id_clase: claseId })
                })
                .then(response => {
                    // Si la respuesta no es OK (ej. 401, 409), el .json() podría fallar.
                    // Es mejor manejar el texto de la respuesta directamente.
                    return response.json().then(data => ({
                        status: response.status,
                        body: data
                    }));
                })
                .then(result => {
                    alert(result.body.message); // Muestra el mensaje de la API

                    if (result.status === 200) { // 200 OK
                        this.textContent = 'Reservado';
                        this.classList.add('lleno'); // Cambia el estilo a "lleno" o similar
                    } else {
                        // Si falló (ej. cupo lleno mientras se decidía, ya inscrito), 
                        // se revierte el botón a su estado original para que el usuario entienda.
                        this.disabled = false;
                        this.textContent = 'Reservar';
                    }
                })
                .catch(error => {
                    console.error('Error en la petición de reserva:', error);
                    alert('Ocurrió un error al intentar realizar la reserva. Por favor, inténtalo de nuevo.');
                    // Revertir el botón en caso de un error de red
                    this.disabled = false;
                    this.textContent = 'Reservar';
                });
            });
        }
    });
});
