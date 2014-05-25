Getting and Cleaning Data Course Project Code Book
=========
<br />
## 1 About the project
This code book contains the description of the variables, the data, and any transformations or work that I did to perform and clean up the data.

First, the raw data came from the following website:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

And a full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

As requested I created one R script called run_analysis.R that does the following (with the raw data from the first link): 
 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## 2 Process, step-by-step
### 2.1 First tidy data
In order, the process of obtaining the first tidy data (requested in 1 to 4 above) was done in R and had the following steps:

1. Download the raw data and unzip the files
2. Store the all data from X_test.txt, Y_test.txt, X_train.txt, Y_train.txt, features.txt, activity_labels.txt (all files from the raw data) into variables.
3. Associate variable names (from features.txt) with the X_test.txt and X_train.txt.
4. Merge X_test.txt and X_train.txt into a new variable called "merged".
5. Extracts, from "merged", only the measurements on the mean and standard deviation (std) for each measurement. The meanFreq was included, and the argument is that, as it was not explicit to include or not, better have more variables than a missing important one. The result was a new variable called "tidy_n1"
6. Associate activity_labels.txt with Y_test.txt and Y_train.txt to label the activities, and than apply later "rbind" to combine them and create the "Activity_Labels" variable.
7. Create a new variable "Partition" that stores from which data set the observation came from (test or train).
8. Store subject_test.txt and subject_train.txt into variables, and than apply "rbind" to combine them, creating the "Subject" variable.
9. Merge the variables associated with Y_test.txt and Y_train.txt to create the "activity_ID" variable.
10. Combine "activity_ID", "Subject", "Partition", "Activity_Labels" and "tidy_n1" (with "cbind") to create the first tidy data.
11. Save the result into a file named "tidy_n1.txt".

PS: The label names of the variables "activity_ID", "Subject", "Partition", "Activity_Labels" that are now part of the first tidy data are "activity_ID","subject","partition","activity_labels" respectively.

### 2.2 Second tidy data
To create the second tidy data (requested in 5 above "1 About the project"), the following steps were done:

1. Load the "tidy_n1.txt" file containing the first tidy data requested.
2. Download and install a library called "reshape2".
3. With a loop and the melt function, a second tidy data was created containing the same variables that the first one had, but now "For each combination of activity and subject in the data, calculate the mean of those entries for each variable" - David HoodCommunity TA.
4. Save the result into a file named "tidy_n2.txt".

## 3 Variables
The resulting data was a data frame with 83 columns (including the "partition" variable) and 180 rows.

Each column corresponds to a variable, and the order, names, class and description of each one are presented below.

#### ID. Name / / Class / / Description

1. activity_ID / / *integer* / / ID associated with each activity_labels
2. subject / / *integer* / / The ID of the person
3. partition / / *factor* / / Selected partition that the volunteer came from
4. activity_labels / / *factor* / / Performed activities done by the volunteers

The following variables are best described by the features_info.txt file that came along with the raw data:

---
*features_info.txt*

For the following variables, the description below is valid and came with the raw data

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
meanFreq(): Weighted average of the frequency components to obtain a mean frequency

---

