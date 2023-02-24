-- List the employee number, last name, first name, sex, and salary of each employee
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
from employees as e
join salaries as s
on e.emp_no=s.emp_no;

-- List the last name, first name, and hire date for the employees who were hired in 1986
select last_name, first_name, hire_date 
from employees
where hire_date like '%/1986';

-- List the manager of each department: department number, department name, employee number, last name, and first name
select dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
from dept_manager as dm
inner join departments as d
	on dm.dept_no=d.dept_no
inner join employees as e
	on dm.emp_no=e.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name
select de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
from dept_employee as de
inner join departments as d
	on de.dept_no=d.dept_no
inner join employees as e
	on de.emp_no=e.emp_no;
	
-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
select first_name, last_name, sex
from employees
where first_name='Hercules'
and last_name like 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name
-- With Subqueries; doesn't include the department name
select emp_no, last_name, first_name
from employees
where emp_no in (
	select emp_no
	from dept_employee
	where dept_no in (
		select dept_no
		from departments
		where dept_name='Sales'
	)
);

-- Same as previous query but done using joins; includes the department name as a check
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
inner join dept_employee as de on de.emp_no=e.emp_no
inner join departments as d on de.dept_no=d.dept_no
where dept_name='Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name 
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
inner join dept_employee as de on de.emp_no=e.emp_no
inner join departments as d on de.dept_no=d.dept_no
where dept_name='Sales' or dept_name='Development';

-- List the frequency counts, in descending order, of all the employee last names 
select last_name, count(last_name) as "frequency"
from employees
group by last_name
order by frequency desc;
