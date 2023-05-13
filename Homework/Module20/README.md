# Module 20

## Table of Contents

1. Overview
2. Definitions 
3. Results
4. Summary

## Overview

The purpose of this analysis was to create a supervised learning model that can accurately predict whether an individual will default on a loan based on the size of the loan, the interest rate, and information about the borrower (income, debt to income ratio, number of accounts, total debt, and the derogatory marks noted for the individual, such as late payments, bankruptcy, etc.).

The healthy loans were noted as '0' in the data model, while high-risk loans were noted as '1'.

To prepare the data, the data was first read from a csv file. Next the features, which are the factors the model uses to predict the loan outcome, were separated from the outcome itself and the features were stored as X while the outcome was stored as y. The X and y datasets were then split into training and testing datasets. 

Once the data was separated, a logistic regression model was instantiated and fit to the training data and the model was used to make predictions about the testing dataset. The accuracy, recall, and precision of the model were then determined by comparing the model's predictions to the actual data in the testing dataset. 

Next, the data was resampled using RandomOverSampler to address potential issues of imbalance in the training dataset. A new logistic regression model was instantiated and fit, and metrics of its predictions were calculated. 

## Definitions:

* Precision: The percent of true predictions among all predictions. This is a measure of how much of the prediction is accurately predicted.
* Recall: The fraction of actual values that were predicted. **Recall of the high-risk loan group is the most important metric**, as a bank is likely to prefer to have all high-risk loans classified as such even at the cost of classifying some safe loans as high-risk.
* Balanced accuracy: The average of sensitivity and specificity. This metric gives an overall idea of how accurate a machine learning model is in making predictions, and works well for unbalanced data and in the event of indifference between correctly predictiing negative and positive outcomes. This is not the best measure for this model, as correctly predicting the high-risk loans is more important to a bank than predicting safe loans.

## Results

* Machine Learning Model 1:
  * Accuracy: 94.4%
  * Precision: 
    * Safe loans: 100%
    * High-risk loans: 87% 
  * Recall:
    * Safe loans: 100%
    * High-risk loans: 89%

* Machine Learning Model 2:
  * Accuracy: 99.6%
  * Precision:
    * Safe loans: 100%
    * High-risk loans: 87% 
  * Recall:
    * Safe loans: 100%
    * High-risk loans: 100%

## Summary

Both machine learning models predict safe loans with very high accuracy and precision. 

However, **the most important metric for these models is their ability to identify all high-risk loans**, as these are the loans a bank would most like to identify and avoid. This means that the most important metric is the **recall of high-risk loans**, and this is where the models score differently. 

Model 2, which was trained using oversampled data, improves the recall of high-risk loans from 89% (in Model 1) to 100%. Model 2 also improves the balanced accuracy from 94% to 99%, though the precision of high-risk loans does not change between the two models. 

This all means that Model 2 performs better, both overall and in recall of high-risk loans, and as such is the better model to use when predicting the safety of a potential load. 