#### ID. Name
<ol start="5">
  <li>tBodyAcc-mean()-X</li>
  <li>tBodyAcc-mean()-Y</li>
  <li>tBodyAcc-mean()-Z</li>
  <li>tBodyAcc-std()-X</li>
  <li>tBodyAcc-std()-Y</li>
  <li>tBodyAcc-std()-Z</li>
  <li>tGravityAcc-mean()-X</li>
  <li>tGravityAcc-mean()-Y</li>
  <li>tGravityAcc-mean()-Z</li>
  <li>tGravityAcc-std()-X</li>
  <li>tGravityAcc-std()-Y</li>
  <li>tGravityAcc-std()-Z</li>
  <li>tBodyAccJerk-mean()-X</li>
  <li>tBodyAccJerk-mean()-Y</li>
  <li>tBodyAccJerk-mean()-Z</li>
  <li>tBodyAccJerk-std()-X</li>
  <li>tBodyAccJerk-std()-Y</li>
  <li>tBodyAccJerk-std()-Z</li>
  <li>tBodyGyro-mean()-X</li>
  <li>tBodyGyro-mean()-Y</li>
  <li>tBodyGyro-mean()-Z</li>
  <li>tBodyGyro-std()-X</li>
  <li>tBodyGyro-std()-Y</li>
  <li>tBodyGyro-std()-Z</li>
  <li>tBodyGyroJerk-mean()-X</li>
  <li>tBodyGyroJerk-mean()-Y</li>
  <li>tBodyGyroJerk-mean()-Z</li>
  <li>tBodyGyroJerk-std()-X</li>
  <li>tBodyGyroJerk-std()-Y</li>
  <li>tBodyGyroJerk-std()-Z</li>
  <li>tBodyAccMag-mean()</li>
  <li>tBodyAccMag-std()</li>
  <li>tGravityAccMag-mean()</li>
  <li>tGravityAccMag-std()</li>
  <li>tBodyAccJerkMag-mean()</li>
  <li>tBodyAccJerkMag-std()</li>
  <li>tBodyGyroMag-mean()</li>
  <li>tBodyGyroMag-std()</li>
  <li>tBodyGyroJerkMag-mean()</li>
  <li>tBodyGyroJerkMag-std()</li>
  <li>fBodyAcc-mean()-X</li>
  <li>fBodyAcc-mean()-Y</li>
  <li>fBodyAcc-mean()-Z</li>
  <li>fBodyAcc-std()-X</li>
  <li>fBodyAcc-std()-Y</li>
  <li>fBodyAcc-std()-Z</li>
  <li>fBodyAcc-meanFreq()-X</li>
  <li>fBodyAcc-meanFreq()-Y</li>
  <li>fBodyAcc-meanFreq()-Z</li>
  <li>fBodyAccJerk-mean()-X</li>
  <li>fBodyAccJerk-mean()-Y</li>
  <li>fBodyAccJerk-mean()-Z</li>
  <li>fBodyAccJerk-std()-X</li>
  <li>fBodyAccJerk-std()-Y</li>
  <li>fBodyAccJerk-std()-Z</li>
  <li>fBodyAccJerk-meanFreq()-X</li>
  <li>fBodyAccJerk-meanFreq()-Y</li>
  <li>fBodyAccJerk-meanFreq()-Z</li>
  <li>fBodyGyro-mean()-X</li>
  <li>fBodyGyro-mean()-Y</li>
  <li>fBodyGyro-mean()-Z</li>
  <li>fBodyGyro-std()-X</li>
  <li>fBodyGyro-std()-Y</li>
  <li>fBodyGyro-std()-Z</li>
  <li>fBodyGyro-meanFreq()-X</li>
  <li>fBodyGyro-meanFreq()-Y</li>
  <li>fBodyGyro-meanFreq()-Z</li>
  <li>fBodyAccMag-mean()</li>
  <li>fBodyAccMag-std()</li>
  <li>fBodyAccMag-meanFreq()</li>
  <li>fBodyBodyAccJerkMag-mean()</li>
  <li>fBodyBodyAccJerkMag-std()</li>
  <li>fBodyBodyAccJerkMag-meanFreq()</li>
  <li>fBodyBodyGyroMag-mean()</li>
  <li>fBodyBodyGyroMag-std()</li>
  <li>fBodyBodyGyroMag-meanFreq()</li>
  <li>fBodyBodyGyroJerkMag-mean()</li>
  <li>fBodyBodyGyroJerkMag-std()</li>
  <li>fBodyBodyGyroJerkMag-meanFreq()</li>
</ol>

All variables above are numerical means of the original ones, obeying the following rule: "For each combination of activity and subject in the data, calculate the mean of those entries for each variable" - David HoodCommunity TA.

The class for the variables 5 to 83 is *numeric*.