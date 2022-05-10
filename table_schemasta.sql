-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/fGkHqg
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE departments (
    dept_no VARCHAR  NOT NULL ,
    dept_name VARCHAR  NOT NULL ,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
    )
)

CREATE TABLE dept_emp (
    emp_no INT  NOT NULL ,
    dept_no VARCHAR  NOT NULL 
)

CREATE TABLE dept_manager (
    dept_no VARCHAR  NOT NULL ,
    emp_no INT  NOT NULL 
)

CREATE TABLE employees (
    emp_no INT  NOT NULL ,
    emp_title_id VACHAR  NOT NULL ,
    birth_date DATE  NOT NULL ,
    first_name VARCHAR  NOT NULL ,
    last_name VARCHAR  NOT NULL ,
    sex VARCHAR  NOT NULL ,
    hire_date DATE  NOT NULL ,
    CONSTRAINT pk_employees PRIMARY KEY  (
        emp_no
    )
)

CREATE TABLE salaries (
    emp_no INT  NOT NULL ,
    salary INT  NOT NULL 
)

CREATE TABLE titles (
    title_id VARCHAR  NOT NULL ,
    title VARCHAR  NOT NULL ,
    CONSTRAINT pk_titles PRIMARY KEY  (
        title_id
    )
)

ALTER TABLE dept_emp  ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no)


ALTER TABLE dept_emp WITH CHECK ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no)


ALTER TABLE dept_manager WITH CHECK ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no)


ALTER TABLE dept_manager WITH CHECK ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no)


ALTER TABLE employees WITH CHECK ADD CONSTRAINT fk_employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id)


ALTER TABLE salaries WITH CHECK ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no)


