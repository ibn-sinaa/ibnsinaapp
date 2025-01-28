-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mar. 28 jan. 2025 à 04:02
-- Version du serveur : 8.0.41
-- Version de PHP : 8.3.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ibnsina_up`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int NOT NULL,
  `admin_user` varchar(50) NOT NULL DEFAULT '',
  `admin_password` varchar(50) NOT NULL DEFAULT '',
  `admin_lastviste` varchar(250) NOT NULL DEFAULT '',
  `admin_lastviste_file` varchar(250) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_user`, `admin_password`, `admin_lastviste`, `admin_lastviste_file`) VALUES
(1, 'admin', 'a8f5f167f44f4964e6c998dee827110c', '1343843001', '1343843001');

-- --------------------------------------------------------

--
-- Structure de la table `banned`
--

CREATE TABLE `banned` (
  `banned_id` int NOT NULL,
  `banned_ip` varchar(250) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `extension`
--

CREATE TABLE `extension` (
  `ex_id` int NOT NULL,
  `ex_name` varchar(250) NOT NULL DEFAULT '',
  `ex_maxsize` varchar(250) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `extension`
--

INSERT INTO `extension` (`ex_id`, `ex_name`, `ex_maxsize`) VALUES
(1, 'jpg', '1000');

-- --------------------------------------------------------

--
-- Structure de la table `files`
--

CREATE TABLE `files` (
  `file_id` int NOT NULL,
  `file_name` varchar(250) NOT NULL DEFAULT '',
  `ipaddress` varchar(250) NOT NULL DEFAULT '',
  `file_date` varchar(250) NOT NULL DEFAULT '',
  `file_url` varchar(250) NOT NULL DEFAULT '',
  `file_tybe` varchar(250) NOT NULL DEFAULT '',
  `file_size` varchar(250) NOT NULL DEFAULT '',
  `file_count` int NOT NULL DEFAULT '0',
  `file_key` varchar(250) NOT NULL DEFAULT '',
  `group` varchar(250) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `gd`
--

CREATE TABLE `gd` (
  `gd_id` int NOT NULL,
  `gd_upload` varchar(250) NOT NULL DEFAULT '',
  `gd_admin` varchar(250) NOT NULL DEFAULT '',
  `gd_friend` varchar(250) NOT NULL DEFAULT '',
  `gd_report` varchar(250) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `gd`
--

INSERT INTO `gd` (`gd_id`, `gd_upload`, `gd_admin`, `gd_friend`, `gd_report`) VALUES
(1, '0', '0', '1', '1');

-- --------------------------------------------------------

--
-- Structure de la table `note`
--

CREATE TABLE `note` (
  `note_id` int NOT NULL,
  `note_value` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `note`
--

INSERT INTO `note` (`note_id`, `note_value`) VALUES
(1, '');

-- --------------------------------------------------------

--
-- Structure de la table `pages`
--

CREATE TABLE `pages` (
  `page_id` int NOT NULL,
  `page_rules` text NOT NULL,
  `page_adv` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `pages`
--

INSERT INTO `pages` (`page_id`, `page_rules`, `page_adv`) VALUES
(1, 'ãËÇá ãÍÊæíÇÊ ÇáÕÝÍÇÊ', 'ãËÇá ãÍÊæíÇÊ ÇáÕÝÍÇÊ');

-- --------------------------------------------------------

--
-- Structure de la table `report`
--

CREATE TABLE `report` (
  `report_id` int NOT NULL,
  `report_key` varchar(250) NOT NULL,
  `report_why` text NOT NULL,
  `report_ip` varchar(250) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `setting`
--

CREATE TABLE `setting` (
  `site_id` int NOT NULL,
  `site_name` varchar(250) NOT NULL DEFAULT '',
  `site_meta` text NOT NULL,
  `site_link` varchar(250) NOT NULL DEFAULT '',
  `site_host` varchar(250) NOT NULL DEFAULT '',
  `site_mail` varchar(250) NOT NULL DEFAULT '',
  `site_logo` varchar(250) NOT NULL DEFAULT '',
  `site_second` varchar(250) NOT NULL DEFAULT '',
  `img_high` int NOT NULL DEFAULT '200',
  `img_width` int NOT NULL DEFAULT '200',
  `site_inactive` varchar(250) NOT NULL DEFAULT '',
  `site_previous` varchar(250) NOT NULL DEFAULT '',
  `site_delimg` varchar(250) NOT NULL DEFAULT '',
  `site_totalsize` varchar(250) NOT NULL DEFAULT '',
  `site_close` varchar(250) NOT NULL DEFAULT '',
  `site_closemessage` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `setting`
--

INSERT INTO `setting` (`site_id`, `site_name`, `site_meta`, `site_link`, `site_host`, `site_mail`, `site_logo`, `site_second`, `img_high`, `img_width`, `site_inactive`, `site_previous`, `site_delimg`, `site_totalsize`, `site_close`, `site_closemessage`) VALUES
(1, 'ãÑßÒ ÊÍãíá ãßÊÈÉ ÇÈä ÓíäÇ', 'ãÑßÒ ÊÍãíá ãßÊÈÉ ÇÈä ÓíäÇ', 'http://ibn-sinaa.com/upload/', 'http://ibn-sinaa.com/upload/', 'ibnsinaa.com@hotmail.com', '1', '10', 150, 150, '0', 'domain-', '3', '1000', '0', 'äÚÊÐÑ ãäßã Êã ÇÛáÇÞ ÇáãæÞÚ ááÕíÇäÉ');

-- --------------------------------------------------------

--
-- Structure de la table `style`
--

CREATE TABLE `style` (
  `style_id` int NOT NULL,
  `style_style` varchar(250) NOT NULL,
  `style_lang` varchar(250) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `style`
--

INSERT INTO `style` (`style_id`, `style_style`, `style_lang`) VALUES
(1, 'tr-v2', 'arabic');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_password`),
  ADD UNIQUE KEY `admin_password` (`admin_password`),
  ADD UNIQUE KEY `admin_id` (`admin_id`);

--
-- Index pour la table `banned`
--
ALTER TABLE `banned`
  ADD PRIMARY KEY (`banned_id`),
  ADD UNIQUE KEY `banned_ip` (`banned_ip`);

--
-- Index pour la table `extension`
--
ALTER TABLE `extension`
  ADD PRIMARY KEY (`ex_id`),
  ADD UNIQUE KEY `ex_name` (`ex_name`);

--
-- Index pour la table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`file_id`),
  ADD UNIQUE KEY `file_key` (`file_key`),
  ADD KEY `file_id` (`file_id`);

--
-- Index pour la table `gd`
--
ALTER TABLE `gd`
  ADD PRIMARY KEY (`gd_id`);

--
-- Index pour la table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`note_id`);

--
-- Index pour la table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`page_id`);

--
-- Index pour la table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD UNIQUE KEY `report_key` (`report_key`);

--
-- Index pour la table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`site_id`);

--
-- Index pour la table `style`
--
ALTER TABLE `style`
  ADD PRIMARY KEY (`style_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `banned`
--
ALTER TABLE `banned`
  MODIFY `banned_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `extension`
--
ALTER TABLE `extension`
  MODIFY `ex_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `files`
--
ALTER TABLE `files`
  MODIFY `file_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `gd`
--
ALTER TABLE `gd`
  MODIFY `gd_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `note`
--
ALTER TABLE `note`
  MODIFY `note_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `pages`
--
ALTER TABLE `pages`
  MODIFY `page_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `report`
--
ALTER TABLE `report`
  MODIFY `report_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `setting`
--
ALTER TABLE `setting`
  MODIFY `site_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `style`
--
ALTER TABLE `style`
  MODIFY `style_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
