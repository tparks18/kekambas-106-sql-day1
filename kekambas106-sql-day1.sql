-- "Hello World" of SQL - SELECT * gets you all records from the table

select * 
from actor;

--Query specific columns - SELECT column_name, ... FROM table_name

select first_name, last_name 
from actor;

--Change query order

select last_name, first_name 
from actor;

select *
from film;

--Filter rows - use the WHERE clause - always after the FROM 
select *
from actor
where first_name = 'Nick';

--Using the LIKE operator
select *
from actor
where first_name LIKE 'Nick';

-- Using the LIKE operagtor with % - % acts as awild card- can be any number of characters(o-infinity)
select *
from actor a where first_name like 'N%';

--Using the LIKE operator with _-_ acts as a wild card for one and only one character 
select *
from actor a where first_name like '_i_'; --any record that has a first_name of three letters with the second letter being i

--Using % and _ in the same pattern
select *
from actor a where first_name like '_i%';

--Using AND and OR in our WHERE clause
--OR - only one things need to be TRUE
select *
from actor
where first_name like 'N%' or last_name like 'W%';

--AND -- where all conditions have to be TRUE
select *
from actor
where first_name like 'N%' and last_name like 'W%';

--Comparing Operators in SQL:
--Greater Than(>) - Less Than(<)
--Greater Than or Equal to (>=) -- Less Than or Equal to (<=)
--Equal(=) -- Not Equal(<>).

select *
from payment;

--Query for all payments greater than $4
select customer_id, amount
from payment
where amount > '4';
--where amount > 4; works the same way because the column type is numeric

--Query for all payments that are not 7.99
select customer_id, amount
from payment
where amount <> 7.99;

--Get all of the payments between $3 and $8(inclusive)
select *
from payment
where amount >= 3 and amount <=8;

--BETWEEN/AND clause
select *
from payment
where amount between 3 and 8;

--Order our rows ofdata by using the order by clause (default ascending)
select *
from payment
where amount between 3 and 8
order by payment_date;

--descending
select *
from payment
where amount between 3 and 8
order by amount desc;

-- Ordering by Strings - alphabetical
select *
from actor
order by last_name;

--SQL Aggregations => SUM(), AVG(), COUNT(), MIN(), MAX()
-- takes in a column_name as an argument a returns a value
--Get the sum of all the payments

select amount
from payment;

select sum(amount)
from payment;

-- Get the sum of all payments of more than $5
select sum(amount)
from payment
where amount > 5;

-- Get the average of all payments of more than $5
select avg(amount)
from payment
where amount > 5;

--Count the amount of payments
select count(amount)
from payment
where amount > 5;

--count all
select count(*)
from payment
where amount > 5;

-- get the min and max of payments
select min(amount)
from payment;

--min with aliasing
select min(amount) as lowest_amount_paid
from payment;

--max with aliasing
select max(amount) as highest_amount_paid
from payment;

--Calculate a column based on two other columns
select payment_id - rental_id as difference
from payment;

select payment_id, rental_id, payment_id - rental_id as difference
from payment;

--select f.title, f.description, a.first_name, a.last_name
--from film f
--join film_actor fa
--on f.film_id = fa.film_id 
--join actor a
--on a.actor_id = fa.actor_id;
--
--SELECT film.title, film.description, actor.first_name, actor.last_name
--FROM film
--JOIN film_actor
--ON film.film_id = film_actor.film_id
--JOIN actor
--ON actor.actor_id = film_actor.actor_id;

-- Query the number of payments per amount
select count(*)
from payment
where amount = 2.99

select count(*)
from payment
where amount = 3.99

select count(*)
from payment
where amount = 4.99

-- GROUP BY clause - used aggregrations
select amount, count(*)
from payment
group by amount;

select amount, count(*), sum(amount), avg(amount)
from payment
group by amount;

-- Using group buys with everything from the select
select amount, customer_id, count(*)
from payment
group by amount; --throws error "payment.customer_id" must appear in the GROUP BY clause or be used in an aggregate function

--correct way
select amount, customer_id, count(*)
from payment
group by amount, customer_id;

-- Query the payment table to display the customers who spent the most
select customer_id, sum(amount)
from payment
group by customer_id
order by sum(amount) desc;

select * from payment order by customer_id;

--alias our aggregation column and use aliased name in order by
select customer_id, sum(amount) as total_spent
from payment
group by customer_id
order by total_spent desc;

--Query the payment table to display customers who have spent the most, but they have made at least 40 payments
select customer_id, sum(amount) as total_spent
from payment
group by customer_id
having count(*) >= 40
order by total_spent desc;

-- LIMIT and OFFSET clause
-- LIMIT - limits the number of rows that are returned

select *
from film
limit 10;

--OFFSET - start your rows after a certain amount using OFFSET
select *
from actor
offset 10;

--OFFSET and LIMIT together
select *
from actor offset 10
limit 5;

--Putting all the clauses into one query
-- display customers 11-20 who have spent the most in under 20 payments
--and the customer id has to be greater than 3

select customer_id, sum(amount), count(*)
from payment
where customer_id > 3
group by customer_id
having count(*) < 20
order by sum(amount)
offset 10
limit 10;

-- Syntax order (SELECT and FROM are the only mandatory keywords):
--select
--from
--join
--on
--where 
--group by 
--having
--order by 
--offset 
--limit