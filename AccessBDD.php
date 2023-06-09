<?php
include_once("ConnexionPDO.php");

/**
 * Classe de construction des requêtes SQL à envoyer à la BDD
 */
class AccessBDD {
	
    public $login="root";
    public $mdp="";
    public $bd="mediatek86";
    public $serveur="localhost";
    public $port="3306";	
    public $conn = null;

    /**
     * constructeur : demande de connexion à la BDD
     */
    public function __construct(){
        try{
            $this->conn = new ConnexionPDO($this->login, $this->mdp, $this->bd, $this->serveur, $this->port);
        }catch(Exception $e){
            throw $e;
        }
    }

    /**
     * récupération de toutes les lignes d'une table
     * @param string $table nom de la table
     * @return lignes de la requete
     */
    public function selectAll($table){
        if($this->conn != null){
            switch ($table) {
                case "livre" :
                    return $this->selectAllLivres();
                case "dvd" :
                    return $this->selectAllDvd();
                case "revue" :
                    return $this->selectAllRevues();
                case "exemplaire" :
                    return $this->selectAllExemplairesRevue();
                default:
                    // cas d'un select portant sur une table simple, avec tri sur le libellé
                    return $this->selectAllTableSimple($table);
            }			
        }else{
            return null;
        }
    }

    /**
     * récupération d'une ligne d'une table
     * @param string $table nom de la table
     * @param string $id id de la ligne à récupérer
     * @return ligne de la requete correspondant à l'id
     */	
    public function selectOne($table, $id){
        if($this->conn != null){
            switch($table){
                case "exemplaire" :
                    return $this->selectAllExemplairesRevue($id);
                    
                case "livre" :
                    return $this->selectLivre($id);
                case "commande":
                    return $this->selectCommande($id);
                default:
                    // cas d'un select portant sur une table simple			
                    $param = array(
                        "id" => $id
                    );
                    return $this->conn->query("select * from $table where id=:id;", $param);					
            }				
        }else{
                return null;
        }
    }
    
    private function selectLivre($id) 
    {
        $req = "Select l.id, l.ISBN, l.auteur, d.titre, d.image, l.collection, ";
        $req .= "d.idrayon, d.idpublic, d.idgenre, g.libelle as genre, p.libelle as lePublic, r.libelle as rayon ";
        $req .= "from livre l join document d on l.id=d.id ";
        $req .= "join genre g on g.id=d.idGenre ";
        $req .= "join public p on p.id=d.idPublic ";
        $req .= "join rayon r on r.id=d.idRayon ";
        $req .= "where l.id=$id ";
        $req .= "order by titre ";
        return $this->conn->query($req);
    }    
    
    private function selectCommande($id) 
    {
        $req = "SELECT c.id, c.dateCommande as DateCommande, c.montant, cd.nbExemplaire, cd.idLivreDvd, s.id as IdSuivi, s.libelle as suivi ";
        $req .= "FROM commandedocument cd ";
        $req .= "JOIN commande c on cd.id = c.id ";
        $req .= "JOIN suivi s ON s.id = cd.idsuivi ";
        $req .= "WHERE cd.idLivreDvd = $id ";
        $req .= "ORDER BY id ";
        return $this->conn->query($req);
    }

    /**
     * récupération de toutes les lignes de d'une table simple (sans jointure) avec tri sur le libellé
     * @param type $table
     * @return lignes de la requete
     */
    public function selectAllTableSimple($table){
        $req = "select * from $table order by libelle;";		
        return $this->conn->query($req);		
    }

    /**
     * récupération de toutes les lignes de la table Livre et les tables associées
     * @return lignes de la requete
     */
    public function selectAllLivres(){
        $req = "Select l.id, l.ISBN, l.auteur, d.titre, d.image, l.collection, ";
        $req .= "d.idrayon, d.idpublic, d.idgenre, g.libelle as genre, p.libelle as lePublic, r.libelle as rayon ";
        $req .= "from livre l join document d on l.id=d.id ";
        $req .= "join genre g on g.id=d.idGenre ";
        $req .= "join public p on p.id=d.idPublic ";
        $req .= "join rayon r on r.id=d.idRayon ";
        $req .= "order by titre ";		
        return $this->conn->query($req);
    }	
    
    /**
     * récupération de toutes les lignes de la table Livre et les tables associées
     * @return lignes de la requete
     */
    public function getHighestId($table){
        $req = "Select id from $table ";
        $req .= "order by id DESC ";		
        return $this->conn->query($req);
    }	

    /**
     * récupération de toutes les lignes de la table DVD et les tables associées
     * @return lignes de la requete
     */
    public function selectAllDvd(){
        $req = "Select l.id, l.duree, l.realisateur, d.titre, d.image, l.synopsis, ";
        $req .= "d.idrayon, d.idpublic, d.idgenre, g.libelle as genre, p.libelle as lePublic, r.libelle as rayon ";
        $req .= "from dvd l join document d on l.id=d.id ";
        $req .= "join genre g on g.id=d.idGenre ";
        $req .= "join public p on p.id=d.idPublic ";
        $req .= "join rayon r on r.id=d.idRayon ";
        $req .= "order by titre ";	
        return $this->conn->query($req);
    }	

