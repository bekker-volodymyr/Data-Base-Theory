USE University;

-- Оголошення змінної
DECLARE @TeacherId INT;
DECLARE @TeacherName NVARCHAR(MAX);

-- Ініціалізація
SET @TeacherId = 2;

-- Ініціалізація результатом запиту та використання
SELECT TOP 1 @TeacherName = FirstName + ' ' + LastName
FROM Teachers WHERE Id = @TeacherId;

-- Вивід значення
SELECT @TeacherName AS [Викладач з ID = 2];

-- Створення процедури
-- Вибір всіх предметів викладача за ID
CREATE PROCEDURE usp_GetSubjectsByTeacher
	@TeacherId INT
AS
BEGIN
	SELECT [Name] AS [Предмет]
	FROM Subjects S
	WHERE Id = ANY (SELECT SubjectId 
					FROM TeachersSubjects TS 
					WHERE TS.TeacherId = @TeacherId);
END

-- Виконання процедури
EXEC usp_GetSubjectsByTeacher @TeacherId = 4;

-- Зміна процедури
ALTER PROCEDURE usp_GetSubjectsByTeacher
	@TeacherId INT,
	@TeacherName NVARCHAR(MAX)
AS
BEGIN
	SELECT 
		@TeacherName AS [Викладач],
		[Name] AS [Предмет]
	FROM Subjects
	WHERE Id = ANY (SELECT SubjectId 
					FROM TeachersSubjects TS 
					WHERE TS.TeacherId = @TeacherId);
END

DECLARE @Name NVARCHAR(MAX);

SELECT TOP 1 @Name = FirstName + ' ' + LastName
FROM Teachers WHERE Id = 4;

EXEC usp_GetSubjectsByTeacher 
	@TeacherId = 4, 
	@TeacherName = @Name;

-- Видалення процедури
DROP PROCEDURE usp_GetSubjectsByTeacher;

-- Створення скалярної функції
CREATE FUNCTION fn_GetFullName
	(@FirstName NVARCHAR(MAX),
	@LastName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
	RETURN @LastName + ' ' + @FirstName;
END

-- Використання функції
-- dbo - назва схеми, в якій зберігається об'єкт БД
SELECT dbo.fn_GetFullName(FirstName, LastName) AS [Повне ім'я]
FROM Students;

ALTER FUNCTION fn_GetFullName
	(@FirstName NVARCHAR(MAX),
	@LastName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
	RETURN @FirstName + ' ' + @LastName;
END

DROP FUNCTION fn_GetFullName;

-- Отримати назву схеми за замовченням
SELECT SCHEMA_NAME();

-- Створення табличної функції
CREATE FUNCTION fn_GetStudentsByGroup
	(@GroupName NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN (
	SELECT * FROM Students
	WHERE GroupId = (SELECT TOP 1 G.Id FROM Groups G WHERE G.[Name] = @GroupName)
);

-- Виклик табличної функції
SELECT dbo.fn_GetFullName(FirstName, LastName)
FROM fn_GetStudentsByGroup('A-ON-24-01');

CREATE TABLE LogActions (
	ActionType NVARCHAR(MAX) NOT NULL,
	ActionTime DATETIME NOT NULL DEFAULT GETDATE()
);

-- Створення тригеру
CREATE TRIGGER tg_StudentLogAction
ON Students
AFTER INSERT
AS
BEGIN
	INSERT INTO LogActions (ActionType, ActionTime) VALUES 
	('Student INSERT', DEFAULT);
END

INSERT INTO Students (FirstName, LastName, Email, BirthDate, Scholarship, GroupId)
VALUES ('Денис', 'Денисенко', 'denis@outlook.com', '2000-10-10', NULL, 5);

SELECT * FROM LogActions;

-- Зміна тригеру
ALTER TRIGGER tg_StudentLogAction
ON Students
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @ActionType NVARCHAR(MAX)

	IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED) 
		SET @ActionType = 'Student UPDATE';
	ELSE IF EXISTS (SELECT * FROM INSERTED) 
		SET @ActionType = 'Student INSERT';
	ELSE IF EXISTS (SELECT * FROM DELETED) 
		SET @ActionType = 'Student DELETE';

	INSERT INTO LogActions (ActionType, ActionTime) VALUES 
	(@ActionType, DEFAULT);
END

-- Видалення тригеру
DROP TRIGGER tg_StudentLogAction;

-- Перевод з 12-бальної системи у вербальну
--	12, 11, 10 - Відмінно
--	9, 8, 7 - Добре
--	6, 5, 4 - Задовільно
--	1, 2, 3 - Незадовільно
CREATE FUNCTION fn_TranslateGrade
	(@Grade INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @GradeVerbal NVARCHAR(MAX)

	SET @GradeVerbal = CASE
		WHEN @Grade >= 10 THEN N'Відмінно'
		WHEN @Grade >= 7 THEN N'Добре'
		WHEN @Grade >= 4 THEN N'Задовільно'
		ELSE N'Незадовільно'
	END -- Кінець виразу CASE
	RETURN @GradeVerbal
END

SELECT dbo.fn_GetFullName(FirstName, LastName) AS [Студент], 
	   dbo.fn_TranslateGrade(Assessment) AS [Оцінка]
FROM Students S
JOIN Assessments A ON S.Id = A.StudentId;

CREATE PROCEDURE usp_RaiseTeachersSalary
	@Amount DECIMAL
AS
BEGIN
	DECLARE @Id INT;
	DECLARE @MaxId INT;
	SELECT @Id = MIN(Id), @MaxId = MAX(Id) FROM Teachers;

	WHILE @Id <= @MaxId
	BEGIN
		IF EXISTS (SELECT 1 FROM Teachers WHERE Id = @Id)
		BEGIN
			UPDATE Teachers
			SET Salary = Salary + @Amount
			WHERE Id = @Id
		END

		SET @Id = @Id + 1;
	END
END

SELECT * FROM Teachers;
EXEC usp_RaiseTeachersSalary @Amount = 500;
SELECT * FROM Teachers;
