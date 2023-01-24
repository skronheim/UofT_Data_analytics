# UofT_Data_analytics/Homework/Module4

## Table of Contents

1. Purpose
3. Assumptions and Requirements
4. Instructions

## Purpose

This code is written in python, for use with Jupyter Notebooks with with csv datasets, to fulfill the Module 5 Challenge homework assignment in the UofT data analytics course. 

More generally, this code is used to make and manipulate dataframes and graph data to analyze a (presumably made-up) drug trial in mice. 

## Assumptions and Requirements 

The code assumes that the data is provided in two csv files that are present in a 'data' directory that is present itself in the same directory as the python script and is formatted in columns with headers. 

Study_results should include columns for 'MouseID', 'Timepoint', 'Tumor Volume (mm3)', and 'Metastatic Sites'.

Mouse_metadata should include columns for 'MouseID', 'Drug Regimen', 'Sex', 'Age_months', and 'Weight (g)'.

Jupyter notebook, python (version 3.7.7), pandas (version 1.0.5), scipy (version 1.5.0), matplotlib (version 3.2.2), and numpy (version 1.18.5) are required to run this code. 

## Instructions 

Python script can be viewed and edited through VSCode or run and edited through Jupyter Notebook.

To run in VSCode, open the 'pymaceuticals.ipynb' file. The code will display the required DataFrames, graphs, and analyses.

To run in Jupyter Notebook, navigate to the directory containing this file,the 'data' directory, and the 'pymaceuticals.ipynb' file in the terminal. Type 'jupyter notebook' into the terminal. This should open up a browser showing the contents of the directory. Navigate into the correct directory and initialize the 'pymaceuticals.ipynb' notebook with a kernel. Run each block of code in the notebook using the controls at the top of the browser. 