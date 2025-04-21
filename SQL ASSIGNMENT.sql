/*                SQL  Assignment
Q1 . Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).
Write the SQL query to create the above table with all constraints.  */
CREATE DATABASE IF NOT EXISTS employee_data;
USE employee_data;
CREATE TABLE employees (
emp_id INTEGER PRIMARY KEY NOT NULL,
emp_name TEXT NOT NULL, 
age INTEGER CHECK (age >= 18),
email TEXT NOT NULL, 
salary DECIMAL DEFAULT 30000 ,
UNIQUE KEY (email(100)) 
); 
USE employee_data;
SELECT   *  FROM  employees;


/* Q2. Explain the purpose of constraints and how they help maintain data integrity 
     in a 	database. 	Provide examples of common types of constraints.

	Purpose of Constraints in a Database
	Constraints in a database are rules enforced on data to ensure accuracy, consistency, 
    and reliability. They help 	maintain data integrity by preventing invalid or 
    inconsistent data from being entered into tables. Without 	constraints, databases 
    may contain duplicate, incomplete, or incorrect information, leading to data corruption 
	and unreliable queries.
	How Constraints Maintain Data Integrity
    1. Preventing Invalid Data Entry 
      Constraints ensure that only valid and meaningful data is inserted into the database.
    2. Maintaining Relationships 
       Constraints enforce relationships between tables, preserving referential integrity.
    3. Avoiding Duplicates 
      Certain constraints prevent duplicate records from being stored.
    4. Ensuring Required Values 
        Some constraints mandate that certain fields must always have a value.
	Common Types of Constraints 
      1. Primary Key (PK)
        ◦ Ensures that each row in a table has a unique identifier.
        ◦ Example:
	CREATE TABLE Employees (
	    EmployeeID INT PRIMARY KEY, 
	    Name VARCHAR(100) 
	    ); 
        ◦ Prevents duplicate EmployeeID values and disallows NULL. 
	
	  2. Foreign Key (FK)
        ◦ Enforces referential integrity by ensuring that a value in one table must exist in another referenced table.
        ◦ Example:
		CREATE TABLE Orders ( 
		    OrderID INT PRIMARY KEY, 
		    CustomerID INT, 
		    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) 
		); 

        ◦ Ensures that CustomerID in Orders must exist in the Customers table. 

	  3. Unique Constraint
        ◦ Ensures that a column has only unique values (but allows NULL unless specified 
                         otherwise).
        ◦ Example:
		CREATE TABLE Users ( 
		    UserID INT PRIMARY KEY, 
		    Email VARCHAR(255) UNIQUE 
                          ); 
        ◦ Prevents multiple users from having the same email. 
        
	  4. Not Null Constraint
        ◦ Ensures that a column cannot contain NULL values.
        ◦ Example:
		CREATE TABLE Products ( 
	               ProductID INT PRIMARY KEY, 
	                ProductName VARCHAR(100) NOT NULL
	               ); 

        ◦ Ensures that every product must have a ProductName.
        ◦  
	  5. Check Constraint
        ◦ Ensures that values in a column meet a specific condition.
        ◦ Example:
		CREATE TABLE Accounts (
		 AccountID INT PRIMARY KEY, 
		 Balance DECIMAL(10,2) CHECK (Balance >= 0) 
		); 

       • Prevents negative balances. 

	 6. Default Constraint
        ◦ Assigns a default value to a column if no value is provided.
        ◦ Example:
		CREATE TABLE Orders ( 
		   OrderID INT PRIMARY KEY, 
		   Status VARCHAR(50) DEFAULT 'Pending'
		 ); 
    • If no status is provided, the default value will be 'Pending'. 
Conclusion
Constraints play a crucial role in maintaining database integrity by enforcing rules on
 data 	storage and 	relationships. They help prevent inconsistencies, ensuring that
  data remains 	accurate, structured, and 	meaningful.
  
/* 



Q3. Why would you apply the NOT NULL constraint to a column? Can a primary key 	contain  NULL values? Justifyyour answer.

    Why Apply the NOT NULL Constraint to a Column?
	The NOT NULL constraint is applied to a column to ensure that it cannot store 
     NULL values. 	This is useful 	in scenarios where a value is always required
	for a particular attribute. Some 	key reasons for using NOT 	NULL include:
    1. Data Integrity: Ensures that critical fields 
          (e.g., customer name, email, or order date) are always populated.
    2. Prevention of Inconsistencies: Helps avoid incomplete records, 
          which could lead to logical errors in applications.
    3. Index and Performance Benefits: Indexed columns with NULL values may have
         performance drawbacks.
    4. Avoiding Unexpected Errors: Some operations (like arithmetic or comparisons) 
          may behave unpredictably with NULL values.
  Can a Primary Key Contain NULL Values?
	No, a primary key cannot contain NULL values.
                   	Justification:
    1. Uniqueness Requirement: A primary key uniquely identifies each row in a table.
       If NULL were allowed, multiple rows could have NULL in the primary key column, 
           violating uniqueness.
    2. Implicit NOT NULL Constraint: When a primary key is defined, the database 
             automatically applies a NOT NULL constraint to ensure every row has a valid, 
               non-null identifier.
    3. Logical Reasoning: NULL represents the absence of a value. A primary key must always 
          have a value to function as a unique identifier.
    4. Relational Integrity: Foreign keys reference primary keys. Allowing NULL in a 
        primary key could break relationships and cause referential integrity issues.
	Thus, in SQL, a primary key must always be unique and non-null to maintain the 
        integrity and functionality 	of the database.
       
       
       
Q 4. Explain the steps and SQL commands used to add or remove constraints on an existing 	table. Provide an example for both adding and removing a constraint.

	Adding a Constraint
	To add a constraint to an existing table, use:
	ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_type 	(column_name); 
	
	Example: Adding a UNIQUE Constraint
	Assume you have a Customers table:
	CREATE TABLE Customers ( 
	   CustomerID INT PRIMARY KEY, 
	   Name VARCHAR(100), 
	   Email VARCHAR(255) 
	   ); 
          
  	Now, you want to ensure that the Email column is unique: 

	ALTER TABLE Customers 
	ADD CONSTRAINT unique_email UNIQUE (Email); 

	This ensures no two customers can have the same email.

           	Removing a Constraint
	To remove a constraint, use:
	ALTER TABLE table_name 
	DROP CONSTRAINT constraint_name; 

    Example: Removing the UNIQUE Constraint
	To remove the unique_email constraint:
    
	ALTER TABLE Customers 
	DROP CONSTRAINT unique_email; 
    
	This allows duplicate values in the Email column. 		
     Special Cases
    1. Dropping a PRIMARY KEY: If the primary key has dependencies (e.g., foreign keys), those must be removed first.
	ALTER TABLE Customers 
	DROP CONSTRAINT Customers_pkey; 

    2. Dropping a NOT NULL Constraint (varies by database, but commonly done with
	ALTER COLUMN): 

	ALTER TABLE Customers 
	ALTER COLUMN Email DROP NOT NULL; 
    

Q5. Explain the consequences of attempting to insert, update, or delete data in a 	way 	that 	violates constraints. 
	Provide an example of an error message that might occur when violating a constraint.

	When attempting to insert, update, or delete data in a way that violates database 	constraints, the 	database management system (DBMS) will reject the operation and 	return an error. The 	consequences depend on the type of constraint being violated. 	
	Here are some common constraints and their effects:
        ◦   Primary Key Violation
        ◦ Occurs when trying to insert a duplicate value in a primary key column.
        ◦ Consequence: The insertion fails.
        ◦ Example Error Message:
		ERROR: duplicate key value violates unique constraint "users_pkey" 
		DETAIL: Key (id)=(101) already exists. 

            ▪ Foreign Key Violation
        ◦ Occurs when inserting or updating a record with a foreign key value that does not exist in the referenced table.
        ◦ Consequence: The operation is rejected.

        ◦ Example Error Message:
			ERROR: insert or update on table "orders" violates foreign key constraint 					"orders_customer_id_fkey"
			DETAIL: Key (customer_id)=(500) is not present in table "customers". 

            ▪ Unique Constraint Violation
        ◦ Occurs when inserting or updating a value in a column that is supposed to have unique values.
        ◦ Consequence: The operation is not allowed.
        ◦ Example Error Message:
			RROR: duplicate key value violates unique constraint "users_email_key" 					DETAIL: Key (email)=(example@email.com) already exists. 

            ▪ Not Null Constraint Violation
        ◦ Occurs when trying to insert a NULL value into a column defined as NOT NULL.
        ◦ Consequence: The operation is blocked.
        ◦ Example Error Message:
			ERROR: null value in column "name" violates not-null constraint 
			DETAIL: Failing row contains (NULL, user@example.com). 

            ▪ Check Constraint Violation
        ◦ Occurs when inserting or updating data that does not meet a defined condition (e.g., age must be greater than 18).
        ◦ Consequence: The update or insertion is rejected.
        ◦ Example Error Message:
		ERROR: new row for relation "employees" violates check constraint "employees_age_check" 
		DETAIL: Failing row contains (John Doe, 16). 
        ◦ Referential Integrity Violation (Cascade Issues) 
        ◦ Occurs when trying to delete a record that is referenced by a foreign key in another table (without ON DELETE CASCADE).
        ◦ Consequence: The deletion fails.
        ◦ Example Error Message:
			ERROR: update or delete on table "departments" violates foreign key
                    constraint 	"employees_department_id_fkey" on table "employees" 
			DETAIL: Key (id)=(5) is still referenced from table "employees". 
	
    Conclusion
	Violating database constraints ensures data integrity but prevents invalid 
    operations.	To avoid errors,developers should validate data before performing 
    operations, Use transactions, and handle exceptions gracefully in their applications.


Q6. You created a products table without constraints as follows:
	CREATE TABLE products (
	product_id INT,
	product_name VARCHAR(50),
	price DECIMAL(10, 2));
	Now, you realise that?
	: The product_id should be a primary keyQ
	: The price should have a default value of 50.0
*/
CREATE DATABASE assignment;
USE assignment;
CREATE TABLE products(
product_id INT,
product_name VARCHAR(50),
price DECIMAL(10,2)
);

