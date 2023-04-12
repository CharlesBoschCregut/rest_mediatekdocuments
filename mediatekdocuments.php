<?php
header('Content-Type: application/json');
include_once("Controle.php");
$controle = new Controle();

// Contrôle de l'authentification
if(!isset($_SERVER['PHP_AUTH_USER']) || (isset($_SERVER['PHP_AUTH_USER']) && 
        !(($_SERVER['PHP_AUTH_USER']=='admin' && ($_SERVER['PHP_AUTH_PW']=='adminpwd'))))){
    $controle->unauthorized();
    
}else{
    
    // récupération des données
    // Nom de la table au format string
    $table = filter_input(INPUT_GET, 'table', FILTER_SANITIZE_STRING) ??
             filter_input(INPUT_POST, 'table', FILTER_SANITIZE_STRING);
    // id de l'enregistrement au format string
    $id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_STRING) ??
          filter_input(INPUT_POST, 'id', FILTER_SANITIZE_STRING);
    
    $type = filter_input(INPUT_GET, 'type', FILTER_SANITIZE_STRING) ??
                    filter_input(INPUT_POST, 'type', FILTER_SANITIZE_STRING);
    // nom et valeur des champs au format json
    $contenu = filter_input(INPUT_GET, 'contenu', FILTER_SANITIZE_STRING,FILTER_FLAG_NO_ENCODE_QUOTES) ??
               filter_input(INPUT_POST, 'contenu', FILTER_SANITIZE_STRING,FILTER_FLAG_NO_ENCODE_QUOTES);
    if($contenu != ""){
        $contenu = json_decode($contenu, true);
    }

    // traitement suivant le verbe HTTP utilisé
    if ($_SERVER['REQUEST_METHOD'] === 'GET') {
        $controle->get($table, $id);
    } else if($_SERVER['REQUEST_METHOD'] === 'POST') {
        switch ($type) {
            case "UPD":
                $controle->put($table, $id, $contenu);
                break;
            case "REM":
                $controle->delete($table, $contenu);
                break;

            default:
                $controle->post($table, $contenu, $id);
        }
    }
}