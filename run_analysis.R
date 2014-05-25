##########################################
## Process to create the first tidy data ##
##########################################

## Download and unzip the files (if you already have the file
# and the "UCI HAR Dataset" is in your work directory, then skip this step)
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="project_Dataset.zip")
unzip("project_Dataset.zip")

# Read the files into variables
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./UCI HAR Dataset/test/Y_test.txt")
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./UCI HAR Dataset/train/Y_train.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")

# Add the activity labels to data
labels<-as.character(features[,2])
names(X_test)<-labels
names(X_train)<-labels

#1. Merges the training and the test sets to create one data set.
merged<-rbind(X_test,X_train)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
# In this task I decided to extract every variable that contained std or mean (
# including meanFreq() for example) because is not clear which variables 
# are needed. Better to have more than missing variables.
tidy_n1<-merged[,grep("std|mean", names(merged))]

# Create, for test and train data sets, a factor variable containing the activity labels
# in order
# 3. Uses descriptive activity names to name the activities in the data set
al_test<-factor(Y_test[,1], labels = as.character(activity_labels[,2]))
al_train<-factor(Y_train[,1], labels = as.character(activity_labels[,2]))
al_test<-data.frame(activity_labels=factor(al_test))
al_train<-data.frame(activity_labels=factor(al_train))

# "Row bind" the factor variables to "column bind" later with the tidy data
Activity_Labels<-rbind(al_test,al_train)

# New variable to track from which data the observation came from: test or
# train? Name of this variable: partition
test<-data.frame(rep(0, nrow(X_test)))
train<-data.frame(rep(1, nrow(X_train)))
names(test)<-"partition"
names(train)<-"partition"

# "Row bind" this variables to "column bind" later with the tidy data (it will be
# transformed to a factor variable later)
Partition<-rbind(test,train)

# Variable to store the subjects from each data set (test and train) 
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_test)<-"subject"
names(subject_train)<-"subject"

# "Row bind" this variables to "column bind" later with the tidy data
Subject<-rbind(subject_test,subject_train)

# Row bind Training and Test labels to create the activity_ID variable
activity_ID<-rbind(Y_test,Y_train)
names(activity_ID)<-"activity_ID"

# Column binding to create tidy data
# 4. Appropriately labels the data set with descriptive activity names.
# All variables that will be column binded are already labeled
tidy_n1<-cbind(Activity_Labels,tidy_n1)
tidy_n1<-cbind(activity_ID,tidy_n1)
tidy_n1<-cbind(tidy_n1,Partition)
tidy_n1<-cbind(Subject,tidy_n1)

# Final detail: transform the numeric partition variable to a factor variable 
tidy_n1$partition<-factor(tidy_n1$partition, labels = c("test", "train"))

# tidy_n1 is now the first tidy data
write.table(tidy_n1, file ="tidy_n1.txt")


##########################################
############################################
## Process to create the second tidy data ##
############################################

# 5. Creates a second, independent tidy data set with the average of each
# variable for each activity and each subject.

# The follow algorithm will column bind the subjects averages from
# each activity to the final, created, tidy data


# Load tidy data number 1 from the generated file
tidy<-read.table("tidy_n1.txt", header = TRUE, check.names = FALSE)

# Install and load reshape2 (if is already installed, it will replaced the old
# installation with the newest version of the package)
install.packages("reshape2")
library(reshape2)

# Create a subject data frame to do a melt later
subject<-as.data.frame(1:30)
names(subject)<-"subject"

# For the additional variable partition, created in the first tidy data,
# is created a data frame that links each subject with the data set that
# he or she came from (train or test), to later merge with the final tidy
# data
partition<-vector()
for(j in 1:30){
    partition_value<-as.character(tidy[tidy$subject==j,]$partition[1])
    partition<-c(partition,partition_value)
}
partition<-as.data.frame(partition)

# Below there is a loop that will, each time, add a new column to the
# tidy data

# Setting the last value of the loop
limit<-ncol(tidy)-1

# Begin of the loop to create the final tidy data
for(i in 4:limit) {
    # First calculate the mean by subject and the activity_labels, creating a
    # matrix of averages for each activity
    initial_table<-tapply(tidy[,i],list(tidy$subject, tidy$activity_labels),mean)
    
    # Transform this table to a data frame
    tab_in_df<-as.data.frame(initial_table)
    
    # Add the subjects to this data frame
    add_subject<-cbind(subject,tab_in_df)
    
    # Add the partition variable to this data frame
    add_partition<-cbind(partition,add_subject)
    
    # Use melt function from the reshape2 package to create a new data frame
    # in the required format (and appropriately designed to merge later)
    table_corr<-melt(add_partition,id=c("subject","partition"),measure.vars=names(tab_in_df))
    
    # If it's the first time of the loop, then the final data set is not
    # created yet. Let's begin the creation with the first columns (subject,
    # partition and activity labels)
    names(table_corr)[3:4]<-c("activity_labels",names(tidy[i]))
    if(i == 4) {
        tidy_n2<-table_corr[,1:3]
    }
    
    # Now it's time to merge the averages from "table_corr" to the final tidy
    # data, and name it accordingly
    tidy_n2<-cbind(tidy_n2,table_corr[,4])
    names(tidy_n2)[i]<-names(table_corr[4])
}

# Next comes the process to include activity_ID

# Check if the process to create the first tidy data occurred and the
# activity_labels was created
if(exists("activity_labels")) {
    ID_levels<-as.character(activity_labels[,2])
} else {
    # If not, associate ID_levels to the right activity_labels order
    ID_levels<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING","LAYING")
}

# Add activity_ID
tidy_n2$activity_ID<-as.character(tidy_n2$activity_labels)
tidy_n2$activity_ID<-factor(tidy_n2$activity_ID,levels=ID_levels)
tidy_n2$activity_ID<-as.integer(tidy_n2$activity_ID)

# Order columns
tidy_n2<-tidy_n2[,c(ncol(tidy_n2),1:limit)]

# Set the right levels order in activity_labels
tidy_n2[,4]<-factor(tidy_n2[,4],levels=ID_levels)

# Final tidy data
head(tidy_n2, n=35)

# tidy_n2 is now the final tidy data
write.table(tidy_n2, file ="tidy_n2.txt")
