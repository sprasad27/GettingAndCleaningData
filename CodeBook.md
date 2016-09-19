# CodeBook.md

The run_analysis.R scripts downloads the data and performs a number of steps in the order below to create a tidy_data file.

Original datasource:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


Data Cleaning Process:

1. The activity labels from the activity_labels.txt and the complete list of feature variables are read into two different dataframes.
2. A common function - loaddataset is called on each of the datasets - training and test datasets. This function reads the subject_* files and the y_* files from original datasource and adds them to the X_* dataset files. The function also adds the different entries from features.txt as column headers to the X_* datasets.
3. The processed data sets returned from the loaddataset function are stored in training and test dataframes and combined together using rbind.
4. The combined dataset is then melted using the reshape library to create a tidy dataset.

Columns in output file

The columns included in the output file are listed below:

subject.id  
activity.name	
TimeBodyAccelerometer-mean()-X	
TimeBodyAccelerometer-mean()-Y	
TimeBodyAccelerometer-mean()-Z	
TimeGravityAccelerometer-mean()-X	
TimeGravityAccelerometer-mean()-Y	
TimeGravityAccelerometer-mean()-Z	
TimeBodyAccelerometerJerk-mean()-X	
TimeBodyAccelerometerJerk-mean()-Y	
TimeBodyAccelerometerJerk-mean()-Z	
TimeBodyGyroscope-mean()-X	
TimeBodyGyroscope-mean()-Y	
TimeBodyGyroscope-mean()-Z	
TimeBodyGyroscopeJerk-mean()-X	
TimeBodyGyroscopeJerk-mean()-Y	
TimeBodyGyroscopeJerk-mean()-Z	
TimeBodyAccelerometerMag-mean()	
TimeGravityAccelerometerMag-mean()	
TimeBodyAccelerometerJerkMag-mean()	
TimeBodyGyroscopeMag-mean()	
TimeBodyGyroscopeJerkMag-mean()	
FrequencyBodyAccelerometer-mean()-X	
FrequencyBodyAccelerometer-mean()-Y	
FrequencyBodyAccelerometer-mean()-Z	
FrequencyBodyAccelerometerJerk-mean()-X	
FrequencyBodyAccelerometerJerk-mean()-Y	
FrequencyBodyAccelerometerJerk-mean()-Z	
FrequencyBodyGyroscope-mean()-X	
FrequencyBodyGyroscope-mean()-Y	
FrequencyBodyGyroscope-mean()-Z	
FrequencyBodyAccelerometerMag-mean()	
FrequencyBodyBodyAccelerometerJerkMag-mean()	
FrequencyBodyBodyGyroscopeMag-mean()	
FrequencyBodyBodyGyroscopeJerkMag-mean()	
TimeBodyAccelerometer-stdev()-X	
TimeBodyAccelerometer-stdev()-Y	
TimeBodyAccelerometer-stdev()-Z	
TimeGravityAccelerometer-stdev()-X	
TimeGravityAccelerometer-stdev()-Y	
TimeGravityAccelerometer-stdev()-Z	
TimeBodyAccelerometerJerk-stdev()-X	
TimeBodyAccelerometerJerk-stdev()-Y	
TimeBodyAccelerometerJerk-stdev()-Z	
TimeBodyGyroscope-stdev()-X	
TimeBodyGyroscope-stdev()-Y	
TimeBodyGyroscope-stdev()-Z	
TimeBodyGyroscopeJerk-stdev()-X	
TimeBodyGyroscopeJerk-stdev()-Y	
TimeBodyGyroscopeJerk-stdev()-Z	
TimeBodyAccelerometerMag-stdev()	
TimeGravityAccelerometerMag-stdev()	
TimeBodyAccelerometerJerkMag-stdev()	
TimeBodyGyroscopeMag-stdev()	
TimeBodyGyroscopeJerkMag-stdev()	
FrequencyBodyAccelerometer-stdev()-X	
FrequencyBodyAccelerometer-stdev()-Y	
FrequencyBodyAccelerometer-stdev()-Z	
FrequencyBodyAccelerometerJerk-stdev()-X	
FrequencyBodyAccelerometerJerk-stdev()-Y	
FrequencyBodyAccelerometerJerk-stdev()-Z	
FrequencyBodyGyroscope-stdev()-X	
FrequencyBodyGyroscope-stdev()-Y
FrequencyBodyGyroscope-stdev()-Z	
FrequencyBodyAccelerometerMag-stdev()	
FrequencyBodyBodyAccelerometerJerkMag-stdev()	
FrequencyBodyBodyGyroscopeMag-stdev()	
FrequencyBodyBodyGyroscopeJerkMag-stdev()

subject_id - The unique identifier used to identify the experiment participant.
activity.name - The name of the activity that the measurements correspond to, like LAYING or WALKING.

The rest of the output varibles are the same as what is described in features_info.txt and available in features.txt (from the original datasource) but have more descriptive names. The t from the original name has been replaced to indicate the Time variable and f from the original name has been replaced with Frequency, Gyro and Acc from the original set has been replaced with Gyroscope and Accelerometer.