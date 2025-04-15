-- Person table
CREATE TABLE People (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    SpouseName VARCHAR(100)
);

-- Actor table (Subtype of People)
CREATE TABLE Actor (
    PersonID INT PRIMARY KEY,
    BirthDate DATE,
    HairColor VARCHAR(50),
    EyeColor VARCHAR(50),
    Height_in INT,
    Weight_lbs INT,
    FavoriteColor VARCHAR(50),
    SAGAnniversaryDate DATE,
    FOREIGN KEY (PersonID) REFERENCES People(PersonID)
);

-- Director table (Subtype of Person)
CREATE TABLE Director (
    PersonID INT PRIMARY KEY,
    FilmSchoolAttended VARCHAR(100),
    DirectorsGuildAnniversaryDate DATE,
    FavoriteLensMaker VARCHAR(100),
    FOREIGN KEY (PersonID) REFERENCES People(PersonID)
);

-- Movie table
CREATE TABLE Movie (
    MovieID INT PRIMARY KEY,
    MovieName VARCHAR(255) NOT NULL,
    ReleaseYear INT,
    MPAANumber VARCHAR(20),
    DomesticBoxOfficeSalesUSD DECIMAL(15, 2),
    ForeignBoxOfficeSalesUSD DECIMAL(15, 2),
    DVDBluRaySales DECIMAL(15, 2)
);

-- Awards Table
CREATE TABLE Awards (
    PersonID INT,
    MovieID INT,
    Award VARCHAR(100),
    PRIMARY KEY (PersonID, MovieID, Award), -- composite key bc one actor cannot get same nom for same movie, but can have diff awards for same movie
    FOREIGN KEY (PersonID) REFERENCES People(PersonID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

-- Movie Participation Table
CREATE TABLE Participation (
    PersonID INT,
    MovieID INT,
    Role VARCHAR(50), -- e.g., 'Actor', 'Director', 'Producer', etc.
    PRIMARY KEY (PersonID, MovieID, Role),
    FOREIGN KEY (PersonID) REFERENCES People(PersonID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

select *
from People;

select *
from Actor;

select *
from Director;

select * 
from Movie;

select *
from Nominations;

select *
from Participation;

--write a query that should show all directors whom actor roger moore worked with
select distinct p.Name as director.name
from participation pa inner join movie m on pa.movieID = m.movieID
					  inner join Participation pd on pd.movieID = m.movieID and pd.role = 'Director'
					  inner join People p on p.personID = pd.personID
					  inner join people pa_actor on pa_actor.personID = pa.personID
where pa_actor.name = 'Roger Moore' and p.Name != 'Roger Moore';