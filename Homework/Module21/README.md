# Module 20

## Table of Contents

1. Overview
2. Results
  1. Data Preprocessing
  2. Model Preparation and Evaluation
3. Summary

## Overview

The purpose of this analysis was to create a supervised machine learning model that can predict whether an applicant for Alphabet Soup funding is likely to succeed with their venture and therefore use the provided money well. Alphabet Soup ideally wants to fund the companies with the best chance of success. 

## Results

### Data Preprocessing

* Success is the target variable, which is accounted for in the "IS_SUCCESSFUL" column of the data. 

* The features on which success is predicted are:
  * APPLICATION_TYPE
    * The type of Alphabet Soup application
  * AFFILIATION
    * The affiliated sector of industry
  * CLASSIFICATION
    * The government organization classification
  * USE_CASE
    * The use case for funding
  * ORGANIZATION
    * The organization type
  * STATUS
    * The active status
  * INCOME_AMT
    * The income band
  * SPECIAL_CONSIDERATIONS
    * Whether there are any special considerations
  * ASK_AMT
    * The funding amount requested

* The identification columns ("EIN" and "NAME") were removed, as they only serve to identify the applicant and as such provide no information about the loan or the company that could contribute to success or failure.

* The "APPLICATION_TYPE" and "CLASSIFICATION" columns were condensed, with all application types and classifications with relatively few applicants (under 500 applicants per application type, and under 1000 applicants per classification) were binned under "Other" categories.

* To complete preprocessing, the categorical values were encoded, the data was split into training and testing sets, and the features in both training and testing sets were normalized. 

* The final features count was 43.

### Model Preparation and Evaluation

* Initially I used 2 hidden layers for my model, with 80 neurons and 30 neurons respectively. 
  * The two hidden layers used the "relu" function for activation.
  * The output layer used "sigmoid" for activation.
* This conformation was an arbitrary first test run of the model, and it resulted in an accuracy of 72.9%. A higher accuracy score was desired, however. 

* To optimize the model, I performed hyperparameter tuning to see if there was an optimal set of hyperparameters that would improve the accuracy of the model. 
  * The first optimization was testing different activation functions. 
    * I tested "relu", "tanh", and "sigmoid" activation functions.
  * Next, I tested different numbers of neurons in the first hidden layer.
    * I tested a range of 80-200 layers with a step of 40, because I hoped increasing the number of neurons in the first layer from the initial 80 would improve accuracy.
  * Finally, I tested different numbers of middle hidden layers with different numbers of neurons.
    * For the number of hidden layers, I started at 2 (to increase the number of hidden layers by 1 from my initial model, as I hoped this would improve accuracy) and increased the layers to a maximum of 8.
    * For the number of neurons in these hidden layers, I started at 20 and increased to 180 with a step of 40. Again, the idea was to increase the number of neurons from the initial 30 to see if that could improve accuracy.
* The final hyperparameters after optimization were:
  * Activation function: sigmoid
  * Hidden layers: 5, including the initial hidden layer (and not including the output layer)
    * Neurons in the first layer: 160
    * Neurons in the second layer: 100
    * Neurons in the third layer: 20
    * Neurons in the fourth layer: 100
    * Neurons in the fifth layer: 60
* After determining the optimal hyperparameters, I trained the optimal model on the data for 100 epochs.
* The optimization process improved the model accuracy by 0.09% to 73% accuracy.

## Summary

Overall, the sequential deep neural network does not perform well to predict which funding applications are most likely to succeed. It only provides 73% accuracy at best, after significant optimization, which is not very good. This may indicate that not many patterns are available to predict on in this dataset. However, many features are present. A random forest model could perhaps provide better results, if the lack of accuracy in the neural network model is due to missing factors, and at the very least would be a very different model to test on this data.