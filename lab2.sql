SELECT 
    COUNT(*) AS number_of_copies
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    f.title = 'Hunchback Impossible';


SELECT
	title, length
FROM
	film
WHERE
	length > (SELECT AVG(length) FROM film);
    
SELECT 
    a.first_name, a.last_name
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
WHERE 
    fa.film_id = (SELECT f.film_id FROM film f WHERE f.title = 'Alone Trip');
    
SELECT 
    f.title
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
WHERE 
    c.name = 'Family';

SELECT 
    c.first_name, c.last_name, c.email
FROM 
    customer c
WHERE 
    c.address_id IN (
        SELECT a.address_id
        FROM address a
        JOIN city ci ON a.city_id = ci.city_id
        JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = 'Canada'
    );

SELECT actor_id, COUNT(film_id) AS films_count
FROM film_actor
GROUP BY actor_id
ORDER BY films_count DESC
LIMIT 1;
SELECT f.title
FROM film_actor fa
JOIN film f ON fa.film_id = f.film_id
WHERE fa.actor_id = most_prolific_actor_id;


SELECT customer_id 
FROM payment 
GROUP BY customer_id 
ORDER BY SUM(amount) DESC 
LIMIT 1;
SELECT film.title
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.customer_id = most_profitable_customer_id;


SELECT 
    c.customer_id, 
    SUM(p.amount) AS total_amount_spent
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id
HAVING 
    total_amount_spent > (
        SELECT AVG(total_spent) 
        FROM (
            SELECT 
                SUM(p.amount) AS total_spent
            FROM 
                customer c
            JOIN 
                payment p ON c.customer_id = p.customer_id
            GROUP BY 
                c.customer_id
        ) AS subquery
    );







	