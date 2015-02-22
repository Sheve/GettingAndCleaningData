# Description of a provided script "run_analysis.R"
## General Description
The provided script "run_analysis.R" performs the following operations with the data set collected from the accelerometers from the Samsung Galaxy S smartphone (available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip):

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Execution
Before running the script, please download and unpack the data from the provided link. The working directory must contain the directory "UCI HAR Dataset". Then run the script using "source()" command and the aggregated data set will be saved as "result.txt" in your working directory.

## Algorithm description
The script work in six steps:

1. Step 1: read test set, label the columns and merge it with activity and user data
2. Step 2: do the same for training data
3. Step 3: join train data and test data
4. Step 4: select only columns which contain required data into new dataframe
5. Step 5: aggregate to obtain required tidy data table
6. Step 6: write the data to a file
Detailed comments of each of those steps could be found in the script itself.

## Description of the produced dataset:
The produced dataset contains in each line an average of the selected variables agregated for each user and activity. In the first two columns there are the name of the activity and the identifier of the user, and the rest of the columns contains aggregated values of the respective variables.