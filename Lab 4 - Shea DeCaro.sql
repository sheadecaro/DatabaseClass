--Lab 4 Start--

--Q1- people data for people who are customers--
select *
from People
where pid in (
	select pid
	from Customers
);

--Q2- people data for people who are agents--
select *
from People
where pid in (
	select pid
	from Agents
);

--Q3- people data for ppl who are both cust and agents-
select *
from People
where pid in (
	select pid
	from Customers
	intersect
	select pid
	from Agents
);

--Q4- people data for ppl who are neither cust nor agents--
select *
from People
where pid not in (select pid
				  from Customers)
and pid not in (select pid
				from Agents);

--Q5- id of cust who ordered p01 or p03-
select distinct pid --distinct used so pid only shown once--
from Customers
where pid in (select custID
				 from Orders
				 where prodID in ('p01', 'p03')
order by pid ASC); --ASC is ascending order--

--Q6- Id of cust who orderd bot p01 & p03--
select distinct pid
from Customers
where pid in (select custID
			  from Orders
			  where prodID in ('p01'))
and pid in (select custID
			from Orders
			where prodID in ('p03'))
order by pid DESC;

--Q7- first and last name of agents sold p05 or p07--
select firstName, lastName
from People
where pid in (select pid
			  from Agents)
and pid in (select agentID
				  from Orders
				  where prodID in ('p05', 'p07'))
order by lastname ASC;

--Q8- home city and DOB of agents who book ord. for cust w/ pid 7--
select homeCity, DOB
from People
where pid in (select pid
			  from Agents
				intersect --intersect is my friend--
			  select agentID
			  from Orders
			  where custID = 7)
order by homeCity DESC;

--Q9- prodID ordered through agents where >=1 ord is from Saginaw--
select distinct prodID --unique product ID
from Orders
where agentID in (select pid
				 from Agents
				 where pid in ( --Agents that take at least one order from cust
					select agentID
					from Orders
					where custID in ( --customers in Saginaw
						select pid
						from People
						where homeCity = 'Saginaw'
						)
					)
				 )
order by prodID DESC;

--Q10- last name and home city of cust whose agents are from Pinn and Regina
select lastName, homeCity
from People
where pid in (select pid --pid of customers who can place orders
				  from Customers
				  where pid in (
						select custID --custid of customers who HAVE placed orders
						from Orders
						where agentID in (
							select pid --Agents from regina and pinner
							from People
							where homeCity in ('Regina', 'Pinner')
						)
				  	 )
				  )
order by lastName ASC;