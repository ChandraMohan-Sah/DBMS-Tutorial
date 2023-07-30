--------------------------------------------------------------------------------------------------------------------------------
--NAME : ChandraMohan Sah
--ROLL NO. : THA077BEI017


--SUBMMITED TO - BISHIKA MAM 
------------------------------------------------------------OUR DATABASE after Creating Table as Per Figure 5 in Tutorial-------------------------------------------

MySQL root@(none):db_HOMEWORK> \dt
+-----------------------+
| Tables_in_db_HOMEWORK |
+-----------------------+
| tbl_Company           |
| tbl_Employee          |
| tbl_Manages           |
| tbl_Works             |
+-----------------------+


MySQL root@(none):db_HOMEWORK> SELECT *FROM tbl_Company;
+------------------------+-------------+
| company_name           | city        |
+------------------------+-------------+
| 321 Co                 | Houston     |
| 456 Corp               | Chicago     |
| 789 Inc                | Los Angeles |
| ABC Inc                | Los Angeles |
| Def Co                 | Houston     |
| First Bank Corporation | New York    |
| Pongyang Corporation   | Chicago     |
| Small Bank Corporation | Chicago     |
+------------------------+-------------+


MySQL root@(none):db_HOMEWORK> SELECT *FROM `tbl_Employee`;
+----------------+---------------+-------------+
| employee_name  | street        | city        |
+----------------+---------------+-------------+
| Alice Williams | 321 Maple St  | Houston     |
| Ashley Johnson | 876 Market St | Chicago     |
| Emily Williams | 741 First St  | Los Angeles |
| Mark Thompson  | 235 Fifth Ave | New York    |
| Michael Brown  | 902 Main St   | Houston     |
| Patrick        | 123 Main St   | New Mexico  |
| Samantha Smith | 111 Second St | Chicago     |
| Sara Davis     | 159 Broadway  | New York    |
+----------------+---------------+-------------+


MySQL root@(none):db_HOMEWORK> SELECT *FROM `tbl_Manages`;
+----------------+----------------+
| employee_name  | manager_name   |
+----------------+----------------+
| Patrick        | Jane Doe       |
| Sara Davis     | Samantha Smith |
| Mark Thompson  | Emily Williams |
| Ashley Johnson | Jane Doe       |
| Michael Brown  | Emily Williams |
+----------------+----------------+


MySQL root@(none):db_HOMEWORK> SELECT *FROM `tbl_Works`;
+----------------+------------------------+-----------+
| employee_name  | company_name           | salary    |
+----------------+------------------------+-----------+
| Patrick        | Pongyang Corporation   | 500000.00 |
| Sara Davis     | First Bank Corporation | 82500.00  |
| Mark Thompson  | Small Bank Corporation | 78000.00  |
| Ashley Johnson | Small Bank Corporation | 92000.00  |
| Emily Williams | Small Bank Corporation | 86500.00  |
| Michael Brown  | Small Bank Corporation | 81000.00  |
| Samantha Smith | Small Bank Corporation | 77000.00  |
+----------------+------------------------+-----------+

---------------------------------------------- QUESTION'S  ANSWER USING SUBQUERY----------------------------------------------------------------------------------


