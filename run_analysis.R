#This script was created to solve the project from Getting and Cleaning Data Course from coursera.
#The tasks required are performed in six steps:

# Step 1: read test set, label the columns and merge it with activity and user data
# Step 2: do the same for training data
# Step 3: put together train data and test data
# Step 4: select only columns which contain required data into new dataframe
# Step 5: aggregate to obtain required tidy data table
# Step 6: write the data to a file

# Do not confuse this steps with those from the project desctription. My numbering is arbitrary, 
# the steps presented do what is requested but in a different order.

# Step 1: read test set and merge it with activity description and user identifier
# step 1a: read test set and describe columns according to feature names provided in file features.txt
labels=read.table('UCI HAR Dataset/features.txt', header = FALSE)
testdata=read.table(file = 'UCI HAR Dataset/test/X_test.txt', header = FALSE, col.names = labels$V2)

# Step 1b: read activities for particular measurements and use descriptive label instead of number
activitylabels=read.table(file = 'UCI HAR Dataset/activity_labels.txt', header = FALSE)
testactivities=read.table(file = 'UCI HAR Dataset/test/y_test.txt', header = FALSE)
testactivitieslabels=merge(x = testactivities, y=activitylabels)

# step 1c: read users for particular measurements
testusers=read.table(file = 'UCI HAR Dataset/test/subject_test.txt', header = FALSE)

# Step 1d: merge test set with activities
testset=cbind(testactivitieslabels[,2],testusers,testdata)
# Rename the column
names(testset)[1] <- "Activity"
names(testset)[2] <- "User"


# Step 2: repeat step 1 for training data
# step 2a: 
traindata=read.table(file = 'UCI HAR Dataset/train/X_train.txt', header = FALSE, col.names = labels$V2)

# Step 2b: read activities for particular measurements and use descriptive label instead of number
trainactivities=read.table(file = 'UCI HAR Dataset/train/y_train.txt', header = FALSE)
trainactivitieslabels=merge(x = trainactivities, y=activitylabels)
                          
# step 2c: read users for particular measurements
trainusers=read.table(file = 'UCI HAR Dataset/train/subject_train.txt', header = FALSE)

# Step 2d: merge train set with activities
trainset=cbind(trainactivitieslabels[,2],trainusers,traindata)
# Rename the column
names(trainset)[1] <- "Activity"
names(trainset)[2] <- "User"


# Step 3: put together train data and test data
dataset=rbind(testset,trainset)

# Step 4: select only columns which contain required data into new dataframe
dataset_reduced=dataset[,unique(grep("std()|mean()",labels$V2))]

# Step 5: aggregate to obtain required tidy data table
dataset_aggregated=aggregate(dataset_reduced[,c(-1,-2)],by = list(dataset_reduced$Activity,dataset_reduced$User), FUN=mean,simplify=TRUE,rm.na=TRUE)
names(dataset_aggregated)[1] <- "Activity"
names(dataset_aggregated)[2] <- "User"


#step 6: write the data to a file
write.table(x=dataset_aggregated,file= 'result.txt',row.names=FALSE)