ALTER TABLE products 
ADD CONSTRAINT pk_products PRIMARY KEY (product_id),
ALTER COLUMN price SET DEFAULT 50.00; 
/*
Q7 you have two tables  students and classes    */
-- creating DATABASE assignment
USE assignment;
-- creating students table in assnment DATABASE
CREATE TABLE students(
student_id INT NOT NULL,
student_name VARCHAR(50) NOT NULL,
class_id INT NOT NULL
);
INSERT INTO students (student_id, student_name,class_id)
VALUES 
    (1,'Alice',101),
	(2,'Bob',102),
    (3,'Charlie',101);
 SELECT * FROM  students;
 
-- creating 'classes' table in 'assnment' DATABASE
USE assignment;
CREATE TABLE classes(
class_id INT NOT NULL,
class_name VARCHAR(50) NOT NULL
);
INSERT INTO classes (class_id, class_name)
VALUES 
    (101,'Math'),
	(102,'Sciance'),
    (103,'History');
 SELECT * FROM  classes;
 
 -- Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
SELECT students.student_name, classes.class_name
FROM students
INNER JOIN classes ON students.class_id = classes.class_id;


/* 
Q 8. Consider the following three tables 'orders', 'customers' and 'products'
*/         
-- creating 'Orders' table in 'assnment' DATABASE
USE assignment;
CREATE TABLE orders (
order_id INT ,
order_date DATE,
customer_id INT 
);
INSERT INTO orders (order_id, order_date, customer_id)
VALUES 
    (1, '2024-1-1' ,101),
	(2, '2024-1-3' ,102);
