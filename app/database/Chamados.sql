-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.1.21-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win32
-- HeidiSQL Versão:              9.2.0.4947
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Copiando estrutura do banco de dados para chamado
DROP DATABASE IF EXISTS `chamado`;
CREATE DATABASE IF NOT EXISTS `chamado` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `chamado`;


-- Copiando estrutura para tabela chamado.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.category: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `description`) VALUES
	(1, 'Bug'),
	(2, 'New feature'),
	(3, 'Improvement'),
	(4, 'Task'),
	(5, 'Support');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.centro_custo
DROP TABLE IF EXISTS `centro_custo`;
CREATE TABLE IF NOT EXISTS `centro_custo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.centro_custo: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `centro_custo` DISABLE KEYS */;
INSERT INTO `centro_custo` (`id`, `description`) VALUES
	(1, 'CONTABILIDADE'),
	(2, 'FINANCEIRO');
/*!40000 ALTER TABLE `centro_custo` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.departamento
DROP TABLE IF EXISTS `departamento`;
CREATE TABLE IF NOT EXISTS `departamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filial_id` int(11) NOT NULL,
  `description` varchar(200) NOT NULL,
  `centro_custo_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_departamento_filial_id` (`filial_id`),
  KEY `fk_departamento_centro_custo_id` (`centro_custo_id`),
  KEY `fk_departamento_empresa_id` (`empresa_id`),
  CONSTRAINT `fk_departamento_centro_custo_id` FOREIGN KEY (`centro_custo_id`) REFERENCES `centro_custo` (`id`),
  CONSTRAINT `fk_departamento_empresa_id` FOREIGN KEY (`empresa_id`) REFERENCES `empresa` (`id`),
  CONSTRAINT `fk_departamento_filial_id` FOREIGN KEY (`filial_id`) REFERENCES `filial` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.departamento: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.empresa
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE IF NOT EXISTS `empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `fantasia` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.empresa: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` (`id`, `nome`, `fantasia`) VALUES
	(1, 'CBD S/A', 'GRUPO PAO DE AÇUCAR'),
	(2, 'MICRO EMPRESA ME', 'DISTRIBUIÇÃO DE SOFTWARE SISLOG');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.filial
DROP TABLE IF EXISTS `filial`;
CREATE TABLE IF NOT EXISTS `filial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `cnpj` varchar(14) NOT NULL,
  `ie` varchar(14) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `fantasia` varchar(200) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `logradouro` varchar(200) NOT NULL,
  `complemento` varchar(50) DEFAULT NULL,
  `numero` varchar(50) DEFAULT NULL,
  `bairro` varchar(100) NOT NULL,
  `localidade` varchar(100) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `unidade` varchar(50) DEFAULT NULL,
  `ibge` varchar(30) NOT NULL,
  `gia` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_filial_cnpj` (`cnpj`),
  KEY `fk_filial_empresa_id` (`empresa_id`),
  CONSTRAINT `fk_filial_empresa_id` FOREIGN KEY (`empresa_id`) REFERENCES `empresa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.filial: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `filial` DISABLE KEYS */;
INSERT INTO `filial` (`id`, `empresa_id`, `cnpj`, `ie`, `nome`, `fantasia`, `cep`, `logradouro`, `complemento`, `numero`, `bairro`, `localidade`, `uf`, `unidade`, `ibge`, `gia`) VALUES
	(1, 2, '9846465465465', 'ISENTO', 'J.A. EQUIPAMENTO ERP', 'LOJA DO SOFTWARE HORTOLANDIA', '13188050', 'Rua Aloísio de Azevedo', NULL, '500', 'Jardim Amanda I', 'Hortolândia', 'SP', NULL, '3519071', '7481'),
	(2, 1, '6546546546546', '468446595', 'CBD FILIAL 100', 'SUPERMERCADO PÃO DE AÇUCAR', '13188051', 'Rua Estácio de sá', NULL, '300', 'Jardim Amanda I', 'Hortolândia', 'SP', NULL, '3519071', '7481'),
	(3, 1, '6546546516516', '65165165165', 'CBP FILIAL 101', 'SUPERMERCADO PÃO DE AÇUCAR', '13188045', 'Rua Olavo Bilac', NULL, '6596', 'Jardim Amanda I', 'Hortolândia', 'SP', NULL, '3519071', '7481');
