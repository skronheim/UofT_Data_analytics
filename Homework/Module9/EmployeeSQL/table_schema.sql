-- removes tables if they exist
drop table if exists departments, title, salaries, employees, dept_employee, dept_manager;

-- creates the departments table
create table departments(
	dept_no varchar(4) NOT NULL primary key,
	dept_name varchar(20)
);

-- creates title table
create table title(
	title_id varchar(5) NOT NULL primary key,
	title varchar(20)
);

-- creates employees table
create table employees(
	emp_no int NOT NULL primary key,
	emp_title_id varchar(5) references title(title_id),
	birth_date varchar(10),
	first_name varchar(20),
	last_name varchar(20),
	sex varchar(1),
	hire_date varchar(10)	
);

-- creates salaries table
create table salaries(
	emp_no int NOT NULL primary key references employees(emp_no),
	salary int
);

-- creates department employees table
create table dept_employee(
	emp_no int NOT NULL references employees(emp_no),
	dept_no varchar(4) NOT NULL references departments(dept_no),
	primary key(emp_no, dept_no)
);

-- creates department managers table
create table dept_manager(
	dept_no varchar(4) NOT NULL references departments(dept_no),
	emp_no int NOT NULL references employees(emp_no),
	primary key (emp_no, dept_no)
);