SELECT * FROM  orders;
-- creating 'customers' table in 'assnment' DATABASE
USE assignment;
CREATE TABLE customers (
customer_id INT ,
customer_name VARCHAR(50) 
);
INSERT INTO customers ( customer_id, customer_name)
VALUES 
    (101, 'Alice' ),
	(102, 'Bob' );
SELECT * FROM  customers;
-- creating 'product' table in 'assnment' DATABASE
USE assignment;
CREATE TABLE product (
product_id INT ,
product_name VARCHAR(50),
order_id INT 
);
INSERT INTO product ( product_id, product_name,order_id)
VALUES 
    (1, 'Laptop',1 ),
	(2, 'Phone', NULL );
select * from product;

/*Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
	listed even if they are not associated with an order
	Hint: (use INNER JOIN and LEFT JOIN) */
USE assignment;
SELECT 
	o.order_id,
    p.product_id,
    p.product_name,
    c.customer_name
FROM product p
LEFT JOIN orders o  ON p.order_id = o.order_id
LEFT JOIN customers c ON o.customer_id = c.customer_id;

/*
Q9  Given the following tables */
  -- creating 'sales' table in 'assnment' DATABASE
USE assignment;
CREATE TABLE sales (
sales_id INT ,
product_id INT, 
amount DECIMAL(10,2)
);
INSERT INTO sales (sales_id, product_id, amount)
VALUES 
    (1, 101 ,500),
	(2, 102 ,300),
    (3, 101 ,700);
SELECT * FROM sales;
-- creating 'products1' table in 'assnment' DATABASE
USE assignment;
CREATE TABLE products1 (
product_id INT ,
product_name VARCHAR(50) 
);
INSERT INTO products1 ( product_id, product_name)
VALUES 
    (101, 'Laptop' ),
	(102, 'Phone' );
select * from products1;
-- Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
select 
 products1.product_name,
 SUM(sales.amount) as total_sales_amount 
 from sales
 inner join products1 on  sales.product_id = products1.product_id
 group by products1.product_name;
 
 /*
 Q 10. You are given three tables 
 */
 select * from orders;
 select * from customers;
 create table order_detail(
	order_id INT,
    product_id INT,
    quantity INT
    );
  INSERT INTO order_detail(order_id, product_id, quantity)
  VALUES 
    (1, 101 ,2),
	(1, 102 ,1),
    (2, 101 ,3);  
select * from order_detail;
/* Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.*/
SELECT 
    o.order_id, 
    c.customer_name, 
    od.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_detail od ON o.order_id = od.order_id;

/*
						SQL Commands
Q1 Identify the primary keys and foreign keys in maven movies db. Discuss the differences                       

	Primary Keys (PKs) and Foreign Keys (FKs) in Maven Movies DB
	1. film Table

    Primary Key: film_id
    Foreign Keys: None (but other tables reference film_id)

	2. customer Table

    Primary Key: customer_id
    Foreign Keys: store_id (references store table)

	3. rental Table

    Primary Key: rental_id
    Foreign Keys:
        customer_id (references customer table)
        inventory_id (references inventory table)
        staff_id (references staff table)

	4. inventory Table

    Primary Key: inventory_id
    Foreign Keys:
        film_id (references film table)
        store_id (references store table)

	5. payment Table

    Primary Key: payment_id
    Foreign Keys:
        customer_id (references customer table)
        rental_id (references rental table)
        staff_id (references staff table)

	6. actor Table

    Primary Key: actor_id
    Foreign Keys: None (but film_actor links actors to films)

	7. film_actor Table (Many-to-Many Relationship between film and actor)

    Primary Key: (actor_id, film_id) → Composite PK
    Foreign Keys:
        actor_id (references actor table)
        film_id (references film table)

	8. film_category Table (Links film to category)

    Primary Key: (film_id, category_id) → Composite PK
    Foreign Keys:
        film_id (references film table)
        category_id (references category table)

	9. store Table

    Primary Key: store_id
    Foreign Keys:
        manager_staff_id (references staff table)

	10. staff Table

    Primary Key: staff_id
    Foreign Keys:
        store_id (references store table)

	Difference Between Primary Key and Foreign Key

	Feature	                      Primary Key (PK)	                              Foreign Key (FK)
	Definition	            Uniquely identifies each record in a table	      Establishes a relationship between two tables
	Uniqueness	            Always unique, no duplicate values allowed	      Can have duplicate values
	Null Values	           Cannot be NULL	                                  Can be NULL (depending on business rules)
	Reference	           Exists within a single table	                      Refers to a primary key in another table
	Example	               film_id in the film table	                      film_id in the inventory table (references film)
    */
    
    
-- Q2 List all details of actors   
   show databases;
   use mavenmovies;
    -- show tables;
    select 
      a. actor_id, 
      a.first_name, 
      a.last_name, 
	  b.awards,
      c.film_info
   from actor a   
   left join actor_award b on a.actor_id = b.actor_id
   left join actor_info c on b.actor_id = c.actor_id ;