/*!40000 ALTER TABLE `filial` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.issue
DROP TABLE IF EXISTS `issue`;
CREATE TABLE IF NOT EXISTS `issue` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_project` int(11) NOT NULL,
  `id_priority` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `id_member` int(11) DEFAULT NULL,
  `register_date` date NOT NULL,
  `close_date` date DEFAULT NULL,
  `issue_time` char(5) DEFAULT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `solution` text,
  `file` text,
  `close_time` char(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_category` (`id_category`),
  KEY `id_priority` (`id_priority`),
  KEY `id_project` (`id_project`),
  KEY `id_status` (`id_status`),
  CONSTRAINT `issue_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`),
  CONSTRAINT `issue_ibfk_2` FOREIGN KEY (`id_priority`) REFERENCES `priority` (`id`),
  CONSTRAINT `issue_ibfk_3` FOREIGN KEY (`id_project`) REFERENCES `project` (`id`),
  CONSTRAINT `issue_ibfk_4` FOREIGN KEY (`id_status`) REFERENCES `status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.issue: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `issue` DISABLE KEYS */;
INSERT INTO `issue` (`id`, `id_user`, `id_status`, `id_project`, `id_priority`, `id_category`, `id_member`, `register_date`, `close_date`, `issue_time`, `title`, `description`, `solution`, `file`, `close_time`) VALUES
	(1, 1, 1, 1, 3, 3, NULL, '2019-01-01', NULL, '15:20', 'Teste', '<p>teste Chamado</p>', NULL, NULL, NULL),
	(2, 1, 1, 1, 3, 3, NULL, '2019-01-01', NULL, '15:20', 'Teste', '<p>teste Chamado</p>', NULL, NULL, NULL),
	(3, 1, 1, 1, 3, 3, NULL, '2019-01-01', NULL, '15:20', 'Teste', '<p>teste Chamado AASSSA</p>', NULL, NULL, NULL);
/*!40000 ALTER TABLE `issue` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.note
DROP TABLE IF EXISTS `note`;
CREATE TABLE IF NOT EXISTS `note` (
  `id` int(11) NOT NULL,
  `id_issue` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `note` text,
  `register_date` date DEFAULT NULL,
  `register_time` text,
  PRIMARY KEY (`id`),
  KEY `id_issue` (`id_issue`),
  CONSTRAINT `note_ibfk_1` FOREIGN KEY (`id_issue`) REFERENCES `issue` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.note: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.priority
DROP TABLE IF EXISTS `priority`;
CREATE TABLE IF NOT EXISTS `priority` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.priority: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `priority` DISABLE KEYS */;
INSERT INTO `priority` (`id`, `description`) VALUES
	(1, 'Low'),
	(2, 'Normal'),
	(3, 'High'),
	(4, 'Urgent');
/*!40000 ALTER TABLE `priority` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.project
DROP TABLE IF EXISTS `project`;
CREATE TABLE IF NOT EXISTS `project` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.project: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` (`id`, `description`) VALUES
	(1, 'Project A'),
	(2, 'Project B');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.project_member
DROP TABLE IF EXISTS `project_member`;
CREATE TABLE IF NOT EXISTS `project_member` (
  `id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_member_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.project_member: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `project_member` DISABLE KEYS */;
INSERT INTO `project_member` (`id`, `project_id`, `member_id`) VALUES
	(5, 1, 1),
	(6, 1, 2),
	(7, 1, 4),
	(8, 2, 1),
	(9, 2, 3);
