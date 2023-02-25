-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projeto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projeto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projeto` DEFAULT CHARACTER SET utf8 ;
USE `projeto` ;

-- -----------------------------------------------------
-- Table `projeto`.`Filme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`Filme` (
  `idFilme` INT NOT NULL,
  `duracao` TIME NOT NULL,
  `classificacao` INT(2) NOT NULL,
  `tipo` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFilme`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto`.`Codigo_Postal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`Codigo_Postal` (
  `codigo_Postal` VARCHAR(8) NOT NULL,
  `localidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo_Postal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`Funcionario` (
  `idFuncionario` INT NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  `contato` INT(9) NOT NULL,
  `morada` VARCHAR(45) NOT NULL,
  `cod_postal` VARCHAR(8) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`idFuncionario`),
  INDEX `fk_Funcionario_Codigo_Postal1_idx` (`cod_postal` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Codigo_Postal1`
    FOREIGN KEY (`cod_postal`)
    REFERENCES `projeto`.`Codigo_Postal` (`codigo_Postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nome` VARCHAR(20) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `contato` INT(9) NOT NULL,
  `cod_postal` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Codigo_Postal1_idx` (`cod_postal` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Codigo_Postal1`
    FOREIGN KEY (`cod_postal`)
    REFERENCES `projeto`.`Codigo_Postal` (`codigo_Postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto`.`Sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`Sala` (
  `numero` INT NOT NULL,
  `capacidade` INT(3) NOT NULL,
  PRIMARY KEY (`numero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto`.`Bilhete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`Bilhete` (
  `idFilme` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `data_compra` DATETIME NOT NULL,
  `data_filme` DATETIME NOT NULL,
  `preco` FLOAT NOT NULL,
  `numSala` INT NOT NULL,
  `idFuncionario` INT NOT NULL,
  INDEX `fk_Filme_has_Cliente_Cliente1_idx` (`idCliente` ASC) VISIBLE,
  INDEX `fk_Filme_has_Cliente_Filme1_idx` (`idFilme` ASC) VISIBLE,
  INDEX `fk_Bilhete_Sala1_idx` (`numSala` ASC) VISIBLE,
  INDEX `fk_Bilhete_Funcionario1_idx` (`idFuncionario` ASC) VISIBLE,
  PRIMARY KEY (`idFuncionario`, `idCliente`),
  CONSTRAINT `fk_Filme_has_Cliente_Filme1`
    FOREIGN KEY (`idFilme`)
    REFERENCES `projeto`.`Filme` (`idFilme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Filme_has_Cliente_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `projeto`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilhete_Sala1`
    FOREIGN KEY (`numSala`)
    REFERENCES `projeto`.`Sala` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilhete_Funcionario1`
    FOREIGN KEY (`idFuncionario`)
    REFERENCES `projeto`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*
CREATE TABLE Codigo_Postal (
    Cod_Postal varchar(8) PRIMARY KEY,
    Localidade varchar(45)
);

CREATE TABLE Sala (
    Numero int PRIMARY KEY,
    Capacidade int
);

CREATE TABLE Filme (
    IDFilme int PRIMARY KEY,
    Duracao time,
    Classificacao int,
    Tipo varchar(10),
    Nome varchar(45)	
    );  

CREATE TABLE Cliente (
    IDCliente int PRIMARY KEY,
    Nome varchar(20),
    Data_Nascimento date,
    Contacto int(9),
    Cod_Postal varchar(8)
    );

CREATE TABLE Funcionario (
    IDFuncionario int PRIMARY KEY,
    Nome varchar(20),
    Contacto int(9),
    Morada varchar(45),
    Cod_Postal varchar(8),
    Data_Nascimento date
    );
   
   
    CREATE TABLE Bilhete (
    IDFilme int,
    IDCliente int,
    Data_compra DATETIME,
    Data_filme DATETIME,
    Preco float,
    Num_Sala int,
    IDFuncionario int	
    );
*/

-- Criação da Tabela Codigo_Postal
INSERT INTO `projeto`.`Codigo_Postal` VALUES
('4700-481','Palmeira, Braga'),
('4715-045','São Victor, Braga'),
('4711-909','Maximinos, Braga'),
('4705-474','Esporões, Braga'),
('4715-445','São Pedro(Este), Braga'),
('4700-912','São José de São Lázaro, Braga');

-- Criação da Tabela Filme
INSERT INTO `projeto`.`Filme` VALUES 
(1, '01:28:00' ,'9', 'Animacao','Rei Leão' ),
(2, '01:37:00' ,'7', 'Ação'    ,'Maléfica'),
(3, '01:59:00' ,'8', 'Drama'   ,'1917'),
(4, '01:52:00' ,'6', 'Aventura','Crónicas de Natal: Parte Dois'),
(5, '01:36:00' ,'5', 'Comédia'    ,'A Princesa Volta a Ser Plebeia');


-- Criação da Tabela Funcionario
INSERT INTO `projeto`.`Funcionario` VALUES 
(1,'Ana César',912348944,'Rua dos Quintais 34','4715-045','1999-10-14'),
(2,'Angélica Cunha',914445678,'Rua do Real 163','4705-474','1967-03-02'),
(3,'André Morais',935467556,'Rua dos Duques 80','4705-474','1980-12-20');

-- Criação da Tabela Sala
INSERT INTO `projeto`.`Sala` VALUES
(1, 50),
(2, 30),
(3, 40);
DESC Bilhete;

-- Criação da Tabela Bilhete
-- Filme 1  sala 1
INSERT INTO `projeto`.`Bilhete` VALUES 
(1,1,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 1 ,1 ),
(1,2,'2010-02-01 15:00:00','2010-02-01 22:00:00',5 , 1 ,1 ),
(1,6,'2010-01-28 13:00:00','2010-02-01 22:00:00',5 , 1 ,2 ),
(1,7,'2010-02-01 22:00:00','2010-02-01 22:00:00',5 , 1 ,3 ),
(1,9,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 1 ,1 ),
(1,8,'2010-02-01 22:00:00','2010-02-01 22:00:00',5 , 1 ,2 ),
(1,10,'2010-01-29 09:00:00','2010-02-01 22:00:00',3.95 , 1 ,1 ),
(1,21,'2010-02-01 22:00:00','2010-02-01 22:00:00',5 , 1 ,2 ),
-- Filme 2 sala 2
(2,4,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 2 ,1 ),
(2,6,'2010-02-01 15:00:00','2010-02-01 22:00:00',5, 2 ,1 ),
(2,13,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 2 ,2 ),
(2,14,'2010-01-28 13:00:00','2010-02-01 22:00:00',3.95 , 2 ,2 ),
(2,17,'2010-01-28 13:00:00','2010-02-01 22:00:00',5 , 2 ,2 ),
(2,18,'2010-01-28 13:00:00','2010-02-01 22:00:00',5 , 2 ,3 ),
(2,19,'2010-01-28 13:00:00','2010-02-01 22:00:00',3.95 , 2 ,2 ),
(2,20,'2010-01-29 09:00:00','2010-02-01 22:00:00',5 , 2 ,1 ),
(2,21,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 2 ,1 ),
-- Filme 3 sala 1
(3,10,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 1 ,3 ),
(3,11,'2010-01-28 13:00:00','2010-02-01 22:00:00',5 , 1 ,2 ),
(3,12,'2010-01-28 13:00:00','2010-02-01 22:00:00',5 , 1 ,2 ),
(3,13,'2010-01-28 13:00:00','2010-02-01 22:00:00',5 , 1 ,3 ),
(3,15,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 1 ,3 ),
(3,16,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 1 ,3 ),
(3,17,'2010-02-01 22:00:00','2010-02-01 22:00:00',5 , 1 ,3 ),
-- Filme 4 sala 3
(4,3,'2010-01-28 13:00:00','2010-02-01 22:00:00',5    , 3 ,2 ),
(4,4,'2010-02-01 22:00:00','2010-02-01 22:00:00',5    , 3 ,2 ),
(4,5,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 3 ,1 ),
(4,7,'2010-01-29 09:00:00','2010-02-01 22:00:00',3.95 , 3 ,2 ),
(4,11,'2010-01-29 09:00:00','2010-02-01 22:00:00',3.95 , 3 ,1 ),
(4,19,'2010-01-29 09:00:00','2010-02-01 22:00:00',3.95 , 3 ,1 ),
-- Filme 5 sala 3
(5,18,'2010-02-01 15:00:00','2010-02-01 22:00:00',3.95 , 3 ,2 ),
(5,14,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 3 ,3 ),
(5,10,'2010-01-28 13:00:00','2010-02-01 22:00:00',5 , 3 ,2 ),
(5,8,'2010-01-28 13:00:00','2010-02-01 22:00:00',5 , 3 ,3 ),
(5,4,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 3 ,3 ),
(5,2,'2010-02-01 22:00:00','2010-02-01 22:00:00',3.95 , 3 ,3 ),
(5,1,'2010-02-01 22:00:00','2010-02-01 22:00:00',5 , 3 ,3 );


-- Criação da Tabela Cliente
INSERT INTO `projeto`.`Cliente` VALUES 
(1, 'José Gonçalves','1999-03-17',935441726,'4700-912'),
(2, 'João Carvalho', '2001-11-13' , 919867832 , '4715-045'),
(3, 'Manuel Oliveira', '1998-08-05' , 915690567 , '4715-045'),
(4, 'Manuel Oliveira', '2003-10-14' , 916539201,'4715-045'),
(5, 'Marta Esteves', '1990-02-10' , 937820182,'4700-481'),
(6, 'Carolina Maia', '2000-05-06' , 919028374 ,'4700-481'),
(7, 'Manuel Ferreira', '1995-11-02' , 939026789,'4715-045'),
(8, 'Luís Pereira', '1998-06-04' , 924389001,'4715-045'),
(9, 'Miguel Vieira', '2000-05-02' , 910054882,'4700-481'),
(10, 'Ana Rocha', '1995-06-01' , 928847703,'4715-045'),
(11, 'Manuel Figueiredo', '1999-09-05' , 916684002,'4715-045'),
(12, 'Alexandre Miranda', '1999-12-03' , 936689012, '4711-909'),
(13, 'Bruno Lobo', '1992-03-14' , 911234567,'4711-909'),
(14, 'Mafalda Oliveira', '2001-10-05' , 967745308,'4715-045'),
(15, 'Nuno Ribeiro', '1996-03-07' , 967891234,'4711-909'),
(16, 'João Macedo', '1993-08-05' , 915792730,'4705-474'),
(17, 'Filipe Silva', '2000-05-02' ,914567838,'4715-045'),
(18, 'Otávio Andrade', '1995-06-02' , 930009897,'4705-474'),
(19, 'Tiago Rodrigues', '1998-04-04' , 925577339,'4715-445'),
(20, 'André Vieira', '2000-01-02' , 910054882,'4715-445'),
(21, 'Vítor Abreu', '1995-01-01' , 928847709,'4715-445');




