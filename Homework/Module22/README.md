# Module 20

## Table of Contents

1. Overview
2. Requirements and Instructions
3. Results


## Overview

The purpose of this analysis was to analyze home sale data using PySpark, SparkSQL, and Parquet software. 

Several queries were performed:
  * Determination of the average price for a 4-bedroom house for each included year
  * Determination of the average price of a 3-bedroom, 3-bathroom home by year that the home was built
  * Determination of the average price of a 3-bedroom, 3-bathroom, 2-floor house that is greater than 2,000 square feet for each year
  * Determination of the "view" rating for homes that cost greater than or equal to $350,000

The final query above was used to determine the differences in runtime between direct use of the data from a temporary table, use of a cached table, and use of a tempoirary table made from improperly partitioned data (where the query run was not related to the partition made).

## Requirements

This code was made with PySpark, Parquet, and Findspark. This means that to successfully run the code PySpark must be properly installed, along with Hadoop, Parquet, Java, and Findspark. If using Windows, the Environment variables "SPARK_HOME", "JAVA_HOME", and "HADOOP_HOME" must be properly set up and point to the appropriate installations and the "hadoop.dll" file must be downloaded into the "C:/Windows/System32" folder. 

This was written for Jupyter Notebook, so this program must be installed and working as well.

## Results

* The query results can be seen in the Home_Sales.ipynb jupyter notebook.

* Runtime results:
  * The initial query, using uncached data with automatic partitioning, took 0.273 seconds to run
  * The same query using cached data took 0.146 seconds to run
  * The same query after using Parquet to partition the data on a field with no relation to the query took 0.547 seconds to run
* This dataset is small, so the runtimes are very short. However, the query using cached data ran the fastest, halving the runtime of the query that used uncached data. 
* The query using manually partitioned data ran the slowest, because the partition was not part of the query. 