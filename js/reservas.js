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

    // Animación de entrada de las tarjetas de clase con GSAP
    gsap.from(".clase-card-reserva", {
        opacity: 0,
        y: 100, // Empieza 100px más abajo
        scale: 0.8, // Empieza un poco más pequeña
        rotationZ: -10, // Ligera rotación inicial
        duration: 1.2, // Duración más larga
        stagger: 0.2, // Retraso entre la animación de cada tarjeta
        ease: "back.out(1.7)" // Efecto de rebote
    });

    // Nueva animación para el contenedor principal (reservas-container)
    gsap.from(".reservas-container", {
        opacity: 0,
        y: 200, // Empieza 200px más abajo para un rebote más pronunciado
        scale: 0.9, // Empieza un 10% más pequeña
        duration: 3.5, // Duración más larga para que el rebote sea visible
        delay: 0.3, // Pequeño retraso
        ease: "bounce.out" // Efecto de rebote
    });
});
