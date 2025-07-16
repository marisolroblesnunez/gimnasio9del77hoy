document.addEventListener('DOMContentLoaded', function() {
    const tablaMensajes = document.querySelector('.tablaMensajes');

    if (tablaMensajes) {
        tablaMensajes.addEventListener('click', function(e) {
            if (e.target.classList.contains('btn-eliminar')) {
                const fila = e.target.closest('tr');
                const id = fila.dataset.id;

                if (confirm('¿Estás seguro de que quieres eliminar este mensaje?')) {
                    fetch('../controllers/contactoController.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `accion=eliminar&id=${id}`
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.exito) {
                            fila.remove();
                        } else {
                            alert('Error al eliminar el mensaje.');
                        }
                    })
                    .catch(error => console.error('Error:', error));
                }
            }
        });
    }
});