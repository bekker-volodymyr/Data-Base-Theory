-- Студенти, що отримали оцінки
SELECT FirstName, LastName, Email
FROM Students S
WHERE EXISTS
	(SELECT * FROM Assessments A
	WHERE A.StudentId = S.Id);

-- Студенти, що не отримали оцінки
SELECT FirstName, LastName, Email
FROM Students S
WHERE NOT EXISTS
	(SELECT * FROM Assessments A
	WHERE A.StudentId = S.Id);

-- Студенти, що отримували оцінку 10
SELECT FirstName, LastName
FROM Students S
WHERE Id = ANY (SELECT StudentId 
				FROM Assessments 
				WHERE Assessment = 10);

-- Студенти, що отримували оцінку 7
SELECT FirstName, LastName
FROM Students S
WHERE Id = SOME (SELECT StudentId 
				FROM Assessments 
				WHERE Assessment = 7);

-- Кількість студентів, старших за хоча б одного викладача
SELECT COUNT(*) AS [Кількість студентів, старших за хоча б одного викладача]
FROM Students
WHERE BirthDate < ANY (SELECT BirthDate FROM Teachers);

-- Студенти які здали всі свої предмети на оцінку вище 8
SELECT FirstName, LastName
FROM Students S, Assessments A
WHERE A.StudentId = S.Id AND 8 <= ALL (
    SELECT Assessment
    FROM Assessments A
	WHERE A.StudentId = S.Id
);

SELECT * FROM Assessments
WHERE SubjectId = 1;

-- Предмети, середня оцінка з яких більша за всі оцінки по С# (id = 5)
SELECT S.[Name] AS SubjectName, AVG(A.Assessment) AS AvgAssessment
FROM Assessments A, Subjects S
WHERE A.SubjectId = S.Id
GROUP BY S.Id, S.[Name]
HAVING AVG(A.Assessment) >= ALL (
    SELECT A2.Assessment
    FROM Assessments A2
    WHERE A2.SubjectId = 5
);