/*!40000 ALTER TABLE `project_member` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.status
DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  `final_state` char(1) DEFAULT NULL,
  `color` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.status: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` (`id`, `description`, `final_state`, `color`) VALUES
	(1, 'New', 'N', '#4d993a'),
	(2, 'In progress', 'N', NULL),
	(3, 'Waiting feedback', 'N', '#ff8514'),
	(4, 'Resolved', 'N', NULL),
	(5, 'Testing', 'N', NULL),
	(6, 'Deploy', 'N', NULL),
	(7, 'Closed', 'Y', '#5761ba'),
	(8, 'Rejected', 'Y', '#ff1414');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_access_log
DROP TABLE IF EXISTS `system_access_log`;
CREATE TABLE IF NOT EXISTS `system_access_log` (
  `id` int(11) NOT NULL,
  `sessionid` text,
  `login` text,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `logout_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_access_log: ~28 rows (aproximadamente)
/*!40000 ALTER TABLE `system_access_log` DISABLE KEYS */;
INSERT INTO `system_access_log` (`id`, `sessionid`, `login`, `login_time`, `logout_time`) VALUES
	(1, 'nu4tr4ppqh72h1etlfgn4bck0t', 'admin', '2018-12-29 16:20:24', '2018-12-29 16:22:43'),
	(2, 'sicae75i63uvr1oo5us41lsn4h', 'admin', '2018-12-29 16:50:30', '2018-12-29 16:52:56'),
	(3, 'ng2qnfocucvk4qcdn8nucqvv1e', 'admin', '2018-12-29 17:01:42', '2018-12-29 17:05:40'),
	(4, 'g654jhe0a59poqh1arjd6gso17', 'admin', '2018-12-29 17:05:56', '2018-12-29 17:14:57'),
	(5, 'qectm8qtisro0dh88j00lcip0g', 'admin', '2018-12-29 17:15:09', '2018-12-29 18:24:18'),
	(6, 'e467gnjocrfo83oq12ema2f41o', 'admin', '2018-12-29 18:24:35', '2018-12-29 18:31:59'),
	(7, 'u4uns8m1re0drnc9u90boo7b4e', 'admin', '2018-12-29 18:32:12', '2018-12-29 18:36:51'),
	(8, 'uf5bcqk605mq0lle1kiffkub85', 'admin', '2018-12-29 18:37:02', '2018-12-29 18:40:47'),
	(9, 'sshpnl99dk30cfu16hbtgouuf5', 'admin', '2018-12-29 18:40:59', '2018-12-29 18:42:27'),
	(10, 'gk131illjfgkhbap3d4n000145', 'admin', '2018-12-29 18:42:46', '2018-12-29 19:47:53'),
	(11, 'emo5sl7oohbbtj5qo7todiprll', 'admin', '2018-12-29 19:50:03', '0000-00-00 00:00:00'),
	(12, 'o4m7h4adf6odcrar2hulca4bm1', 'admin', '2018-12-30 14:04:13', '0000-00-00 00:00:00'),
	(13, 'prmq2ev8klao43s1it57c9dnn0', 'admin', '2018-12-30 15:00:42', '2018-12-30 16:55:20'),
	(14, 'gs2icmadlt1ah0ft84b7374ss4', 'admin', '2018-12-30 16:55:48', '2018-12-30 16:59:56'),
	(15, 'du7cd2or2t3nrquuseqoqq33hi', 'admin', '2018-12-30 17:00:25', '2018-12-30 17:04:54'),
	(16, 'b046pgarm8dbui84fj7g7c9c56', 'admin', '2018-12-30 17:14:27', '2018-12-30 17:16:25'),
	(17, '6tn3bl7uv4s6paso5ro23j2duo', 'admin', '2018-12-30 17:16:41', '2018-12-30 23:21:14'),
	(18, 'rhgnehb8j16pvm3613ktlgtvei', 'admin', '2018-12-30 23:21:47', '0000-00-00 00:00:00'),
	(19, 'rj4694n6usg5p9bas619dg17d3', 'admin', '2018-12-31 18:06:03', '2018-12-31 18:45:28'),
	(20, 'se1u3rcbhq6qoeqebujvl7ps20', 'admin', '2018-12-31 18:47:56', '0000-00-00 00:00:00'),
	(21, 'a78ubentorc64t73gos5ugacmf', 'admin', '2018-12-31 20:54:28', '2018-12-31 23:04:16'),
	(22, 'v9sr19liccgrqkkt3fn8oek2on', 'admin', '2018-12-31 23:43:39', '0000-00-00 00:00:00'),
	(23, '3mncdjar7l44l4dh1nsr45pboc', 'admin', '2019-01-01 10:43:34', '2019-01-01 13:29:13'),
	(24, '6gv481o8auhjg42dmieg5o47nk', 'admin', '2019-01-01 13:29:25', '2019-01-01 15:31:12'),
	(25, 'osiqkspoglpe8vo9lg6lgf0v42', 'admin', '2019-01-01 13:36:35', '0000-00-00 00:00:00'),
	(26, '6291lpa452r7o33ejacjgoq77d', 'admin', '2019-01-01 14:21:41', '0000-00-00 00:00:00'),
	(27, 'nsvf3ir1hmojs2m2i183d0mhal', 'admin', '2019-01-01 15:31:27', '2019-01-01 15:33:25'),
	(28, 's0c2riat50h5gr46937vtth92o', 'admin', '2019-01-01 15:33:43', '0000-00-00 00:00:00');
