DROP DATABASE Movies;

CREATE DATABASE Movies;

USE Movies;

CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleTitle NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(200) NOT NULL UNIQUE,
    Email NVARCHAR(200) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(256) NOT NULL,
    RegistrationDate DATETIME NOT NULL DEFAULT GETDATE(),
    Role NVARCHAR(20) NOT NULL,
    Rating INT NOT NULL DEFAULT 0,
    CONSTRAINT CHK_UserEmail CHECK (Email LIKE '%@%._%'),
    CONSTRAINT CHK_UserRole CHECK (Role IN ('User', 'Admin', 'Moderator'))
);

CREATE TABLE People (
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200) NOT NULL,
    BirthDate DATE,
    Biography NVARCHAR(MAX)
);

CREATE TABLE Titles (
    TitleID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    ReleaseYear INT,
    DurationMinutes INT,
    UserId INT NOT NULL,
    AdditionDT DATETIME NOT NULL DEFAULT GETDATE(),
    ModificationDT DATETIME,
    CONSTRAINT FK_Titles_Users FOREIGN KEY (UserId) REFERENCES Users(UserID)
);

CREATE TABLE Lists (
    ListID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    IsPublic BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Lists_Users FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE ListItems (
    ListItemID INT IDENTITY(1,1) PRIMARY KEY,
    ListID INT NOT NULL,
    TitleID INT NOT NULL,
    AddedDate DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_ListItems_Lists FOREIGN KEY (ListID) REFERENCES Lists(ListID),
    CONSTRAINT FK_ListItems_Titles FOREIGN KEY (TitleID) REFERENCES Titles(TitleID)
);

CREATE TABLE PeopleInvolved (
    TitleID INT NOT NULL,
    PersonID INT NOT NULL,
    RoleID INT NOT NULL,
    CONSTRAINT PK_PeopleInvolved PRIMARY KEY (TitleID, PersonID, RoleID),
    CONSTRAINT FK_PeopleInvolved_Titles FOREIGN KEY (TitleID) REFERENCES Titles(TitleID),
    CONSTRAINT FK_PeopleInvolved_People FOREIGN KEY (PersonID) REFERENCES People(PersonID),
    CONSTRAINT FK_PeopleInvolved_Roles FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

CREATE TRIGGER tg_Titles_AfterInsert
ON Titles
AFTER INSERT
AS
BEGIN
    UPDATE U
    SET U.Rating = U.Rating + 1
    FROM Users U
    INNER JOIN inserted I ON U.UserID = I.UserId;
END;