/*
Q3 List all customer information from DB.
*/
use mavenmovies;
select 
  a.customer_id,
  b.name,
  b.phone,
  a.email,
  b.address,
  b.`zip code`,
  b.city,
  b.country,
  a.store_id,
  a.create_date,
  a.last_update
  from customer a
  left join customer_list b on a.customer_id = b.ID ;
  
  /*
  Q4 List different countries
  */
  use mavenmovies;
  select * from country;
  
   /*
  Q5 Display all active customers
  */
  use mavenmovies;
  select 
  a.customer_id,
  a.active,
  b.name,
  b.phone,
  a.email,
  b.address,
  b.`zip code`,
  b.city,
  b.country,
  a.store_id,
  a.create_date,
  a.last_update
  from customer a
  left join customer_list b on a.customer_id = b.ID 
  where a.active = 1 ;
  
  
   /*
  Q6 List of all rental IDs for customer with ID 1.
  */
   use mavenmovies;
  select rental_id , customer_id from rental
  where customer_id =1 ;
  
  /*
  Q7  Display all the films whose rental duration is greater than 5 
  */
  use mavenmovies;
  select * from film;
  select film_id, title , rental_duration from film
  where rental_duration > 5 ;
 /*
  Q8  List the total number of films whose replacement cost is greater than $15 and less than $20.
 */
 use mavenmovies;
  select * from film;
 select film_id, title , replacement_cost from film
 where replacement_cost between 15 and  20;
 SELECT COUNT(replacement_cost) 
 FROM film
 WHERE replacement_cost between 15 and  20;
/*
  Q9 Display the count of unique first names of actors
 */ 
use mavenmovies;
select * from actor;
select count(distinct first_name) from actor;

/*
Q10  Display the first 10 records from the customer table
 */ 
use mavenmovies;
select * from customer limit 10;

/*
Q11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
 */ 
use mavenmovies;
select * from customer 
where first_name like 'B%' 
limit 3;

/*
Q12 - -Display the names of the first 5 movies which are rated as ‘G
 */ 
use mavenmovies;
select * from film
where rating like 'G' 
limit 5;
 
 /*
Q13 Find all customers whose first name starts with "a".
 */ 
use mavenmovies;
select * from customer
where first_name like 'a%' ; 

 /*
Q14 Find all customers whose first name ends with "a".
 */ 
use mavenmovies;
select * from customer
where first_name like '%a' ; 
 
  /*
Q15 Display the list of first 4 cities which start and end with ‘a’ 
 */ 
use mavenmovies;
select * from city
where city like 'a%a' ; 
 
 /*
Q16  Find all customers whose first name have "NI" in any position
 */ 
use mavenmovies;
select * from customer
where first_name like '%NI%' ; 

/*
Q17   Find all customers whose first name have "r" in the second position .
 */ 
use mavenmovies;
select * from customer
where first_name like '_r%' ; 

/*
Q18   Find all customers whose first name starts with "a" and are at least 5 characters in length.
 */ 
use mavenmovies;
select * from customer
where first_name like 'a____%' ; 

/*
Q19    Find all customers whose first name starts with "a" and ends with "o"
 */ 
use mavenmovies;
select * from customer
where first_name like 'a%o' ; 


/*
Q20 Get the films with pg and pg-13 rating using IN operato
 */ 
use mavenmovies;
select * from film
where rating in ('pg','pg-13'); 

/*
Q21 Get the films with length between 50 to 100 using between operator.
 */ 
use mavenmovies;
select * from film
where length between 50 and 100 ; 

/*
Q22 Get the top 50 actors using limit operator
 */ 
use mavenmovies;
select * from actor 
limit 50;

/*
Q23 Get the distinct film ids from inventory table
 */ 
use mavenmovies;
select distinct film_id  from inventory;



--                      Functions              
                       
/* Question 1:
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.
*/
use sakila;
show tables;
select * from rental;
select count(rental_id) from rental;

/* Question 2:
Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function.
*/
use sakila;
show tables;
select * from film;
select
 	title,   
    AVG(rental_duration)
from film
group by title;

/* String Functions:
Question 3:
Display the first name and last name of customers in uppercase. Hint: Use the UPPER () function.
*/
use sakila;
show tables;
describe customer;
select * from customer;
select
 	customer_id,
    store_id,
    upper(first_name),
    upper(last_name),
    email,
    address_id,
    active,
    create_date,
    last_update
from customer ;

/* 
Question 4:
Extract the month from the rental date and display it alongside the rental ID. Hint: Employ the MONTH() function.
*/
use sakila;
show tables;
describe rental ;
select * from rental;
select 
	rental_id,
 	rental_date,
    month(rental_date) as rental_month,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    last_update
from rental;

/* GROUP BY:
Question 5:
Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Hint: Use COUNT () in conjunction with GROUP BY.
*/

use sakila;
show tables;
describe rental ;
select * from rental;
select 
	customer_id,
    count(rental_id) as count_of_rentals   
from rental
group by customer_id ;
    
/* GROUP BY:
Question 6:
Find the total revenue generated by each store. Hint: Combine SUM() and GROUP BY.
*/

use sakila;
show tables;
select 
	store,
    sum(total_sales) as revenue_generated
from sales_by_store
group by store ;    
/* GROUP BY:
Question 7:
Determine the total number of rentals for each category of movies.
Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
*/

use sakila;
show tables;
describe film_category;
describe film ;
describe inventory;
describe rental;
select 
	category_id,
    count(d.rental_id) as number_of_rentals
from film_category a
left join film b on a.film_id = b.film_id
left join inventory c on b.film_id = c.film_id
left join rental d on c.inventory_id = d.inventory_id
group by a.category_id ;

/*
Question 8:
Find the average rental rate of movies in each language.
Hint: JOIN film and language tables, then use AVG () and GROUP BY
*/
use sakila;
show tables;
select * from film;
select 
	language_id,
    AVG(rental_rate) as avg_rent_rate_by_language
