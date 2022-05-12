/*Lab | SQL Join (Part I)
In this lab, you will be using the Sakila database of movie rentals.

Instructions
How many films are there for each of the categories in the category table. Use appropriate join to write this query.
Display the total amount rung up by each staff member in August of 2005.
Which actor has appeared in the most films?
Most active customer (the customer that has rented the most number of films)
Display the first and last names, as well as the address, of each staff member.
List each film and the number of actors who are listed for that film.
Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
List number of films per category.*/
use sakila;
-- 1)How many films are there for each of the categories in the category table. Use appropriate join to write this query.
select * from category;
select * from film_category;
SELECT name as cat_name , COUNT(film_id) as "number of films"
FROM sakila.category as cat
right JOIN sakila.film_category as f
ON cat.category_id = f.category_id
GROUP BY cat_name
order by count(film_id) desc;


-- 2)Display the total amount rung up by each staff member in August of 2005.
select * from staff;
select * from payment;
select first_name as first, last_name as last, sum(amount) as "total rung up amount"
from staff as st
right join payment as pay
on st.staff_id=pay.staff_id
group by first_name
order by sum(amount);
-- OR JUST TO PRACTICE SYNTAX:
select st.first_name as first, st.last_name as last, sum(pay.amount) as "total rung up amount"
from staff as st
right join payment as pay
on st.staff_id=pay.staff_id
group by st.first_name
order by sum(pay.amount);

-- 3) Which actor has appeared in the most films?
select * from actor;
select * from film_actor;
select first_name as first, last_name as last, count(film_id) as "number of movies"
from actor as actor
right join film_actor as starring
on actor.actor_id=starring.actor_id
group by first_name
order by count(film_id) desc
limit 1;

-- OR ANOTHER WAY.. JUST TO PRACTICE
select first_name as first, last_name as last, count(film_id) as "number of movies",
rank () over(order by count(film_id) desc) as ranking
from actor as actor
right join film_actor as starring
on actor.actor_id=starring.actor_id
group by first_name
limit 1;

-- 4) Most active customer (the customer that has rented the most number of films)
select * from customer;
select * from rental;
select first_name as first, last_name as last, count(rental_id) as "number of rentals"
from customer as cust
right join rental as rent
on cust.customer_id=rent.customer_id
group by first_name
order by count(rental_id) desc
limit 1;

-- 5) Display the first and last names, as well as the address, of each staff member.
select * from staff;
select * from address;
select first_name as first, last_name as last, address as "staff address"
from staff as st
left join address as ad
on st.address_id=ad.address_id
group by first_name
order by last_name;

-- 6) List each film and the number of actors who are listed for that film.
select * from film;
select * from film_actor;
select title as film_title, count(actor_id) as "number of actors/actress"
from film as f
left join film_actor as fi_ac
on f.film_id=fi_ac.film_id
group by title
order by count(actor_id) desc;

-- 7) Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
select * from customer;
select * from payment;
select first_name as first, last_name as last, sum(amount) as "total amount paid (cad)"
from customer as cust
right join payment as pay
on cust.customer_id=pay.customer_id
group by first_name
order by last_name asc;

-- 8) List number of films per category
-- i think this is a repition of question 1
select * from category;
select * from film_category;
SELECT name as cat_name , COUNT(film_id) as "number of films"
FROM sakila.category as cat
right JOIN sakila.film_category as f
ON cat.category_id = f.category_id
GROUP BY cat_name
order by count(film_id) desc;