/*!40000 ALTER TABLE `system_access_log` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_change_log
DROP TABLE IF EXISTS `system_change_log`;
CREATE TABLE IF NOT EXISTS `system_change_log` (
  `id` int(11) NOT NULL,
  `logdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `login` text,
  `tablename` text,
  `primarykey` text,
  `pkvalue` text,
  `operation` text,
  `columnname` text,
  `oldvalue` text,
  `newvalue` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_change_log: ~30 rows (aproximadamente)
/*!40000 ALTER TABLE `system_change_log` DISABLE KEYS */;
INSERT INTO `system_change_log` (`id`, `logdate`, `login`, `tablename`, `primarykey`, `pkvalue`, `operation`, `columnname`, `oldvalue`, `newvalue`) VALUES
	(1, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'id', NULL, '1'),
	(2, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'title', NULL, 'Teste'),
	(3, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'id_project', NULL, '1'),
	(4, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'register_date', NULL, '2019-01-01'),
	(5, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'issue_time', NULL, '15:20'),
	(6, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'id_priority', NULL, '3'),
	(7, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'id_category', NULL, '3'),
	(8, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'description', NULL, '<p>teste Chamado</p>'),
	(9, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'id_user', NULL, '1'),
	(10, '2019-01-01 15:23:14', 'admin', 'issue', 'id', '1', 'created', 'id_status', NULL, '1'),
	(11, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'id', NULL, '2'),
	(12, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'title', NULL, 'Teste'),
	(13, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'id_project', NULL, '1'),
	(14, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'register_date', NULL, '2019-01-01'),
	(15, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'issue_time', NULL, '15:20'),
	(16, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'id_priority', NULL, '3'),
	(17, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'id_category', NULL, '3'),
	(18, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'description', NULL, '<p>teste Chamado</p>'),
	(19, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'id_user', NULL, '1'),
	(20, '2019-01-01 15:23:42', 'admin', 'issue', 'id', '2', 'created', 'id_status', NULL, '1'),
	(21, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'id', NULL, '3'),
	(22, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'title', NULL, 'Teste'),
	(23, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'id_project', NULL, '1'),
	(24, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'register_date', NULL, '2019-01-01'),
	(25, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'issue_time', NULL, '15:20'),
	(26, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'id_priority', NULL, '3'),
	(27, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'id_category', NULL, '3'),
	(28, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'description', NULL, '<p>teste Chamado AASSSA</p>'),
	(29, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'id_user', NULL, '1'),
	(30, '2019-01-01 15:24:48', 'admin', 'issue', 'id', '3', 'created', 'id_status', NULL, '1'),
	(31, '2019-01-01 15:25:58', 'admin', 'issue', 'id', '2', 'deleted', 'file', NULL, NULL);
/*!40000 ALTER TABLE `system_change_log` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_document
DROP TABLE IF EXISTS `system_document`;
CREATE TABLE IF NOT EXISTS `system_document` (
  `id` int(11) NOT NULL,
  `system_user_id` int(11) DEFAULT NULL,
  `title` text,
  `description` text,
  `category_id` int(11) DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `archive_date` date DEFAULT NULL,
  `filename` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_document: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_document` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_document_category
DROP TABLE IF EXISTS `system_document_category`;
CREATE TABLE IF NOT EXISTS `system_document_category` (
  `id` int(11) NOT NULL,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_document_category: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_document_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_document_category` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_document_group
DROP TABLE IF EXISTS `system_document_group`;
CREATE TABLE IF NOT EXISTS `system_document_group` (
  `id` int(11) NOT NULL,
  `document_id` int(11) DEFAULT NULL,
  `system_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_document_group: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_document_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_document_group` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_document_user
DROP TABLE IF EXISTS `system_document_user`;
CREATE TABLE IF NOT EXISTS `system_document_user` (
  `id` int(11) NOT NULL,
  `document_id` int(11) DEFAULT NULL,
  `system_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_document_user: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_document_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_document_user` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_group
DROP TABLE IF EXISTS `system_group`;
CREATE TABLE IF NOT EXISTS `system_group` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_group: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `system_group` DISABLE KEYS */;
INSERT INTO `system_group` (`id`, `name`) VALUES
	(1, 'Admin'),
	(2, 'Standard'),
	(3, 'Manager'),
	(4, 'Team member'),
	(5, 'Customer');