from film 
group by language_id;      

/*
Questions 9 -
Display the title of the movie, customer s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables
*/
use sakila;
show tables;
describe film ;
describe inventory;
describe rental;
describe customer;
select 
	a.title as film_title,
    d.first_name as customer_first_name,
    d.last_name as customer_last_name
from film a
left join inventory b on a.film_id = b.film_id
left join rental c on b.inventory_id = c.inventory_id
left join customer d on c.customer_id = d.customer_id;

/*
Question 10:
Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film actor, film, and actor tables
*/
use sakila;
show tables;
describe actor;
describe film_actor;
describe film ;
select
    a.actor_id,
    a.first_name,
    a.last_name,
    c.title
from actor a
left join film_actor b on a.actor_id = b.actor_id
left join film c on b.film_id = c.film_id
where c.title like 'Gone with the Wind' ;

/*
Question 11:
Retrieve the customer names along with the total amount they've spent on rentals.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
*/
use sakila;
show tables;
describe customer;
describe rental ;
describe payment;

select
    a.customer_id,
    a.first_name,
    a.last_name,
   sum( c. amount) as total_amount_on_rental
from customer a
left join rental b on a.customer_id = b.customer_id
left join payment c on b.rental_id = c.rental_id
group by a.customer_id;

/*
Question 12:
List the titles of movies rented by each customer in a particular city (e.g., 'London').
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
*/
use sakila;
show tables;
describe city;
describe address ;
describe customer;
describe rental;
describe inventory;
describe film;

select
    a.city,
    c.first_name,
    c.last_name,
    f.title as film_title
from city a
left join address b on a.city_id = b.city_id
left join customer c on b.address_id = c.address_id
left join rental d on c.customer_id = d.customer_id
left join inventory e on d.inventory_id = e.inventory_id
left join film f on e.film_id = f.film_id 
where a.city like 'london' ;

/*   Advanced Joins and GROUP BY:
Question 13:
Display the top 5 rented movies along with the number of times they've been rented.
Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
*/
use sakila;
show tables;
describe film;
describe inventory ;
describe rental ;
select
    a.film_id,
    a.title,
    count( c.rental_id) as number_of_rentals
from film a
left join inventory b on a.film_id = b.film_id
left join rental c on b.inventory_id = c.inventory_id
group by a.film_id,a.title
order by number_of_rentals desc
limit 5;

/*   Advanced Joins and GROUP BY:
Question 14:
Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY
*/
use sakila;
show tables;
describe customer;
describe rental ;
describe inventory ;
select 
 a.customer_id,
 a.first_name,
 a.last_name
 from customer a
join rental b on a.customer_id = b.customer_id 
join inventory c on b.inventory_id = c.inventory_id
where c.store_id in (1,2)
group by  a.customer_id, a.first_name,a.last_name 
order by first_name ;

/*   Windows Function:
Q1. Rank the customers based on the total amount they've spent on rentals
*/
USE sakila;
SHOW tables;
SELECT 
    c.customer_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS ranking
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC;

