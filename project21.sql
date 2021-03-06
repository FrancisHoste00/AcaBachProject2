-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Machine: 127.0.0.1
-- Gegenereerd op: 22 apr 2015 om 17:58
-- Serverversie: 5.6.21
-- PHP-versie: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databank: `project2`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `exam`
--

CREATE TABLE IF NOT EXISTS `exam` (
`idExam` bigint(20) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `examinees`
--

CREATE TABLE IF NOT EXISTS `examinees` (
`idExaminees` bigint(20) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `dateExam` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UserGroup_idUserGroup` bigint(20) NOT NULL DEFAULT '3'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `examinees`
--

INSERT INTO `examinees` (`idExaminees`, `firstName`, `lastName`, `email`, `dateExam`, `UserGroup_idUserGroup`) VALUES
(1, 'Francis', 'Hoste', 'hallo@kroket.be', '2015-04-01 17:48:39', 3),
(3, 'Jopie', 'VandeGraskant', 'hallo@kroket.be', '2015-04-01 17:53:57', 3);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `imagelink`
--

CREATE TABLE IF NOT EXISTS `imagelink` (
`idImageLink` bigint(20) NOT NULL,
  `Original` varchar(45) NOT NULL,
  `highRes` varchar(45) NOT NULL,
  `lowRes` varchar(45) NOT NULL,
  `Questions_idQuestions` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
`idQuestions` bigint(20) NOT NULL,
  `questionSet` tinyint(4) NOT NULL,
  `question` varchar(45) NOT NULL,
  `correctAnswer` varchar(45) NOT NULL,
  `alternativeAnswer1` varchar(45) NOT NULL,
  `alternativeAnswer2` varchar(45) NOT NULL,
  `Exam_idExam` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `results`
--

CREATE TABLE IF NOT EXISTS `results` (
`idResults` int(11) NOT NULL,
  `correct` tinyint(1) NOT NULL,
  `Exam_idExam` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `role`
--

CREATE TABLE IF NOT EXISTS `role` (
`role_id` bigint(20) NOT NULL,
  `Group` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `score`
--

CREATE TABLE IF NOT EXISTS `score` (
  `score` int(11) DEFAULT NULL,
  `Exam_idExam` bigint(20) NOT NULL,
  `Examinees_idExaminees` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `usergroup`
--

CREATE TABLE IF NOT EXISTS `usergroup` (
`idUserGroup` bigint(20) NOT NULL,
  `Group` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `usergroup`
--

INSERT INTO `usergroup` (`idUserGroup`, `Group`) VALUES
(1, 'Admin'),
(2, 'Examinator'),
(3, 'User');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`usr_id` bigint(20) NOT NULL,
  `usr_name` varchar(45) NOT NULL,
  `usr_password` varchar(45) NOT NULL,
  `usrl_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `exam`
--
ALTER TABLE `exam`
 ADD PRIMARY KEY (`idExam`), ADD UNIQUE KEY `idExam_UNIQUE` (`idExam`);

--
-- Indexen voor tabel `examinees`
--
ALTER TABLE `examinees`
 ADD PRIMARY KEY (`idExaminees`,`UserGroup_idUserGroup`), ADD UNIQUE KEY `idExaminees_UNIQUE` (`idExaminees`), ADD KEY `fk_Examinees_UserGroup1_idx` (`UserGroup_idUserGroup`);

--
-- Indexen voor tabel `imagelink`
--
ALTER TABLE `imagelink`
 ADD PRIMARY KEY (`idImageLink`,`Questions_idQuestions`), ADD UNIQUE KEY `idImageLink_UNIQUE` (`idImageLink`), ADD UNIQUE KEY `Questions_idQuestions_UNIQUE` (`Questions_idQuestions`), ADD UNIQUE KEY `Original_UNIQUE` (`Original`), ADD UNIQUE KEY `highRes_UNIQUE` (`highRes`), ADD UNIQUE KEY `lowRes_UNIQUE` (`lowRes`), ADD KEY `fk_ImageLink_Questions1_idx` (`Questions_idQuestions`);

--
-- Indexen voor tabel `questions`
--
ALTER TABLE `questions`
 ADD PRIMARY KEY (`idQuestions`,`Exam_idExam`), ADD UNIQUE KEY `idQuestionSet_UNIQUE` (`idQuestions`), ADD KEY `fk_Questions_Exam1_idx` (`Exam_idExam`);

--
-- Indexen voor tabel `results`
--
ALTER TABLE `results`
 ADD PRIMARY KEY (`idResults`,`Exam_idExam`), ADD KEY `fk_Results_Exam1_idx` (`Exam_idExam`);

--
-- Indexen voor tabel `role`
--
ALTER TABLE `role`
 ADD PRIMARY KEY (`role_id`), ADD UNIQUE KEY `idUserGroup_UNIQUE` (`role_id`);

--
-- Indexen voor tabel `score`
--
ALTER TABLE `score`
 ADD PRIMARY KEY (`Examinees_idExaminees`,`Exam_idExam`), ADD UNIQUE KEY `Exam_idExam_UNIQUE` (`Exam_idExam`), ADD UNIQUE KEY `Examinees_idExaminees_UNIQUE` (`Examinees_idExaminees`), ADD KEY `fk_Score_Examinees1_idx` (`Examinees_idExaminees`);

--
-- Indexen voor tabel `usergroup`
--
ALTER TABLE `usergroup`
 ADD PRIMARY KEY (`idUserGroup`), ADD UNIQUE KEY `idUserGroup_UNIQUE` (`idUserGroup`);

--
-- Indexen voor tabel `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`usr_id`,`usrl_id`), ADD UNIQUE KEY `idUsers_UNIQUE` (`usr_id`), ADD KEY `fk_Users_UserGroup_idx` (`usrl_id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `exam`
--
ALTER TABLE `exam`
MODIFY `idExam` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `examinees`
--
ALTER TABLE `examinees`
MODIFY `idExaminees` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT voor een tabel `imagelink`
--
ALTER TABLE `imagelink`
MODIFY `idImageLink` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `questions`
--
ALTER TABLE `questions`
MODIFY `idQuestions` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `results`
--
ALTER TABLE `results`
MODIFY `idResults` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `role`
--
ALTER TABLE `role`
MODIFY `role_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `usergroup`
--
ALTER TABLE `usergroup`
MODIFY `idUserGroup` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT voor een tabel `users`
--
ALTER TABLE `users`
MODIFY `usr_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `imagelink`
--
ALTER TABLE `imagelink`
ADD CONSTRAINT `fk_ImageLink_Questions1` FOREIGN KEY (`Questions_idQuestions`) REFERENCES `questions` (`idQuestions`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `questions`
--
ALTER TABLE `questions`
ADD CONSTRAINT `fk_Questions_Exam1` FOREIGN KEY (`Exam_idExam`) REFERENCES `exam` (`idExam`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `results`
--
ALTER TABLE `results`
ADD CONSTRAINT `fk_Results_Exam1` FOREIGN KEY (`Exam_idExam`) REFERENCES `exam` (`idExam`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Beperkingen voor tabel `score`
--
ALTER TABLE `score`
ADD CONSTRAINT `fk_Score_Exam1` FOREIGN KEY (`Exam_idExam`) REFERENCES `exam` (`idExam`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Score_Examinees1` FOREIGN KEY (`Examinees_idExaminees`) REFERENCES `examinees` (`idExaminees`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
