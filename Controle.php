<?php
include_once("AccessBDD.php");
/**
 * Contrôleur : reçoit et traite les demandes du point d'entrée
 */
class Controle{
	
    private $accessBDD;

    /**
     * Constructeur : récupération de l'instance d'accès à la BDD
     */
    public function __construct(){
        try{
            $this->accessBDD = new AccessBDD();
        }catch(Exception $e){
            $this->reponse(500, "erreur serveur");
            die();
        }
    }

    /**
     * réponse renvoyée (affichée) au client au format json
     * @param int $code code standard HTTP
     * @param string $message message correspondant au code
     * @param array $result résultat de la demande 
     */
    private function reponse($code, $message, $result=""){
        $retour = array(
            'code' => $code,
            'message' => $message,
            'result' => $result
        );
        error_log(json_encode($retour, JSON_UNESCAPED_UNICODE));
        echo json_encode($retour, JSON_UNESCAPED_UNICODE);
    }

    /**
     * requete arrivée en GET (select)
     * @param string $table nom de la table
     * @param string $id valeur de l'id
     */
    public function get($table, $id=null){
        $result = null;
        if ($id==null){
            $result = $this->accessBDD->selectAll($table);
        } elseif ($id=="get") {
            $result = $this->accessBDD->getHighestId($table);
        }
        else{
            $result = $this->accessBDD->selectOne($table, $id);
        }
        if ($result == null || $result == false){
            $this->reponse(400, "requete invalide");
        }else{	
            $this->reponse(200, "OK", $result);
        }
    }

    /**
     * requete arrivée en DELETE
     * @param string $table nom de la table
     * @param array $champs nom et valeur des champs
     */
    public function delete($table, $champs){
        $result = $this->accessBDD->delete($table, $champs);	
        if ($result == null || $result == false){
            $this->reponse(400, "requete invalide");
        }else{	
            $this->reponse(200, "OK");
        }
    }

    /**
     * requete arrivée en POST (insert)
     * @param string $table nom de la table
     * @param array $champs nom et valeur des champs
     */
    public function post($table, $champs, $id){
        if ($id==null) {
            $result = $this->accessBDD->insertOne($table, $champs);	
        } else {
            $result = $this->accessBDD->insertClass($table, $champs);	
        }
        
        if ($result == false || $result == null) {
            $this->reponse(400, "requete invalide");
        }elseif ($result == true){	
            $this->reponse(200, "OK ");
        } else {
            $this->reponse(400, "Erreur SQL : ".$result);
        }
    }

    /**
     * requete arrivée en PUT (update)
     * @param string $table nom de la table
     * @param string $id valeur de l'id
     * @param array $champs nom et valeur des champs
     */
    public function put($table, $id, $champs){
        $result = $this->accessBDD->updateOne($table, $id, $champs);	
        if ($result == null || $result == false){
            $this->reponse(400, "requete invalide");
        }else{	
            $this->reponse(200, "OK");
        }
    }
    
    public function login($credentials) {
        $result = $this->accessBDD->login($credentials);	
        if ($result == null || $result == false){
            $this->reponse(400, "requete invalide");
        } elseif ($result == "failed") {
            $this->reponse(401 , "Indentifiant ou mdp invalide");
        }else{	
            $this->reponse(200, "OK", $result);
        }
    }


    /**
     * login et/ou pwd incorrects
     */
    public function unauthorized(){
        $this->reponse(401, "authentification incorrecte");
    }
}