/*   Windows Function:
 Q2 Calculate the cumulative revenue generated by each film over time
*/
USE sakila;
SHOW tables;
WITH RevenueOverTime AS (
    SELECT 
        f.film_id,
        f.title,
        r.rental_date,
        p.amount AS revenue,
        SUM(p.amount) OVER (
            PARTITION BY f.film_id 
            ORDER BY r.rental_date 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue
    FROM rental r
    JOIN payment p ON r.rental_id = p.rental_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
)
SELECT * FROM RevenueOverTime
ORDER BY film_id, rental_date;

/*
 Q3 Determine the average rental duration for each film, considering films with similar length
*/
USE sakila;
SHOW tables;
describe film;
describe inventory;
describe rental;

SELECT f.film_id, f.title, f.length, 
       AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
GROUP BY f.film_id, f.title, f.length
ORDER BY f.length, avg_rental_duration DESC;




/*
 Q4  Identify the top 3 films in each category based on their rental counts.
*/
USE sakila;
SHOW tables;
WITH FilmRentalCounts AS (
    SELECT 
        c.name AS category_name,
        f.film_id,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank_position
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.name, f.film_id, f.title
)
SELECT 
    category_name,
    film_title,
    rental_count
FROM FilmRentalCounts
WHERE rank_position <= 3
ORDER BY category_name, rank_position;

/*
 Q5 Calculate the difference in rental counts between each customer's total rentals and the average rentals
   across all customers.
*/
USE sakila;
SHOW tables;
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS total_rentals,
    (SELECT AVG(rental_count) 
     FROM (SELECT customer_id, COUNT(rental_id) AS rental_count 
           FROM rental 
           GROUP BY customer_id) AS avg_rentals) AS avg_rentals,
    COUNT(r.rental_id) - 
    (SELECT AVG(rental_count) 
     FROM (SELECT customer_id, COUNT(rental_id) AS rental_count 
           FROM rental 
           GROUP BY customer_id) AS avg_rentals) AS rental_difference
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY rental_difference DESC;

/*
 Q6  Find the monthly revenue trend for the entire rental store over time
*/
USE sakila;
SELECT 
    DATE_FORMAT(rental.rental_date, '%Y-%m') AS month,
    SUM(payment.amount) AS total_revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
GROUP BY month
ORDER BY month;


/*
 Q7   Identify the customers whose total spending on rentals falls within the top 20% of all customers.
*/
USE sakila;
WITH customer_spending AS (
    SELECT 
      p.customer_id,
      SUM(p.amount) AS total_spent
    FROM payment p
    GROUP BY p.customer_id
),
ranked_customers AS (
    SELECT 
     customer_id,
     total_spent,
   NTILE(5) OVER (ORDER BY total_spent DESC) AS spending_rank
    FROM customer_spending
)
SELECT customer_id as top_spending_customer_id,  total_spent FROM ranked_customers
WHERE spending_rank = 1;


/*
 Q8  Calculate the running total of rentals per category, ordered by rental count
*/
USE sakila;
WITH rental_counts AS (
    SELECT 
        c.name AS category,
        COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.name
)
SELECT 
    category,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM rental_counts
ORDER BY rental_count DESC;

 /*
 Q9  Find the films that have been rented less than the average rental count for their respective categories
*/
USE sakila;
WITH CategoryRentalAvg AS (
    SELECT 
        c.category_id,
        c.name AS category_name,
        AVG(rental_count) AS avg_rental_count
    FROM (
        SELECT 
            f.film_id,
            fc.category_id,
            COUNT(r.rental_id) AS rental_count
        FROM film f
        JOIN film_category fc ON f.film_id = fc.film_id
        LEFT JOIN inventory i ON f.film_id = i.film_id
        LEFT JOIN rental r ON i.inventory_id = r.inventory_id
        GROUP BY f.film_id, fc.category_id
    ) AS FilmRentalCount
    JOIN category c ON FilmRentalCount.category_id = c.category_id
    GROUP BY c.category_id, c.name
)

SELECT 
    f.film_id,
    f.title,
    c.category_id,
    c.name AS category_name,
    COUNT(r.rental_id) AS rental_count,
    cra.avg_rental_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
JOIN CategoryRentalAvg cra ON fc.category_id = cra.category_id
GROUP BY f.film_id, f.title, c.category_id, c.name, cra.avg_rental_count
HAVING COUNT(r.rental_id) < cra.avg_rental_count
ORDER BY c.category_id, COUNT(r.rental_id) ASC;

 /*
 Q10  . Identify the top 5 months with the highest revenue and display the revenue generated in each month
 */
USE sakila;
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY revenue_month
ORDER BY total_revenue DESC
LIMIT 5;

-- Normalisation & CTE
 /*
 Q1  First Normal Form (1NF):
  a. Identify a table in the Sakila database that violates 1NF. Explain how you  would normalize it to achieve 1NF.
 */
 -- Ans
/* In the Sakila database, the film table potentially violates First Normal Form (1NF) because it contains a column called 
special_features, which stores multiple values 
(features like "Trailers", "Commentaries", etc.) as a comma-separated string.
 1NF Violation
1NF states that each column must contain atomic (indivisible) values, and special_features contains multiple values 
in a single field, violating this rule.  */

CREATE TABLE special_feature (
    feature_id INT PRIMARY KEY AUTO_INCREMENT,
    feature_name VARCHAR(50) NOT NULL UNIQUE
	);
CREATE TABLE film_special_feature (
    film_id SMALLINT UNSIGNED NOT NULL,
    feature_id INT NOT NULL,
    PRIMARY KEY (film_id, feature_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id) ON DELETE CASCADE,
    FOREIGN KEY (feature_id) REFERENCES special_feature(feature_id) ON DELETE CASCADE
);

INSERT INTO special_feature (feature_name) VALUES 
('Trailers'), ('Commentaries'), ('Deleted Scenes'), ('Behind the Scenes');
INSERT INTO film_special_feature (film_id, feature_id)
SELECT f.film_id, sf.feature_id
FROM film f
JOIN special_feature sf 
ON FIND_IN_SET(sf.feature_name, f.special_features) > 0;
ALTER TABLE film DROP COLUMN special_features;

/*
Q2  Second Normal Form (2NF):
a. Choose a table in Sakila and describe how you would determine whether it is in 2NF.
   If it violates 2NF, explain the steps to normalize it
   
 -- Ans
/* Understand 2NF Requirements A table is in 2NF if:
    It is in First Normal Form (1NF) (all attributes are atomic, and there are no repeating groups).
    No partial dependencies exist, meaning no non-prime attribute (an attribute not part of any candidate key)
      is dependent on a proper subset of any candidate key.*/
      
  --  Let's choose the film_actor table from the Sakila database.
   use sakila;
   describe film_actor;
   -- This table represents the many-to-many relationship between   film and actor.
   -- The structure of the film_actor table is:
/*  actor_id	smallint unsigned	NO	PRI	
     film_id	smallint unsigned	NO	PRI	
	last_update	timestamp	NO		CURRENT_TIMESTAMP 
    
Check for 1NF
    The film_actor table is already in 1NF because:
    Each column contains atomic values.
	There are no repeating groups.
Check for 2NF
    The primary key of the film_actor table is a composite key: (actor_id, film_id).
    The only non-prime attribute is last_update.
    To check for partial dependencies, we need to determine if last_update depends on only part of the primary key 
     (either actor_id or film_id alone).
  In this case:
    last_update is a timestamp that records when the row was last updated. 
    It depends on the combination of actor_id and film_id, not on either one individually.
    Therefore, there are no partial dependencies.
Conclusion
    The film_actor table is already in 2NF because it meets both conditions:
    It is in 1NF.
    There are no partial dependencies.	
    
If the Table Violated 2NF
    If the table violated 2NF, here’s how we would normalize it:
	Example of a Violation
    Suppose the film_actor table had an additional column, actor_name, which depends only on actor_id 
       (not the full primary key). 
    This would violate 2NF because actor_name depends on a subset of the primary key (actor_id).
 Steps to Normalize    
  Identify the Partial Dependency:
	actor_name depends only on actor_id, not the full primary key.
  Decompose the Table:
    Create a new table for the partially dependent attribute:   
      
      actor (
       actor_id SMALLINT UNSIGNED PRIMARY KEY,
       actor_name VARCHAR(255),
       last_update TIMESTAMP
       );
       
   Remove actor_name from the film_actor table:
     
     film_actor (
    actor_id SMALLINT UNSIGNED,
    film_id SMALLINT UNSIGNED,
    last_update TIMESTAMP,
    PRIMARY KEY (actor_id, film_id)
    );
     
  Establish a Foreign Key Relationship:
    Add a foreign key constraint in the film_actor table to reference the actor table: 
     
     ALTER TABLE film_actor
      ADD CONSTRAINT fk_actor_id
      FOREIGN KEY (actor_id) REFERENCES actor(actor_id);
      
  Verify 2NF:
    After decomposition, both tables are in 2NF because:
    All non-prime attributes depend on the full primary key in their respective tables.
    No partial dependencies exist. 
*/  

/*
Q3  Third Normal Form (3NF):
  a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the 
     steps to normalize the table to 3NF
*/   
   
 use sakila;
show tables;
describe staff;
/*The staff table in the Sakila database appears to violate Third Normal Form (3NF) due to the presence of transitive 
 dependencies.
 creating the copy of staff table to avoid error in execution of earlier questionsin the assignment based on tables in 
  sakila database */

CREATE TABLE staff1 LIKE staff;
INSERT INTO staff1 SELECT * FROM staff;
describe staff1;
drop table staff1;
/*
staff_id	tinyint unsigned	NO	PRI
first_name	varchar(45)	NO	
last_name	varchar(45)	NO	
address_id	smallint unsigned	NO	MUL
picture	blob	YES	
email	varchar(50)	YES	
store_id	tinyint unsigned	NO	MUL
active	tinyint(1)	NO	
username	varchar(16)	NO	
password	varchar(40)	YES	
last_update	timestamp	NO	
      
The staff table in the Sakila database appears to violate Third Normal Form (3NF) due to the presence of transitive 
   dependencies.
 A table is in 3NF if it is in 2NF and all non-prime attributes are functionally dependent only on the candidate key 
 (i.e., there are no transitive dependencies).
 
 Transitive Dependencies in the staff Table
 A transitive dependency occurs when a non-prime attribute depends on another non-prime attribute, rather than directly on 
    the primary key. 
  In the staff table:
   The primary key is staff_id.
	The attributes first_name, last_name, address_id, picture, email, store_id, active, username, password, and last_update
      are non-prime attributes.
  The following transitive dependencies can be identified:
    store_id → address_id: If store_id determines address_id, and address_id is not part of the primary key, 
      this is a transitive dependency.
    username → email: If username determines email, and email is not part of the primary key,
       this is another transitive dependency.
    These dependencies violate 3NF because non-prime attributes (address_id and email) are not directly dependent on the
     primary key (staff_id).
     
  Steps to Normalize the staff Table to 3NF
    To normalize the staff table to 3NF, we need to remove the transitive dependencies by decomposing the table into smaller
      tables.
    Step 1: Create a New Table for store Information
      Extract the store_id and address_id columns into a new table called store.
       The store table will have store_id as its primary key. */
    CREATE TABLE store1 (
    store_id TINYINT UNSIGNED PRIMARY KEY,
    address_id SMALLINT UNSIGNED,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
   );
/*  
Step 2: Create a New Table for username and email
   Extract the username and email columns into a new table called staff_credentials.
   The staff_credentials table will have username as its primary key.
*/
   CREATE TABLE staff_credentials (
    username VARCHAR(16) PRIMARY KEY,
    email VARCHAR(50)
);

/*
Step 3: Modify the Original staff Table
Remove the address_id and email columns from the staff table.
Add a foreign key reference to the store table.
*/
 CREATE TABLE staff1 (
    staff_id TINYINT UNSIGNED PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    picture BLOB,
    store_id TINYINT UNSIGNED,
    active TINYINT(1) NOT NULL,
    username VARCHAR(16),
    password VARCHAR(40),
    last_update TIMESTAMP NOT NULL,
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (username) REFERENCES staff_credentials(username)
 );
 
 -- Original staff Table (Before Normalization)
  describe staff;
/* staff Table (after Normalization ) staff, store  table is renamed as staff1, store1 to avoid errors in the execution 
    of previous Questions based on sakila database */
 -- tables after normalisation
 describe store1;
 describe staff_credentials;
 describe staff1;
/*
  Benefits of Normalization
  Eliminates Redundancy: By separating store and staff_credentials into their own tables, we avoid duplicating data.
  Improves Data Integrity: Foreign key constraints ensure that relationships between tables are maintained.
  Simplifies Maintenance: Updates to store or email information only need to be made in one place.
  By following these steps, the staff1 table is now in 3NF, and the transitive dependencies have been resolved. 
 */
 
/*
Q4   Normalization Process:
a. Take a specific table in Sakila and guide through the process of normalizing it from the initial
unnormalized form up to at least 2NF.
*/
/*  
  Steps to Normalize the staff Table to 3NF
    To normalize the staff table to 3NF, we need to remove the transitive dependencies by decomposing the table into smaller
      tables.
    Step 1: Create a New Table for store Information
      Extract the store_id and address_id columns into a new table called store.
       The store table will have store_id as its primary key. */
    CREATE TABLE store1 (
    store_id TINYINT UNSIGNED PRIMARY KEY,
    address_id SMALLINT UNSIGNED,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
   );
/*  
Step 2: Create a New Table for username and email
   Extract the username and email columns into a new table called staff_credentials.
   The staff_credentials table will have username as its primary key.
*/
   CREATE TABLE staff_credentials (
    username VARCHAR(16) PRIMARY KEY,
    email VARCHAR(50)
);

/*
Step 3: Modify the Original staff Table
Remove the address_id and email columns from the staff table.
Add a foreign key reference to the store table.
*/
 CREATE TABLE staff1 (
    staff_id TINYINT UNSIGNED PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    picture BLOB,
    store_id TINYINT UNSIGNED,
    active TINYINT(1) NOT NULL,
    username VARCHAR(16),
    password VARCHAR(40),
    last_update TIMESTAMP NOT NULL,
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (username) REFERENCES staff_credentials(username)
 );
 
 -- Original staff Table (Before Normalization)
  describe staff;
/* staff Table (after Normalization ) staff, store  table is renamed as staff1, store1 to avoid errors in the execution 
    of previous Questions based on sakila database */
 -- tables after normalisation
 describe store1;
 describe staff_credentials;
 describe staff1;
/*
  Benefits of Normalization
  Eliminates Redundancy: By separating store and staff_credentials into their own tables, we avoid duplicating data.
  Improves Data Integrity: Foreign key constraints ensure that relationships between tables are maintained.
  Simplifies Maintenance: Updates to store or email information only need to be made in one place.
  By following these steps, the staff1 table is now in 3NF, and the transitive dependencies have been resolved. 
 */
  
 /*
Q5   CTE Basics:
    a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they  have acted in 
      from the actor and film_actor tables.
*/
use sakila;
WITH ActorFilmCount AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM 
        actor a
    JOIN 
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY 
        a.actor_id, a.first_name, a.last_name
    )
  SELECT 
    distinct actor_name,
    film_count
  FROM 
    ActorFilmCount
  ORDER BY 
    film_count DESC, actor_name;

