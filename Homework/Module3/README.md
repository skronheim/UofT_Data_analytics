# UofT_Data_analytics/Homework/Module3

## Table of Contents

1. Purpose
2. Of Note
3. Assumptions and Requirements
4. Instructions

## Purpose

This code is written in python, for use with csv datasets, to fulfill the "Python-challenge" homework assignment in the UofT data analytics course. 

More generally, this code is used to automate analysis and summary of financial data over a period of time and election data. 

## Of Note

For this assignment, I used 'csv.DictReader' instead of 'csv.reader' to read the csv files. The DictReader loads the files by row into dictionaries with keys equal to the column headers, instead of loading each row into a list with the header row being the first list. This means that the next() function used to move past and save the header row in the standard 'csv.reader' is unnecessary and not how my code works. I did however save the header row by saving each unique dictionary key to a variable.

## Assumptions and Requirements 

The code assumes that the data is provided in a csv file that is present in a 'Resources' directory that is present itself in the same directory as the python sctipt and is formatted in columns with headers. 

Financial data should include columns for month and profit/losses. Number of months doesn't matter.

Election data should include a column for candidate voted for; number of candidates doesn't matter.

## Instructions 

Both python sctipts are run the same way; navigate to the appropriate directory and run the main.py file.

Each main.py file prints an output to the terminal and writes a .txt file with the same information into the directory in which the main.py file resides. 