/*!40000 ALTER TABLE `system_group` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_group_program
DROP TABLE IF EXISTS `system_group_program`;
CREATE TABLE IF NOT EXISTS `system_group_program` (
  `id` int(11) NOT NULL,
  `system_group_id` int(11) DEFAULT NULL,
  `system_program_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_group_program_program_idx` (`system_program_id`),
  KEY `system_group_program_group_idx` (`system_group_id`),
  CONSTRAINT `system_group_program_ibfk_1` FOREIGN KEY (`system_group_id`) REFERENCES `system_group` (`id`),
  CONSTRAINT `system_group_program_ibfk_2` FOREIGN KEY (`system_program_id`) REFERENCES `system_program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_group_program: ~69 rows (aproximadamente)
/*!40000 ALTER TABLE `system_group_program` DISABLE KEYS */;
INSERT INTO `system_group_program` (`id`, `system_group_id`, `system_program_id`) VALUES
	(323, 4, 36),
	(324, 4, 37),
	(325, 4, 38),
	(326, 4, 39),
	(327, 4, 40),
	(328, 1, 1),
	(329, 1, 2),
	(330, 1, 3),
	(331, 1, 4),
	(332, 1, 5),
	(333, 1, 6),
	(334, 1, 8),
	(335, 1, 9),
	(336, 1, 11),
	(337, 1, 14),
	(338, 1, 15),
	(339, 1, 21),
	(340, 1, 26),
	(341, 1, 27),
	(342, 1, 28),
	(343, 1, 29),
	(344, 2, 10),
	(345, 2, 12),
	(346, 2, 13),
	(347, 2, 16),
	(348, 2, 17),
	(349, 2, 18),
	(350, 2, 19),
	(351, 2, 20),
	(352, 2, 22),
	(353, 2, 23),
	(354, 2, 24),
	(355, 2, 25),
	(356, 2, 30),
	(357, 5, 36),
	(358, 5, 37),
	(359, 5, 39),
	(360, 5, 40),
	(365, 3, 35),
	(366, 3, 36),
	(367, 3, 37),
	(368, 3, 38),
	(369, 3, 39),
	(370, 3, 40),
	(371, 1, 41),
	(372, 1, 42),
	(373, 1, 43),
	(374, 1, 44),
	(375, 1, 31),
	(376, 3, 31),
	(377, 1, 45),
	(378, 2, 45),
	(379, 3, 45),
	(380, 4, 45),
	(381, 5, 45),
	(382, 1, 7),
	(383, 1, 32),
	(384, 3, 32),
	(385, 1, 33),
	(386, 3, 33),
	(387, 1, 34),
	(388, 3, 34),
	(389, 1, 35),
	(390, 3, 35),
	(391, 1, 36),
	(392, 3, 36),
	(393, 1, 37),
	(394, 3, 37),
	(395, 1, 38),
	(396, 3, 38),
	(397, 1, 39),
	(398, 3, 39),
	(399, 1, 40),
	(400, 3, 40),
	(401, 1, 46),
	(402, 3, 46),
	(403, 1, 47),
	(404, 3, 47),
	(405, 1, 48),
	(406, 3, 48),
	(407, 1, 49),
	(408, 3, 49),
	(409, 1, 50),
	(410, 3, 50);
/*!40000 ALTER TABLE `system_group_program` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_message
DROP TABLE IF EXISTS `system_message`;
CREATE TABLE IF NOT EXISTS `system_message` (
  `id` int(11) NOT NULL,
  `system_user_id` int(11) DEFAULT NULL,
  `system_user_to_id` int(11) DEFAULT NULL,
  `subject` text,
  `message` text,
  `dt_message` text,
  `checked` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_message: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_message` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_notification
DROP TABLE IF EXISTS `system_notification`;
CREATE TABLE IF NOT EXISTS `system_notification` (
  `id` int(11) NOT NULL,
  `system_user_id` int(11) DEFAULT NULL,
  `system_user_to_id` int(11) DEFAULT NULL,
  `subject` text,
  `message` text,
  `dt_message` text,
  `action_url` text,
  `action_label` text,
  `icon` text,
  `checked` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_notification: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_notification` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_preference
DROP TABLE IF EXISTS `system_preference`;
CREATE TABLE IF NOT EXISTS `system_preference` (
  `id` text,
  `value` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_preference: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `system_preference` DISABLE KEYS */;
