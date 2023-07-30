--------------------------------------------------------------------------------------------------------------------------------
--NAME : ChandraMohan Sah
--ROLL NO. : THA077BEI017


--SUBMMITED TO - BISHIKA MAM 
-------------------------------------------------------------------------------------


--a) Find the names of all employees who work for First Bank Corporation.
MySQL root@(none):db_HOMEWORK> 
	SELECT tbl_Employee.employee_name
	FROM tbl_Employee
	JOIN `tbl_Works` ON tbl_Employee.employee_name =
	tbl_Works.employee_name 
	WHERE tbl_Works.company_name =
	'First Bank Corporation';
	+---------------+
	| employee_name |
	+---------------+
	| Sara Davis    |
	+---------------+


--b) Find the names and cities of residence of all employees who work for First Bank Corporation.
MySQL root@(none):db_HOMEWORK> 
	SELECT tbl_Employee.employee_name , tbl_Employee.city
	FROM tbl_Employee
	JOIN tbl_Works ON tbl_Employee.employee_name = tbl_Works.employee_name
	WHERE tbl_Works.company_name = 'First Bank Corporation';
	+---------------+----------+
	| employee_name | city     |
	+---------------+----------+
	| Sara Davis    | New York |
	+---------------+----------+
	
		
--c) Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000.
MySQL root@(none):db_HOMEWORK> 
	SELECT tbl_Employee.employee_name , tbl_Employee.street, tbl_Employee.city
	FROM tbl_Employee
	JOIN tbl_Works ON tbl_Employee.employee_name = tbl_Works.employee_name
	WHERE tbl_Works.company_name = 'First Bank Corporation' AND tbl_Works.salary >10000;
	+---------------+--------------+----------+
	| employee_name | street       | city     |
	+---------------+--------------+----------+
	| Sara Davis    | 159 Broadway | New York |
	+---------------+--------------+----------+



--d) Find all employees in the database who live in the same cities as the companies for which they work.
MySQL root@(none):db_HOMEWORK> SELECT tbl_Employee.employee_name 
                            -> FROM tbl_Employee
                            -> JOIN tbl_Works
                            -> ON tbl_Employee.employee_name = tbl_Works.employee_name 
                            -> JOIN tbl_Company ON tbl_Works.company_name = tbl_Company.company_name
                            -> WHERE tbl_Works.company_name = 'First Bank Corporation';
				+---------------+
				| employee_name |
				+---------------+
				| Sara Davis    |
				+---------------+



--e) Find all employees in the database who live in the same cities and on the same streets as do their managers.
MySQL root@(none):db_HOMEWORK> SELECT e.employee_name, e.street, e.city
                            -> FROM tbl_Employee e
                            -> JOIN tbl_Employee m ON e.street = m.street AND e.city = m.city
                            -> JOIN tbl_Manages mg ON e.employee_name = mg.employee_name AND m.employee_name = mg.manager_name;
			+---------------+--------+------+
			| employee_name | street | city |
			+---------------+--------+------+
			+---------------+--------+------+



--f) Find all employees in the database who do not work for First Bank Corporation.
MySQL root@(none):db_HOMEWORK> SELECT tbl_Employee.employee_name
                             FROM tbl_Employee 
                             JOIN tbl_Works 
                             ON tbl_Employee.employee_name 
                             =tbl_Works.employee_name
                             WHERE NOT tbl_Works.company_name = 'First Bank Corporation';
                             
			+----------------+
			| employee_name  |
			+----------------+
			| Patrick        |
			| Mark Thompson  |
			| Ashley Johnson |
			| Emily Williams |
			| Michael Brown  |
			| Samantha Smith |
			+----------------+
	

--In this Way , We can use join in efficient way .

--Please, checkout the MySQL-Learning Repository  As well, Where I have practiced  A lot of questions on Join Operation.





