Getting and Cleaning Data Course Project
=========================

This repository is dedicated to the Getting and Cleaning Data Course Project. It contains 3 files:

#### run_analysis.R
R script that download the raw data (for more details, see CodeBook.md) and:
<ol>
  <li>Merges the training and the test sets to create one data set.</li>
  <li>Extracts only the measurements on the mean and standard deviation for each measurement.</li>
  <li>Uses descriptive activity names to name the activities in the data set</li>
  <li>Appropriately labels the data set with descriptive activity names.</li>
  <li>Creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>
</ol>
The run_analysis.R is a R script and should be "ran" in R.
    
It will generate 2 files: the tidy_n1.txt and tidy_n2.txt. The CodeBook.md describes the process in details and is focused on the tidy_n2.txt variables.
<br />
<br />
<br />
#### CodeBook.md
"A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data."
Variables described in the CodeBook.md (in the section 3 "Variables") are from the second, independent tidy data (tidy_n2.txt).
<br />
<br />
<br />
#### README.md
"Explains how all of the scripts work and how they are connected."