(a) Find the names of all employees who work for First Bank Corporation.

	MySQL root@(none):db_HOMEWORK> 
		SELECT employee_name FROM tbl_Employee 
		WHERE  employee_name IN (
		SELECT employee_name FROM tbl_Works WHERE company_name = 'First 
		Bank Corporation'  );
		+---------------+
		| employee_name |
		+---------------+
		| Sara Davis    |
		+---------------+

(b) Find the names and cities of residence of all employees who work for First Bank Cor-poration.

	MySQL root@(none):db_HOMEWORK> 
		SELECT employee_name, city FROM tbl_Employee 
		WHERE employee_name IN (
		SELECT employee_name FROM tbl_Works
		WHERE company_name = 'First Bank Corporation');
		+---------------+----------+
		| employee_name | city     |
		+---------------+----------+
		| Sara Davis    | New York |
		+---------------+----------+

(c) Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000.

	MySQL root@(none):db_HOMEWORK> 
		SELECT employee_name, street, city FROM `tbl_Employee` 
		WHERE employee_name IN (
		SELECT employee_name FROM tbl_Works WHERE
		company_name = 'First Bank Corporation' AND
		salary > 10000);
		+---------------+--------------+----------+
		| employee_name | street       | city     |
		+---------------+--------------+----------+
		| Sara Davis    | 159 Broadway | New York |
		+---------------+--------------+----------+


(d) Find all employees in the database who live in the same cities as the companies for which they work.

	MySQL root@(none):db_HOMEWORK> 
		SELECT employee_name FROM `tbl_Employee` WHERE employee_name IN
		(SELECT employee_name FROM `tbl_Works` WHERE company_name IN(
		SELECT company_name FROM `tbl_Company`
		WHERE tbl_Company.city = `tbl_Employee`.city));
		+----------------+
		| employee_name  |
		+----------------+
		| Ashley Johnson |
		| Samantha Smith |
		| Sara Davis     |
		+----------------+


(f) Find all employees in the database who do not work for First Bank Corporation.

	MySQL root@(none):db_HOMEWORK> 
		SELECT employee_name FROM tbl_Employee WHERE employee_name IN (
		SELECT employee_name FROM `tbl_Works`
		WHERE NOT  company_name  = 'First Bank Corporation');
		+----------------+
		| employee_name  |
		+----------------+
		| Ashley Johnson |
		| Emily Williams |
		| Mark Thompson  |
		| Michael Brown  |
		| Patrick        |
		| Samantha Smith |
		+----------------+



(g) Find all employees in the database who earn more than each employee of Small Bank Corporation.

	MySQL root@(none):db_HOMEWORK> 
		SELECT employee_name FROM tbl_Employee WHERE employee_name IN (
		SELECT employee_name FROM tbl_Works WHERE 
		company_name = 'Small Bank Corporation');
		+----------------+
		| employee_name  |
		+----------------+
		| Mark Thompson  |
		| Ashley Johnson |
		| Emily Williams |
		| Michael Brown  |
		| Samantha Smith |
		+----------------+


(h) Assume that the companies may be located in several cities. Find all companies located in every city in which Small Bank Corporation is located.

	MySQL root@(none):db_HOMEWORK> SELECT tbl_Works.employee_name
		FROM tbl_Employee, tbl_Works
		WHERE tbl_Employee.employee_name = tbl_Works.employee_name
		AND tbl_Works.salary > (
		    SELECT MAX(salary)
		    FROM tbl_Works
		    WHERE tbl_Works.company_name = 'Small Bank Corporation'
		);
		+---------------+
		| employee_name |
		+---------------+
		| Patrick       |
		+---------------+

(i) Find all employees who earn more than the average salary of all employees of their company.

	MySQL root@(none):db_HOMEWORK> 
		SELECT company_name  FROM tbl_Company WHERE city IN 
		(SELECT city FROM `tbl_Company` WHERE company_name = 'Small Bank Corporation');
		+------------------------+
		| company_name           |
		+------------------------+
		| 456 Corp               |
		| Pongyang Corporation   |
		| Small Bank Corporation |
		+------------------------+

(j) Find the company that has the most employees.

	MySQL root@(none):db_HOMEWORK> 
		SELECT tbl_Employee.employee_name FROM tbl_Employee, tbl_Works wrk 
		WHERE tbl_Employee.employee_name = wrk.employee_name AND 
		wrk.salary > (SELECT AVG(salary) FROM tbl_Works 
		WHERE tbl_Works.company_name = wrk.company_name );
		+----------------+
		| employee_name  |
		+----------------+
		| Ashley Johnson |
		| Emily Williams |
		+----------------+


(k) Find the company that has the smallest payroll.

	MySQL root@(none):db_HOMEWORK> 
		SELECT company_name
		FROM tbl_Works
		GROUP BY company_name
		ORDER BY COUNT(*) DESC
		limit 1;
		+------------------------+
		| company_name           |
		+------------------------+
		| Small Bank Corporation |
		+------------------------+




(l) Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.

	MySQL root@(none):db_HOMEWORK> 
		SELECT company_name
		FROM tbl_Works
		GROUP BY company_name
		HAVING AVG(salary) > ( 
		SELECT AVG(salary) FROM tbl_Works 
		WHERE company_name = 'First Bank Corporation' );
		+------------------------+
		| company_name           |
		+------------------------+
		| Pongyang Corporation   |
		| Small Bank Corporation |
		+------------------------+
		
		


------------------------------------------------ANSWERS TO QUESTION NUMBER 3--------------------------------------------------------------------------

(a) Modify the database so that Jones now lives in Newtown.
	
	--BEFORE EXUCUTION OF COMMAND

	MySQL root@(none):db_HOMEWORK> SELECT *FROM `tbl_Employee`;
		+----------------+---------------+-------------+
		| employee_name  | street        | city        |
		+----------------+---------------+-------------+
		| Alice Williams | 321 Maple St  | Houston     |
		| Ashley Johnson | 876 Market St | Chicago     |
		| Emily Williams | 741 First St  | Los Angeles |
		| Mark Thompson  | 235 Fifth Ave | New York    |
		| Michael Brown  | 902 Main St   | Houston     |
		| Patrick        | 123 Main St   | New Mexico  | --<<
		| Samantha Smith | 111 Second St | Chicago     |
		| Sara Davis     | 159 Broadway  | New York    |
		+----------------+---------------+-------------+

	
	MySQL root@(none):db_HOMEWORK> 
		UPDATE tbl_Employee
		SET city = 'Newtown'
		WHERE employee_name = 'Patrick';
		MySQL root@(none):db_HOMEWORK> SELECT *FROM `tbl_Employee`;
		
		--AFTER EXECUTION OF COMMAND
		
		+----------------+---------------+-------------+
		| employee_name  | street        | city        |
		+----------------+---------------+-------------+
		| Alice Williams | 321 Maple St  | Houston     |
		| Ashley Johnson | 876 Market St | Chicago     |
		| Emily Williams | 741 First St  | Los Angeles |
		| Mark Thompson  | 235 Fifth Ave | New York    |
		| Michael Brown  | 902 Main St   | Houston     |
		| Patrick        | 123 Main St   | Newtown     | --<<
		| Samantha Smith | 111 Second St | Chicago     |
		| Sara Davis     | 159 Broadway  | New York    |
		+----------------+---------------+-------------+



(b) Give all employees of First Bank Corporation a 10 percent raise.

	--BEFORE EXUCUTION OF COMMAND

	MySQL root@(none):db_HOMEWORK> SELECT *FROM `tbl_Works`;
		+----------------+------------------------+-----------+
		| employee_name  | company_name           | salary    |
		+----------------+------------------------+-----------+
		| Patrick        | Pongyang Corporation   | 500000.00 |
		| Sara Davis     | First Bank Corporation | 82500.00  | --<<
		| Mark Thompson  | Small Bank Corporation | 78000.00  |
		| Ashley Johnson | Small Bank Corporation | 92000.00  |
		| Emily Williams | Small Bank Corporation | 86500.00  |
		| Michael Brown  | Small Bank Corporation | 81000.00  |
		| Samantha Smith | Small Bank Corporation | 77000.00  |
		+----------------+------------------------+-----------+

	
	
	MySQL root@(none):db_HOMEWORK> 
	UPDATE tbl_Works
	SET salary = salary * 1.1
	WHERE company_name = 'First Bank Corporation';
	
	--AFTER EXECUTION OF COMMAND
	
	MySQL root@(none):db_HOMEWORK> SELECT *FROM `tbl_Works`;
		+----------------+------------------------+-----------+
		| employee_name  | company_name           | salary    |
		+----------------+------------------------+-----------+
		| Patrick        | Pongyang Corporation   | 500000.00 |
		| Sara Davis     | First Bank Corporation | 90750.00  | --<<
		| Mark Thompson  | Small Bank Corporation | 78000.00  |
		| Ashley Johnson | Small Bank Corporation | 92000.00  |
		| Emily Williams | Small Bank Corporation | 86500.00  |
		| Michael Brown  | Small Bank Corporation | 81000.00  |
		| Samantha Smith | Small Bank Corporation | 77000.00  |
		+----------------+------------------------+-----------+


(c) Give all managers of First Bank Corporation a 10 percent raise.
	UPDATE tbl_works
	SET salary = salary * 1.1
	WHERE employee_name IN (
	  SELECT manager_name
	  FROM tbl_manages
	  WHERE company_name = 'First Bank Corporation');

		
	
(d) Give all managers of First Bank Corporation a 10 percent raise unless the salary be comes greater than $100,000; in such cases, give only a 3 percent raise.
	UPDATE tbl_works
	SET salary = 
	  CASE
	    WHEN salary * 1.1 <= 100000 THEN salary * 1.1
	    ELSE salary * 1.03
	  END
	WHERE employee_name IN (
	  SELECT manager_name
	  FROM tbl_manages
	  WHERE company_name = 'First Bank Corporation'
	);	



(e) Delete all tuples in the works relation for employees of Small Bank Corporation.
	DELETE FROM tbl_works
	WHERE company_name = 'Small Bank Corporation';

	





