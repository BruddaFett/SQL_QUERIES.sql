/*		Q1
*/
SELECT 
	COUNT(rental_date) AS RentalCount,
    	rental_date 	   AS `Date`
FROM rental
GROUP BY rental_date
HAVING RentalCount > 100;



/*		Q2
*/

SELECT 
	CONCAT(last_name,', ', first_name) AS Staff,
	DATE_FORMAT(rental_date, '%e-%b-%y') AS `Date`,
    	COUNT(rental_date) AS RentalCount
FROM staff
	JOIN rental USING (staff_id)
GROUP BY Staff, `Date`
ORDER BY last_name, rental_date ASC;



/*		Q3
*/

SELECT 
	SUM(amount) AS Total,
    	DATE_FORMAT(payment_date, '%b-%y') AS YearMonth, 
	COUNT(payment_date) AS 'Payment Count'
FROM payment
GROUP BY YearMonth
ORDER BY payment_date DESC;



/*		Q4
*/

SELECT 
	CONCAT(last_name,', ',first_name) AS Customer, 
	district AS District, 
    	COUNT(payment_id) AS'Payments', 
    	SUM(amount) AS Total
FROM payment
	JOIN customer USING (customer_id)
    	JOIN address  USING (address_id)
GROUP BY customer
HAVING SUM(amount) >= 150
ORDER BY Customer ASC;



/*		Q5
*/

SELECT COUNT(film_id) AS FilmsCount, `name`
FROM film
	JOIN film_category USING (film_id)
    	JOIN category USING (category_id)
GROUP BY `name`
HAVING FilmsCount > 60;



/*		PART 02
							
		Q6
subquery*/

SELECT city
FROM city
WHERE country_id IN
	(SELECT country_id
	FROM country
	WHERE country LIKE '%united%') AND city LIKE '%south%'
ORDER BY city;



/*		Q7
*/

SELECT 
	/*amount,*/
    customer_id,
    CONCAT(first_name,' ', last_name) AS Customer, 
    email
FROM customer
	JOIN payment USING (customer_id)
WHERE amount IN	
    (SELECT amount
	FROM payment
	WHERE amount >= 10);


/*		Q8
*/

SELECT 
	DISTINCT(`name`), film_id, length
FROM category
	JOIN film ON (category_id)
WHERE length > 180
HAVING length IN
	(SELECT film_id
FROM film);

/*		Q9		
*/

SELECT city 
FROM city 
WHERE city IN
	(SELECT city
	FROM film
		JOIN inventory USING (film_id)
		JOIN store USING (store_id)
		JOIN address USING (address_id)
		JOIN city USING (city_id)
	WHERE title LIKE '%airplane sierra%')
GROUP BY city;



/*	
	original query

SELECT city
FROM film
	JOIN inventory USING (film_id)
    JOIN store USING (store_id)
    JOIN address USING (address_id)
	JOIN city USING (city_id)
WHERE title LIKE '%airplane sierra%'
GROUP BY city;

	mini query

SELECT DISTINCT(city), city_id
FROM city;
*/

/*		Q 10
*/

SELECT postal_code 	   AS 'Postal Code', 
	COUNT(postal_code) AS 'PostalCount'
FROM address
WHERE postal_code IN
	(SELECT postal_code
	FROM address
	HAVING COUNT(postal_code) > 1 OR AVG(postal_code) = 2) AND postal_code <> '' 
GROUP BY postal_code;
