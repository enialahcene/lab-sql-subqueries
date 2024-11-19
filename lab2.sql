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

SELECT 
    a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
    a.actor_id, a.first_name, a.last_name
ORDER BY 
    film_count DESC
LIMIT 1;


SELECT 
    f.title
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
WHERE 
    fa.actor_id = most_prolific_actor_id;


SELECT 
    c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_spent DESC
LIMIT 1;


SELECT 
    f.title
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    r.customer_id = most_profitable_customer_id;


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







	