------------------------------------------------------------------------------------------------------
-- PostgreSQL create, load, and query script for CAP v009.
--
-- Derived a long time ago from the CAP examples in _Database Principles, Programming, and Performance_,
--                                               Second Edition by Patrick O'Neil and Elizabeth O'Neil
--
-- Drastically modified and perverted for many years by Alan G. Labouseur, with a little help from my friends.
--
-- Tested on Postgres 16 (For versions < 10 you may need
-- to remove the "if exists" clause from the DROP TABLE commands.)
------------------------------------------------------------------------------------------------------

-- Connect to your Postgres server and set the active database to CAP ("\connect CAP" in psql). Then ...

DROP VIEW IF EXISTS PeopleCustomers;
DROP VIEW IF EXISTS PeopleAgents;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Agents;
DROP TABLE IF EXISTS People;

-- People --
CREATE TABLE People (
   pid         int not null,
   prefix      text,
   firstName   text,
   lastName    text,
   suffix      text,
   homeCity    text,
   DOB         date,
 primary key(pid)
);

-- Customers --
CREATE TABLE Customers (
   pid          int not null references People(pid),
   paymentTerms text,
   discountPct  decimal(5,2),
 primary key(pid)
);

-- Agents --
CREATE TABLE Agents (
   pid            int not null references People(pid),
   paymentTerms   text,
   commissionPct  decimal(5,2),
 primary key(pid)
);

-- Products --
CREATE TABLE Products (
  prodId    text not null,
  name      text,
  city      text,
  qtyOnHand int,
  priceUSD  numeric(10,2),
 primary key(prodId)
);

-- Orders --
CREATE TABLE Orders (
  orderNum        int     not null,
  dateOrdered     date    not null,
  custId          int     not null references Customers(pid),
  agentId         int     not null references Agents(pid),
  prodId          char(3) not null references Products(prodId),
  quantityOrdered integer,
  totalUSD        numeric(12,2),
 primary key(orderNum)
);


-- SQL statements for loading example data

-- People --
INSERT INTO People (pid, prefix,      firstName, lastName,       suffix,      homeCity,      DOB)
VALUES             (001, 'Mr.',       'Billy',   'Joel',         'Piano Man', 'Oyster Bay',  '1949-05-09'),
                   (002, 'Ms.',       'Renee',   'Rosnes',       NULL,        'Regina',      '1962-03-24'),
                   (003, 'Sir',       'Elton',   'John',         'Esq.',      'Pinner',      '1947-03-25'),
                   (004, 'Mr.',       'Reginald','Dwight',       '',          'Pinner',      '1947-03-25'),
                   (005, 'Mr.',       'Michael', 'McDonald',     NULL,        'St. Louis',   '1952-02-12'),
                   (006, 'Mr.',       'Ray',     'Charles',      'MD',        'in Georgia',  '1930-09-23'),
                   (007, 'Dr.',       'Stevie',  'Wonder',       'Ph.D.',     'Saginaw',     '1950-01-12'),
                   (008, 'Ms.',       'Yuja',    'Wang (王羽佳)', '',          'Beijing',     '1987-02-10'),
                   (010, 'Dr. (Hon)', 'Diana',   'Krall',        '',          'Nanaimo',     '1960-11-16');

-- Customers --
INSERT INTO Customers (pid, paymentTerms, discountPct)
VALUES                (001, 'Net 30'    , 21.12),
                      (004, 'Net 15'    ,  2.47),
                      (005, 'In Advance',  5.05),
                      (007, 'On Receipt',  2.00),
                      (010, 'Net 30'    , 10.01);

INSERT INTO Agents (pid, paymentTerms, commissionPct)
VALUES             (002, 'Quarterly',   5.00),
                   (003, 'Annually',   10.00),
                   (006, 'Monthly',     1.00),
                   (007, 'Weekly',      2.00);

-- Products --
INSERT INTO Products(prodId, name,                    city,     qtyOnHand, priceUSD)
VALUES              ('p01', 'Kurzweil PC2R',          'Dallas',        47,    67.76),
                    ('p02', 'Yamaha CP-80',           'Newark',      2399,    51.50),
                    ('p03', 'Apple //+',              'Duluth',      1979,    65.02),
                    ('p04', 'LCARS module',           'Duluth',         3,    17.01),
                    ('p05', 'Roland 808',             'Dallas',   8675309,    16.61),
                    ('p06', 'PDP-11 operator panel',  'Beijing',       88,    88.00),
                    ('p07', 'Flux Capacitor',         'Newark',      1007,     1.00),
                    ('p08', 'HAL 9000 memory chip',   'Newark',       200,     1.25),
                    ('p09', 'Oberheim OB-Xa',         'Regina',         1, 37900.42);

-- Orders --
INSERT INTO Orders(orderNum, dateOrdered,  custId, agentId, prodId, quantityOrdered,  totalUSD)
VALUES            (1011,     '2024-01-22',    001,     002, 'p01',             1100,  58794.00),
                  (1012,     '2023-01-23',    004,     003, 'p03',             1200,  76096.81),
                  (1015,     '2022-01-23',    005,     003, 'p05',             1000,  15771.20),
                  (1016,     '2021-01-23',    007,     003, 'p01',             1000,  66404.80),
                  (1017,     '2023-02-14',    001,     003, 'p03',              500,  25643.98),
                  (1018,     '2023-02-14',    001,     003, 'p04',              600,   8050.49),
                  (1019,     '2023-02-14',    001,     002, 'p02',              400,  16249.28),
                  (1020,     '2023-02-14',    004,     006, 'p07',              600,    585.18),
                  (1021,     '2023-02-14',    004,     006, 'p01',             1000,  66086.33),
                  (1022,     '2023-03-15',    001,     003, 'p06',              450,  31236.48),
                  (1023,     '2023-03-15',    001,     002, 'p05',              500,   6550.98),
                  (1024,     '2023-03-15',    005,     002, 'p01',              880,  56671.55),
                  (1025,     '2022-04-01',    007,     003, 'p07',              888,    870.24),
                  (1026,     '2022-05-04',    007,     006, 'p03',              808,  47277.29);


-- SQL statements for displaying this example data:
select *
from People;

select *
from Customers;

select *
from Agents;

select *
from Products;

select *
from Orders;

select totalusd
from Orders;

select lastname, homecity
from People where prefix = 'Ms.';

select prodid, name, qtyonhand
from Products where qtyonhand > 1007;

select firstname, homecity
from People where dob >= '1940-01-01' and dob < '1950-01-01';

select prefix, lastname
from People where prefix != 'Mr.';

select *
from Products where (city != 'Dallas' and city != 'Duluth'
			   and priceusd <= 17.00);

select *
from Orders
where extract(month from dateordered) = 1;


select *
from Orders
where extract(month from dateordered) = 2 
	  and totalusd >= 23000;

select *
from Orders
where custid = 010;


select *
from Orders
where custid = 005;




