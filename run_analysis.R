library(reshape2)
setwd('F:/data science JH')
# capture activity labels & features
act_Labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
act_Labels[,2] <- as.character(act_Labels[,2])
# separate out mean and standard deviation
features1 <- grep(".*mean.*|.*std.*", features[,2])
features1.names <- features[features1,2]


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features1]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subjects, train_activities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[features1]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects, test_activities, test)

# merge datasets and add labels
Total_Data <- rbind(train, test)
colnames(Total_Data) <- c("subject", "activity", features1.names)

# turn activities & subjects into factors
Total_Data$activity <- factor(Total_Data$activity, levels = act_Labels[,1], labels = act_Labels[,2])
Total_Data$subject <- as.factor(Total_Data$subject)

Total_Data.melted <- melt(Total_Data, id = c("subject", "activity"))
Total_Data.mean <- dcast(Total_Data.melted, subject + activity ~ variable, mean)

write.table(Total_Data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)