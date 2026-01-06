-- Фукнції агрегування

USE University;

-- COUNT() - підрахунок кількості записів

-- Кількість студентів, що отримують стипендію
SELECT COUNT(Scholarship) 
	AS [Кількість студентів, що отримують стипендію]
FROM Students;

-- Кількість унікальних імен студентів
SELECT COUNT(DISTINCT FirstName)
	AS [Кількість унікальних імен студентів]
FROM Students;

-- Кількість студентів, що використовують gmail
SELECT COUNT(Email)
	AS [Кількість студентів, що використовують gmail]
FROM Students
WHERE Email LIKE '%@gmail.com';

-- AVG() - середнє значення стовпця

-- Середня стипендія
SELECT AVG(Scholarship) AS [Середня стипендія]
FROM Students;

-- Середній вік студента
SELECT AVG(DATEDIFF(yy, BirthDate, GETDATE())) AS [Середній вік]
FROM Students;

-- SUM() - обчислення суми значень стовпця

-- Загальна сума стипендій
SELECT SUM(Scholarship) AS [Загальна сума стипендій]
FROM Students;

-- MIN() | MAX() - мінімальне/максимальне значення стовпця

-- Останній по журналу студент
SELECT MAX(LastName + ' ' + FirstName) AS [Останній по журналу]
FROM Students;

-- День народження наймолодшого студента
SELECT MIN(BirthDate) AS [День народження наймолодшого студента]
FROM Students;

-- Найнижча та найвища стипендії
SELECT 
	MAX(Scholarship) AS [Найвища стипендія],
	MIN(Scholarship) AS [Найнижча стипендія]
FROM Students;

-- Багатотабличний запит

-- Кількість студентів на онлайн формі навчання
SELECT COUNT(*) AS [Кількість студентів]
FROM Students S, Groups G
WHERE S.GroupId = G.Id AND G.[Name] LIKE '__ON______';