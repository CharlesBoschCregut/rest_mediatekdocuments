<?php
/**
 * Classe de connexion et d'exécution des requêtes dans une BDD MySQL
 */

class ConnexionPDO {

    private $conn = null;

    /**
     * constructeur privé : connexion à la BDD
     * @param string $login 
     * @param string $mdp
     * @param string $bd
     * @param string $serveur
     * @param int $port
     */
    public function __construct($login, $mdp, $bd, $serveur, $port){
        try {
            $this->conn = new PDO("mysql:host=$serveur;dbname=$bd;port=$port", $login, $mdp);
            $this->conn->query('SET CHARACTER SET utf8');
        } catch (PDOException $e) {
            throw $e;
        }
    }

    /**
     * Exécution d'une requête de mise à jour (insert, update, delete)
     * @param string $requete
     * @param array $param
     * @return résultat requête (booléen)
     */
    public function execute($requete, $param=null){
        try{	
            $requetePrepare = $this->conn->prepare($requete);
            if($param != null){
                foreach($param as $key => &$value){				
                    $requetePrepare->bindParam(":$key", $value);
                }
            }	
            $requetePrepare->execute();
            if ($requetePrepare->errorCode() != "00000") {
                return true;
            } else {
                return "Code : ".$requetePrepare->errorCode()." -> ".$requete;
            }
        }catch(Exception $e){
            return false;
        }
    }

    /**
     * Exécution d'une requête select retournant 0 à plusieurs lignes
     * @param string $requete
     * @param array $param
     * @return lignes récupérées
     */
    public function query($requete, $param=null){
        try{
            $requetePrepare = $this->conn->prepare($requete);
            if($param != null){
                foreach($param as $key => &$value){
                    $requetePrepare->bindParam(":$key", $value);
                }
            }
            $requetePrepare->execute();				
            return $requetePrepare->fetchAll(PDO::FETCH_ASSOC);
        }catch(Exception $e){
            return null;
        }		
    }
    
    public function getTableCols($requete){
        try{
            $requetePrepare = $this->conn->prepare($requete);
            $requetePrepare->execute();				
            $colCount = $requetePrepare->columnCount();
            $columns = array();
            for($i=0;$i<$colCount;$i++){
                $meta = $requetePrepare->getColumnMeta($i);
                $columns[strtolower($meta['name'])] = $meta['name'];
            }
            return $columns;
        }catch(Exception $e){
            return null;
        }
    }
	
}