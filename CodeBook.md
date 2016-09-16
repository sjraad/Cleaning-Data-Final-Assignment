# Code Book
This code book summarizes the analysis of a Human Activity Recognition study using smartphones performed by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Onto at Smartlab.

### The Experiment
The experiment was conducted on a 30 individuals between the ages of 19-48.  Each individual performed 6 activities while wearing a Samsung Galaxy II on the waist.  Data from the 3-axial accelerometer for velocity and acceleration was collected.  The collected dataset was randomly partitioned into two sets, Test & Training.

The full description on this experiment along with the dataset can be found on the Machine Learning Repository:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The link for the Dataset is:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### The Analysis
The downloaded dataset was manipulated for the purpose of this exercise and saved in a script file named run_analysis.R

The following steps were performed:
  * Load appropriate libraries for analysis
  * Check if a directory to store downloaded data exists, if not, create one
  * Download the dataset from the link above and unzip the file
  * Read all relevant tables for the analysis and set column labels when appropriate (see Table list)
  * Extract only columns containing Mean and Standard Deviation (std) from the dataset
  * Tidy dataset by removing symbols from column labels by using a function (see Function)
  * Merge Test and Training sets into one table
  * From the tidy dataset, create a 2nd tidy dataset with the average of each variable for each activity and subject
  * Save the result to a text file called MeanSTDdataset.txt

### Original Data Tables
  * X_test
  * Y_test
  * subject-test
  * x_train
  * y_train
  * subject_train
  * activity_labels
  * features

### Variables
  * x_test, y_test, and subjectTest - contain dataset from Testing tables
  * x_training, y_training, subjectTraining - contain dataset from Train tables
  * Activity - contain dataset from the activity_labels table, and names the columns as activityID & activityName respectively
  * ActivityName - changes the class of the Activity variable to character
  * Features - contains dataset from the features table, and names the columns as featureID & featureName respectively
  * FeaturesName - changes the class of the Features variable to character
  * FeaturesWanted - extracts only columns with mean and std from the  FeaturesName data frame and performs an additional step to select only the second column (contains features data) from the Features table
  * mgsub - is the function that allows for multiple gsub steps to be combined into one, and cleans up all symbols form the FeaturesWanted column labels
  * test - combines of x-test, y-test, subjectTest into one table
  * training - combines of x-training, y-training, subjectTraining into one table
  * mergedDATA - combines of test and training tables into one
  * colnames(mergedDATA) - labels the columns for the mergedDATA table
  * mergedDATA$activity & mergedDATA$subject - converts activity and subject into factors
  * MeltMergedData & MeanMergedData - reshapes the data and recreates output into a dataset that with the average (mean) for each variable and for each activity

### Function
I created a function (mgsub) to combine multiple gsub steps into one.  Original is what you want to replace, and replacement is what you want to replace with.

### Activities
  * WALKING
  * WALKING_UPSTAIRS
  * WALKING_DOWNSTAIRS
  * SITTING
  * STANDING
  * LAYING
