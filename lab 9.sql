Create table People (
	personID INT Primary key,
	firstName VARCHAR(100) NOT NULL,
	lastName VARCHAR(100) NOT NULL,
	address VARCHAR(200) NOT NULL,
	phoneNumber VARCHAR(30),
);

Create Table Players (
	personID INT Primary Key,
	teamID INT,
	foreign key (personID) references People(personID),
	foreign key (teamID) references Teams(teamID)
);

Create Table Coaches (
	personID INT Primary Key,
	coachID INT Primary Key,
	yearsofEXP INT,
	foreign key (personID) references People(personID)
);

Create Table Teams (
	teamID INT Primary Key,
	teamName VARCHAR(150),
	agegroupID INT,
	foreign key (agegroupID) references AgeGroup(agegroupID)
);

Create Table AgeGroup (
	agegroupID INT Primary Key,
	groupName VARCHAR(200),
	minAge INT,
	maxAge INT
);

Create Table TeamCoach (
	teamID INT,
	coachID INT,
	Role VARCHAR(20) --Either assistant or head coach
	primary key (teamID, coachID),
	foreign key (teamID) references Teams(teamID),
	foreign key (coachID) references Coaches(coachID)
);


--convince you that my table is in BCNF? Easy
--
--The People table has a primary key (personID) in which all 
--the other attributes are functionally dependent on it.
--The Players table also has personID as the primary key, and the teamID depends
--on the personID. There are also NO partial or transitive dependencies.
--The coach table has personID as the primary key, and the years of experience is
--dependent on the personID.
--The Team table has teamID as the primary key, and the team name and agegroupID are dependent on the
--primary key.
--The age group table has agegroupID as the primary key, where all of the other attributes 
--are fully dependent on it.
--and finaly, the teamcoach table has a composite primary key, where the role is
--fully dependent on the key. 
--therefore, all tables have clearly defines primary keys, has attributes that are fully functionally
--dependent on those keys, and there are no transitive or partial dependencies.
--TA DA! BCNF fulfilled.













