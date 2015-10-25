##Getting and Cleaning Data Course Project

###Description
This is the code book for the course project in the Getting and Cleaning Data class on Coursera and describes the variables, the data, and any transformations or work performed to clean up the data from the following source:

###Source Data
    One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
    
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
    
    Here are the data for the project: 
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###1. Merges the training and the test sets to create one data set.
Downloaded and unzipped from the above zip file are metadata files: 
- features.txt
- activity_labels.txt
Downloaded and unzipped from the above zip file are the actual data files that are read into tables:
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

Assign names and merge into a complete dataset:

###2. Extracts only the measurements on the mean and standard deviation for each measurement. 
Extract the mean or standard deviation and add the extract to the column list using the meanstdcols variable
Get the new extracted dataset

###3. Uses descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to include the descriptive activity names
Change dataext variable to character to give descriptive names from the activity_labels table

###4. Appropriately labels the data set with descriptive variable names. 
The gsub function is applied to dataext for pattern replacement to clean up the data labels

###5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
A tidy data set with the average for each activity and subject is produces and then extrated it to a tidydataset.txt file with write.table() using row.name=FALSE 
