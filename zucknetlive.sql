-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 11, 2018 at 01:26 AM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zucknet`
--

-- --------------------------------------------------------

--
-- Table structure for table `zn_comments`
--

CREATE TABLE `zn_comments` (
  `idcomment` int(36) NOT NULL,
  `contents` varchar(160) NOT NULL,
  `post_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_comments`
--

INSERT INTO `zn_comments` (`idcomment`, `contents`, `post_time`) VALUES
(1, 'This is a test comment!', '2018-04-06 18:04:16'),
(9, 'test comment', '2018-04-10 20:12:26'),
(10, 'Test post two.', '2018-04-10 20:22:53'),
(11, 'You can do it old man!', '2018-04-10 20:26:15'),
(12, 'why so jelly bill?', '2018-04-10 20:27:28');

-- --------------------------------------------------------

--
-- Table structure for table `zn_connections`
--

CREATE TABLE `zn_connections` (
  `idconnection` int(36) NOT NULL,
  `sender` int(16) NOT NULL,
  `sendee` int(16) NOT NULL,
  `post_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `trueconn` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_connections`
--

INSERT INTO `zn_connections` (`idconnection`, `sender`, `sendee`, `post_time`, `trueconn`) VALUES
(1, 1, 2, '2018-04-08 16:50:00', 1),
(2, 3, 1, '2018-04-08 16:50:04', 1),
(6, 1, 3, '2018-04-08 17:40:08', 1),
(7, 1, 6, '2018-04-08 17:40:22', 1),
(8, 1, 4, '2018-04-08 17:40:36', 1),
(11, 4, 7, '2018-04-10 22:43:04', 1),
(12, 4, 11, '2018-04-10 22:48:38', 1),
(13, 7, 8, '2018-04-10 22:47:21', 1),
(14, 8, 1, '2018-04-10 22:36:56', 9),
(15, 10, 1, '2018-04-10 22:45:57', 1),
(16, 6, 11, '2018-04-10 22:49:20', 0),
(17, 9, 11, '2018-04-10 22:50:18', 0),
(18, 2, 11, '2018-04-10 23:20:30', 1),
(19, 11, 1, '2018-04-10 23:21:08', 1);

-- --------------------------------------------------------

--
-- Table structure for table `zn_cools`
--

CREATE TABLE `zn_cools` (
  `idcool` int(36) NOT NULL,
  `post_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_cools`
--

INSERT INTO `zn_cools` (`idcool`, `post_time`) VALUES
(2, '2018-04-10 16:57:25'),
(3, '2018-04-10 17:06:14'),
(4, '2018-04-10 17:06:21'),
(5, '2018-04-10 18:54:57'),
(6, '2018-04-10 21:16:32'),
(7, '2018-04-10 21:16:33'),
(8, '2018-04-10 21:16:36'),
(9, '2018-04-10 21:16:37');

-- --------------------------------------------------------

--
-- Table structure for table `zn_lames`
--

CREATE TABLE `zn_lames` (
  `idlame` int(36) NOT NULL,
  `post_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_lames`
--

INSERT INTO `zn_lames` (`idlame`, `post_time`) VALUES
(8, '2018-04-10 17:05:10'),
(9, '2018-04-10 17:07:05'),
(10, '2018-04-10 21:16:32'),
(11, '2018-04-10 21:16:34'),
(12, '2018-04-10 21:16:36'),
(13, '2018-04-10 21:16:38');

-- --------------------------------------------------------

--
-- Table structure for table `zn_posts`
--

CREATE TABLE `zn_posts` (
  `idpost` int(36) NOT NULL,
  `contents` varchar(160) NOT NULL,
  `post_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_posts`
--

INSERT INTO `zn_posts` (`idpost`, `contents`, `post_time`) VALUES
(1, 'testing posts!', '2018-04-07 06:42:39'),
(2, 'thinking about clandestine ways to get your data.', '2018-04-07 06:43:04'),
(3, 'super cool!', '2018-04-07 07:30:30'),
(4, 'suuuuper cooool!!1  BD', '2018-04-07 07:32:04'),
(5, 'so jealous!', '2018-04-07 07:37:57'),
(6, 'wondering how to make this open source.', '2018-04-07 07:39:29'),
(7, 'the best', '2018-04-07 08:14:53'),
(8, 'using bootstrap.', '2018-04-07 16:17:16'),
(9, 'freaking out rn.', '2018-04-07 21:02:37'),
(10, 'hacking a tube.', '2018-04-07 21:59:42'),
(11, 'still the best!!', '2018-04-08 00:04:13'),
(12, 'eating some pie.', '2018-04-08 00:06:52'),
(13, 'eating some pie.', '2018-04-08 00:07:09'),
(14, 'doing social media right.', '2018-04-08 15:33:45'),
(15, 'loving his air pods.', '2018-04-08 15:56:25'),
(16, 'going to slap you upside the head.', '2018-04-08 19:31:54'),
(17, 'showing vagene n bobs', '2018-04-08 19:40:07'),
(18, 'looking to RP', '2018-04-08 19:40:31'),
(19, 'riding the Tidal wave.', '2018-04-08 19:43:50'),
(20, 'making connections!', '2018-04-08 22:34:15'),
(21, 'never free', '2018-04-09 00:21:38'),
(22, 'not eating animals.', '2018-04-09 00:39:44'),
(23, 'throwing red paint on stuff.', '2018-04-09 00:46:21'),
(24, 'being used as a guineau pig', '2018-04-09 00:48:17'),
(25, 'a test monkey.', '2018-04-09 00:51:19'),
(26, 'breaking the cage', '2018-04-09 00:53:19'),
(27, 'MARRR', '2018-04-09 00:53:52'),
(28, 'bored', '2018-04-09 00:56:32'),
(29, 'figuring out what to do next.', '2018-04-09 16:39:39'),
(30, 'forgot to test the enter key on the last post.', '2018-04-09 16:39:53'),
(31, 'thinking about X. iPhone X.', '2018-04-09 21:46:54'),
(32, 'having a party.', '2018-04-09 21:47:18'),
(33, 'having trouble keeping up.', '2018-04-09 21:48:12'),
(34, 'feeling the burn.', '2018-04-10 02:03:19');

-- --------------------------------------------------------

--
-- Table structure for table `zn_usercomments`
--

CREATE TABLE `zn_usercomments` (
  `idusercomment` int(36) NOT NULL,
  `iduser_users` int(16) NOT NULL,
  `idcomment_comments` int(36) NOT NULL,
  `idpost_posts` int(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_usercomments`
