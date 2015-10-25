Description
This is the code book for the course project in the Getting and Cleaning Data class on Coursera and describes the variables, the data, and any transformations or work performed to clean up the data from the following source:

    Source Data
    
    One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
    
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
    
    Here are the data for the project: 
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

downlaoded and unzipped from the above zip file is the supporting data about the data (metadata) files in:
features.txt
activity_labels.txt

Here are the actual data files that are read into tables:

subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt

1. Merges the training and the test sets to create one data set.
using rbind, these training and test tables are then merged into three varibles:
subject <- rbind(subject_train, subject_test)
activity <- rbind(y_train, y_test)
feature <- rbind(X_train, X_test)

These varibales are ultimately combiuned to create a complete dataset:
data <- cbind(feature,activity,subject)
 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 

Extract the mean or standard deviation into the meanstd variable:
meanstd and add the extract to the column list using the meanstdcols variable
get the new extracted dataset in the dataext variable:
dataext <- data[,meanstdcols]

3. Uses descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to cinlude the descriptive activity names
Change dataext variable to character to give descriptive names from the activity_labels table

4. Appropriately labels the data set with descriptive variable names. 
the gsub function is applied to dataext for pattern replacement to clean up the data labels

Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
A tidy data set with the average for each activity and subject is produces and then extrated it to a tidydataset.txt file with write.table() using row.name=FALSE 
