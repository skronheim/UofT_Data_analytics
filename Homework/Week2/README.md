# UofT_Data_analytics/Homework/Week2

## Table of Contents

1. Purpose
2. Assumptions and Requirements
3. Instructions

## Purpose

This code is written in VBA, for use with Excel datasets, to fulfill the "VBA-challenge" homework assignment in the UofT data analytics course. 

More generally, this code is used to automate analysis and summary of stock data for a period of time. 

## Assumptions, Requirements, and Runtime 

The code assumes that the data is provided in an Excel file, formatted in columns with headers starting at cell A1. The code can take indefinite formatted worksheets.

Sheets should consist of one of each column: ticker, date, open price, high, low, close price, and stock volume in order.

The code starts by sorting by ticker and then by date, so sorting within the columns doesn't matter.

Summary statistics are based on whatever timeframe is represented in the data; for homework purposes, the assumption is one year per sheet but the exact number of datapoints doesn't matter except to runtime.

This code can take a while to run: I've observed it taking ~5 minutes per sheet for the full dataset to run on a 4-year old laptop (so ~15 minutes total), and ~25 seconds per sheet on a higher-powered desktop (so ~1.25 minutes total).


## Instructions 

The single VBA file has everything required. 

1. Open the Excel file with the provided data
2. Open the Developer tab and VisualBasic
3. Import the VBA code (*.bas file)
4. Run the code from the Excel (choose the macro) or F5 from the VBA editor