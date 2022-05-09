-- Query to retrieve retirement data

-- Deliverable 1 Queries

-- Retrieve the emp_no, first_name, last_name from Employees
SELECT emp_no,
	first_name,
	last_name
FROM employees

-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title,
	from_date,
	to_date
FROM titles

-- Create new table for retirement titles using the INTO CLAUSE
SELECT e.emp_no,
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;


-- Query to remove duplicates from retirement_titles, create unique titles table
SELECT DISTINCT ON (rt.emp_no)rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

-- Query to retrieve # of employees by their most recent job title about to retire
SELECT COUNT(ut.title),
ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY count DESC;



-- Deliverable 2 Queries Membership Eligibility
SELECT DISTINCT ON (e.emp_no)e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO membership_eligibility	
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no ASC;