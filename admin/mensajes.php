<?php
require_once __DIR__ . '/../controllers/contactoController.php';

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['logueado']) || !$_SESSION['logueado']) {
    header("Location: login.php");
    exit();
}

$contactoController = new ContactoController();
$mensajes = $contactoController->obtenerTodosLosMensajes();

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mensajes de Contacto</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <div class="container">
        <h1>Mensajes de Contacto</h1>
        <a href="index.php" class="btn-volver">Volver al Panel</a>
        <table class="tablaMensajes">
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Mensaje</th>
                    <th>Fecha</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($mensajes)):
                    foreach ($mensajes as $mensaje):
                ?>
                        <tr data-id="<?php echo $mensaje['id']; ?>">
                            <td><?php echo htmlspecialchars($mensaje['nombre']); ?></td>
                            <td><?php echo htmlspecialchars($mensaje['email']); ?></td>
                            <td><?php echo htmlspecialchars($mensaje['mensaje']); ?></td>
                            <td><?php echo htmlspecialchars($mensaje['fecha']); ?></td>
                            <td>
                                <button class="btn-eliminar">Eliminar</button>
                            </td>
                        </tr>
                <?php 
                    endforeach;
                else:
                ?>
                    <tr>
                        <td colspan="5">No hay mensajes.</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
    <script src="js/mensajes.js"></script>
</body>
</html>