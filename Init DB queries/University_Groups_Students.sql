DROP DATABASE IF EXISTS University;

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
