#Loading Required libraries
library(reshape2)
library(dplyr)
#saving your current working directory path
wd <- getwd()
#changing the working directory to the folder of the extracted data
setwd("./UCI HAR Dataset")
#reading data from features and processing
features <- read.csv("features.txt", sep = " ", header = F, col.names = c("MeasurementID", "Measurement") )
cols <- features[grep("mean()", features$Measurement, value = F), 1]
rcols <- features[grep("meanFreq()", features$Measurement, value = F), 1]
means <- setdiff(cols, rcols)
stds <- features[grep("std()", features$Measurement, value = F), 1]
append(means, stds) %>% sort() -> req_cols
activity_labels <- read.csv("activity_labels.txt", sep = " ", header = F, col.names = c("ActivityID", "Activity"))
#merging test subjects and test activities
xsub <- read.csv("./test/subject_test.txt", header = F, col.names = "Subject")
xactivity <- read.csv("./test/y_test.txt", header = F, col.names = "Activity")
xs_a <- cbind(xsub, xactivity)
#merging training subjects and training activities
ysub <- read.csv("./train/subject_train.txt", header = F, col.names = "Subject" )
yactivity <- read.csv("./train/y_train.txt", header = F, col.names = "Activity" )
ys_a <- cbind(ysub, yactivity)
#combining test and training subjects and activities
s_a <- rbind(xs_a, ys_a)
#extracting test data
xTest <- read.table("./test/X_test.txt", sep = "", header = F)
names(xTest) <- 1:561
#extracting training data
xTrain <- read.table("./train/X_train.txt", sep="")
names(xTrain) <- 1:561
#combining test and training data
X <- rbind(xTest, xTrain)
#subsetting the required data of std's and means
X_trim <- X[, req_cols]
#merging data with subjects and activities
xComplete <- cbind(s_a, X_trim)
#changing the wide format to long format
xCom <- melt(xComplete, id.vars=c("Subject","Activity"))
names(xCom) <- c("Subject", "ActivityID", "MeasurementID", "Value")
#grouping by subject, activity and measurement and summerizing to mean, assigning labels to IDs' sorting by subject, activity and measurement
group_by(xCom, Subject, ActivityID, MeasurementID) %>% summarize(MeanValue = mean(Value)) %>% merge(activity_labels, by = "ActivityID", all = T) %>% merge(features[req_cols, ], by = "MeasurementID", all = T) %>% arrange(Subject, ActivityID, MeasurementID) %>% select ( Subject, Activity, Measurement, MeanValue) -> xResult
#exporting tidy data to text file
setwd(wd)
write.table(xResult, file = "tidyData.txt", sep = " ", row.name = F, col.names = T)
