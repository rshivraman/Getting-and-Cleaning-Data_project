# My Code for the Getting and Cleaning Project:

# Downloaded the zipped file “getdata-projectfiles-UCI HAR Dataset” in a local directory
# Set the working directory to point to that directory

setwd("C:\\Users\\Raj Shivraman\\Documents\\Data Scientist\\R Programming\\Wrk_dir\\getdata-projectfiles-UCI HAR Dataset")

# Verify the Working Directory 
getwd()

# Read Metadata for the name of the features and the name of the activities
featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Merge the training and the test sets to create one data set
# Read training data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE) 

# Read test data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

# combine the subject, activity and features training and test data sets
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

# Name the columns in features using featureNames
colnames(features) <- t(featureNames[2]) 


# Merge the Data in features, activity and subject 
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
mergeData <- cbind(features,activity,subject)

# Extract only the measurements on the mean and standard deviation for each measurement
# Extract the column indices with either mean or std 
colsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(mergeData), ignore.case=TRUE)
# add activity and subject columns to the selected columns
requiredColumns <- c(colsWithMeanSTD, 562, 563)
# create dataset with selected columns
extrData <- mergeData[,requiredColumns]

# Factor variables are hard to update when cleaning data 
# activity is numeric so cannot accept activity names
# So first convert the variable to character with as.character() to handle it as a character vector
extrData$Activity <- as.character(extrData$Activity)
for (i in 1:6){
extrData$Activity[extrData$Activity == i] <- as.character(activityLabels[i,2])
} 

# then convert it to factor using as.factor() at the end
extrData$Activity <- as.factor(extrData$Activity)
# Modify labels to descriptive names
names(extrData)<-gsub("Acc", "Accelerometer", names(extrData))
names(extrData)<-gsub("Gyro", "Gyroscope", names(extrData))
names(extrData)<-gsub("BodyBody", "Body", names(extrData))
names(extrData)<-gsub("Mag", "Magnitude", names(extrData))
names(extrData)<-gsub("^t", "Time", names(extrData))
names(extrData)<-gsub("^f", "Frequency", names(extrData))
names(extrData)<-gsub("tBody", "TimeBody", names(extrData))
names(extrData)<-gsub("-mean()", "Mean", names(extrData), ignore.case = TRUE)
names(extrData)<-gsub("-std()", "STD", names(extrData), ignore.case = TRUE)
names(extrData)<-gsub("-freq()", "Frequency", names(extrData), ignore.case = TRUE)
names(extrData)<-gsub("angle", "Angle", names(extrData))
names(extrData)<-gsub("gravity", "Gravity", names(extrData))

# Subject as a factor variable
extrData$Subject <- as.factor(extrData$Subject)
extrData <- data.table(extrData)

# Finally create tidyData with average for each activity and subject. 
tidyData <- aggregate(. ~Subject + Activity, extrData, mean)

# Order the data
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

# write it into data file
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)  
