--
-- Our database schema
-- A WORK IN PROGRESS
--

--
-- the schema
--

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL';

CREATE DATABASE IF NOT EXISTS cs157a_sec3_team5 -- new name. drop cs157a database if exist
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;
USE cs157a_sec3_team5;

--
-- users: students, teachers, dept chair, etc.
--
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  user_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(128) NOT NULL,
  password VARCHAR(128) NOT NULL,
  PRIMARY KEY (user_id),
  UNIQUE KEY (username)
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS users_detail;
CREATE TABLE users_detail (
  user_id      INT UNSIGNED NOT NULL,
  email        VARCHAR(255) DEFAULT NULL,
  first_name   VARCHAR(64)  DEFAULT NULL,
  last_name    VARCHAR(64)  DEFAULT NULL,
  birthday     DATE         DEFAULT NULL, -- default yyyy-mm-dd
  nickname     VARCHAR(128) DEFAULT NULL,
  phone_number VARCHAR(128) DEFAULT NULL,
  address      VARCHAR(128) DEFAULT NULL,
  gender       VARCHAR(64)  DEFAULT NULL,
  ethnicity    VARCHAR(128) DEFAULT NULL,
  PRIMARY KEY (user_id),
  UNIQUE KEY (email),
  FOREIGN KEY (user_id) REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS students;
CREATE TABLE students (
  student_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id    INT UNSIGNED NOT NULL,
  PRIMARY KEY (student_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS professors;
CREATE TABLE professors (
  professor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id      INT UNSIGNED NOT NULL,
  PRIMARY KEY (professor_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS dept_heads;
CREATE TABLE dept_heads (
  dept_head_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id      INT UNSIGNED NOT NULL,
  PRIMARY KEY (dept_head_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;

-- ----------------------------------------

--
-- departments, courses, buildings, rooms, etc.
--
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  course_id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  dept_short_name    VARCHAR(8)   NOT NULL,
  course_number      VARCHAR(16)  NOT NULL,
  course_name        VARCHAR(128) NOT NULL,
  course_description TEXT                  DEFAULT NULL,
  ge VARCHAR(16) DEFAULT 'N/A',
  FULLTEXT idx_course_description (course_description),
  PRIMARY KEY (course_id),
  UNIQUE KEY (course_number, dept_short_name),
  FOREIGN KEY (dept_short_name) REFERENCES departments (dept_short_name)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  dept_short_name VARCHAR(8)   NOT NULL,
  dept_name       VARCHAR(128) NOT NULL,
  PRIMARY KEY (dept_short_name, dept_name)
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS classrooms;
CREATE TABLE classrooms (
  building_name VARCHAR(32)       NOT NULL,
  room_num      SMALLINT UNSIGNED NOT NULL,
  floor         TINYINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (building_name, room_num)
)
  ENGINE = InnoDB;

-- ----------------------------------------

--
-- the relationships
--
DROP TABLE IF EXISTS enrolled_in;
CREATE TABLE enrolled_in (
  student_id INT UNSIGNED NOT NULL,
  course_id  INT UNSIGNED NOT NULL,
  grade      ENUM ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F', 'CR', 'NC', 'W', 'I'),
  completed  BOOL DEFAULT FALSE,
  is_taking  BOOL DEFAULT FALSE,
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students (student_id)
    ON UPDATE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses (course_id)
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS teaches;
CREATE TABLE teaches (
  professor_id INT UNSIGNED NOT NULL,
  course_id    INT UNSIGNED NOT NULL,
  PRIMARY KEY (course_id),
  INDEX (professor_id),
  FOREIGN KEY (professor_id) REFERENCES professors (professor_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses (course_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS taught_in;
CREATE TABLE taught_in (
  course_id     INT UNSIGNED                                   NOT NULL,
  building_name VARCHAR(32)                                    NOT NULL,
  room_num      SMALLINT UNSIGNED                              NOT NULL,
  session_date  ENUM ('Mo', 'Tu', 'We', 'Th', 'F', 'Sa', 'Su') NOT NULL,
  session_time  TIME                                           NOT NULL,
  PRIMARY KEY (course_id),
  UNIQUE KEY (building_name, room_num, session_date, session_time),
  FOREIGN KEY (building_name, room_num) REFERENCES classrooms (building_name, room_num)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS hired_by;
CREATE TABLE hired_by (
  professor_id    INT UNSIGNED NOT NULL,
  dept_short_name VARCHAR(8)   NOT NULL,
  PRIMARY KEY (professor_id, dept_short_name),
  FOREIGN KEY (professor_id) REFERENCES professors (professor_id)
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;


DROP TABLE IF EXISTS head_of;
CREATE TABLE head_of (
  dept_head_id    INT UNSIGNED NOT NULL,
  dept_short_name VARCHAR(8)   NOT NULL,
  PRIMARY KEY (dept_head_id, dept_short_name),
  FOREIGN KEY (dept_short_name) REFERENCES departments (dept_short_name)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
  ENGINE = InnoDB;

-- ------------------------------------

