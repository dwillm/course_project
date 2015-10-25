Description
This is the README file for the run_analysis.r file to explain how all of the scripts work and how they are connected.
This project is for the  Getting and Cleaning Data class on Coursera. 
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

Source Data
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Reads these data files into tables:
   features.txt
   activity_labels.txt
   subject_train.txt
   x_train.txt
   y_train.txt
   subject_test.txt
   x_test.txt
   y_test.txt

1. Merges the training and the test sets to create these data sets:
   subject <- rbind(subject_train, subject_test)
   activity <- rbind(y_train, y_test)
   feature <- rbind(X_train, X_test)

These sets are combined to create a complete dataset:
   data <- cbind(feature,activity,subject)
 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 

Extracts the mean or standard deviation into meanstd variable using the grep function:
   meanstd <- grep(".*Mean.*|.*Std.*", names(data), ignore.case=TRUE)
Add the extract to the column list
   meanstdcols <- c(meanstd, 562, 563)
Get the new extracted dataset as dataext:
  dataext <- data[,meanstdcols]

3. Uses descriptive activity names to name the activities in the data set
Merge dataext dataset with the activity table to include the descriptive activity names
Change dataext variable to character to give descriptive names from the activity_labels table
   dataext$Activity <- as.character(dataext$Activity)
   for (i in 1:6){
     dataext$Activity[dataext$Activity == i] <- as.character(activityLabels[i,2])
   }
   dataext$Activity <- as.factor(dataext$Activity)

4. Appropriately labels the data set with descriptive variable names. 
The gsub function is applied to the dataext set for pattern replacement to clean up the data labels
    names(dataext)<-gsub("Acc", "Accelerometer", names(dataext))
    names(dataext)<-gsub("Gyro", "Gyroscope", names(dataext))
    names(dataext)<-gsub("BodyBody", "Body", names(dataext))
    names(dataext)<-gsub("Mag", "Magnitude", names(dataext))
    names(dataext)<-gsub("^t", "Time", names(dataext))
    names(dataext)<-gsub("^f", "Frequency", names(dataext))
    names(dataext)<-gsub("tBody", "TimeBody", names(dataext))
    names(dataext)<-gsub("-mean()", "Mean", names(dataext), ignore.case = TRUE)
    names(dataext)<-gsub("-std()", "STD", names(dataext), ignore.case = TRUE)
    names(dataext)<-gsub("-freq()", "Frequency", names(dataext), ignore.case = TRUE)
    names(dataext)<-gsub("angle", "Angle", names(dataext))
    names(dataext)<-gsub("gravity", "Gravity", names(dataext))

Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
A tidy data set with the average for each activity and subject is extracted to a tidydataset.txt file
    write.table(tidydataset, file = "tidydataset.txt", row.names = FALSE)
