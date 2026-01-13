-- UNION

-- Студенти та викладачі, що народились влітку
SELECT LastName + ' ' + FirstName AS [Ім'я], Email, BirthDate, 'S' AS [Студент/Викладач]
FROM Students
WHERE MONTH(BirthDate) BETWEEN 6 AND 7
UNION
SELECT LastName + ' ' + FirstName AS [Ім'я], Email, BirthDate, 'T'
FROM Teachers
WHERE MONTH(BirthDate) BETWEEN 6 AND 7
ORDER BY BirthDate;

-- Студенти з gmail та з поштою на .com
SELECT * FROM Students
WHERE Email LIKE '%gmail%'
UNION ALL
SELECT * FROM Students
WHERE Email LIKE '%com';

-- Суденти, викладачі та загальна кількість, народжених восени
SELECT 'Students' AS [Народились восени], COUNT(*) AS [Кількість]
FROM Students
WHERE MONTH(BirthDate) BETWEEN 9 AND 11
UNION
SELECT 'Teachers', COUNT(*)
FROM Teachers
WHERE MONTH(BirthDate) BETWEEN 9 AND 11
UNION
SELECT 'All', SUM(SumTable.AllCount)
FROM (
	SELECT COUNT(*) AS AllCount
	FROM Students
	WHERE MONTH(BirthDate) BETWEEN 9 AND 11
	UNION
	SELECT COUNT(*)
	FROM Teachers
	WHERE MONTH(BirthDate) BETWEEN 9 AND 11
	) AS SumTable;

-- Студент - група
SELECT FirstName, LastName, G.[Name]
FROM Students S
JOIN Groups G ON S.GroupId = G.Id;

-- Студент, предмет, оцінка, група
SELECT FirstName, LastName, SUB.[Name] AS [Предмет], Assessment, G.[Name] AS [Група]
FROM Students S
JOIN Assessments A ON S.Id = A.StudentId
JOIN Subjects SUB ON SUB.Id = A.SubjectId
JOIN Groups G ON S.GroupId = G.Id
ORDER BY FirstName, LastName;

-- Студенти та оцінки + студенти без оцінок
SELECT FirstName, LastName, Assessment
FROM Students S
LEFT JOIN Assessments A
ON S.Id = A.StudentId
ORDER BY FirstName, LastName;

-- Студенти та оцінки + студенти без оцінок
SELECT FirstName, LastName, Assessment
FROM Assessments A
RIGHT JOIN Students S
ON S.Id = A.StudentId
ORDER BY FirstName, LastName;

-- Викладачі та предмети + викладачі яким не назначено предмет
SELECT SubjectId, FirstName, LastName
FROM TeachersSubjects TS
RIGHT JOIN Teachers T
ON T.Id = TS.TeacherId
ORDER BY SubjectId;

-- Викладачі та предмети 
-- + викладачі яким не назначено предмет
-- + предмети яким не назначено викладача
SELECT FirstName, LastName, S.[Name]
FROM TeachersSubjects TS
FULL JOIN Teachers T ON T.Id = TS.TeacherId
FULL JOIN Subjects S ON S.Id = TS.SubjectId
ORDER BY S.[Name];