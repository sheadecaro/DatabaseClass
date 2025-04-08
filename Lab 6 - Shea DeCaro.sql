--Start of Lab 6--

--Q1- display cities that make the most different kidns of products using rank
select city,
    rank() over (order by product_count desc) AS rank
from (select city, 
        count(distinct prodid) as product_count
    from Products
    group by city
);

--Q2- display name of product where price is < 1% of average priceUSD. A-Z
select name
from Products
where priceUSD < (
		select avg(priceUSD) * 0.01
		from Products
)
order by name ASC;

--Q3- display cust lastname, prodid ordered and totalUSD for all orders in march of any year
select p.lastName as customer_lastName,
	   o.prodId, 
	   o.totalUSD
from Orders o inner join People p on o.custId = p.pid
			  inner join Customers c on p.pid = c.pid
where extract(month from o.dateOrdered) = 3

order by totalUSD ASC;

--Q4- display name of all customers and total ordered by customer
select p.lastname,
    coalesce(sum(o.totalusd), 0)
from customers c inner join people p on c.pid = p.pid
			 	  left join orders o on c.pid = o.custid
group by p.lastname
order by p.lastname DESC;

--Q5- display names of all cust who bought from agents in regina, and names of prod and agents
select cust.firstName as customerFirst,
	   cust.lastName as customerLast,
	   agent.firstName as agentFirst,
	   agent.lastName as agentLast,
	   prod.name as productName
from Orders o inner join Customers c on o.custId = c.pid
			  inner join People cust on c.pid = cust.pid
			  inner join People agent on o.agentId = agent.pid
			  inner join Products prod on o.prodId = prod.prodId
where agent.homeCity = 'Regina';

--Q6- check accuracy of totalUSD in Orders. Calc orders.totalUSD & display all rows if any are incorrect.
select
    o.ordernum,
    o.quantityordered,
    p.priceUSD,
    o.totalusd,
    (o.quantityordered * p.priceUSD) as calculated_total
from orders o inner join products p on o.prodid = p.prodid
where round(o.totalusd::numeric, 2) <> round((o.quantityordered * p.priceUSD)::numeric, 2);


--Q7- display first and last name of all customers who are also agents
select p.firstName, p.lastName
from People p inner join Customers c on p.pid = c.pid
			  inner join Agents a on p.pid = a.pid;

--Q8- create view of all cust and ppl data and all agent and ppl data
create view PeopleCustomers as
select p.pid,
	   p.prefix,
	   p.firstName,
	   p.lastName,
	   p.suffix,
	   p.homeCity,
	   p.dob,
	   c.paymentTerms,
	   c.discountPct
from People p inner join Customers c on p.pid = c.pid;

create view PeopleAgents as 
select p.pid,
	   p.prefix,
	   p.firstName,
	   p.lastName,
	   p.suffix,
	   p.homeCity,
	   p.dob,
	   a.paymentTerms,
	   a.commissionPct
from People p inner join Agents a on p.pid = a.pid;

select *
from PeopleCustomers;

select *
from PeopleAgents;

--Q9- first & last of all cust who are agents using view from Q8
select pc.firstName, pc.lastName
from PeopleCustomers pc inner join PeopleAgents pa on pc.pid = pa.pid

--Q10- output is the same for no views and with views, how does that work & what is the database doing internally
--how it works is that in #7 we are joining the tables directly from the CAP
--database and then cross examine to see if pid is in both agents and customer tables,
--whereas in #9, it does the same thing but in a cleaner way because it is still comparing
--pid in the views the same way it is comparing them in the tables. 

--Q11- [bonus] what is the difference btwn left outer join & right outer join