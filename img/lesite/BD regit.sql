-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Dim 24 Janvier 2016 à 21:20
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `pub`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `idadmin` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `mdp` varchar(256) NOT NULL,
  PRIMARY KEY (`idadmin`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `campagnes`
--

CREATE TABLE IF NOT EXISTS `campagnes` (
  `idcampagne` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idutilisateur` bigint(20) unsigned NOT NULL,
  `typeCampagne` varchar(32) NOT NULL,
  `titre` varchar(128) NOT NULL,
  `contenu` text NOT NULL,
  `largeur` int(11) NOT NULL,
  `hauteur` int(11) NOT NULL,
  `mode` varchar(128) NOT NULL,
  `prixUnitaire` double NOT NULL,
  `dateDebut` date NOT NULL,
  `dateFin` date NOT NULL,
  `description` text NOT NULL,
  `valider` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idcampagne`,`idutilisateur`),
  KEY `campagnes_ibfk_1` (`idutilisateur`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Structure de la table `diffusions`
--

CREATE TABLE IF NOT EXISTS `diffusions` (
  `idutilisateur` bigint(20) unsigned NOT NULL,
  `idcampagne` bigint(20) unsigned NOT NULL,
  `compteur` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idutilisateur`,`idcampagne`),
  KEY `fk_diffusion_idcampagne` (`idcampagne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `encaissements`
--

CREATE TABLE IF NOT EXISTS `encaissements` (
  `idencaissement` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `idutilisateur` bigint(20) unsigned NOT NULL,
  `idcampagne` bigint(20) unsigned NOT NULL,
  `montant` bigint(20) NOT NULL,
  `dateEncaissement` date NOT NULL,
  PRIMARY KEY (`idencaissement`),
  KEY `fk_encaissements_idutilisateur` (`idutilisateur`),
  KEY `fk_encaissements_idmodule` (`idcampagne`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `idutilisateur` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `urlSite` varchar(64) DEFAULT NULL,
  `typeSite` varchar(16) DEFAULT NULL,
  `societe` varchar(32) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `mdp` varchar(128) NOT NULL,
  `nom` varchar(32) NOT NULL,
  `prenom` varchar(32) NOT NULL,
  `adresse` varchar(128) NOT NULL,
  `codePostal` int(11) NOT NULL,
  `ville` varchar(32) NOT NULL,
  `pays` varchar(32) NOT NULL,
  `tel` varchar(10) NOT NULL,
  `banni` tinyint(1) NOT NULL,
  `typeUser` varchar(16) NOT NULL,
  PRIMARY KEY (`idutilisateur`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `campagnes`
--
ALTER TABLE `campagnes`
  ADD CONSTRAINT `campagnes_ibfk_1` FOREIGN KEY (`idutilisateur`) REFERENCES `utilisateurs` (`idutilisateur`),
  ADD CONSTRAINT `fk_campagnes_idutilisateur` FOREIGN KEY (`idutilisateur`) REFERENCES `utilisateurs` (`idutilisateur`);

--
-- Contraintes pour la table `diffusions`
--
ALTER TABLE `diffusions`
  ADD CONSTRAINT `fk_diffusion_idcampagne` FOREIGN KEY (`idcampagne`) REFERENCES `campagnes` (`idcampagne`),
  ADD CONSTRAINT `fk_diffusion_idutilisateur` FOREIGN KEY (`idutilisateur`) REFERENCES `utilisateurs` (`idutilisateur`);

--
-- Contraintes pour la table `encaissements`
--
ALTER TABLE `encaissements`
  ADD CONSTRAINT `fk_encaissements_idmodule` FOREIGN KEY (`idcampagne`) REFERENCES `campagnes` (`idcampagne`),
  ADD CONSTRAINT `fk_encaissements_idutilisateur` FOREIGN KEY (`idutilisateur`) REFERENCES `utilisateurs` (`idutilisateur`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
