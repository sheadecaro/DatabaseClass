--Start of Lab 5--

--Q1- all ppl data for ppl who are customers using a join
select *
from People inner join Customers on People.pid = Customers.pid;

--Q2- all ppl data for ppl who are agents using a join
select *
from People inner join Agents on People.pid = Agents.pid;

--Q3- all ppl & Agent data for ppl who are cust & agents
select *
from People join Customers on People.pid = Customers.pid
			join Agents on People.pid = Agents.pid;

--Q4- first of cust who have never placed order. Subquery.
select pid, firstName
from People
where pid in (select pid
			  from Customers
			  where pid not in (
					select CustID
					from Orders
			  		)
			  );

--Q5- first of cust who have never placed an order using one inner & outer join
select firstName
from People inner join Customers on People.pid = Customers.pid
			 left outer join Orders on Customers.pid = Orders.custID
			 where Orders.custID is NULL;

--Q6- id and comm. % of Agents who book for cust w/ id 007.
select distinct pid, commissionPct
from Agents inner join Orders on Agents.pid = Orders.agentID
where Orders.custID = 007
Order By commissionPct DESC;

--Q7- lastname, homecity, commpct of agents who book for cust w/ id 001
select distinct lastName, homeCity, commissionPct
from People inner join Agents on People.pid = Agents.pid --FIRST FIND PPL WHO ARE AGENTS
			right outer join Orders on Agents.pid = Orders.agentID --NOW FIND AGENTS WHO PLACED ORDERS
			where Orders.custID = 001
Order By commissionPct DESC;

--Q8- lastname, homecity of agents who live in city w fewest different kind of product
select lastName, homeCity
from People inner join Agents on People.pid = Agents.pid
where homeCity in (
	select city
	from Products
	group by city
	having count(prodID) = (
		select min(qtyOnHand)
		from (
			select count (prodID) as qtyOnHand
			from Products
			group by city
		)
	)
)

--Q9- name and id of all prod ordered through agents who books >= 1 order for cust in Oyster Bay.
select distinct p.name, p.prodID --told me that it wasnt distinct enough until i added p. before name and prodid
from Products p inner join Orders o on p.prodid = o.prodid --make sure to add o. and p. before prodid
where o.agentID in (
		select o2.agentID --must make 02 to distinguish between first query and subquery
		from Orders o2 inner join People pe on o2.custID = pe.pid
		where pe.homeCity = 'Oyster Bay'
)
order by p.name ASC;

--Q10- firstName and lastName of cust and agents living in same city along with name of shared city.
select distinct p.firstName as custFirstName, --said leaving it only as "firstName" is ambiguous so make sure to laben with p or pe
			    p.lastName as custLastName, 
				pe.firstName as agentFirstName, 
				pe.lastName as agentLastName, 
				p.homeCity as sharedCity -- make sure to relabel so that the table makes more sense and you know who is who
from People p inner join Customers c on p.pid = c.pid
			  inner join People pe on pe.pid in (select distinct agentID
			  									  from Orders)
												where p.homeCity = pe.homeCity;
												

