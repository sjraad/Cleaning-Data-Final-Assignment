library(dplyr)
library(reshape2)

# CHECK FOR DIRECTORY AND CREATE IF IT DOESN'T EXIST, DOWNLOAD DATA & EXTRACT FILE
## Check for dir and create one if needed, download file
if(!file.exists("./Assignment")){dir.create("./Assignment")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./Assignment/dataset.zip", method = "curl")

## Unzip dataset to directory "Assignment"
unzip(zipfile = "./Assignment/dataset.zip", exdir = "./Assignment")

# READ DATA FORM DONWLOADED FILES,  AND MERGE TO CREATE ONE DATASET
## Read Testing Tables
x_test <- read.table("./Assignment/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./Assignment/UCI HAR Dataset/test/Y_test.txt")
subjectTest <- read.table("./Assignment/UCI HAR Dataset/test/subject_test.txt")

## Read Training Tables
x_training <- read.table("./Assignment/UCI HAR Dataset/train/X_train.txt")
y_training <- read.table("./Assignment/UCI HAR Dataset/train/Y_train.txt")
subjectTraining <- read.table("./Assignment/UCI HAR Dataset/train/subject_train.txt")

## Read Activitie Set and add column labels
Activity <- read.table("./Assignment/UCI HAR Dataset/activity_labels.txt", col.names = c("activityID", "activityName"))
ActivityName <- as.character(Activity$activityName)

## Read Features Set and add column labels
Features <- read.table("./Assignment/UCI HAR Dataset/features.txt", col.names = c("featureID", "featureName"))
FeaturesName <- as.character(Features$featureName)

## Extract Mean and STD and clean data
FeaturesWanted <- grep(".*mean.*|.*std.*", FeaturesName)
FeaturesWanted <- Features[FeaturesWanted, 2]

## Remove symbols and tidy column names
mgsub <- function(original, replacement, x, ...) {
    result <- x
    for (i in 1:length(original)) {
        result <- gsub(original[i], replacement[i], result, ...)
    }
    result
}
FeaturesWanted <- mgsub(c("-mean", "-std", "-X", "-Y", "-Z"), c("mean", "std", "X", "Y", "Z"), FeaturesWanted)

## Merge test and training sets into one dataset named mergedDATA  and add labesl
test <- cbind(subjectTest, y_test, x_test)
training <- cbind(subjectTraining, y_training, x_training)
mergedDATA <- rbind(training, test)
colnames(mergedDATA) <- c("subject", "activity", FeaturesWanted)

## Turn dataset column headngs into factors
mergedDATA$activity <- factor(mergedDATA$activity, levels = Activity[, 1], labels = ActivityName)
mergedDATA$subject <- as.factor(mergedDATA$subject)

# A SECOND LEVEL OF TIDY DATASET
## Create a dataset with the average of each variable for each activity and subject
MeltMergedData <- melt(mergedDATA, id = c("subject", "activity"))
MeanMergedData <- dcast(MeltMergedData, subject + activity ~ variable, mean)

# WRITE FINAL TIDY DATASET CALLED (MeanSTDdataset) TO A .TXT FILE
write.table(MeanMergedData, "./Assignment/GitHub/MeanSTDdataset.txt", row.name = FALSE)
