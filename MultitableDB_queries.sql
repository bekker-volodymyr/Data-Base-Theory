USE University;

DELETE FROM Students;

CREATE TABLE Groups (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(10) NOT NULL UNIQUE,
);

ALTER TABLE Students
ADD GroupId INT FOREIGN KEY REFERENCES Groups(Id);

INSERT INTO Groups ([Name])
VALUES ('U25-M18G1'),
	('U25-M16G2'),
	('U25-M10G3'),
	('U25-M14G1'),
	('U25-M18G2'),
	('U25-M12G4'),
	('U25-M16G5'),
	('U25-M10G6'),
	('U25-M18G7'),
	('U25-M14G8');

INSERT INTO Students
	(FirstName, LastName, Email, BirthDate, Scholarship, GroupId)
VALUES
	('Andrii', 'Kovalenko', 'andrii.k@example.com', 1200, '2005-03-12', 1),
	('Olha', 'Melnyk', 'olha.m@example.com', NULL, '2006-07-08', 2),
	('Dmytro', 'Bondarenko', 'dmytro.b@example.com', 800, '2005-11-23', 3),
	('Kateryna', 'Shevchenko', 'kateryna.s@example.com', NULL, '2004-05-14', 4),
	('Ivan', 'Tkachenko', 'ivan.t@example.com', 1000, '2006-01-30', 5),
	('Anastasiia', 'Polishchuk', 'ana.p@example.com', 950, '2005-09-17', 6),
	('Mykhailo', 'Kravchenko', 'mykh.k@example.com', NULL, '2004-12-02', 7),
	('Alina', 'Danylenko', 'alina.d@example.com', 700, '2005-06-25', 8),
	('Yurii', 'Lysenko', 'yurii.l@example.com', NULL, '2006-02-10', 9),
	('Iryna', 'Rudenko', 'iryna.r@example.com', 850, '2005-10-19', 10),
	('Serhii', 'Horbatiuk', 'serhii.h@example.com', 1100, '2004-08-06', 10),
	('Maria', 'Tkachuk', 'maria.t@example.com', NULL, '2005-04-22', 1),
	('Oleksii', 'Pavlenko', 'oleksii.p@example.com', 950, '2005-03-01', 3),
	('Viktoriia', 'Moroz', 'viktoriia.m@example.com', NULL, '2006-12-03', 5),
	('Roman', 'Sokolov', 'roman.s@example.com', 800, '2004-07-29', 5),
	('Daria', 'Nechyporenko', 'daria.n@example.com', NULL, '2006-05-15', 5),
	('Bohdan', 'Oliinyk', 'bohdan.o@example.com', 1000, '2005-08-08', 10),
	('Yuliia', 'Hrytsenko', 'yuliia.h@example.com', NULL, '2004-09-20', 9),
	('Taras', 'Sydorenko', 'taras.s@example.com', 900, '2005-01-11', 5),
	('Natalia', 'Kostiuk', 'natalia.k@example.com', 850, '2006-06-06', 6);


CREATE TABLE Departments (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(MAX) NOT NULL,
	Phone NVARCHAR(5) NOT NULL
);

CREATE TABLE Teachers (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(MAX) NOT NULL,
	LastName NVARCHAR(MAX) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id)
);

INSERT INTO Departments ([Name], Phone) VALUES 
('Mathematics', '12-45'),
('Physics', '23-56'),
('Chemistry', '34-67'),
('Biology', '45-78'),
('Computer Science', '56-89'),
('History', '67-90'),
('Geography', '78-01'),
('Philosophy', '89-12'),
('Psychology', '90-23'),
('Linguistics', '01-34');

INSERT INTO Teachers (FirstName, LastName, DepartmentId) VALUES 
('Ivan', 'Petrenko', 1),
('Olga', 'Shevchenko', 2),
('Dmytro', 'Tkachenko', 3),
('Svitlana', 'Melnyk', 4),
('Andriy', 'Kovalchuk', 5),
('Nina', 'Kravchenko', 6),
('Taras', 'Hnatyuk', 7),
('Iryna', 'Lysenko', 8),
('Yurii', 'Bondarenko', 9),
('Kateryna', 'Marchenko', 10);