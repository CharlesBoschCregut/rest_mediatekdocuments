-- --------------------------------------------------------
-- Hôte:                         localhost
-- Version du serveur:           8.0.27 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.4.0.6670
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour mediatek86
CREATE DATABASE IF NOT EXISTS `mediatek86` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mediatek86`;

-- Listage de la structure de la table mediatek86. abonnement
CREATE TABLE IF NOT EXISTS `abonnement` (
  `id` varchar(5) NOT NULL,
  `dateFinAbonnement` date DEFAULT NULL,
  `idRevue` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idRevue` (`idRevue`),
  CONSTRAINT `abonnement_ibfk_1` FOREIGN KEY (`id`) REFERENCES `commande` (`id`),
  CONSTRAINT `abonnement_ibfk_2` FOREIGN KEY (`idRevue`) REFERENCES `revue` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.abonnement : ~0 rows (environ)

-- Listage de la structure de la table mediatek86. commande
CREATE TABLE IF NOT EXISTS `commande` (
  `id` varchar(5) NOT NULL,
  `dateCommande` datetime DEFAULT NULL,
  `montant` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.commande : ~4 rows (environ)
INSERT INTO `commande` (`id`, `dateCommande`, `montant`) VALUES
	('30002', '2023-04-14 15:02:01', 0),
	('30003', '2023-04-13 18:31:02', 65),
	('30004', '2023-04-13 18:31:10', 87),
	('30006', '2023-04-14 17:05:10', 0.21),
	('30007', '2023-04-14 17:11:52', 0);

-- Listage de la structure de la table mediatek86. commandedocument
CREATE TABLE IF NOT EXISTS `commandedocument` (
  `id` varchar(5) NOT NULL,
  `nbExemplaire` int DEFAULT NULL,
  `idLivreDvd` varchar(10) NOT NULL,
  `idsuivi` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idLivreDvd` (`idLivreDvd`),
  KEY `FK_commandedocument_suivi` (`idsuivi`) USING BTREE,
  CONSTRAINT `commandedocument_ibfk_1` FOREIGN KEY (`id`) REFERENCES `commande` (`id`),
  CONSTRAINT `commandedocument_ibfk_2` FOREIGN KEY (`idLivreDvd`) REFERENCES `livresdvd` (`id`),
  CONSTRAINT `FK_commandedocument_suivi` FOREIGN KEY (`idsuivi`) REFERENCES `suivi` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.commandedocument : ~5 rows (environ)
INSERT INTO `commandedocument` (`id`, `nbExemplaire`, `idLivreDvd`, `idsuivi`) VALUES
	('30002', 1, '00005', '00003'),
	('30003', 3, '00005', '00003'),
	('30004', 4, '00005', '00004'),
	('30006', 7, '00009', '00001'),
	('30007', 1, '00005', '00003');

-- Listage de la structure de la table mediatek86. document
CREATE TABLE IF NOT EXISTS `document` (
  `id` varchar(10) NOT NULL,
  `titre` varchar(60) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `idRayon` varchar(5) NOT NULL,
  `idPublic` varchar(5) NOT NULL,
  `idGenre` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idRayon` (`idRayon`),
  KEY `idPublic` (`idPublic`),
  KEY `idGenre` (`idGenre`),
  CONSTRAINT `document_ibfk_1` FOREIGN KEY (`idRayon`) REFERENCES `rayon` (`id`),
  CONSTRAINT `document_ibfk_2` FOREIGN KEY (`idPublic`) REFERENCES `public` (`id`),
  CONSTRAINT `document_ibfk_3` FOREIGN KEY (`idGenre`) REFERENCES `genre` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.document : ~41 rows (environ)
INSERT INTO `document` (`id`, `titre`, `image`, `idRayon`, `idPublic`, `idGenre`) VALUES
	('00001', 'Quand sort la recluse', '', 'LV003', '00002', '10014'),
	('00002', 'Un pays à l\'aube', '', 'LV001', '00002', '10004'),
	('00003', 'Et je danse aussi', '', 'LV002', '00003', '10013'),
	('00004', 'L\'armée furieuse', '', 'LV003', '00002', '10014'),
	('00005', 'Les anonymes', '', 'LV001', '00002', '10014'),
	('00006', 'La marque jaune', '', 'BD001', '00003', '10001'),
	('00007', 'Dans les coulisses du musée', '', 'LV001', '00003', '10006'),
	('00008', 'Histoire du juif errant', '', 'LV002', '00002', '10006'),
	('00009', 'Pars vite et reviens tard', '', 'LV003', '00002', '10014'),
	('00010', 'Le vestibule des causes perdues', '', 'LV001', '00002', '10006'),
	('00011', 'L\'île des oubliés', '', 'LV002', '00003', '10006'),
	('00012', 'La souris bleue', '', 'LV002', '00003', '10006'),
	('00013', 'Sacré Pêre Noël', '', 'JN001', '00001', '10001'),
	('00014', 'Mauvaise étoile', '', 'LV003', '00003', '10014'),
	('00015', 'La confrérie des téméraires', '', 'JN002', '00004', '10014'),
	('00016', 'Le butin du requin', '', 'JN002', '00004', '10014'),
	('00017', 'Catastrophes au Brésil', '', 'JN002', '00004', '10014'),
	('00018', 'Le Routard - Maroc', '', 'DV005', '00003', '10011'),
	('00019', 'Guide Vert - Iles Canaries', '', 'DV005', '00003', '10011'),
	('00020', 'Guide Vert - Irlande', '', 'DV005', '00003', '10011'),
	('00021', 'Les déferlantes', '', 'LV002', '00002', '10006'),
	('00022', 'Une part de Ciel', '', 'LV002', '00002', '10006'),
	('00023', 'Le secret du janissaire', '', 'BD001', '00002', '10001'),
	('00024', 'Pavillon noir', '', 'BD001', '00002', '10001'),
	('00025', 'L\'archipel du danger', '', 'BD001', '00002', '10001'),
	('00026', 'La planète des singes', '', 'LV002', '00003', '10002'),
	('10001', 'Arts Magazine', '', 'PR002', '00002', '10016'),
	('10002', 'Alternatives Economiques', '', 'PR002', '00002', '10015'),
	('10003', 'Challenges', '', 'PR002', '00002', '10015'),
	('10004', 'Rock and Folk', '', 'PR002', '00002', '10016'),
	('10005', 'Les Echos', '', 'PR001', '00002', '10015'),
	('10006', 'Le Monde', '', 'PR001', '00002', '10018'),
	('10007', 'Telerama', '', 'PR002', '00002', '10016'),
	('10008', 'L\'Obs', '', 'PR002', '00002', '10018'),
	('10009', 'L\'Equipe', '', 'PR001', '00002', '10017'),
	('10010', 'L\'Equipe Magazine', '', 'PR002', '00002', '10017'),
	('10011', 'Geo', '', 'PR002', '00003', '10016'),
	('10012', 'AAZAZAZA', 'leimage', 'BL001', '00004', '10007'),
	('20001', 'Star Wars 5 L\'empire contre attaque', '', 'DF001', '00003', '10002'),
	('20002', 'Le seigneur des anneaux : la communauté de l\'anneau', '', 'DF001', '00003', '10019'),
	('20003', 'Jurassic Park', '', 'DF001', '00003', '10002'),
	('20004', 'Matrix', '', 'DF001', '00003', '10002');

-- Listage de la structure de la table mediatek86. dvd
CREATE TABLE IF NOT EXISTS `dvd` (
  `id` varchar(10) NOT NULL,
  `synopsis` text,
  `realisateur` varchar(20) DEFAULT NULL,
  `duree` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `dvd_ibfk_1` FOREIGN KEY (`id`) REFERENCES `livresdvd` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.dvd : ~4 rows (environ)
INSERT INTO `dvd` (`id`, `synopsis`, `realisateur`, `duree`) VALUES
	('20001', 'Luc est entraîné par Yoda pendant que Han et Leia tentent de se cacher dans la cité des nuages.', 'George Lucas', 124),
	('20002', 'L\'anneau unique, forgé par Sauron, est porté par Fraudon qui l\'amène à Foncombe. De là, des représentants de peuples différents vont s\'unir pour aider Fraudon à amener l\'anneau à la montagne du Destin.', 'Peter Jackson', 228),
	('20003', 'Un milliardaire et des généticiens créent des dinosaures à partir de clonage.', 'Steven Spielberg', 128),
	('20004', 'Un informaticien réalise que le monde dans lequel il vit est une simulation gérée par des machines.', 'Les Wachowski', 136);

-- Listage de la structure de la table mediatek86. etat
CREATE TABLE IF NOT EXISTS `etat` (
  `id` char(5) NOT NULL,
  `libelle` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.etat : ~4 rows (environ)
INSERT INTO `etat` (`id`, `libelle`) VALUES
	('00001', 'neuf'),
	('00002', 'usagé'),
	('00003', 'détérioré'),
	('00004', 'inutilisable');

-- Listage de la structure de la table mediatek86. exemplaire
CREATE TABLE IF NOT EXISTS `exemplaire` (
  `id` varchar(10) NOT NULL,
  `numero` int NOT NULL,
  `dateAchat` date DEFAULT NULL,
  `photo` varchar(500) NOT NULL,
  `idEtat` char(5) NOT NULL,
  PRIMARY KEY (`id`,`numero`),
  KEY `idEtat` (`idEtat`),
  CONSTRAINT `exemplaire_ibfk_1` FOREIGN KEY (`id`) REFERENCES `document` (`id`),
  CONSTRAINT `exemplaire_ibfk_2` FOREIGN KEY (`idEtat`) REFERENCES `etat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.exemplaire : ~15 rows (environ)
INSERT INTO `exemplaire` (`id`, `numero`, `dateAchat`, `photo`, `idEtat`) VALUES
	('10002', 418, '2021-12-01', '', '00001'),
	('10007', 3237, '2021-11-23', '', '00001'),
	('10007', 3238, '2021-11-30', '', '00001'),
	('10007', 3239, '2021-12-07', '', '00001'),
	('10007', 3240, '2021-12-21', '', '00001'),
	('10011', 505, '2022-10-16', '', '00001'),
	('10011', 506, '2021-04-01', '', '00001'),
	('10011', 507, '2021-05-03', '', '00001'),
	('10011', 508, '2021-06-05', '', '00001'),
	('10011', 509, '2021-07-01', '', '00001'),
	('10011', 510, '2021-08-04', '', '00001'),
	('10011', 511, '2021-09-01', '', '00001'),
	('10011', 512, '2021-10-06', '', '00001'),
	('10011', 513, '2021-11-01', '', '00001'),
	('10011', 514, '2021-12-01', '', '00001');

-- Listage de la structure de la table mediatek86. genre
CREATE TABLE IF NOT EXISTS `genre` (
  `id` varchar(5) NOT NULL,
  `libelle` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.genre : ~19 rows (environ)
INSERT INTO `genre` (`id`, `libelle`) VALUES
	('10000', 'Humour'),
	('10001', 'Bande dessinée'),
	('10002', 'Science Fiction'),
	('10003', 'Biographie'),
	('10004', 'Historique'),
	('10006', 'Roman'),
	('10007', 'Aventures'),
	('10008', 'Essai'),
	('10009', 'Documentaire'),
	('10010', 'Technique'),
	('10011', 'Voyages'),
	('10012', 'Drame'),
	('10013', 'Comédie'),
	('10014', 'Policier'),
	('10015', 'Presse Economique'),
	('10016', 'Presse Culturelle'),
	('10017', 'Presse sportive'),
	('10018', 'Actualités'),
	('10019', 'Fantazy');

-- Listage de la structure de la table mediatek86. livre
CREATE TABLE IF NOT EXISTS `livre` (
  `id` varchar(10) NOT NULL,
  `ISBN` varchar(13) DEFAULT NULL,
  `auteur` varchar(20) DEFAULT NULL,
  `collection` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `livre_ibfk_1` FOREIGN KEY (`id`) REFERENCES `livresdvd` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.livre : ~26 rows (environ)
INSERT INTO `livre` (`id`, `ISBN`, `auteur`, `collection`) VALUES
	('00001', '1234569877896', 'Fred Vargas', 'Commissaire Adamsberg'),
	('00002', '1236547896541', 'Dennis Lehanne', ''),
	('00003', '6541236987410', 'Anne-Laure Bondoux', ''),
	('00004', '3214569874123', 'Fred Vargas', 'Commissaire Adamsberg'),
	('00005', '3214563214563', 'RJ Ellory', ''),
	('00006', '3213213211232', 'Edgar P. Jacobs', 'Blake et Mortimer'),
	('00007', '6541236987541', 'Kate Atkinson', ''),
	('00008', '1236987456321', 'Jean d\'Ormesson', ''),
	('00009', '', 'Fred Vargas', 'Commissaire Adamsberg'),
	('00010', '', 'Manon Moreau', ''),
	('00011', '', 'Victoria Hislop', ''),
	('00012', '', 'Kate Atkinson', ''),
	('00013', '', 'Raymond Briggs', ''),
	('00014', '', 'RJ Ellory', ''),
	('00015', '', 'Floriane Turmeau', ''),
	('00016', '', 'Julian Press', ''),
	('00017', '', 'Philippe Masson', ''),
	('00018', '', '', 'Guide du Routard'),
	('00019', '', '', 'Guide Vert'),
	('00020', '', '', 'Guide Vert'),
	('00021', '', 'Claudie Gallay', ''),
	('00022', '', 'Claudie Gallay', ''),
	('00023', '', 'Ayrolles - Masbou', 'De cape et de crocs'),
	('00024', '', 'Ayrolles - Masbou', 'De cape et de crocs'),
	('00025', '', 'Ayrolles - Masbou', 'De cape et de crocs'),
	('00026', '', 'Pierre Boulle', 'Julliard');

-- Listage de la structure de la table mediatek86. livresdvd
CREATE TABLE IF NOT EXISTS `livresdvd` (
  `id` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `livresdvd_ibfk_1` FOREIGN KEY (`id`) REFERENCES `document` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.livresdvd : ~30 rows (environ)
INSERT INTO `livresdvd` (`id`) VALUES
	('00001'),
	('00002'),
	('00003'),
	('00004'),
	('00005'),
	('00006'),
	('00007'),
	('00008'),
	('00009'),
	('00010'),
	('00011'),
	('00012'),
	('00013'),
	('00014'),
	('00015'),
	('00016'),
	('00017'),
	('00018'),
	('00019'),
	('00020'),
	('00021'),
	('00022'),
	('00023'),
	('00024'),
	('00025'),
	('00026'),
	('20001'),
	('20002'),
	('20003'),
	('20004');

-- Listage de la structure de la table mediatek86. public
CREATE TABLE IF NOT EXISTS `public` (
  `id` varchar(5) NOT NULL,
  `libelle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.public : ~4 rows (environ)
INSERT INTO `public` (`id`, `libelle`) VALUES
	('00001', 'Jeunesse'),
	('00002', 'Adultes'),
	('00003', 'Tous publics'),
	('00004', 'Ados');

-- Listage de la structure de la table mediatek86. rayon
CREATE TABLE IF NOT EXISTS `rayon` (
  `id` char(5) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.rayon : ~15 rows (environ)
INSERT INTO `rayon` (`id`, `libelle`) VALUES
	('BD001', 'BD Adultes'),
	('BL001', 'Beaux Livres'),
	('DF001', 'DVD films'),
	('DV001', 'Sciences'),
	('DV002', 'Maison'),
	('DV003', 'Santé'),
	('DV004', 'Littérature classique'),
	('DV005', 'Voyages'),
	('JN001', 'Jeunesse BD'),
	('JN002', 'Jeunesse romans'),
	('LV001', 'Littérature étrangère'),
	('LV002', 'Littérature française'),
	('LV003', 'Policiers français étrangers'),
	('PR001', 'Presse quotidienne'),
	('PR002', 'Magazines');

-- Listage de la structure de la table mediatek86. revue
CREATE TABLE IF NOT EXISTS `revue` (
  `id` varchar(10) NOT NULL,
  `periodicite` varchar(2) DEFAULT NULL,
  `delaiMiseADispo` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `revue_ibfk_1` FOREIGN KEY (`id`) REFERENCES `document` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.revue : ~11 rows (environ)
INSERT INTO `revue` (`id`, `periodicite`, `delaiMiseADispo`) VALUES
	('10001', 'MS', 52),
	('10002', 'MS', 52),
	('10003', 'HB', 15),
	('10004', 'HB', 15),
	('10005', 'QT', 5),
	('10006', 'QT', 5),
	('10007', 'HB', 26),
	('10008', 'HB', 26),
	('10009', 'QT', 5),
	('10010', 'HB', 12),
	('10011', 'MS', 52),
	('10012', 'ZS', 1);

-- Listage de la structure de la table mediatek86. suivi
CREATE TABLE IF NOT EXISTS `suivi` (
  `id` char(5) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table mediatek86.suivi : ~4 rows (environ)
INSERT INTO `suivi` (`id`, `libelle`) VALUES
	('00001', 'en cours'),
	('00002', 'relancé'),
	('00003', 'livrée'),
	('00004', 'réglée');

-- Listage de la structure de le déclencheur mediatek86. tr_commandedocument_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `tr_commandedocument_insert` BEFORE INSERT ON `commandedocument` FOR EACH ROW BEGIN
    IF NOT EXISTS (SELECT 1 FROM commande WHERE id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'L\'identifiant n\'existe pas dans la table Commande';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Listage de la structure de le déclencheur mediatek86. tr_commande_before_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `tr_commande_before_delete` BEFORE DELETE ON `commande` FOR EACH ROW BEGIN
  DELETE FROM commandedocument
  WHERE commandedocument.id = OLD.id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Listage de la structure de le déclencheur mediatek86. tr_commande_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `tr_commande_before_insert` BEFORE INSERT ON `commande` FOR EACH ROW BEGIN
    IF EXISTS (SELECT 1 FROM commande WHERE id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'L\'identifiant existe deja dans la table Commande';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Listage de la structure de le déclencheur mediatek86. tr_document_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tr_document_insert` BEFORE INSERT ON `document` FOR EACH ROW BEGIN
   IF EXISTS (SELECT 1 FROM Document WHERE id = NEW.id) THEN
      SIGNAL SQLSTATE '45000' 
      SET MESSAGE_TEXT = 'L\'identifiant existe déjà dans la table Document';
   END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Listage de la structure de le déclencheur mediatek86. tr_livresdvd_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tr_livresdvd_insert` BEFORE INSERT ON `livresdvd` FOR EACH ROW BEGIN
    IF NOT EXISTS (SELECT 1 FROM Document WHERE id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'L\'identifiant n\'existe pas dans la table Document';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Listage de la structure de le déclencheur mediatek86. tr_livre_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tr_livre_insert` BEFORE INSERT ON `livre` FOR EACH ROW BEGIN
    IF NOT EXISTS (SELECT 1 FROM LivresDvd WHERE id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'L\'identifiant n\'existe pas dans la table LivresDvd';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Listage de la structure de le déclencheur mediatek86. tr_revue_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tr_revue_insert` BEFORE INSERT ON `revue` FOR EACH ROW BEGIN
    IF NOT EXISTS (SELECT 1 FROM document WHERE id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'L\'identifiant n\'existe pas dans la table document';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
