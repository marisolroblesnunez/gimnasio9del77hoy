<?php

session_start();
if(isset($_SESSION['logueado'])){

//borrar todos los datos de la sesion
session_unset();
//destruye la sesion
session_destroy();
}
//redireccionar a la pagina de inicio