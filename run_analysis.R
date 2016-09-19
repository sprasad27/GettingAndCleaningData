# Download the zip file from the url 
setwd("/Users/sushmaprasad/dataCleaning/data")
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataUrl, destfile="Dataset.zip", method="curl")

# set working directory
setwd("/Users/sushmaprasad/dataCleaning/data/UCIHARDataset")

# Read activity_labels
activity <- read.table("activity_labels.txt")

# Read column headers from features.txt
data_headers <- read.table("features.txt")

loaddataset <- function(dataset_path, vector_filename,activity_filename, subject_filename,  data_headers) {
  ###########################################################
  # Helper function to read the dataset given name and path
  # return: merged dataset with the activity and subject added
  ############################################################
  
  # Read given dataset 561 feature vector
    data <- read.table(file.path(paste(dataset_path, "/",vector_filename, sep = "")))
  
  # Read activity labels
  labels <- read.table(file.path(paste(dataset_path, "/", activity_filename, sep = "")))
  
  # Read dataset subject
  subject <- read.table(file.path(paste(dataset_path, "/", subject_filename, sep = "")))
  
  # Add column headers to data set
  names(data) <- data_headers$V2
  
  # Add labels & subject to data
  data$subject.id <- subject$V1
  data$activity.label <- labels$V1
  
  # merge activity lables with dataset
  merged_data <- merge(data , activity, by.x="activity.label", by.y="V1")
  # update column name for activity.label
  colnames(merged_data)[564] <- "activity.name"
  
  return (merged_data) # return merged data

}

# load training_data_set
training_data_set <- loaddataset("train","X_train.txt","y_train.txt","subject_train.txt",data_headers)

# load_test_data_set
test_data_set <- loaddataset("test","X_test.txt", "y_test.txt", "subject_test.txt", data_headers)

# 1.Merges the training and the test sets to create one data set. 
#combine the two datasets
combined_data <- rbind(training_data_set, test_data_set)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set

mean_columns <-( (grep("mean\\(\\)", names(combined_data), value = TRUE))
std_columns <- (grep("std\\(\\)", names(combined_data), value = TRUE))
extracted_data<- combined_data[, c(mean_columns, std_columns)]
# Add subject id and activity.name columns to extracted_data and rename the columns
extracted_data <- cbind(combined_data$subject.id, combined_data$activity.name, extracted_data)

# 4. Appropriately labels the data set with descriptive variable names.
library("plyr")
extracted_data <- rename(extracted_data, c("combined_data$subject.id" ="subject.id", "combined_data$activity.name" = "activity.name"))

names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("std", "stdev", names(extracted_data))
names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library("reshape2")
tmp <- melt(extracted_data, id=c("subject.id","activity.name"))
tidy_data <- dcast(tmp, subject.id+activity.name ~ variable, mean)

write.table(extracted_data, "tidy_data.txt" , row.names=FALSE)
write.csv(tidy_data, "tidy_data.csv", row.names=FALSE)