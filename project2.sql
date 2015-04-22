SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`UserGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`UserGroup` (
  `idUserGroup` BIGINT NOT NULL,
  `Group` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUserGroup`),
  UNIQUE INDEX `idUserGroup_UNIQUE` (`idUserGroup` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `idUsers` BIGINT NOT NULL,
  `userName` VARCHAR(45) NOT NULL,
  `passWord` VARCHAR(45) NOT NULL,
  `UserGroup_idUserGroup` INT NOT NULL,
  PRIMARY KEY (`idUsers`, `UserGroup_idUserGroup`),
  UNIQUE INDEX `idUsers_UNIQUE` (`idUsers` ASC),
  INDEX `fk_Users_UserGroup_idx` (`UserGroup_idUserGroup` ASC),
  CONSTRAINT `fk_Users_UserGroup`
    FOREIGN KEY (`UserGroup_idUserGroup`)
    REFERENCES `mydb`.`UserGroup` (`idUserGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Examinees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Examinees` (
  `idExaminees` BIGINT NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `dateExam` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UserGroup_idUserGroup` BIGINT NOT NULL,
  PRIMARY KEY (`idExaminees`, `UserGroup_idUserGroup`),
  UNIQUE INDEX `idExaminees_UNIQUE` (`idExaminees` ASC),
  INDEX `fk_Examinees_UserGroup1_idx` (`UserGroup_idUserGroup` ASC),
  CONSTRAINT `fk_Examinees_UserGroup1`
    FOREIGN KEY (`UserGroup_idUserGroup`)
    REFERENCES `mydb`.`UserGroup` (`idUserGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exam` (
  `idExam` BIGINT NOT NULL,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idExam`),
  UNIQUE INDEX `idExam_UNIQUE` (`idExam` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Questions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Questions` (
  `idQuestions` BIGINT NOT NULL,
  `questionSet` TINYINT NOT NULL,
  `question` VARCHAR(45) NOT NULL,
  `correctAnswer` VARCHAR(45) NOT NULL,
  `alternativeAnswer1` VARCHAR(45) NOT NULL,
  `alternativeAnswer2` VARCHAR(45) NOT NULL,
  `Exam_idExam` BIGINT NOT NULL,
  PRIMARY KEY (`idQuestions`, `Exam_idExam`),
  UNIQUE INDEX `idQuestionSet_UNIQUE` (`idQuestions` ASC),
  INDEX `fk_Questions_Exam1_idx` (`Exam_idExam` ASC),
  CONSTRAINT `fk_Questions_Exam1`
    FOREIGN KEY (`Exam_idExam`)
    REFERENCES `mydb`.`Exam` (`idExam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ImageLink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ImageLink` (
  `idImageLink` BIGINT NOT NULL,
  `Original` VARCHAR(45) NOT NULL,
  `highRes` VARCHAR(45) NOT NULL,
  `lowRes` VARCHAR(45) NOT NULL,
  `Questions_idQuestions` BIGINT NOT NULL,
  PRIMARY KEY (`idImageLink`, `Questions_idQuestions`),
  UNIQUE INDEX `idImageLink_UNIQUE` (`idImageLink` ASC),
  INDEX `fk_ImageLink_Questions1_idx` (`Questions_idQuestions` ASC),
  CONSTRAINT `fk_ImageLink_Questions1`
    FOREIGN KEY (`Questions_idQuestions`)
    REFERENCES `mydb`.`Questions` (`idQuestions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Score`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Score` (
  `score` INT NOT NULL,
  `Exam_idExam` INT NOT NULL,
  `Examinees_idExaminees` INT NOT NULL,
  PRIMARY KEY (`Exam_idExam`, `Examinees_idExaminees`),
  INDEX `fk_Score_Examinees1_idx` (`Examinees_idExaminees` ASC),
  CONSTRAINT `fk_Score_Exam1`
    FOREIGN KEY (`Exam_idExam`)
    REFERENCES `mydb`.`Exam` (`idExam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Score_Examinees1`
    FOREIGN KEY (`Examinees_idExaminees`)
    REFERENCES `mydb`.`Examinees` (`idExaminees`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
