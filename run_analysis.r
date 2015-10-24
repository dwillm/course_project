#read in the data from files
subject_test = read.table('test/subject_test.txt',header=FALSE)
subject_train = read.table('train/subject_train.txt',header=FALSE)

x_test       = read.table('test/x_test.txt',header=FALSE)
x_train       = read.table('train/x_train.txt',header=FALSE)

y_test       = read.table('test/y_test.txt',header=FALSE)
y_train       = read.table('train/y_train.txt',header=FALSE)

features     = read.table('features.txt',header=FALSE)
activity_labels = read.table('activity_labels.txt',header=FALSE)

#1 create column names and merge train and test sets 

colnames(activity_labels)  = c('activityId','activity_labels')
colnames(subject_train)  = "subjectId"
colnames(x_train)        = features[,2] 
colnames(y_train)        = "activityId"
train = cbind(y_train,subject_train,x_train)


colnames(subject_test) = "subjectId"
colnames(x_test)       = features[,2] 
colnames(y_test)       = "activityId"
test = cbind(y_test,subject_test,x_test)

#merge train and test sets together
data = rbind(train,test)
colNames  = colnames(data) 

#2 measurements on the mean and standard deviation for each measurement. 
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl
                 ("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))
data = data[logicalVector==TRUE]

#3 descriptive activity names
data = merge(data,activity_labels,by='activityId',all.x=TRUE)
colNames  = colnames(data) 

#4 appropriately labels the data set 
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","Standard Deviation",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","Time",colNames[i])
  colNames[i] = gsub("^(f)","Frequency",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","Accelerometer Magnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","Body Accelerometer Jerk Magnitude",colNames[i])
  colNames[i] = gsub("JerkMag","Jerk Magnitude",colNames[i])
  colNames[i] = gsub("GyroMag","Gyro Magnitude",colNames[i])
}
colnames(data) = colNames;

#5 independent tidy data set with the average of each variable for each activity and each subject
tidy = data[,names(data) != 'activity_labels'];
tidydataset = aggregate(tidy[,names(tidy) != c('activityId','subjectId')],by=list(activityId=tidy$activityId,subjectId = tidy$subjectId),mean);
tidydataset = merge(tidydataset,activity_labels,by='activityId',all.x=TRUE);

#export the tidydataset set 
write.table(tidydataset, 'tidydataset.txt',row.names=TRUE,sep='\t');
