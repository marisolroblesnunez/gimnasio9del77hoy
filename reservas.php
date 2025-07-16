<?php
// Iniciar la sesión para acceder a las variables de sesión
session_start();

// 1. PROTEGER LA PÁGINA
// Si el usuario no está logueado, redirigirlo a la página de login.
if (!isset($_SESSION['logueado']) || !$_SESSION['logueado']) {
    header('Location: login.php');
    exit(); // Detener la ejecución del script
}

// 2. OBTENER DATOS DINÁMICOS
// Incluir el controlador de clases para obtener la lista de clases.
require_once __DIR__ . '/controllers/claseController.php';

// Crear una instancia del controlador y obtener los datos de las clases.
$claseController = new ClaseController();
$datos = $claseController->mostrarClases();
$clases = $datos['clases']; // Array con todas las clases

// Obtener el nombre del usuario de la sesión para el mensaje de bienvenida.
$nombre_usuario = $_SESSION['usuario']['nombre'] ?? 'Usuario';

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservar Clases - PowerGym</title>
    <link rel="stylesheet" href="css/estilos.css">
    <style>
        /* Estilos específicos para la página de reservas con la nueva paleta */
        body.reservas-page {
            background-image: url('img/fondoGim.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #fff;
            font-family: 'Arial', sans-serif;
        }
        .reservas-container {
            max-width: 90%;
            margin: 2rem auto;
            padding: 2rem;
            background-color: rgba(0, 0, 0, 0.8); /* Fondo más oscuro */
            border-radius: 15px;
            text-align: center;
            border: 1px solid #6a0dad; /* Borde morado */
        }
        .welcome-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        .welcome-header h1 {
            font-size: 2.5rem;
            color: #9370DB; /* Tono de morado medio */
        }
        .logout-btn {
            padding: 10px 20px;
            background-color: #8A2BE2; /* Morado */
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .logout-btn:hover {
            background-color: #6a0dad; /* Morado más oscuro */
        }
        .clases-carrusel {
            display: flex;
            overflow-x: auto;
            padding-bottom: 20px;
            gap: 20px;
        }
        .clase-card-reserva {
            flex: 0 0 300px;
            background-color: rgba(255, 255, 255, 0.05); /* Casi transparente */
            border: 1px solid #8A2BE2;
            border-radius: 10px;
            padding: 1.5rem;
            text-align: left;
        }
        .clase-card-reserva h3 {
            margin-top: 0;
            color: #9370DB; /* Morado medio */
        }
        .clase-card-reserva p {
            margin: 0.5rem 0;
        }
        .reservar-btn {
            width: 100%;
            padding: 10px;
            margin-top: 1rem;
            background-color: #6a0dad; /* Morado oscuro */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .reservar-btn:hover {
            background-color: #4B0082; /* Morado índigo */
        }
        .reservar-btn.lleno {
            background-color: #444;
            border-color: #555;
            color: #aaa;
            cursor: not-allowed;
        }
    </style>
</head>
<body class="reservas-page">

    <div class="reservas-container">
        <div class="welcome-header">
            <h1>Forja tu mejor versión, <?php echo htmlspecialchars($nombre_usuario); ?>.</h1>
            <a href="logout.php" class="logout-btn">Cerrar Sesión</a>
        </div>
        
        <h2>No pierdas la oportunidad. ¡Apúntate ahora!</h2>

        <div class="clases-carrusel">
            <?php if (empty($clases)): ?>
                <p>No hay clases disponibles en este momento.</p>
            <?php else:
                foreach ($clases as $clase):
            ?>
                <div class="clase-card-reserva">
                    <h3><?php echo htmlspecialchars($clase['nombre']); ?></h3>
                    <p><strong>Entrenador:</strong> <?php echo htmlspecialchars($clase['nombre_entrenador'] ?? 'N/A'); ?></p>
                    <p><strong>Día:</strong> <?php echo htmlspecialchars($clase['dia_semana']); ?></p>
                    <p><strong>Hora:</strong> <?php echo htmlspecialchars(substr($clase['hora'], 0, 5)); ?> (<?php echo htmlspecialchars($clase['duracion_minutos']); ?> min)</p>
                    <p><strong>Plazas reservadas:</strong> <?php echo htmlspecialchars($clase['inscritos_actuales']); ?> de <?php echo htmlspecialchars($clase['cupo_maximo']); ?></p>
                    
                    <?php if ($clase['inscritos_actuales'] >= $clase['cupo_maximo']): ?>
                        <button class="reservar-btn lleno" disabled>Cupo Lleno</button>
                    <?php else: ?>
                        <button class="reservar-btn" data-clase-id="<?php echo $clase['id']; ?>">Reservar</button>
                    <?php endif; ?>
                </div>
            <?php 
                endforeach;
            endif; 
            ?>
        </div>
    </div>

    <script src="js/reservas.js"></script>
</body>
</html>