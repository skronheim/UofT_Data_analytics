## Table of Contents

1. Purpose
3. Assumptions and Requirements
4. Instructions

## Purpose

This code is written in Python for use with SqLite to fulfill the Module 10 Challenge homework assignment in the UofT data analytics course. 

More generally, this code is used to query a database with Temperature and Precipitation data for various stations in Hawaii, and to set up an API to show these data from specific queries. 

## Assumptions and Requirements 

Python, Jupyter Notebook, Numpy, Datetime, Flask, Pandas, Matplotlib, SqlAlchemy version 1.3.17, and SqLite version 3.40.1 are required to run this code. 

A 'Resources' folder containing the Hawaii.sqlite database is also required. 

## Instructions 

To run the Jupyter Notebook, just open the 'climate_starter.ipynb' file and run each cell. 

To utilize the API, initialize the 'app.py' file in a terminal and then navigate to 'localhost:5000/' in a browser. This will bring you to the home page of the app, which shows the various possible endpoints. Navigate to an endpoint to view the associated data.

You can also query the API from a separate python file or terminal using a get request, but that is not set up here. 