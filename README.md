##Getting and Cleaning Data Course Project
This is the README file for the run_analysis.r file to explain how all of the scripts work and how they are connected.

###Source Data
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The features and can be found in the x_test.txt and x_train.txt files. The activity labels are in the y_test.txt and y_train.txt files. The test subjects are in the subject_test.txt and subject_train.txt files.

###Project Overview
Create and R script called run_analysis.R does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###About the run_analysis.r script and tidy data set
Script assumes that the above source data has been downloaded, unzipped and is in the working directory.
The run_analysis.R which will merge the test and training sets together, then
labels are added and only columns that have to do with mean and standard deviation are kept.
The script will create a tidy data set containing the means of all the subjects and activities. 
This tidy dataset will be written to a file called tidydataset.txt, which is also included in this repository

### About the Code Book
Additional information about the variables, data and transformations can be found in the CodeBook.MD file.


