SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Databank: `zf2project`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `exam`
--

CREATE TABLE IF NOT EXISTS `exam` (
`idExam` 			int(11) 	NOT NULL,
  `date` 			datetime 	NOT NULL 	DEFAULT CURRENT_TIMESTAMP,
  `idExaminator` 	int(11) 	NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `exam`
--

INSERT INTO `exam` (`idExam`, `date`, `idExaminator`) VALUES
(1, '2015-04-30 21:34:41', 2),
(2, '2015-04-30 21:37:54', 4),
(3, '2015-04-30 21:39:43', 6),
(4, '2015-04-30 21:41:36', 8),
(5, '2015-05-06 13:12:49', 4);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `examinees`
--

CREATE TABLE IF NOT EXISTS `examinees` (
`idExaminees` 				int(11) 	NOT NULL,
  `firstName` 				varchar(45) NOT NULL,
  `lastName` 				varchar(45) NOT NULL,
  `email` 					varchar(45) NOT NULL,
  `dateExam` 				datetime 	NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UserGroup_idUserGroup` 	int(11) 	NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `examinees`
--

INSERT INTO `examinees` (`idExaminees`, `firstName`, `lastName`, `email`, `dateExam`, `UserGroup_idUserGroup`) VALUES
(1, 'Water'		, 'Fles'		, 'WaterFles@khbo.be'		, '2015-04-29 12:07:08'	, 3),
(2, 'John'		, 'Beton'		, 'JohnBeton@khbo.be'		, '2015-05-11 12:00:00'	, 3),
(3, 'Pat'		, 'Patat'		, 'PatPatat@khbo.be'		, '2015-05-11 12:00:00'	, 3),
(4, 'Ziek'		, 'Keramiek'	, 'ZiekKeramiek@khbo.be'	, '2015-05-11 12:00:00'	, 3),
(5, 'Mosterd'	, 'Brood'		, 'MosterdBrood@khbo.be'	, '2015-05-11 12:00:00'	, 3);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `imagelink`
--

CREATE TABLE IF NOT EXISTS `imagelink` (
`idImageLink` 				int(11) 	NOT NULL,
  `Original` 				varchar(45) NOT NULL,
  `highRes` 				varchar(45) NOT NULL,
  `lowRes` 					varchar(45) NOT NULL,
  `Questions_idQuestions` 	int(11) 	NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `interexamquestions`
--

CREATE TABLE IF NOT EXISTS `interexamquestions` (
`idInterExamQuestions` 	int(11) NOT NULL,
  `idExam` 				int(11) NOT NULL,
  `idQuestions` 		int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `interexamquestions`
--

INSERT INTO `interexamquestions` (`idInterExamQuestions`, `idExam`, `idQuestions`) VALUES
(1, 1, 1),	(2, 1, 3), 	(3, 1, 5), 	(4, 2, 2), 	(5, 2, 5), 	(6, 2, 6), 	(7, 3, 3), (8, 3, 5),
(9, 3, 7), 	(10, 4, 4), (11, 4, 6), (12, 4, 8), (13, 5, 5), (14, 5, 7), (15, 5, 9);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
`idQuestions` 			int(11) 	NOT NULL,
  `questionSet` 		tinyint(4) 	NOT NULL,
  `question` 			varchar(45) NOT NULL,
  `correctAnswer` 		varchar(45) NOT NULL,
  `alternativeAnswer1` 	varchar(45) NOT NULL,
  `alternativeAnswer2` 	varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `questions`
--

INSERT INTO `questions` (`idQuestions`, `questionSet`, `question`, `correctAnswer`, `alternativeAnswer1`, `alternativeAnswer2`) VALUES
(1	, 0, 'Vanaf dit bord moet ik...'		, 'mij houden aan maximaal 50 km/h'				, 'minimaal 50 jaar zijn om te mogen passeren'	, '50 cent in de parkeerautomaat steken'		),
(2	, 0, 'Ik moet zorgen dat ik...'			, 'voorzichtig ben, er zijn wegenwerken'		, 'geen zand laat liggen'						, 'de 2 bergjes even hoog zijn'					),
(3	, 0, 'Bij dit bord, moet ik...'			, 'voorrang verlenen'							, 'niets doen. Het bord hangt ondersteboven'	, 'Kijken wat op de grond staat'				),
(4	, 0, 'De betekenis van dit bord:'		, 'Ik moet stoppen bij het bord'				, 'stoppen met roken'							, 'Stop, In the name of love...'				),
(5	, 0, 'Wanneer ik dit bord zie, dan...'	, 'weet ik dat ik op een vorrangsweg ben.'		, 'ben ik in een zone 30'						, 'ik geen gevaarlijke stoffen mag vervoeren'	),
(6	, 0, 'Ter hoogte van dit bord ...'		, 'heb ik voorrang op de tegenligger'			, 'mag ik enkel vooruit rijden'					, 'is het verboden in te halen'					),
(7	, 0, 'Hier moet ik...'					, 'rechtdoor rijden'							, 'goed omhoog kijken'							, 'de koffer openmaken'							),
(8	, 0, 'Pas op voor de...'				, 'verkeersdrempel'								, 'een hobbelige weg'							, 'monokini-strand'								);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `results`
--

CREATE TABLE IF NOT EXISTS `results` (
`idResults` 	int(11) 	NOT NULL,
  `correct` 	tinyint(1) 	NOT NULL,
  `Exam_idExam` int(11) 	NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `role`
--

CREATE TABLE IF NOT EXISTS `role` (
`role_id` int(11) 		NOT NULL,
  `Group` varchar(45) 	NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `score`
--

CREATE TABLE IF NOT EXISTS `score` (
  `score` 					int(11) NOT NULL DEFAULT 0,
  `Exam_idExam` 			int(11) NOT NULL,
  `Examinees_idExaminees` 	int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `score`
--

INSERT INTO `score` (`score`, `Exam_idExam`, `Examinees_idExaminees`) VALUES
(18, 1, 1), (17, 2, 2), (18, 3, 3), (17, 4, 4), (16, 5, 5);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `usergroup`
--

CREATE TABLE IF NOT EXISTS `usergroup` (
`idUserGroup` 	int(11) 	NOT NULL,
  `Group` 		varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
`idUsers` 					int(11) 	NOT NULL,
  `userName` 				varchar(45) NOT NULL,
  `passWord` 				varchar(45) NOT NULL,
  `UserGroup_idUserGroup` 	int(11) 	NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;		

--
-- Gegevens worden geëxporteerd voor tabel `users`
--

INSERT INTO `users` (`idUsers`, `userName`, `passWord`, `UserGroup_idUserGroup`) VALUES
(1, 'FrancisH'	, '202cb962ac59075b964b07152d234b70', 1),
(2, 'FrancisH2'	, '202cb962ac59075b964b07152d234b70', 2),
(3, 'JonasVW'	, '1411a6edc5f0f494118b79ff3fa6e090', 1),
(4, 'JonasVW2'	, '1411a6edc5f0f494118b79ff3fa6e090', 2),
(5, 'GerdVB' 	, '1411a6edc5f0f494118b79ff3fa6e090', 1),
(6, 'GerdVB2'	, '1411a6edc5f0f494118b79ff3fa6e090', 2),
(7, 'KevinVH'	, '1411a6edc5f0f494118b79ff3fa6e090', 1),
(8, 'KevinVH2'	, '1411a6edc5f0f494118b79ff3fa6e090', 2);

--
-- Tabelstructuur voor tabel 'activeexam'
--

CREATE TABLE IF NOT EXISTS `activeexam` (
  `idActiveExam` 	int(11) 	NOT NULL,
  `activeExam` 		int(11) 	NOT NULL,
  `idSender` 		varchar(26) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `users`
--

INSERT INTO `activeexam` (`idActiveExam`,`activeExam`, `idSender`) VALUES
(1,0, '0');

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
-- Indexen voor tabel `interexamquestions`
--
ALTER TABLE `interexamquestions`
 ADD PRIMARY KEY (`idInterExamQuestions`);

--
-- Indexen voor tabel `questions`
--
ALTER TABLE `questions`
 ADD PRIMARY KEY (`idQuestions`);

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
 ADD PRIMARY KEY (`Examinees_idExaminees`,`Exam_idExam`);

--
-- Indexen voor tabel `usergroup`
--
ALTER TABLE `usergroup`
 ADD PRIMARY KEY (`idUserGroup`), ADD UNIQUE KEY `idUserGroup_UNIQUE` (`idUserGroup`);

--
-- Indexen voor tabel `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`idUsers`,`UserGroup_idUserGroup`), ADD UNIQUE KEY `idUsers_UNIQUE` (`idUsers`), ADD KEY `fk_Users_UserGroup_idx` (`UserGroup_idUserGroup`);

--
-- Indexen voor tabel `users`
--
ALTER TABLE `activeexam`
ADD PRIMARY KEY (`idActiveExam`);


--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `exam`
--
ALTER TABLE `exam`
MODIFY `idExam` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `examinees`
--
ALTER TABLE `examinees`
MODIFY `idExaminees` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `imagelink`
--
ALTER TABLE `imagelink`
MODIFY `idImageLink` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `interexamquestions`
--
ALTER TABLE `interexamquestions`
MODIFY `idInterExamQuestions` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `questions`
--
ALTER TABLE `questions`
MODIFY `idQuestions` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `results`
--
ALTER TABLE `results`
MODIFY `idResults` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `role`
--
ALTER TABLE `role`
MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `usergroup`
--
ALTER TABLE `usergroup`
MODIFY `idUserGroup` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `users`
--
ALTER TABLE `users`
MODIFY `idUsers` int(11) NOT NULL AUTO_INCREMENT;
--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `examinees`
--
ALTER TABLE `examinees`
ADD CONSTRAINT `fk_Examinees_UserGroup1` FOREIGN KEY (`UserGroup_idUserGroup`) REFERENCES `usergroup` (`idUserGroup`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `imagelink`
--
ALTER TABLE `imagelink`
ADD CONSTRAINT `fk_ImageLink_Questions1` FOREIGN KEY (`Questions_idQuestions`) REFERENCES `questions` (`idQuestions`) ON DELETE CASCADE ON UPDATE CASCADE;

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

--
-- Beperkingen voor tabel `users`
--
ALTER TABLE `users`
ADD CONSTRAINT `fk_Users_UserGroup` FOREIGN KEY (`UserGroup_idUserGroup`) REFERENCES `usergroup` (`idUserGroup`) ON DELETE CASCADE ON UPDATE CASCADE;
