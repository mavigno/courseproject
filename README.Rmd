Getting and Cleaning Data Course Project
========================================================

This README describes how the submitted script *run_analysis.R* works.

### Uncompress dataset 
The script will expect a dataset alredy downloaded with the name **getdata-projectfiles-UCI HAR Dataset.zip** in the working directory. To decompress it will use the function *unzip*.
### Reading data
It will read all the **test** data and **train** data and perform the necessary transformations in the following order:

1. read features.txt file
1. read subject_test.txt file from test directory
1. read y_test.txt file from test directory
1. read x_test.txt file from test directory
1. keep only mean and std deviation columns in x_test
1. do the same steps above for train files in the train directory

### Merge the the test and train datasets together using rbind
### Merge the resulting dataset with the activities dataset to get the activities description

1. read activities file
1. bind data with activities labels using merge

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. melt df1 with activity and subject as id's
1. dcast df1Melted with mean as aggregate function
1. change column names to comply with the aggregation
1. write 2nd tidy dataset
1. read written tidy data to see if everything is ok


