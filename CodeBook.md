## PROCESS

The script run_analysis.R performs the following steps described in the course project's definition.

* Sets the Working directory to point to the location where the zipped file “getdata-projectfiles-UCI HAR Dataset” is downloaded. 

* Next it reads the metadata for feature names and activity names

* Then it reads the Training and Test data and merges the similar data using rbind(). The three similar files are subject, activity and features

* Afterwards it merges the Data in features, activity and subject using cbind()

* Then it extracts only the measurements on the mean and standard deviation for each measurement

* Then the column names are corrected for descriptive names

* Finally it generates the file Tidy.txt ordered by subject and activity name with the average measures


## VARIABLES

* featureNames and activityLabels contain the metadata i.e. the name of the features and the name of the activities respectively

* subjectTrain, activityTrain, featuresTrain, subjectTest, activityTest, and featuresTest contain data from the downloaded files

* subject, activity and features combine the similar training and test datasets

* mergedata contains the merged data from features, activity and subject datasets into a big dataset

* extrdata contains only the only the measurements on the mean and standard deviation for each measurement 

* tidyData contains the average for each activity and subject

* Finally a test file Tidy.txt is used to store the data from tidyData above 

