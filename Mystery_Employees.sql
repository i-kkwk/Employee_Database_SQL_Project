-- Create Table and Drop Table if Exists.
-- Specify Data types, Primary keys and Foreign keys.
-- Import CSV files to get information in existing tables.

DROP TABLE IF EXISTS departments;
CREATE TABLE departments(
dept_no VARCHAR NOT NULL ,
dept_name VARCHAR NOT NULL,
CONSTRAINT pk_departments PRIMARY KEY (dept_no)
);

DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
title_id VARCHAR NOT NULL,
title VARCHAR NOT NULL,
CONSTRAINT pk_title PRIMARY KEY (title_id)
);	

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
emp_no INT NOT NULL,
emp_title_id VARCHAR NOT NULL,
birth_date DATE NOT NULL,
first_name VARCHAR NOT NULL,
last_name VARCHAR NOT NULL,
sex VARCHAR NOT NULL,
hire_date DATE NOT NULL,
CONSTRAINT pk_employees PRIMARY KEY (emp_no)
);

DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp(
emp_no INT NOT NULL,
dept_no VARCHAR NOT NULL
);
 
DROP TABLE IF EXISTS  dept_manager; 
CREATE TABLE dept_manager(
dept_no VARCHAR NOT NULL,
emp_no INT NOT NULL
);

DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
emp_no INT NOT NULL,
salary INT NOT NULL
);

ALTER TABLE  employees ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

ALTER TABLE  dept_manager ADD CONSTRAINT  fk_dept_manager_dept_no FOREIGN KEY( dept_no )
REFERENCES departments (dept_no);

ALTER TABLE  dept_manager  ADD CONSTRAINT  fk_dept_manager_emp_no  FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

-- Confirming data from each tables

SELECT * FROM departments;
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;


--List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
RIGHT JOIN salaries s
ON (e.emp_no = s.emp_no);

-- List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name,hire_date
FROM employees e
WHERE hire_date BETWEEN '1986/01/01' AND '1986/12/31';


-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments d
LEFT JOIN dept_manager dm
ON d.dept_no = dm.dept_no
LEFT JOIN employees e
ON dm.emp_no = e.emp_no;

-- List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
LEFT JOIN employees e
ON de.emp_no = e.emp_no
LEFT JOIN departments d
ON de.dept_no = d.dept_no;

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
LEFT JOIN employees e
ON de.emp_no = e.emp_no
RIGHT JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
LEFT JOIN employees e
ON de.emp_no = e.emp_no
RIGHT JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Development';

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
LEFT JOIN employees e
ON de.emp_no = e.emp_no
RIGHT JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, 
COUNT (last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY 
COUNT(last_name) DESC;