    /**
     * récupération de toutes les lignes de la table Revue et les tables associées
     * @return lignes de la requete
     */
    public function selectAllRevues(){
        $req = "Select l.id, l.periodicite, d.titre, d.image, l.delaiMiseADispo, ";
        $req .= "d.idrayon, d.idpublic, d.idgenre, g.libelle as genre, p.libelle as lePublic, r.libelle as rayon ";
        $req .= "from revue l join document d on l.id=d.id ";
        $req .= "join genre g on g.id=d.idGenre ";
        $req .= "join public p on p.id=d.idPublic ";
        $req .= "join rayon r on r.id=d.idRayon ";
        $req .= "order by titre ";
        return $this->conn->query($req);
    }	

    /**
     * récupération de tous les exemplaires d'une revue
     * @param string $id id de la revue
     * @return lignes de la requete
     */
    public function selectAllExemplairesRevue($id){
        $param = array(
                "id" => $id
        );
        $req = "Select e.id, e.numero, e.dateAchat, e.photo, e.idEtat, et.libelle AS Etat ";
        $req .= "from exemplaire e join document d on e.id=d.id ";
        $req .= "join etat et on et.id = e.idEtat ";
        $req .= "where e.id = :id ";
        $req .= "order by e.dateAchat DESC";		
        return $this->conn->query($req, $param);
    }

    /**
     * suppresion d'une ou plusieurs lignes dans une table
     * @param string $table nom de la table
     * @param array $champs nom et valeur de chaque champs
     * @return true si la suppression a fonctionné
     */	
    public function delete($table, $champs){
        if($this->conn != null){
            // construction de la requête
            $requete = "delete from $table where ";
            foreach ($champs as $key => $value){
                $requete .= "$key=:$key and ";
            }
            // (enlève le dernier and)
            $requete = substr($requete, 0, strlen($requete)-5);   
            return $this->conn->execute($requete, $champs);		
        }else{
            return null;
        }
    }

    /**
     * ajout d'une ligne dans une table
     * @param string $table nom de la table
     * @param array $champs nom et valeur de chaque champs de la ligne
     * @return true si l'ajout a fonctionné
     */	
    public function insertOne($table, $champs){
        if($this->conn != null && $champs != null){
            // construction de la requête
            $requete = "insert into $table (";
            foreach ($champs as $key => $value){
                $requete .= "$key,";
            }
            // (enlève la dernière virgule)
            $requete = substr($requete, 0, strlen($requete)-1);
            $requete .= ") values (";
            foreach ($champs as $key => $value){
                $requete .= ":$key,";
            }
            // (enlève la dernière virgule)
            $requete = substr($requete, 0, strlen($requete)-1);
            $requete .= ");";	
            return $this->conn->execute($requete, $champs);		
        }else{
            return null;
        }
    }
    
    /**
     * Ajout d'une ligne dans une table en éliminant les données inutiles
     * @param type $table
     * @param type $contenu
     * @return type
     */
    public function insertClass($table, $contenu){
        if ($this->conn != null && $contenu != null) {
            //Récupération des noms des colonnes de la table Livre
            $req = "SELECT * FROM $table";
            $columns = $this->conn->getTableCols($req);
            
            //Construction de la requete
            $requete = "insert into $table (";
            foreach ($contenu as $key => $value){
                if (isset($columns[strtolower($key)])) {
                    $requete .= "$key,";
                } else {
                   unset($contenu[$key]);
                }
            }
            
            // (enlève la dernière virgule)
            $requete = substr($requete, 0, strlen($requete)-1);
            
            $requete .= ") values (";
            foreach ($contenu as $key => $value){
                if (isset($columns[strtolower($key)])) {
                    $requete .= ":$key,";
                }
            }
            // (enlève la dernière virgule)
            $requete = substr($requete, 0, strlen($requete)-1);
            $requete .= ");";
            return $this->conn->execute($requete, $contenu);
        } else {
            return null;
        }
    }

    /**
     * modification d'une ligne dans une table
     * @param string $table nom de la table
     * @param string $id id de la ligne à modifier
     * @param array $param nom et valeur de chaque champs de la ligne
     * @return true si la modification a fonctionné
     */	
    public function updateOne($table, $id, $champs){
        if($this->conn != null && $champs != null){
            $req = "SELECT * FROM $table";
            $columns = $this->conn->getTableCols($req);
            
            //Construction de la requete
            $requete = "update $table set ";    
            foreach ($champs as $key => $value){
                if (isset($columns[strtolower($key)])) {
                    $requete .= "$key=:$key,";
                } else {
                   unset($champs[$key]);
                }
            }
            
            // (enlève la dernière virgule)
            $requete = substr($requete, 0, strlen($requete)-1);				
            $champs["id"] = $id;
            if ($table == "exemplaire") {
                $requete .= " where numero=:id;";
            } else {
                $requete .= " where id=:id;";
            }
            return $this->conn->execute($requete, $champs);		
        }else{
            return null;
        }
    }
    
    public function login($creds)
    {
        $param = array(
            "login" => $creds["login"],
            "pwd" => $creds["pwd"]
        );

        $req = "SELECT users.idservice ";
        $req .= "FROM userlogin login ";
        $req .= "JOIN utilisateurs users ON login.id = users.id ";
        $req .= "WHERE login.login = :login AND login.pwd = :pwd ";
        
        $result = $this->conn->query($req, $param);
        if (empty($result)) {
            return "failed";
        } else {
            return $result;
        }
    }

}