--

INSERT INTO `zn_usercomments` (`idusercomment`, `iduser_users`, `idcomment_comments`, `idpost_posts`) VALUES
(1, 2, 1, 1),
(6, 1, 9, 34),
(7, 1, 10, 34),
(8, 1, 11, 33),
(9, 1, 12, 5);

-- --------------------------------------------------------

--
-- Table structure for table `zn_userconnections`
--

CREATE TABLE `zn_userconnections` (
  `iduserconnection` int(36) NOT NULL,
  `idconn_conns` int(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_userconnections`
--

INSERT INTO `zn_userconnections` (`iduserconnection`, `idconn_conns`) VALUES
(1, 1),
(2, 2),
(3, 6),
(4, 7),
(5, 8),
(9, 11),
(12, 12),
(11, 13),
(7, 14),
(10, 15),
(13, 18),
(14, 19);

-- --------------------------------------------------------

--
-- Table structure for table `zn_usercoolposts`
--

CREATE TABLE `zn_usercoolposts` (
  `iduser_users` int(16) NOT NULL,
  `idpost_posts` int(36) NOT NULL,
  `idcool_cools` int(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_usercoolposts`
--

INSERT INTO `zn_usercoolposts` (`iduser_users`, `idpost_posts`, `idcool_cools`) VALUES
(1, 10, 4),
(1, 14, 2),
(1, 32, 3),
(1, 34, 5),
(3, 2, 9),
(3, 9, 8),
(3, 29, 7),
(3, 34, 6);

-- --------------------------------------------------------

--
-- Table structure for table `zn_userlameposts`
--

CREATE TABLE `zn_userlameposts` (
  `iduser_users` int(16) NOT NULL,
  `idpost_posts` int(36) NOT NULL,
  `idlame_lames` int(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_userlameposts`
--

INSERT INTO `zn_userlameposts` (`iduser_users`, `idpost_posts`, `idlame_lames`) VALUES
(1, 30, 9),
(1, 31, 8),
(3, 1, 13),
(3, 8, 12),
(3, 20, 11),
(3, 30, 10);

-- --------------------------------------------------------

--
-- Table structure for table `zn_userposts`
--

CREATE TABLE `zn_userposts` (
  `iduserpost` int(36) NOT NULL,
  `idpost_posts` int(36) NOT NULL,
  `iduser_users` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_userposts`
--

INSERT INTO `zn_userposts` (`iduserpost`, `idpost_posts`, `iduser_users`) VALUES
(1, 1, 1),
(2, 2, 1),
(6, 3, 4),
(7, 4, 4),
(8, 5, 3),
(9, 6, 7),
(10, 7, 11),
(11, 8, 1),
(12, 9, 1),
(13, 10, 6),
(14, 11, 11),
(15, 12, 7),
(16, 13, 7),
(17, 14, 4),
(18, 15, 2),
(19, 16, 5),
(20, 17, 8),
(21, 18, 8),
(22, 19, 9),
(23, 20, 1),
(24, 21, 8),
(25, 22, 10),
(26, 23, 10),
(27, 24, 10),
(29, 25, 10),
(30, 26, 10),
(31, 27, 10),
(32, 28, 10),
(33, 29, 1),
(34, 30, 1),
(35, 31, 2),
(36, 32, 2),
(37, 33, 6),
(38, 34, 1);

-- --------------------------------------------------------

--
-- Table structure for table `zn_users`
--

CREATE TABLE `zn_users` (
  `iduser` int(16) NOT NULL,
  `uspassword` varchar(50) NOT NULL DEFAULT 'password',
  `fname` varchar(27) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `email` varchar(60) NOT NULL,
  `city` varchar(54) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `join_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `photo_path` varchar(150) DEFAULT 'userphotos/defaultimage.jpg',
  `tagline` varchar(160) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zn_users`
--

INSERT INTO `zn_users` (`iduser`, `uspassword`, `fname`, `lname`, `email`, `city`, `last_update`, `join_time`, `photo_path`, `tagline`) VALUES
(1, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Mark', 'Zuckerberg', 'mark@markymark.com', 'Interbutt', '2018-04-08 00:24:52', '2018-04-06 17:36:31', 'userphotos/mark.jpg', 'You never know until you know.'),
(2, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Steve', 'Jobs', 'steve@comp.com', 'The iCloud', '2018-04-08 15:58:20', '2018-04-06 18:00:12', 'userphotos/15232029472Steveznstevej.jpg', 'Looking down on you, always.'),
(3, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Bill', 'Gates', 'bill@ms.com', 'Interbutt', '2018-04-08 15:31:27', '2018-04-06 18:07:07', 'userphotos/15232014873Billznbilly.jpg', 'Paving the digital highway.'),
(4, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Oprah', 'Winfrey', 'opr@h.com', 'Interbutt', '2018-04-08 15:37:04', '2018-04-06 18:11:57', 'userphotos/15232018244Oprahznoprah.jpg', 'Get a car!'),
(5, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Roseanne', 'Barr', 'rosie@barr.com', 'Interbutt', '2018-04-08 19:31:35', '2018-04-06 18:11:57', 'userphotos/defaultimage.jpg', 'Eat it Jimmy Kimmel'),
(6, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Steve', 'Wozniack', 'steve@thewoz.com', 'Interbutt', '2018-04-08 15:47:21', '2018-04-06 18:11:57', 'userphotos/defaultimage.jpg', 'Too cool for school.'),
(7, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Richard', 'Stallman', 'rich@gnu.org', 'Interbutt', '2018-04-08 19:59:14', '2018-04-06 18:11:57', 'userphotos/15232175547RichardznToaster.jpg', 'Open that source.'),
(8, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Pussy', 'Galore', 'pajeet@xxx.com', 'livejasmin.sex', '2018-04-08 19:39:12', '2018-04-06 18:11:57', 'userphotos/15232163208Pussyznpaj.jpg', 'Bing bing bong bong.'),
(9, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Beyonce', 'Knowles', 'yonce@me.be', 'Interbutt', '2018-04-08 19:43:15', '2018-04-06 18:29:18', 'userphotos/15232165959Beyonceznyonce.jpg', 'I depend on me.'),
(10, '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'Pamela', 'Anderson', 'pig@gross.com', 'Interbutt', '2018-04-08 19:48:01', '2018-04-06 18:32:29', 'userphotos/152321688110Pamelaznpam.jpg', 'DAK'),
(11, 'd6769fdc7d35ede61be6e74e9feaf742963dadd1', 'Elon', 'Musk', 'sp@ce.man', 'Olympus Mons', '2018-04-08 19:29:45', '2018-04-07 08:14:31', 'userphotos/152321578511Elonznelon.jpg', 'SpaceX');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `zn_comments`
--
ALTER TABLE `zn_comments`
  ADD PRIMARY KEY (`idcomment`);

--
-- Indexes for table `zn_connections`
--
ALTER TABLE `zn_connections`
  ADD PRIMARY KEY (`idconnection`);

--
-- Indexes for table `zn_cools`
--
ALTER TABLE `zn_cools`
  ADD PRIMARY KEY (`idcool`);

--
-- Indexes for table `zn_lames`
--
ALTER TABLE `zn_lames`
  ADD PRIMARY KEY (`idlame`);

--
-- Indexes for table `zn_posts`
--
ALTER TABLE `zn_posts`
  ADD PRIMARY KEY (`idpost`);

--
-- Indexes for table `zn_usercomments`
--
ALTER TABLE `zn_usercomments`
  ADD PRIMARY KEY (`idusercomment`),
  ADD KEY `iduser_users` (`iduser_users`),
  ADD KEY `idpost_posts` (`idpost_posts`),
  ADD KEY `idcomment_comments` (`idcomment_comments`);

--
-- Indexes for table `zn_userconnections`
--
ALTER TABLE `zn_userconnections`
  ADD PRIMARY KEY (`iduserconnection`),
  ADD KEY `idconn_conns` (`idconn_conns`);

--
-- Indexes for table `zn_usercoolposts`
--
ALTER TABLE `zn_usercoolposts`
  ADD PRIMARY KEY (`iduser_users`,`idpost_posts`,`idcool_cools`),
  ADD KEY `idpost_posts` (`idpost_posts`),
  ADD KEY `idcool_cools` (`idcool_cools`);

--
-- Indexes for table `zn_userlameposts`
--
ALTER TABLE `zn_userlameposts`
  ADD PRIMARY KEY (`iduser_users`,`idpost_posts`,`idlame_lames`),
  ADD KEY `idpost_posts` (`idpost_posts`),
  ADD KEY `idlame_lames` (`idlame_lames`);

--
-- Indexes for table `zn_userposts`
--
ALTER TABLE `zn_userposts`
  ADD PRIMARY KEY (`iduserpost`),
  ADD KEY `idpost_posts` (`idpost_posts`),
  ADD KEY `iduser_users` (`iduser_users`);

--
-- Indexes for table `zn_users`
--
ALTER TABLE `zn_users`
  ADD PRIMARY KEY (`iduser`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `zn_comments`
--
ALTER TABLE `zn_comments`
  MODIFY `idcomment` int(36) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `zn_connections`
--
ALTER TABLE `zn_connections`
  MODIFY `idconnection` int(36) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `zn_cools`
--
ALTER TABLE `zn_cools`
  MODIFY `idcool` int(36) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `zn_lames`
--
ALTER TABLE `zn_lames`
  MODIFY `idlame` int(36) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `zn_posts`
--
ALTER TABLE `zn_posts`
  MODIFY `idpost` int(36) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `zn_usercomments`
--
ALTER TABLE `zn_usercomments`
  MODIFY `idusercomment` int(36) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `zn_userconnections`
--
ALTER TABLE `zn_userconnections`
  MODIFY `iduserconnection` int(36) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `zn_userposts`
--
ALTER TABLE `zn_userposts`
  MODIFY `iduserpost` int(36) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `zn_users`
--
ALTER TABLE `zn_users`
  MODIFY `iduser` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `zn_usercomments`
--
ALTER TABLE `zn_usercomments`
  ADD CONSTRAINT `zn_usercomments_ibfk_1` FOREIGN KEY (`iduser_users`) REFERENCES `zn_users` (`iduser`),
  ADD CONSTRAINT `zn_usercomments_ibfk_2` FOREIGN KEY (`idpost_posts`) REFERENCES `zn_posts` (`idpost`),
  ADD CONSTRAINT `zn_usercomments_ibfk_3` FOREIGN KEY (`idcomment_comments`) REFERENCES `zn_comments` (`idcomment`);

--
-- Constraints for table `zn_userconnections`
--
ALTER TABLE `zn_userconnections`
  ADD CONSTRAINT `zn_userconnections_ibfk_1` FOREIGN KEY (`idconn_conns`) REFERENCES `zn_connections` (`idconnection`);

--
-- Constraints for table `zn_usercoolposts`
--
ALTER TABLE `zn_usercoolposts`
  ADD CONSTRAINT `zn_usercoolposts_ibfk_1` FOREIGN KEY (`iduser_users`) REFERENCES `zn_users` (`iduser`),
  ADD CONSTRAINT `zn_usercoolposts_ibfk_2` FOREIGN KEY (`idpost_posts`) REFERENCES `zn_posts` (`idpost`),
  ADD CONSTRAINT `zn_usercoolposts_ibfk_3` FOREIGN KEY (`idcool_cools`) REFERENCES `zn_cools` (`idcool`);

--
-- Constraints for table `zn_userlameposts`
--
ALTER TABLE `zn_userlameposts`
  ADD CONSTRAINT `zn_userlameposts_ibfk_1` FOREIGN KEY (`iduser_users`) REFERENCES `zn_users` (`iduser`),
  ADD CONSTRAINT `zn_userlameposts_ibfk_2` FOREIGN KEY (`idpost_posts`) REFERENCES `zn_posts` (`idpost`),
  ADD CONSTRAINT `zn_userlameposts_ibfk_3` FOREIGN KEY (`idlame_lames`) REFERENCES `zn_lames` (`idlame`);

--
-- Constraints for table `zn_userposts`
--
ALTER TABLE `zn_userposts`
  ADD CONSTRAINT `zn_userposts_ibfk_1` FOREIGN KEY (`idpost_posts`) REFERENCES `zn_posts` (`idpost`),
  ADD CONSTRAINT `zn_userposts_ibfk_2` FOREIGN KEY (`iduser_users`) REFERENCES `zn_users` (`iduser`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
