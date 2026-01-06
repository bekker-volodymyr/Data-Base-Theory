-- Підзапити

-- Наймолодший студент
SELECT * FROM Students
WHERE BirthDate = (SELECT MIN(BirthDate) FROM Students);

-- Студенти з найменшою та найбільшою стипендією
SELECT FirstName + ' ' + LastName AS [Студент], Scholarship AS [Стипендія]
FROM Students
WHERE Scholarship = (SELECT MIN(Scholarship) FROM Students) OR
	Scholarship = (SELECT MAX(Scholarship) FROM Students);

-- Студенти, що навчаються на спеціальності програмування
SELECT * FROM Students
WHERE GroupId IN (
    SELECT Id FROM Groups WHERE [Name] LIKE 'P-%'
);

-- Common Table Expression

-- Наймолодший студент
WITH Min_BirthDate (Min_BD) AS (SELECT MIN(BirthDate) FROM Students)
SELECT * FROM Students, Min_BirthDate
WHERE BirthDate = Min_BD;

-- Студенти з найменшою та найбільшою стипендією
WITH Min_Max_Scholarships ([Min], [Max]) AS (
	SELECT MIN(Scholarship), MAX(Scholarship)
	FROM Students
)
SELECT FirstName + ' ' + LastName AS [Студент], Scholarship AS [Стипендія]
FROM Students S, Min_Max_Scholarships MinMax
WHERE S.Scholarship = MinMax.[Min] OR S.Scholarship = MinMax.[Max];