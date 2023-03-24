## Table of Contents

1. Purpose
3. Assumptions and Requirements
4. Instructions
5. Task Breakdown

## Purpose

This code is written in Python for use with Pandas and pgAdmin 4 to fulfill Project 2 in the UofT data analytics course. 

More generally, this code is used to clean two datasets with crowdfunding data and design, set up, and query a database with and for this information. 

## Assumptions and Requirements 

Python, Pandas, Numpy, Json, datetime, PostgreSQL, and pgAdmin 4 are required to run this code. 

The datasets are assumed to be in excel files in a 'Resources' folder.

## Instructions 

Open the 'ETL_Mini_Project_SKronheim.ipynb' file and run each cell. The program will output four cleaned csv files into the "Resources" folder. 

First, two csvs with category and subcategory IDs and titles are generated and output for later insertion into a PostgreSQL database. This allows these data to be separated from the larger dataset since they repeat throughout the larger dataset. 

Next, the larger dataset for the crowdfunding data is cleaned and columns for category and subcategory IDs are added such that the larger dataset can be joined to the category and subcategory tables. This file is then output as a csv for later insertion into a PostgreSQL database. 

Finally, the contacts dataset is cleaned and exported to a csv for use in the PostgreSQL database. 

A SQL ERD is pictured in the 'schema.svg' file and shows the relationships between each table in the database. 

To set up the database, run pgAdmin4 and create a new batabase for the crowdfunding data. Import the "crowdfunding_db_schema.sql" file and run the 'CREATE TABLE'. This will create the tables that will hold the data. Next, run the 'ALTER TABLE' commands to set up the relationships between each table. 

Import the csv files: 'category.csv', 'contacts.csv', 'subcategory.csv', and 'campaign.csv'. The 'campaign.csv' file MUST be imported last, as it depends on the other tables due to foreign key restrictions. 

The queries can now be run. Each 'Select * from {Table name}' shows all columns of the specified table. To view each table, these commands must be run one at a time. The final command joins all four tables on the shared ID values, and can be run to view the full dataset with all columns. 

## Task Breakdown

My partner and I each completed the project by ourselves. We collaborated by assisting each other when we had issues. 