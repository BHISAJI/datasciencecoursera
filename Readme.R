This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

I assumed data is already down loaded and extracted in folder as 'UCI HAR Dataset'
First capture activity labels & features
act_Labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

 separated out mean and standard deviation:

features1 <- grep(".*mean.*|.*std.*", features[,2])
features1.names <- features[features1,2]

Loaded the datasets and finally conbine into one table:

train <- read.table("UCI HAR Dataset/train/X_train.txt")[features1]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subjects, train_activities, train)

Similarly for test dataset:
test <- read.table("UCI HAR Dataset/test/X_test.txt")[features1]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects, test_activities, test)

merge datasets into Tatal_Data and added labels
Total_Data <- rbind(train, test)
colnames(Total_Data) <- c("subject", "activity", features1.names)


 activities & subjects into factorised to build final tidy data file.
Total_Data$activity <- factor(Total_Data$activity, levels = act_Labels[,1], labels = act_Labels[,2])
Total_Data$subject <- as.factor(Total_Data$subject)
 
Importent operations for building tidy data
Total_Data.melted <- melt(Total_Data, id = c("subject", "activity"))

finally creates a tidy dataset that having  of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file tidy.txt:

Total_Data.mean <- dcast(Total_Data.melted, subject + activity ~ variable, mean)

write.table(Total_Data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)