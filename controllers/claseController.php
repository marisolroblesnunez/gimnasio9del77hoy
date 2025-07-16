<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../data/claseDB.php';
require_once __DIR__ . '/../data/entrenadorDB.php';

class ClaseController {
    private $claseDB;
    private $entrenadorDB;

    public function __construct() {
        $database = new Database();
        $this->claseDB = new ClaseDB($database);
        $this->entrenadorDB = new EntrenadorDB($database);
    }

    public function mostrarClases() {
        $clases = [];
        $dia_seleccionado = isset($_GET['dia']) ? $_GET['dia'] : null;

        if ($dia_seleccionado) {
            $clases = $this->claseDB->getClasesByDia($dia_seleccionado);
        } else {
            $clases = $this->claseDB->getAllClasesWithDetails();
        }

        $entrenadores = $this->entrenadorDB->getAll();

        // Puedes pasar $clases y $entrenadores a tu vista (clases.php)
        // Por ejemplo, incluyendo la vista aquí o retornando los datos.
        // Para este ejemplo, simplemente los haremos disponibles para la inclusión de la vista.
        return ['clases' => $clases, 'entrenadores' => $entrenadores, 'dia_seleccionado' => $dia_seleccionado];
    }

    // Otros métodos para manejar inscripciones, etc., se añadirán aquí más tarde.

    public function handleApiRequest($method) {
        if ($method == 'GET') {
            // Esta línea hace lo mismo que tu api/clases.php
            $clases = $this->claseDB->getAllClasesWithDetails();
            echo json_encode($clases);
        } else {
            // Devolvemos un error si se intenta usar un método no permitido (POST, PUT, etc.)
            header('HTTP/1.1 405 Method Not Allowed');
            echo json_encode(['error' => 'Método no permitido para este recurso']);
        }
    }
}
