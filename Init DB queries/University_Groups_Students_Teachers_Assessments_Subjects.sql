﻿DROP DATABASE University;

CREATE DATABASE University;

USE University;

DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Groups;

CREATE TABLE Groups (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(10) NOT NULL UNIQUE,
);

CREATE TABLE Students (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(MAX) NOT NULL,
	LastName NVARCHAR(MAX) NOT NULL,
	BirthDate DATE NOT NULL,
	Email NVARCHAR(50) NOT NULL UNIQUE,
	Scholarship DECIMAL(8,2) NULL,
	GroupId INT FOREIGN KEY REFERENCES Groups(Id)
);

/*
Формат назви:
Спеціальність:
	- P - програмування
	- D - дизайн
	- A - адміністрування
Форма відвідування:
	- ON - онлайн
	- OF - офлайн
	- HB - гібрід
Рік початку (24, 25, 26)
Порядковий номер групи на потоці (01, 02, 03)
Приклад: P-ON-24-01
*/

INSERT INTO Groups (Name) VALUES
('P-ON-24-01'),
('P-ON-24-02'),
('P-OF-24-01'),
('P-HB-24-01'),
('D-ON-24-01'),
('D-OF-24-01'),
('D-HB-24-01'),
('A-ON-24-01'),
('A-OF-24-01'),
('P-ON-25-01'),
('P-OF-25-01'),
('P-HB-25-01'),
('D-ON-25-01'),
('A-ON-25-01'),
('P-ON-26-01');

INSERT INTO Students
	(FirstName, LastName, Email, Scholarship, BirthDate, GroupId)
VALUES
	('Andrii', 'Kovalenko', 'andrii.k@gmail.com', 1200, '2005-03-12', 1),
	('Olha', 'Melnyk', 'olha.m@outlook.com', NULL, '2006-07-08', 2),
	('Dmytro', 'Bondarenko', 'dmytro.b@outlook.com', 800, '2005-11-23', 3),
	('Kateryna', 'Shevchenko', 'kateryna.s@gmail.com', NULL, '2004-05-14', 4),
	('Ivan', 'Tkachenko', 'ivan.t@gmail.com', 1000, '2006-01-30', 5),
	('Anastasiia', 'Polishchuk', 'ana.p@gmail.com', 950, '2005-09-17', 6),
	('Mykhailo', 'Kravchenko', 'mykh.k@gmail.com', NULL, '2004-12-02', 7),
	('Alina', 'Danylenko', 'alina.d@gmail.com', 700, '2005-06-25', 8),
	('Yurii', 'Lysenko', 'yurii.l@gmail.com', NULL, '2006-02-10', 9),
	('Iryna', 'Rudenko', 'iryna.r@outlook.com', 850, '2005-10-19', 10),
	('Serhii', 'Horbatiuk', 'serhii.h@outlook.com', 1100, '2004-08-06', 11),
	('Maria', 'Tkachuk', 'maria.t@gmail.com', NULL, '2005-04-22', 12),
	('Oleksii', 'Pavlenko', 'oleksii.p@gmail.com', 950, '2005-03-01', 13),
	('Viktoriia', 'Moroz', 'viktoriia.m@gmail.com', NULL, '2006-12-03', 14),
	('Roman', 'Sokolov', 'roman.s@outlook.com', 800, '2004-07-29', 15),
	('Daria', 'Nechyporenko', 'daria.n@outlook.com', NULL, '2006-05-15', 1),
	('Bohdan', 'Oliinyk', 'bohdan.o@outlook.com', 1000, '2005-08-08', 2),
	('Yuliia', 'Hrytsenko', 'yuliia.h@outlook.com', NULL, '2004-09-20', 3),
	('Taras', 'Sydorenko', 'taras.s@gmail.com', 900, '2005-01-11', 4),
	('Natalia', 'Kostiuk', 'natalia.k@gmail.com', 850, '2006-06-06', 5);

SELECT * FROM Students;
SELECT * FROM Groups;

DROP TABLE Assessments;
DROP TABLE TeachersSubjects;
DROP TABLE Teachers;
DROP TABLE Subjects;

