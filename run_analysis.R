##datadir <- "001-Data"
## download data
##download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","getdata-projectfiles-UCI HAR Dataset.zip",method="curl")
## uncompress data
print("Unziping file")
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

## read features.txt file
features <- read.table("UCI HAR Dataset/features.txt",col.names=c("Feature.number","Feature"))
head(features)

## read subject_test.txt file from test directory
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names="Subject",header=FALSE)
head(subject_test)

## read y_test.txt file from test directory
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",col.names="Labels",check.names=FALSE)
head(y_test)

## read x_test.txt file from test directory
x_test <- read.table("UCI HAR Dataset/test/x_test.txt",col.names=features[,2],check.names=FALSE)
head(x_test)

## keep only mean and std deviation columns in x_test
toMatch <- c("mean\\(\\)[-]|std\\(\\)[-]") # create character vector with match
matches <- unique(grep(toMatch,features[,2],value=TRUE)) # make it unique
x_test <- subset(x_test,select=matches) # subset only the columns that match
test <- cbind(subject_test,y_test,x_test) # bind all together

## do the same for train files from train directory
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                            col.names="Subject")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",
                      col.names="Labels",check.names=FALSE)
x_train <- read.table("UCI HAR Dataset/train/x_train.txt",
                      col.names=features[,2],check.names=FALSE)
x_train <- subset(x_train,select=matches)
train <- cbind(subject_train,y_train,x_train)

# bind test and train data together
test_train <- rbind(test,train) 

## read activities file
activities <- read.table("UCI HAR Dataset/activity_labels.txt",col.names=c("Activity","Activity.Description"))
## bind data with activities labels
df1 <- merge(activities,test_train,by.y="Labels",by.x="Activity",all.x=TRUE,all.y=FALSE)
## melt df1 with activity and subject as id's
library(reshape2)
df1Melted <- melt(df1,id=c("Subject","Activity"),measure.vars=names(df1)[c(-1,-2,-3)])
## dcast df1Melted with mean as aggregate function
df1Dcast <- dcast(df1Melted,Subject + Activity ~ variable,fun.aggregate=mean)
## change column names to comply with the aggregation
measureCols <- colnames(df1Dcast)[3:50]
colnames(df1Dcast)[3:50] <- paste("MeanOf",measureCols,sep="-")
## write 2nd tidy dataset
write.csv(df1Dcast,"tidy2.csv",row.names=F)
## read written tidy data to see if everything is ok
tidy <- read.csv("tidy2.csv")
## list first rows of tidy data
head(tidy)
dim(tidy)