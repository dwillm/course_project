#You should create one R script called run_analysis.R that does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#read in data files
features <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt", header = FALSE)

subject_train <- read.table("train/subject_train.txt", header = FALSE)
y_train <- read.table("train/y_train.txt", header = FALSE)
X_train <- read.table("train/X_train.txt", header = FALSE)

subject_test <- read.table("test/subject_test.txt", header = FALSE)
y_test <- read.table("test/y_test.txt", header = FALSE)
X_test <- read.table("test/X_test.txt", header = FALSE)

#1 Merges the training and the test sets to create one data set.
subject <- rbind(subject_train, subject_test)
activity <- rbind(y_train, y_test)
feature <- rbind(X_train, X_test)

#column names for features
colnames(feature) <- t(features[2])

#merge all sets to a complete data set 
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
data <- cbind(feature,activity,subject)

#2 Extracts only the measurements on the mean and standard deviation for each measurement.
meanstd <- grep(".*Mean.*|.*Std.*", names(data), ignore.case=TRUE)
meanstdcols <- c(meanstd, 562, 563)
dataext <- data[,meanstdcols]

#3 Uses descriptive activity names to name the activities in the data set
dataext$Activity <- as.character(dataext$Activity)
for (i in 1:6){
  dataext$Activity[dataext$Activity == i] <- as.character(activityLabels[i,2])
}
dataext$Activity <- as.factor(dataext$Activity)

#4 Appropriately labels the data set with descriptive variable names. 
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

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dataext$Subject <- as.factor(dataext$Subject)
dataext <- data.table(dataext)
tidydataset <- aggregate(. ~Subject + Activity, dataext, mean)
tidydataset <- tidydataset[order(tidydataset$Subject,tidydataset$Activity),]
write.table(tidydataset, file = "tidydataset.txt", row.names = FALSE)