CREATE TABLE Subjects (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO Subjects ([Name]) VALUES
(N'Програмування'),
(N'Алгоритми та структури даних'),
(N'Бази даних'),
(N'SQL'),
(N'C#'),
(N'.NET'),
(N'Unity'),
(N'Веб-розробка'),
(N'Операційні системи'),
(N'Компʼютерні мережі'),
(N'Теорія ймовірності'),
(N'Лінійна алгебра'),
(N'Математичний аналіз');

INSERT INTO Subjects([Name]) VALUES
(N'Робототехніка');

CREATE TABLE Assessments (
	SubjectId INT FOREIGN KEY REFERENCES Subjects(Id) NOT NULL,
	StudentId INT FOREIGN KEY REFERENCES Students(Id) NOT NULL,
	Assessment INT NOT NULL CHECK (Assessment BETWEEN 1 AND 12),
	PRIMARY KEY (SubjectId, StudentId)
);

INSERT INTO Assessments (SubjectId, StudentId, Assessment) VALUES
(1, 1, 10),
(2, 1, 9),
(3, 1, 11),
(1, 2, 8),
(4, 2, 10),
(1, 4, 11),
(5, 7, 8),
(6, 7, 9),
(9, 7, 10),
(4, 8, 11),
(10, 8, 9),
(1, 9, 7),
(3, 9, 8),
(11, 9, 10),
(2, 10, 9),
(8, 13, 10),
(2, 14, 8),
(9, 14, 11),
(1, 15, 10),
(6, 15, 9),
(4, 16, 8),
(12, 16, 7),
(11, 20, 10);

CREATE TABLE Teachers (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(MAX) NOT NULL,
	LastName NVARCHAR(MAX) NOT NULL,
	BirthDate DATE NOT NULL,
	Email NVARCHAR(50) NOT NULL UNIQUE,
	Salary DECIMAL(10,2) NOT NULL
);

INSERT INTO Teachers (FirstName, LastName, BirthDate, Email, Salary) VALUES
(N'Олександр', N'Коваленко', '1985-04-12', 'o.kovalenko@uni.edu', 32000.00),
(N'Ірина',     N'Мельник',   '1990-09-03', 'i.melnyk@uni.edu',    29500.00),
(N'Андрій',    N'Шевченко',  '1982-01-27', 'a.shevchenko@uni.edu',35000.00),
(N'Наталія',   N'Бондар',    '1988-06-15', 'n.bondar@uni.edu',    31000.00),
(N'Сергій',    N'Ткаченко',  '1979-11-08', 's.tkachenko@uni.edu', 38000.00),
(N'Олена',     N'Романюк',   '1992-02-20', 'o.romaniuk@uni.edu',  28500.00),
(N'Дмитро',    N'Петренко',  '1984-07-01', 'd.petrenko@uni.edu',  33000.00),
(N'Марія',     N'Лисенко',   '1995-12-10', 'm.lysenko@uni.edu',   27000.00);

INSERT INTO Teachers (FirstName, LastName, BirthDate, Email, Salary) VALUES 
(N'Антон',     N'Тимошенко',   '1998-09-01', 'a.tymosh@uni.edu',   29000.00);

CREATE TABLE TeachersSubjects (
	TeacherId INT FOREIGN KEY REFERENCES Teachers(Id),
	SubjectId INT FOREIGN KEY REFERENCES Subjects(Id),
	PRIMARY KEY (TeacherId, SubjectId)
);

INSERT INTO TeachersSubjects (TeacherId, SubjectId) VALUES
-- Олександр Коваленко
(1, 1),  -- Програмування
(1, 5),  -- C#
(1, 6),  -- .NET
-- Ірина Мельник
(2, 8),  -- Веб-розробка
(2, 10), -- Операційні системи
-- Андрій Шевченко
(3, 2),  -- Алгоритми та структури даних
(3, 3),  -- Бази даних
(3, 4),  -- SQL
-- Наталія Бондар
(4, 7),  -- Unity
(4, 9),  -- Компʼютерні мережі
-- Сергій Ткаченко
(5, 10), -- Операційні системи
(5, 11), -- Теорія ймовірності
-- Олена Романюк
(6, 12), -- Лінійна алгебра
(6, 13), -- Математичний аналіз
-- Дмитро Петренко
(7, 1),  -- Програмування
(7, 8),  -- Веб-розробка
-- Марія Лисенко
(8, 11), -- Теорія ймовірності
(8, 12); -- Лінійна алгебра