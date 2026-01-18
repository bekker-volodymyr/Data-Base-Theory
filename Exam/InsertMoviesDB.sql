USE Movies;

INSERT INTO Users (Username, Email, PasswordHash, Role)
VALUES
('Fenix_Olga', 'olga.fenix@cinemania.ua', HASHBYTES('SHA2_256', 'FlamePass42!'), 'Admin'),
('PixelMaks', 'maks.pixel@streamcloud.io', HASHBYTES('SHA2_256', 'Pixelated321$'), 'Moderator'),
('NovaVika', 'vika.nova@serieshub.com', HASHBYTES('SHA2_256', 'NovaStar789@'), 'Moderator'),
('GlitchAndriy', 'andriy.glitch@movieland.ua', HASHBYTES('SHA2_256', 'GlitchPass1!'), 'User'),
('LunaMarta', 'marta.luna@filmverse.net', HASHBYTES('SHA2_256', 'LunaLight2@'), 'User'),
('CipherOleksiy', 'oleksiy.cipher@cinema.io', HASHBYTES('SHA2_256', 'CipherKey3#'), 'User');

INSERT INTO Titles (Title, Description, ReleaseYear, DurationMinutes, UserID)
VALUES
('Inception',
 'A skilled thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.',
 2010, 148, 1),
('28 Days Later',
 'Four weeks after a mysterious, incurable virus spreads throughout the United Kingdom, a handful of survivors try to find sanctuary.',
 2002, 113, 2),
('The Room',
 'Cult classic drama film known for its unconventional storytelling.',
 2003, 99, 3),
('Люксембург, Люксембург',
 'Коли брати-близнюки дізнаються, що їхній давно зниклий батько захворів у Люксембургу, вони вирушають у подорож, аби побачити його востаннє. Та чи буде чоловік, якого вони там зустрінуть, таким само поганим татом, яким вони його пам’ятають?',
 2022, 106, 4),
('Тіні забутих предків',
 'Класичний український фільм, що розповідає про гуцульське життя і кохання.',
 1965, 89, 5),
('Dune',
 'Epic sci-fi film about a desert planet and the fight for its control.',
 2021, 155, 6),
('Dune: Part Two',
 'Duke Paul Atreides joins the Fremen and begins a spiritual and martial journey to become Muaddib, while trying to prevent the horrible but inevitable future he is witnessed: a Holy War in his name, spreading throughout the known universe.',
 2024, 167, 1),
 ('Ти - космос',
 'Український космічний далекобійник Андрій перевозить ядерні відходи з Землі на супутник Юпітера. Після несподіваного вибуху Землі, уламки якої знищують все навколо, Андрій залишається останньою людиною у Всесвіті.',
 2025, 90, 2
 );

INSERT INTO Roles (RoleTitle)
VALUES 
    (N'Director'),
    (N'Actor'),
    (N'Screenwriter'),
    (N'Cinematographer'),
    (N'Producer'),
    (N'Composer'),
    (N'Editor'),
    (N'Production Designer'),
    (N'Stunt Performer'),
    (N'Makeup Artist'),
    (N'Sound Engineer');


INSERT INTO Lists (UserID, Title, Description, IsPublic) VALUES
(1, 'Улюблені українські фільми', 'Збірка найкращих українських фільмів, які я бачив.', 1), -- IsPublic = true (1)
(2, 'Наукова фантастика', 'Фантастичні фільми та серіали, що змушують задуматися.', 1), -- IsPublic = true (1)
(3, 'Подивитися пізніше', 'Тайтли, які варто подивитися найближчим часом.', 0), -- IsPublic = false (0)
(4, 'Культові фільми', 'Фільми, що отримали культовий статус.', 1); -- IsPublic = true (1)

-- Додавання елементів до Списку 1 (Улюблені українські фільми, ListID = 1)
INSERT INTO ListItems (ListID, TitleID) VALUES
(1, 4), -- Люксембург, Люксембург
(1, 5), -- Тіні забутих предків
(1, 8); -- Ти - космос

-- Додавання елементів до Списку 2 (Наукова фантастика, ListID = 2)
INSERT INTO ListItems (ListID, TitleID) VALUES
(2, 1), -- Inception
(2, 6), -- Dune
(2, 7), -- Dune: Part Two
(2, 8); -- Ти - космос

