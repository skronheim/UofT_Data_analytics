# UofT_Data_analytics/Homework/Module4

## Table of Contents

1. Purpose
2. Of Note
3. Assumptions and Requirements
4. Instructions

## Purpose

This code is written in python, for use with Jupyter Notebooks with the Openweathermap and Geoapify APIs, to fulfill the Module 6 Challenge homework assignment in the UofT data analytics course. 

More generally, this code is used to collect and compare weather data for a random sample of approximately 500-600 cities and find ideal vacation spots based on the weather. 

## Of Note

This code runs by first generating a random list of cities. Re-running this part of the code will change the number and identity of the cities involved, and as such will change the output graphs. This is particularly important for the regression lines and subsequent analysis; drastic changes in the r-values of the correlations could occur and would change the validity of the analysis.

## Assumptions and Requirements 

Jupyter notebook, python (version 3.7.7), pandas (version 1.0.5), scipy (version 1.5.0), matplotlib (version 3.2.2), numpy (version 1.18.5), requests, time, geoviews, cartopy, pyviz, hvplot, and API keys for Openweathermap and Geoapify are required to run this code. 

## Instructions 

Python script can be viewed and edited through VSCode or run and edited through Jupyter Notebook.

To run the full code, including the API requests, create a file in the WeatherPy directory called 'api_keys.py' and assign your Opneweathermap and Geoapify API keys to the variables 'weather_api_key' and 'geoapify_key' respectively. The code will pull the keys from this file to run the get requests.

To run in VSCode, open the 'WeatherPy.ipynb' file and the 'VacationPy.ipynb' file. The code will display the required DataFrames, graphs, maps, and analyses.

To run in Jupyter Notebook, navigate to the directory containing these files in the terminal. Type 'jupyter notebook' into the terminal. This should open up a browser showing the contents of the directory. Navigate into the correct directory and initialize the correct notebooks with a kernel. Run each block of code in the notebook using the controls at the top of the browser. 