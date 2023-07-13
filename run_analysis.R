### Getting and cleaning data coursera project_Dominik Vuksan

library(tidyverse) # loading tidy verse

# Test data import

x.test= read.table("./UCI HAR Dataset/test/X_test.txt")
y.test= read.table ("./UCI HAR Dataset/test/y_test.txt", col.names= "activity")
subject.test= read.table ("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

test.set= cbind(subject.test, y.test, x.test)

# Train data import

x.train= read.table("./UCI HAR Dataset/train/X_train.txt")
y.train= read.table("./UCI HAR Dataset/train/y_train.txt", col.names= "activity")
subject.train= read.table("./UCI HAR Dataset/train/subject_train.txt", col.names= "subject")

train.set= cbind(subject.train, y.train, x.train)


### Merged test set and train set

all= rbind(test.set, train.set)


### Reading activity labels and features

activity= read.table("./UCI HAR Dataset/activity_labels.txt")
features= read.table("./UCI HAR Dataset/features.txt")

### Finding features which contain mean and std

mean.std.features= grep("mean()|std()", features$V2)
 

### Creating a data set containing variables which contain only mean and std values

mean.std.all= all [, mean.std.features]

### Creating a factor and renamin the activities

mean.std.all= mutate(mean.std.all, activity= factor(1*activity, labels= c("walking", "walking.up", "walking.down", "sitting", "standing", "laying")))

### Variable naming

var.names= grep("mean()|std()", features$V2, value=TRUE)
colnames(mean.std.all)= c("subject", "activity", var.names)

# Creating a tidy dataset

tidy= mean.std.all %>% group_by(activity, subject) %>% summarise_at(vars(1:77), mean)