-- Додавання елементів до Списку 3 (Подивитися пізніше, ListID = 3)
INSERT INTO ListItems (ListID, TitleID) VALUES
(3, 1), -- Inception
(3, 2); -- 28 Days Later

-- Додавання елементів до Списку 4 (Культові фільми, ListID = 4)
INSERT INTO ListItems (ListID, TitleID) VALUES
(4, 3), -- The Room
(4, 5); -- Тіні забутих предків

INSERT INTO People (FullName, BirthDate, Biography) VALUES
-- Іноземні персони
('Christopher Nolan', '1970-07-30', 'Британсько-американський кінорежисер, сценарист і продюсер, відомий своїми нелінійними сюжетами.'), -- PersonID = 1
('Leonardo DiCaprio', '1974-11-11', 'Американський актор та продюсер, лауреат премії Оскар.'), -- PersonID = 2
('Danny Boyle', '1956-10-20', 'Британський кінорежисер, продюсер та сценарист, відомий фільмом "28 Days Later".'), -- PersonID = 3
('Timothée Chalamet', '1995-12-27', 'Американський актор, номінант премії Оскар.'), -- PersonID = 4
('Denis Villeneuve', '1967-10-03', 'Канадський кінорежисер та сценарист, відомий своїми науково-фантастичними фільмами.'), -- PersonID = 5
('Cillian Murphy', '1976-05-25', 'Ірландський актор, який часто співпрацює з Крістофером Ноланом.'), -- PersonID = 6

-- Українські та пов'язані з українським кіно персони
('Антоніо Лукіч', '1991-09-12', 'Український кінорежисер та сценарист, відомий фільмом "Люксембург, Люксембург".'), -- PersonID = 7
('Раміль Насіров', '1992-06-21', 'Український актор, виконавець головної ролі у фільмі "Люксембург, Люксембург".'), -- PersonID = 8
('Іван Миколайчук', '1941-06-15', 'Видатний український актор, сценарист, режисер.'), -- PersonID = 9
('Сергій Параджанов', '1924-01-09', 'Радянський та український кінорежисер вірменського походження, автор "Тіні забутих предків".'), -- PersonID = 10
('Олег Сенцов', '1976-07-11', 'Український режисер, сценарист і письменник, громадський діяч.'); -- PersonID = 11


INSERT INTO PeopleInvolved (TitleID, PersonID, RoleID) VALUES
-- 1. 'Inception'
(1, 1, 1), -- Christopher Nolan (Director)
(1, 1, 3), -- Christopher Nolan (Screenwriter) 
(1, 2, 2), -- Leonardo DiCaprio (Actor)
(1, 6, 2), -- Cillian Murphy (Actor)
(1, 1, 5), -- Christopher Nolan (Producer)

-- 2. '28 Days Later'
(2, 3, 1), -- Danny Boyle (Director)
(2, 6, 2), -- Cillian Murphy (Actor)

-- 4. 'Люксембург, Люксембург'
(4, 7, 1), -- Антоніо Лукіч (Director)
(4, 7, 3), -- Антоніо Лукіч (Screenwriter)
(4, 8, 2), -- Раміль Насіров (Actor)
(4, 7, 5), -- Антоніо Лукіч (Producer)

-- 5. 'Тіні забутих предків'
(5, 10, 1), -- Сергій Параджанов (Director)
(5, 10, 3), -- Сергій Параджанов (Screenwriter)
(5, 9, 2), -- Іван Миколайчук (Actor)

-- 6. 'Dune'
(6, 5, 1), -- Denis Villeneuve (Director)
(6, 4, 2), -- Timothée Chalamet (Actor)
(6, 5, 3), -- Denis Villeneuve (Screenwriter - співавтор)

-- 7. 'Dune: Part Two'
(7, 5, 1), -- Denis Villeneuve (Director)
(7, 4, 2), -- Timothée Chalamet (Actor)
(7, 5, 3), -- Denis Villeneuve (Screenwriter - співавтор)

-- 8. 'Ти - космос'
(8, 11, 1), -- Олег Сенцов (Director)
(8, 11, 3); -- Олег Сенцов (Screenwriter)
