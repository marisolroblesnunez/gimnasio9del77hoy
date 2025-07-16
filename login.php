<?php
if(session_status() == PHP_SESSION_NONE){
    session_start();
}

// Si el usuario ya está logueado, redirigir a la página de reservas
if(isset($_SESSION['logueado']) && $_SESSION['logueado'] == true){
    header("Location: reservas.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PowerGym</title>
    <link rel="stylesheet" href="css/estilos.css">
    <style>
        /* Estilos para el modal, si se usan desde una página sin JS específico */
        .modal {
            display: none; 
        }
    </style>
</head>
<body class="login-page-body">
    <div class="container">
        <h2>Iniciar Sesión</h2>
        <form method="post" action="controllers/usuarioController.php">
            <input type="email" name="email" required placeholder="Correo electrónico">
            <input type="password" name="password" required placeholder="Contraseña">
            <input type="submit" name="login" value="Iniciar Sesión">
        </form>
        
        <div class="olvido-password">
            <a href="#" class="abrir-modal-recuperar">Recuperar contraseña</a>
        </div>
        <div class="crear-cuenta">
            <a href="#" class="abrir-modal-registro">Crear cuenta nueva</a>
        </div>
        
        <?php
        if(isset($_SESSION['mensaje'])){
            echo "<div class='error'>" . htmlspecialchars($_SESSION['mensaje']) . "</div>";
            unset($_SESSION['mensaje']);
        }
        ?>

        <!-- Modales para recuperación y registro -->
        <div id="modalRecuperar" class="modal">
            <div class="modal-contenido">
                <span class="cerrarRecuperar">&times;</span>
                <h2>Recuperar contraseña</h2>
                <form method="POST" action="controllers/usuarioController.php">
                    <input type="email" name="email" required placeholder="Correo electrónico">
                    <input type="submit" name="recuperar" value="Recuperar Contraseña">
                </form>
            </div>
        </div>

        <div id="modalRegistro" class="modal">
            <div class="modal-contenido">
                <span class="cerrarRegistro">&times;</span>
                <h2>Registro Cuenta nueva</h2>
                <form method="POST" action="controllers/usuarioController.php">
                    <input type="email" name="email" required placeholder="Correo electrónico">
                    <input type="password" name="password" required placeholder="Contraseña">
                    <input type="submit" name="registro" value="Registrarse">
                </form>
            </div>
        </div>
    </div>
    <!-- Asegúrate de que el JS para los modales se cargue -->
    <script src="js/login.js"></script> 
</body>
</html>
