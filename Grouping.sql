-- Групування

-- Кількість студентів в кожній групі
SELECT G.[Name] AS [Група], COUNT(*) AS [Кількість] -- Обираємо назву групи та кількість студентів (в кожній групі)
FROM Groups G, Students S
WHERE G.Id = S.GroupId -- Фільтр для пар група-студент (для уникнення декартового представлення)
GROUP BY G.[Name]; -- Групуємо результати за назвою групи

-- Стипендія на групу
SELECT G.[Name] AS [Група], SUM(S.Scholarship) AS [Стипендія]
FROM Groups G, Students S
WHERE G.Id = S.GroupId
GROUP BY G.[Name];

-- Групи в яких більше одного студента
SELECT G.[Name] AS [Група], COUNT(*) AS [Кількість]
FROM Groups G, Students S
WHERE G.Id = S.GroupId
GROUP BY G.[Name]
HAVING COUNT(*) > 1;

-- Кількість студентів на кожній спеціальності та формі відвідування
SELECT 
    LEFT(Name, 1) AS Specialty,           -- перший символ: P, D, A
    SUBSTRING(Name, 3, 2) AS Attendance,  -- символи 3–4: ON, OF, HB
    COUNT(s.Id) AS StudentsCount
FROM Students S, Groups G
WHERE S.GroupId = G.Id
GROUP BY 
    LEFT(Name, 1),
    SUBSTRING(Name, 3, 2)
ORDER BY Specialty, Attendance;