## 1
##Clear workspace
rm(list=ls())

##Load dependencies
require(dplyr)

## 2
##Read features and activity labels
features <- read.table("~/features.txt", stringsAsFactors = FALSE)
activities <- read.table("~/activity_labels.txt", stringsAsFactors = FALSE)

## 3
## Read data and labels for training dataset
train <- read.table("~/train/X_train.txt", stringsAsFactors = FALSE)
train_labels <- read.table("~/train/y_train.txt", stringsAsFactors = FALSE)
train_subject <- read.table("~/train/subject_train.txt", stringsAsFactors = FALSE)


## Bind datasets
train <- cbind(train_subject,train_labels,train)
#Clean duplicates
rm(train_labels,train_subject)
##Name columns
colnames(train) <- c("subject","activity",features[,2])


## 4
## Read data and labels for test dataset
test <- read.table("~/test/X_test.txt", stringsAsFactors = FALSE)
test_labels <- read.table("~/test/y_test.txt", stringsAsFactors = FALSE)
test_subject <- read.table("~test/subject_test.txt", stringsAsFactors = FALSE)

## Bind datasets
test <- cbind(test_subject,test_labels,test)
#Clean duplicates
rm(test_labels,test_subject)
##Name columns
colnames(test) <- c("subject","activity",features[,2])  

## 5
## Combine datasets
data <- rbind(train, test)
##Clean duplicates
rm(train, test)

## 6
## Give appropriate labels to activities  
data$activities <- activities[match(data$activity, activities$V1),2]

## 7 
## Select id, activity, mean and st.dev columns
data_selection <- cbind(data$subject, data$activities, data[grep("*mean|*std" , colnames(data))])

##Clean data
rm(data)


## 8
##Summarize by subject and activity
summary <- data_selection %>% 
  group_by(.dots = c("`data$subject`","`data$activities`")) %>% 
  summarize_all(funs(mean))

