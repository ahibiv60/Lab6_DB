CREATE DATABASE IF NOT EXISTS Spodaryk_db DEFAULT CHARACTER SET utf8;
USE Spodaryk_db ;


# DROP TABLE IF EXISTS Spodaryk_db.vacancy_info_has_user_info;
# DROP TABLE IF EXISTS Spodaryk_db.candidate_level;
# DROP TABLE IF EXISTS Spodaryk_db.contact_person_info;
# DROP TABLE IF EXISTS Spodaryk_db.vacancy_info;
# DROP TABLE IF EXISTS Spodaryk_db.it_company_info;
# DROP TABLE IF EXISTS Spodaryk_db.language;
# DROP TABLE IF EXISTS Spodaryk_db.user_private_info;
# DROP TABLE IF EXISTS Spodaryk_db.user_info;
# DROP TABLE IF EXISTS Spodaryk_db.level_of_experience;
# DROP TABLE IF EXISTS Spodaryk_db.technical_level;


CREATE TABLE Spodaryk_db.candidate_level (
  id INT NOT NULL AUTO_INCREMENT,
  level VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;



CREATE TABLE Spodaryk_db.it_company_info (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;



CREATE TABLE Spodaryk_db.contact_person_info (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  surname VARCHAR(45) NOT NULL,
  age INT NOT NULL,
  phone_number INT NOT NULL,
  email VARCHAR(45) NOT NULL,
  it_company_info_id INT,
  PRIMARY KEY (id),
  INDEX fk_contact_person_info_it_company_info_idx (it_company_info_id ASC) VISIBLE,
  CONSTRAINT fk_contact_person_info_it_company_info
    FOREIGN KEY (it_company_info_id)
    REFERENCES Spodaryk_db.it_company_info (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Spodaryk_db.language (
  id INT NOT NULL AUTO_INCREMENT,
  language VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Spodaryk_db.level_of_experience (
  id INT NOT NULL AUTO_INCREMENT,
  level VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Spodaryk_db.technical_level (
  id INT NOT NULL AUTO_INCREMENT,
  level VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Spodaryk_db.user_info (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  surname VARCHAR(45) NOT NULL,
  age INT NOT NULL,
  technical_level_id INT NOT NULL,
  level_of_experience_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_user_info_technical_level_idx (technical_level_id ASC) VISIBLE,
  INDEX fk_user_info_level_of_experience_idx (level_of_experience_id ASC) VISIBLE,
  CONSTRAINT fk_user_info_level_of_experience
    FOREIGN KEY (level_of_experience_id)
    REFERENCES Spodaryk_db.level_of_experience (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_info_technical_level
    FOREIGN KEY (technical_level_id)
    REFERENCES Spodaryk_db.technical_level (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Spodaryk_db.user_private_info (
  user_info_id INT NOT NULL AUTO_INCREMENT,
  login VARCHAR(45) NOT NULL,
  password VARCHAR(10) NOT NULL,
  PRIMARY KEY (user_info_id),
  INDEX fk_user_private_info_user_info_idx (user_info_id ASC) VISIBLE,
  CONSTRAINT fk_user_private_info_user_info
    FOREIGN KEY (user_info_id)
    REFERENCES Spodaryk_db.user_info (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Spodaryk_db.vacancy_info (
  id INT NOT NULL AUTO_INCREMENT,
  description VARCHAR(225) NULL DEFAULT NULL,
  project_name VARCHAR(45) NOT NULL,
  it_company_info_id INT NOT NULL,
  language_id INT NOT NULL,
  level_of_experience_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_vacancy_info_it_company_info_idx (it_company_info_id ASC) VISIBLE,
  INDEX fk_vacancy_info_language_idx (language_id ASC) VISIBLE,
  INDEX fk_vacancy_info_level_of_experience_idx (level_of_experience_id ASC) VISIBLE,
  CONSTRAINT fk_vacancy_info_it_company_info
    FOREIGN KEY (it_company_info_id)
    REFERENCES Spodaryk_db.it_company_info (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_vacancy_info_language
    FOREIGN KEY (language_id)
    REFERENCES Spodaryk_db.language (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_vacancy_info_level_of_experience
    FOREIGN KEY (level_of_experience_id)
    REFERENCES Spodaryk_db.level_of_experience (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Spodaryk_db.vacancy_info_has_user_info (
  vacancy_info_id INT NOT NULL,
  user_info_id INT NOT NULL,
  comment VARCHAR(45) NULL DEFAULT NULL,
  approve BIT(1) NULL DEFAULT NULL,
  candidate_level_id INT NULL DEFAULT NULL,
  PRIMARY KEY (vacancy_info_id, user_info_id),
  INDEX fk_vacancy_info_has_user_info_user_info_idx (user_info_id ASC) VISIBLE,
  INDEX fk_vacancy_info_has_user_info_vacancy_info_idx (vacancy_info_id ASC) VISIBLE,
  INDEX fk_vacancy_info_has_user_info_candidate_level_idx (candidate_level_id ASC) VISIBLE,
  CONSTRAINT fk_vacancy_info_has_user_info_candidate_level
    FOREIGN KEY (candidate_level_id)
    REFERENCES Spodaryk_db.candidate_level (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_vacancy_info_has_user_info_user_info
    FOREIGN KEY (user_info_id)
    REFERENCES Spodaryk_db.user_info (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_vacancy_info_has_user_info_vacancy_info
    FOREIGN KEY (vacancy_info_id)
    REFERENCES Spodaryk_db.vacancy_info (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



INSERT INTO Spodaryk_db.candidate_level(id, level) VALUES
(1,'BAD'),
(2, 'SATISFACTORY'),
(3, 'ENOUGH'),
(4, 'GOOD'),
(5, 'VERY GOOD');


INSERT INTO Spodaryk_db.it_company_info(id, name) VALUES
(1, 'SoftServe'),
(2, 'Epam'),
(3, 'GlobalLogic'),
(4, 'Cypress'),
(5, 'Microsoft'),
(6, 'IBM'),
(7, 'Oracle'),
(8, 'SAP'),
(9, 'TCS'),
(10, 'HPE');


INSERT INTO Spodaryk_db.contact_person_info(id, name, surname, age, phone_number, email, it_company_info_id) VALUES
(1, 'Igor', 'Loza', 24, 0687444371, 'igor.loza@gmail.com', 2),
(2, 'Oleh', 'Hoza', 24, 0687444757, 'oleh.hoza@gmail.com', 1),
(3, 'Stepan', 'Doza', 24, 0687447717, 'stepan.doza@gmail.com', 3),
(4, 'Roman', 'Roza', 24, 0687442817, 'roman.roza@gmail.com', 6),
(5, 'Nazar', 'Poza', 24, 0687423717, 'nazar.poza@gmail.com', 5),
(6, 'Ira', 'Moza', 24, 0687447717, 'ira.moza@gmail.com', 4),
(7, 'Pavlo', 'Koza', 24, 0684446617, 'pavlo.koza@gmail.com', 7),
(8, 'Bohdan', 'Soza', 24, 0874443447, 'bohdan.soza@gmail.com', 8),
(9, 'Ostap', 'Woza', 24, 0674443712, 'ostap.woza@gmail.com', null),
(10, 'Volodia', 'Boza', 24, 0684443732, 'volodia.boza@gmail.com', 10);


INSERT INTO Spodaryk_db.language(id, language) VALUES
(1, 'Java'),
(2, 'Python'),
(3, 'C'),
(4, 'C++'),
(5, 'C#'),
(6, '.NET'),
(7, 'Kotlin'),
(8, 'JS'),
(9, 'Ruby'),
(10, 'Pascal');


INSERT INTO Spodaryk_db.level_of_experience(id, level) VALUES
(1, 'BEGINNER'),
(2, 'TRAINEE'),
(3, 'JUNIOR'),
(4, 'MIDDLE'),
(5, 'SENIOR'),
(6, 'PROFI');



INSERT INTO Spodaryk_db.technical_level(id, level) VALUES
(1,'BAD'),
(2, 'SATISFACTORY'),
(3, 'ENOUGH'),
(4, 'GOOD'),
(5, 'VERY GOOD');

 
INSERT INTO Spodaryk_db.user_info(id, name, surname, age, technical_level_id, level_of_experience_id) VALUES
(1, 'Oleh', 'Hatsyk', 22, 4, 4),
(2, 'Roman', 'Bolik', 23, 2, 4),
(3, 'Nazar', 'Holik', 22, 4, 3),
(4, 'Ira', 'Nolik', 32, 1, 1),
(5, 'Oleh', 'Volik', 52, 3, 1),
(6, 'Ostap', 'Popo', 21, 3, 4),
(7, 'Rostyk', 'Lopo', 33, 2, 4),
(8, 'Ivan', 'Holo', 41, 2, 4),
(9, 'Pavlo', 'Tolo', 38, 4, 5),
(10, 'Oleh', 'Rop', 48, 4, 6);



INSERT INTO Spodaryk_db.user_private_info(user_info_id, login, password) VALUES
(1, 'klfdvniqenv', '1234567890'),
(2, 'fwevwwww', '1234567890'),
(3, '3245vf355v', '1234567890'),
(4, 'dfkvo343', '1234514590'),
(5, 'klfdvniqenv', '1234567890'),
(6, 'elgioi00', '3534567853'),
(7, 'klfdvniqenv', '123443290'),
(8, 'ekrjbeoibi', '1255567890'),
(9, 'wrtiowoii44', '1234567890'),
(10, 'egkeo3455', '1234567890');



INSERT INTO Spodaryk_db.vacancy_info(id, description, project_name, it_company_info_id, language_id, level_of_experience_id) VALUES
(1, DEFAULT, 'SmartSMTH', 2, 3, 3),
(2, DEFAULT, 'GLOBAL', 10, 3, 4),
(3, DEFAULT, 'RRRRRRR', 6, 3, 2),
(4, DEFAULT, '300033', 5, 3, 1),
(5, DEFAULT, '000110011011', 4, 3, 4),
(6, 'smth interesting', 'ropopo', 2, 3, 3),
(7, DEFAULT, 'voda', 1, 4, 4),
(8, DEFAULT, 'loverer', 2, 3, 4),
(9, DEFAULT, 'DDDD', 7, 2, 3),
(10, DEFAULT, 'HHHHH', 9, 1, 3);


  
INSERT INTO Spodaryk_db.vacancy_info_has_user_info(vacancy_info_id, user_info_id, comment, approve, candidate_level_id) VALUES
(1, 1, DEFAULT, DEFAULT, 5),
(1, 3, DEFAULT, 1, 3),
(2, 3, DEFAULT, 0, 4),
(2, 1, DEFAULT, 1, 5),
(3, 1, DEFAULT, DEFAULT, 1),
(7, 5, DEFAULT, 1, 1),
(5, 5, DEFAULT, 0, 3),
(2, 2, DEFAULT, 0, 3),
(1, 4, DEFAULT, DEFAULT, 4),
(1, 9, DEFAULT, DEFAULT, 5);