/*
Q6   CTE with Joins:
   a. Create a CTE that combines information from the film and language tables to display the
        film title, language name, and rental rate
*/
  use sakila;
  WITH FilmLanguageInfo AS (
    SELECT
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM
        film f
    JOIN
        language l ON f.language_id = l.language_id
     )
   SELECT
    film_title,
    language_name,
    rental_rate
   FROM
    FilmLanguageInfo;


/*
Q7   CTE for Aggregation:
a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)
     from the customer and payment tables
*/
  use sakila;
  WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM
        customer c
    JOIN
        payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
    )
   SELECT
    customer_id,
    customer_name,
    total_revenue
  FROM
    CustomerRevenue
  ORDER BY
    total_revenue DESC;
    
    
 /*   
  Q8  CTE with Window Functions:
      a. Utilize a CTE with a window function to rank films based on their rental duration from the film table
*/
  use sakila;
  WITH FilmRentalRank AS (
    SELECT
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM
        sakila.film
  )
 SELECT
    film_id,
    title,
    rental_duration,
    rental_rank
 FROM
    FilmRentalRank
 ORDER BY
    rental_rank;
 
 
 /*   
  Q9  CTE and Filtering:
   a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the
	   customer table to retrieve additional customer details
*/
  use sakila;
  WITH CustomerRentals AS (
    SELECT 
        customer_id, 
        COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
 )

 SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.active,
    c.create_date,
    cr.rental_count