INSERT INTO `system_preference` (`id`, `value`) VALUES
	('mail_from', 'email@domain.com.br'),
	('smtp_auth', '0'),
	('smtp_host', 'smtp.gmail.com'),
	('smtp_port', '465'),
	('smtp_user', 'email@domain.com.br'),
	('smtp_pass', 'password'),
	('mail_support', 'another@domain.com.br');
/*!40000 ALTER TABLE `system_preference` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_program
DROP TABLE IF EXISTS `system_program`;
CREATE TABLE IF NOT EXISTS `system_program` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `controller` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_program: ~46 rows (aproximadamente)
/*!40000 ALTER TABLE `system_program` DISABLE KEYS */;
INSERT INTO `system_program` (`id`, `name`, `controller`) VALUES
	(1, 'System Group Form', 'SystemGroupForm'),
	(2, 'System Group List', 'SystemGroupList'),
	(3, 'System Program Form', 'SystemProgramForm'),
	(4, 'System Program List', 'SystemProgramList'),
	(5, 'System User Form', 'SystemUserForm'),
	(6, 'System User List', 'SystemUserList'),
	(7, 'Common Page', 'CommonPage'),
	(8, 'System PHP Info', 'SystemPHPInfoView'),
	(9, 'System ChangeLog View', 'SystemChangeLogView'),
	(10, 'Welcome View', 'WelcomeView'),
	(11, 'System Sql Log', 'SystemSqlLogList'),
	(12, 'System Profile View', 'SystemProfileView'),
	(13, 'System Profile Form', 'SystemProfileForm'),
	(14, 'System SQL Panel', 'SystemSQLPanel'),
	(15, 'System Access Log', 'SystemAccessLogList'),
	(16, 'System Message Form', 'SystemMessageForm'),
	(17, 'System Message List', 'SystemMessageList'),
	(18, 'System Message Form View', 'SystemMessageFormView'),
	(19, 'System Notification List', 'SystemNotificationList'),
	(20, 'System Notification Form View', 'SystemNotificationFormView'),
	(21, 'System Document Category List', 'SystemDocumentCategoryFormList'),
	(22, 'System Document Form', 'SystemDocumentForm'),
	(23, 'System Document Upload Form', 'SystemDocumentUploadForm'),
	(24, 'System Document List', 'SystemDocumentList'),
	(25, 'System Shared Document List', 'SystemSharedDocumentList'),
	(26, 'System Unit Form', 'SystemUnitForm'),
	(27, 'System Unit List', 'SystemUnitList'),
	(28, 'System Access stats', 'SystemAccessLogStats'),
	(29, 'System Preference form', 'SystemPreferenceForm'),
	(30, 'System Support form', 'SystemSupportForm'),
	(31, 'Categories', 'CategoryFormList'),
	(32, 'Statuses', 'StatusFormList'),
	(33, 'Priorities', 'PriorityFormList'),
	(34, 'Project List', 'ProjectList'),
	(35, 'Project form', 'ProjectForm'),
	(36, 'New issue form', 'NewIssueForm'),
	(37, 'Issues', 'IssueList'),
	(38, 'Update issue', 'UpdateIssueForm'),
	(39, 'View issue', 'ViewIssueForm'),
	(40, 'Issue notes', 'NoteForm'),
	(41, 'System PHP Error', 'SystemPHPErrorLogView'),
	(42, 'System Database Browser', 'SystemDatabaseExplorer'),
	(43, 'System Table List', 'SystemTableList'),
	(44, 'System Data Browser', 'SystemDataBrowser'),
	(45, 'Form Departamento Lista', 'FormDepartamentoLista'),
	(46, 'Form Centro Custo Lista', 'FormCentroCustoLista'),
	(47, 'Form Empresa Lista', 'FormEmpresaLista'),
	(48, 'Form Filial Lista', 'FormFilialLista'),
	(49, 'Endereco', 'Endereco'),
	(50, 'Form Filial', 'FormFilial');
