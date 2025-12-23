USE University;

SELECT FirstName + ' ' + LastName AS FullName, [Name]
FROM Teachers, Departments
WHERE Teachers.DepartmentId = Departments.Id;

-- Декартове представлення
SELECT FirstName + ' ' + LastName AS FullName, [Name]
FROM Teachers, Departments;