FROM CustomerRentals cr
JOIN customer c ON cr.customer_id = c.customer_id;


/*   
  Q10 CTE for Date Calculations:
a. Write a query using a CTE to find the total number of rentals made each month, considering the
    rental_date from the rental table
*/
  use sakila;
  WITH MonthlyRentals AS (
    SELECT
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM
        rental
    GROUP BY
        DATE_FORMAT(rental_date, '%Y-%m')
   )
  SELECT
    rental_month,
    total_rentals
  FROM
    MonthlyRentals
ORDER BY
    rental_month;
    
 
 /*   
  Q11  CTE and Self-Join:
     a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film
        together, using the film_actor table.
*/
   use sakila;
   WITH ActorPairs AS (
    SELECT
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id
    FROM
        film_actor fa1
    JOIN
        film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE
        fa1.actor_id < fa2.actor_id
  )
  SELECT
    actor1_id,
    actor2_id,
    COUNT(film_id) AS films_together
  FROM
    ActorPairs
  GROUP BY
    actor1_id,
    actor2_id
  ORDER BY
    films_together DESC,
    actor1_id,
    actor2_id;  



/*   
  Q12   CTE for Recursive Search:
        a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager,
          considering the reports_to column
*/
use assignment;
CREATE TABLE staff_manager (
staff_id INTEGER PRIMARY KEY NOT NULL,
first_name TEXT NOT NULL, 
last_name TEXT NOT NULL,
reports_to  INTEGER
); 
INSERT INTO staff_manager(staff_id, first_name, last_name, reports_to)
VALUES 
    (1,'Gyan', 'sharma',0 ),
	(2,'rajesh', 'mishra',1 ),
    (3,'vijayendra', 'kulkarni',2),
    (4,'suresh', 'ranga',2 ),
    (5,'rakesh', 'patel',3 ),
    (6,'ramesh', 'patel',4 ),
    (7,'hariram', 'sharma',5 ),
    (8,'nilesh', 'patil',5 ),
    (9,'birendra', 'singh',7 ),
    (10,'kishan', 'marwadi',6),
    (11,'ganesh', 'patel',6),
    (12,'ravindra', 'patil',5 ),
    (13,'avdhesh', 'gupta',3 );
 select * from staff_manager;   
use assignment;
show tables;
select * from staff_manager;
WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Select the initial manager (starting point)
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM 
        staff_manager
    WHERE 
        staff_id = 1  

    UNION ALL

    -- Recursive member: Select employees who report to the current level
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM 
        staff_manager s
    INNER JOIN 
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id
   )
-- Final SELECT to retrieve all employees under the specified manager
   SELECT 
    staff_id,
    first_name,
    last_name,
    reports_to
  FROM 
    EmployeeHierarchy ;
    
 