/*!40000 ALTER TABLE `system_program` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_sql_log
DROP TABLE IF EXISTS `system_sql_log`;
CREATE TABLE IF NOT EXISTS `system_sql_log` (
  `id` int(11) NOT NULL,
  `logdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `login` text,
  `database_name` text,
  `sql_command` text,
  `statement_type` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_sql_log: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_sql_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_sql_log` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_unit
DROP TABLE IF EXISTS `system_unit`;
CREATE TABLE IF NOT EXISTS `system_unit` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_unit: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_unit` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_user
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE IF NOT EXISTS `system_user` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `login` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `frontpage_id` int(11) DEFAULT NULL,
  `system_unit_id` int(11) DEFAULT NULL,
  `active` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_user_program_idx` (`frontpage_id`),
  CONSTRAINT `system_user_ibfk_1` FOREIGN KEY (`frontpage_id`) REFERENCES `system_program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_user: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `system_user` DISABLE KEYS */;
INSERT INTO `system_user` (`id`, `name`, `login`, `password`, `email`, `frontpage_id`, `system_unit_id`, `active`) VALUES
	(1, 'Administrator', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@test.com', 6, NULL, 'Y'),
	(2, 'John Manager', 'john', '098f6bcd4621d373cade4e832627b4f6', 'john@test.com', 37, NULL, 'Y'),
	(3, 'Daniel developer', 'daniel', '098f6bcd4621d373cade4e832627b4f6', 'daniel@test.com', 37, NULL, NULL),
	(4, 'Mary customer', 'mary', '098f6bcd4621d373cade4e832627b4f6', 'mary@test.com', 37, NULL, NULL);
/*!40000 ALTER TABLE `system_user` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_user_group
DROP TABLE IF EXISTS `system_user_group`;
CREATE TABLE IF NOT EXISTS `system_user_group` (
  `id` int(11) NOT NULL,
  `system_user_id` int(11) DEFAULT NULL,
  `system_group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_user_group_group_idx` (`system_group_id`),
  KEY `system_user_group_user_idx` (`system_user_id`),
  CONSTRAINT `system_user_group_ibfk_1` FOREIGN KEY (`system_user_id`) REFERENCES `system_user` (`id`),
  CONSTRAINT `system_user_group_ibfk_2` FOREIGN KEY (`system_group_id`) REFERENCES `system_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_user_group: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `system_user_group` DISABLE KEYS */;
INSERT INTO `system_user_group` (`id`, `system_user_id`, `system_group_id`) VALUES
	(14, 1, 1),
	(15, 2, 2),
	(16, 2, 3),
	(17, 3, 2),
	(18, 3, 4),
	(19, 4, 2),
	(20, 4, 5),
	(21, 1, 2);
/*!40000 ALTER TABLE `system_user_group` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_user_program
DROP TABLE IF EXISTS `system_user_program`;
CREATE TABLE IF NOT EXISTS `system_user_program` (
  `id` int(11) NOT NULL,
  `system_user_id` int(11) DEFAULT NULL,
  `system_program_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_user_program_program_idx` (`system_program_id`),
  KEY `system_user_program_user_idx` (`system_user_id`),
  CONSTRAINT `system_user_program_ibfk_1` FOREIGN KEY (`system_user_id`) REFERENCES `system_user` (`id`),
  CONSTRAINT `system_user_program_ibfk_2` FOREIGN KEY (`system_program_id`) REFERENCES `system_program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_user_program: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_user_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_user_program` ENABLE KEYS */;


-- Copiando estrutura para tabela chamado.system_user_unit
DROP TABLE IF EXISTS `system_user_unit`;
CREATE TABLE IF NOT EXISTS `system_user_unit` (
  `id` int(11) NOT NULL,
  `system_user_id` int(11) DEFAULT NULL,
  `system_unit_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_user_id` (`system_user_id`),
  KEY `system_unit_id` (`system_unit_id`),
  CONSTRAINT `system_user_unit_ibfk_1` FOREIGN KEY (`system_user_id`) REFERENCES `system_user` (`id`),
  CONSTRAINT `system_user_unit_ibfk_2` FOREIGN KEY (`system_unit_id`) REFERENCES `system_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela chamado.system_user_unit: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `system_user_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_user_unit` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
