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

CREATE DATABASE IF NOT EXISTS cs157a;
USE cs157a;

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
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS users_detail;
CREATE TABLE users_detail (
  user_detail_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id        INT UNSIGNED NOT NULL,
  email          VARCHAR(128)          DEFAULT NULL,
  first_name     VARCHAR(64)           DEFAULT NULL,
  last_name      VARCHAR(64)           DEFAULT NULL,
  birthday       VARCHAR(128)          DEFAULT NULL,
  nickname       VARCHAR(128)          DEFAULT NULL,
  PRIMARY KEY (user_detail_id),
  UNIQUE KEY (email),
  INDEX (user_id),
  FOREIGN KEY (user_id)
  REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS students;
CREATE TABLE students (
  student_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id    INT UNSIGNED NOT NULL,
  PRIMARY KEY (student_id),
  FOREIGN KEY (user_id)
  REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS professors;
CREATE TABLE professors (
  professor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id      INT UNSIGNED NOT NULL,
  PRIMARY KEY (professor_id),
  FOREIGN KEY (user_id)
  REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------------------

--
-- departments, courses, buildings, rooms, etc.
--
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  course_id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  dept_short_name VARCHAR(8)   NOT NULL,
  course_number      VARCHAR(16)  NOT NULL,
  course_name        VARCHAR(128) NOT NULL,
  course_description TEXT                  DEFAULT NULL,
  FULLTEXT idx_course_description (course_description),
  PRIMARY KEY (course_id),
  UNIQUE KEY (course_number, dept_short_name),
  INDEX (dept_short_name),
  FOREIGN KEY (dept_short_name)
  REFERENCES departments (dept_short_name)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  dept_short_name VARCHAR(8)   NOT NULL,
  dept_name       VARCHAR(128) NOT NULL,
  PRIMARY KEY (dept_short_name, dept_name)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS classrooms;
CREATE TABLE classrooms (
  room_num      VARCHAR(8)   NOT NULL,
  building_name VARCHAR(32)  NOT NULL,
  floor         TINYINT UNSIGNED      DEFAULT NULL,
  PRIMARY KEY (room_num, building_name)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------------------

--
-- the relationships
--
DROP TABLE IF EXISTS enrolled_in;
CREATE TABLE enrolled_in (
  enrollment_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  student_id    INT UNSIGNED NOT NULL,
  course_id     INT UNSIGNED NOT NULL,
  completed     BOOL                  DEFAULT FALSE,
  grade         ENUM ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F', 'CR', 'NC', 'W', 'I'),
  is_taking     BOOL                  DEFAULT FALSE,
  PRIMARY KEY (enrollment_id),
  UNIQUE KEY (student_id, course_id),
  INDEX (student_id, course_id),
  FOREIGN KEY (student_id)
  REFERENCES students (student_id)
    ON UPDATE CASCADE,
  FOREIGN KEY (course_id)
  REFERENCES courses (course_id)
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS teaches;
CREATE TABLE teaches (
  professor_id INT UNSIGNED NOT NULL,
  course_id    INT UNSIGNED NOT NULL,
  PRIMARY KEY (course_id),
  FOREIGN KEY (course_id)
  REFERENCES courses (course_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- ------------------------------------

-- ---------- NEW NEW NEW NEW ---------

--
-- enrollment_capacity
--
DROP TABLE IF EXISTS entroll_capacity;
CREATE TABLE entroll_capacity (
  course_id        INT UNSIGNED NOT NULL,
  capacity_current TINYINT UNSIGNED      DEFAULT 0,
  capacity_max     TINYINT UNSIGNED      DEFAULT 20, -- for now
  PRIMARY KEY (course_id),
  FOREIGN KEY (course_id)
  REFERENCES courses (course_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
