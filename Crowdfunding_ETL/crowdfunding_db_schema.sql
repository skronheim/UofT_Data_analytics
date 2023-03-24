-- removes tables if they exist
drop table if exists Subcategory, Category, Contacts, Campaign;

CREATE TABLE Subcategory (
    subcategory_id varchar(10)   NOT NULL,
    subcategory varchar(50)   NOT NULL,
    CONSTRAINT pk_Subcategory PRIMARY KEY (
        subcategory_id
     )
);

CREATE TABLE Category (
    category_id varchar(10)   NOT NULL,
    category varchar(50)   NOT NULL,
    CONSTRAINT pk_Category PRIMARY KEY (
        category_id
     )
);

CREATE TABLE Contacts (
    contact_id int   NOT NULL,
    first_name varchar(50)   NOT NULL,
    last_name varchar(50)   NOT NULL,
    email varchar(50)   NOT NULL,
    CONSTRAINT pk_Contacts PRIMARY KEY (
        contact_id
     )
);

CREATE TABLE Campaign (
    cf_id int   NOT NULL,
    contact_id int   NOT NULL,
    company_name varchar   NOT NULL,
    description varchar   NOT NULL,
    goal varchar   NOT NULL,
    pledged varchar   NOT NULL,
    outcome varchar   NOT NULL,
    backers_count int   NOT NULL,
    country varchar   NOT NULL,
    currency varchar   NOT NULL,
    launch_date date   NOT NULL,
    end_date date   NOT NULL,
    category_id varchar  NOT NULL,
    subcategory_id varchar   NOT NULL,
    CONSTRAINT pk_Campaign PRIMARY KEY (
        cf_id
     )
);


ALTER TABLE Campaign ADD CONSTRAINT subcategory_id FOREIGN KEY(subcategory_id)
REFERENCES Subcategory (subcategory_id);

ALTER TABLE Campaign ADD CONSTRAINT category_id FOREIGN KEY(category_id)
REFERENCES Category (category_id);

ALTER TABLE Campaign ADD CONSTRAINT contact_id FOREIGN KEY(contact_id)
REFERENCES Contacts (contact_id);

select * from campaign;

select * from category;

select * from contacts;

select * from subcategory;

select c.cf_id, con.first_name, con.last_name, con.email, c.description, c.goal, c.pledged, c.outcome, 
c.backers_count, c.country, c.currency, c.launch_date, c.end_date, c.company_name,  
cat.category, sub.subcategory, c.contact_id, c.category_id, c.subcategory_id
from campaign c
inner join category cat on 
c.category_id = cat.category_id
inner join subcategory sub on 
c.subcategory_id = sub.subcategory_id
inner join contacts con on 
c.contact_id = con.contact_id;
