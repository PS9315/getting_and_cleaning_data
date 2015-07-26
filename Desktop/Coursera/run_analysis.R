#Read in the train and test sets
subject_train <- read.table("./train/subject_train.txt",stringsAsFactors = F)
train_set <- read.table("./train/X_train.txt", stringsAsFactors = F)
train_set_labels <- read.table("./train/y_train.txt",  stringsAsFactors = F)

subject_test <- read.table("./test/subject_test.txt", stringsAsFactors = F)
test_set <- read.table("./test/X_test.txt", stringsAsFactors = F)
test_set_labels <- read.table("./test/y_test.txt", stringsAsFactors = F)

#Read in features file
features <- read.table("./features.txt")

########
#set_colnames <- features[,2]
#adding the descritions for each variable to the variable reults
#t_train_set <- t(train_set) #transposing so it can be cbinded
#train_set_colnames <- as.data.frame(cbind(set_colnames,t_train_set))
########

#Merges the training and the test sets to create one data set
###create train data frame with subject_train, train_set & train_set_labels
train_df <- cbind(subject_train,train_set_labels,train_set)
###create test data frame with subject_test, test_set & test_set_labels
test_df <- cbind(subject_test,test_set_labels,test_set)
###Concatenating the traing and test data frames
agg_df <- rbind(train_df,test_df)

#Extracts only the measurements on the mean and standard deviation for each measurement
###Gettiing columns with mean in them
mean_columns<- as.vector(grep("mean",features$V2))
###Gettiing columns with std in them
std_columns<- as.vector(grep("std",features$V2))
###adding 2 to account for the two first columns on subject and label and sorting in ascending order
extract_columns <- (sort(c(mean_columns,std_columns))+2)
###subset by indexing the columns that we need to extract
subset_agg_df <- agg_df[,c(1,2,extract_columns)]

#Uses descriptive activity names to name the activities in the data set
subset_agg_df$V1.1[subset_agg_df$V1.1==1]<-"WALKING"
subset_agg_df$V1.1[subset_agg_df$V1.1==2]<-"WALKING_UPSTAIRS"
subset_agg_df$V1.1[subset_agg_df$V1.1==3]<-"WALKING_DOWNSTAIRS"
subset_agg_df$V1.1[subset_agg_df$V1.1==4]<-"SITTING"
subset_agg_df$V1.1[subset_agg_df$V1.1==5]<-"STANDING"
subset_agg_df$V1.1[subset_agg_df$V1.1==6]<-"LAYING"

#Appropriately labels the data set with descriptive variable names
extract_features_rows <- sort(c(mean_columns,std_columns))
###subset the rows that we need to add to column names. 
subset_features <- t(as.character(features[extract_features_rows,2]))
###create column names
colnames(subset_agg_df) <- c("subject_no","activity",subset_features)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
activityMelt <- melt(subset_agg_df, id=c("subject_no","activity"),measure.vars = subset_features)
average <- dcast(activityMelt,subject_no+activity ~ variable, mean )

#write table
write.table(average,"./run_analysis_results.txt",row.names=F, sep="\t")
