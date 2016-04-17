# Getting-and-Cleaning-Data_project

This is the course project for the Getting and Cleaning Data Coursera course. 
The R script, `run_analysis.R`, does the following:

1.	Download the dataset into the local folder

2.	Set the working directory to point to it

3.	Load the activity and feature metadata

4.	Merge similar datasets for training and test and then merge them into one big data set using rbind() for the first and cbind() for the second merge

5.	Extract and keep only those columns which reflect a mean or standard deviation

6.	Add the activity and subject column to the selected columns from above

7.	Converts the activity and subject columns into factors

8.	Modify the variable names to be descriptive

9.	Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.


The end result is shown in the file `tidy.txt`.

