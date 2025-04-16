-- Person table
CREATE TABLE People (
    PersonID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    SpouseName VARCHAR(100)
);

insert into People (PersonID, Name, Address, SpouseName)
values (100, 'Roger Moore', 'Sherwood House', 'Kristina Tholstrup'),
		(101, 'Guy Hamilton', 'Ya Mamas House', 'Kerima' ),
		(102, 'Lewis Gilbert', '123 British Ave', 'Hylda Tafler'),
		(103, 'John Glen', '456 Beans on Toast Rd', 'Mary Anne Glen');

-- Actor table (Subtype of People)
CREATE TABLE Actor (
    PersonID INT PRIMARY KEY,
    BirthDate DATE,
    HairColor VARCHAR(50),
    EyeColor VARCHAR(50),
    Heightin INT,
    Weightlbs INT,
    FavoriteColor VARCHAR(50),
    SAGAnniversaryDate DATE,
    FOREIGN KEY (PersonID) REFERENCES People(PersonID)
);

insert into Actor (PersonID, BirthDate, HairColor, EyeColor, Heightin, Weightlbs, FavoriteColor, SAGAnniversaryDate)
values (100, '10-14-1927', 'brown', 'blue', 73, 170, 'blue', '06-01-1969'),
	   (103, '05-15-1932', 'Brown', 'Blue', 70, 170, 'Blue', '01-01-1950');
		
-- Director table (Subtype of Person)
CREATE TABLE Director (
    PersonID INT PRIMARY KEY,
    FilmSchoolAttended VARCHAR(100),
    DirectorsGuildAnniversaryDate DATE,
    FavoriteLensMaker VARCHAR(100),
    FOREIGN KEY (PersonID) REFERENCES People(PersonID)
);

insert into Director (PersonID, FilmSchoolAttended, DirectorsGuildAnniversaryDate, FavoriteLensMaker)
values (100, 'NYU Tisch', '1985-09-15', 'Zeiss'),
		(101, 'London Film School', '01-01-1961', 'Zeiss'),
		(102, 'RADA', '01-01-1950', 'Cooke'),
		(103, 'Pinewood Training Program', '01-01-1975', 'Angénieux');
		
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

insert into Movie (MovieID, MovieName, ReleaseYear, MPAANumber, DomesticBoxOfficeSalesUSD, ForeignBoxOfficeSalesUSD, DVDBluRaySales)
values (200, 'The Spy Who Loved Me', 1977, 'MPAA12345', 18500000.00, 40000000.00, 5000000.00),
	   (201, 'A View to Kill', 1985, 'MPAA6789', 50327960.00, 102300000.00, 7000000),
	   (202, 'Christopher Columbus: The Discovery', 1992, 'MPAA4321', 8300000.00, 16000000.00, 1500000.00),
	   (203, 'Live and Let Die', 1973, 'MPAA9011', 35500000.00, 45000000.00, 12000000.00),
	   (204, 'The Man with the Golden Gun', 1974, 'MPAA9012', 28000000.00, 47000000.00, 9000000.00),
	   (205, 'MoonRaker', 1979, 'MPAA9013', 210000000.00, 530000000.00, 15000000.00),
	   (206, 'For Your Eyes Only', 1981, 'MPAA9014', 195000000.00, 380000000.00, 14000000.00),
	   (207, 'Octopussy', 1983, 'MPAA9015', 183000000.00, 410000000.00, 11000000.00);

-- Awards Table
CREATE TABLE Awards (
    PersonID INT,
    MovieID INT,
    Award VARCHAR(100),
    PRIMARY KEY (PersonID, MovieID, Award), -- composite key bc one actor cannot get same nom for same movie, but can have diff awards for same movie
    FOREIGN KEY (PersonID) REFERENCES People(PersonID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

insert into Awards (PersonID, MovieID, Award)
values (100, 201, 'Best Actor' ),
	   (103, 202, 'Worst Foreign Film');

-- Movie Participation Table
CREATE TABLE Participation (
    PersonID INT,
    MovieID INT,
    Role VARCHAR(50), -- e.g., 'Actor', 'Director', 'Producer', etc.
    PRIMARY KEY (PersonID, MovieID, Role),
    FOREIGN KEY (PersonID) REFERENCES People(PersonID),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);

insert into Participation (PersonID, MovieId, Role)
values (100, 200, 'Actor'),
	   (100, 201, 'Actor'),
	   (103, 202, 'Director');

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