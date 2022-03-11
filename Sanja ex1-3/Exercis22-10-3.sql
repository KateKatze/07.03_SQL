-- How many rows do we have in each table in the employees database?a
SELECT COUNT(*) FROM `employees`;
SELECT SUM(TABLE_ROWS)
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_SCHEMA = 'employees';

--2. How many employees with the first name "Mark" do we have in our company?
SELECT COUNT(first_name) FROM employees em WHERE first_name = "Mark";
--all Marks
SELECT * FROM employees em WHERE em.first_name = "Mark";

--3- How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?
SELECT COUNT(*) FROM employees WHERE first_name = "Eric" AND last_name LIKE "A%";
--to show all
SELECT * FROM employees WHERE first_name = "Eric" AND last_name LIKE "A%";

--4.  How many employees do we have that are working for us since 1985 and who are they?
SELECT COUNT(*) FROM employees em JOIN salaries sa ON sa.emp_no = em.emp_no WHERE sa.from_date BETWEEN "1985-01-01" AND NOW();
SELECT * FROM employees em JOIN salaries sa ON sa.emp_no = em.emp_no WHERE sa.from_date BETWEEN "1985-01-01" AND NOW();

--5.  How many employees got hired from 1990 until 1997 and who are they?
SELECT * FROM employees em WHERE em.hire_date BETWEEN "1990-01-01" AND "1997-12-31";
SELECT COUNT(*) FROM employees em WHERE em.hire_date BETWEEN "1990-01-01" AND "1997-12-31";

--6.  How many employees have salaries higher than EUR 70 000,00 and who are they? 
SELECT * FROM employees em JOIN salaries sa ON sa.emp_no = em.emp_no WHERE sa.salary > 70000;

--7.  How many employees do we have in the Research Department, who are working for us since 1992 and who are they?
SELECT COUNT(*) FROM employees em JOIN dept_emp de ON de.emp_no = em.emp_no JOIN departments dep ON dep.dept_no = de.dept_no WHERE dep.dept_name = "Research" AND em.hire_date BETWEEN "1992-01-01" AND CURRENT_DATE();

--8.  How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?
SELECT COUNT(*) FROM employees em JOIN dept_emp de ON de.emp_no = em.emp_no JOIN departments dep ON dep.dept_no = de.dept_no JOIN salaries sa ON sa.emp_no = em.emp_no WHERE dep.dept_name = "Finance" AND em.hire_date BETWEEN "1985-01-01" AND CURRENT_DATE() AND sa.salary > 75000;
SELECT * FROM employees em JOIN dept_emp de ON de.emp_no = em.emp_no JOIN departments dep ON dep.dept_no = de.dept_no JOIN salaries sa ON sa.emp_no = em.emp_no WHERE dep.dept_name = "Finance" AND em.hire_date BETWEEN "1985-01-01" AND CURRENT_DATE() AND sa.salary > 75000;

--9.  We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary.
SELECT em.*, ti.title, sa.salary FROM employees em JOIN salaries sa ON sa.emp_no = em.emp_no JOIN titles ti ON ti.emp_no = em.emp_no WHERE sa.to_date = CURRENT_DATE();

--10.  We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.
SELECT em.*, ti.title, dep.dept_name, sa.salary FROM employees em JOIN salaries sa ON sa.emp_no = em.emp_no JOIN titles ti ON ti.emp_no = em.emp_no JOIN dept_emp de ON de.emp_no = em.emp_no JOIN departments dep ON dep.dept_no = de.dept_no WHERE dep.dept_name = "Quality Management" AND sa.to_date >= CURRENT_DATE();

--  Create a query that will join all tables and show all data from all tables.
SELECT * FROM employees em JOIN titles ti ON ti.emp_no = em.emp_no JOIN salaries sa ON sa.emp_no = em.emp_no JOIN dept_manager dm ON dm.emp_no = em.emp_no JOIN dept_emp de ON de.emp_no = em.emp_no JOIN departments dep ON dep.dept_no = de.dept_no;

--employees from department Development
SELECT em.*, ti.title, sa.salary FROM employees em JOIN titles ti ON ti.emp_no = em.emp_no 
JOIN salaries sa ON sa.emp_no = em.emp_no JOIN dept_manager dm ON dm.emp_no = em.emp_no 
JOIN departments dep ON dep.dept_no = dm.dept_no WHERE dep.dept_name IN ('Development');
--or 
SELECT em.*, ti.title, sa.salary, dep.dept_name FROM employees em 
JOIN titles ti ON ti.emp_no = em.emp_no 
JOIN salaries sa ON sa.emp_no = em.emp_no 
JOIN dept_manager dm ON dm.emp_no = em.emp_no 
JOIN departments dep ON dep.dept_no = dm.dept_no
WHERE sa.salary >= 70000 AND dep.dept_name = "Development";

--SUBQUERY 
select employees.first_name, employees.last_name FROM employees WHERE employees.emp_no IN (SELECT salaries.emp_no FROM salaries WHERE salaries.salary >=70000)

--
SELECT employees.first_name, employees.last_name FROM employees WHERE employees.emp_no IN (SELECT titles.emp_no FROM titles WHERE titles.title = "Engineer");


SELECT em.* FROM employees em WHERE em.emp_no IN (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.dept_no = "d001");

--nicht meine 1.
SELECT (SELECT COUNT(1) FROM departments) +
       (SELECT COUNT(1) FROM dept_emp) +
       (SELECT COUNT(1) FROM dept_manager) +
       (SELECT COUNT(1) FROM employees) +
       (SELECT COUNT(1) FROM salaries) +
       (SELECT COUNT(1) FROM titles) AS row_count_all_tables;

SELECT SUM(TABLE_ROWS) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'employees';

SELECT table_name, table_rows
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_SCHEMA = 'employees';
