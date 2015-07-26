# getting_and_cleaning_data
Coursera getting_and_cleaning_data course

The run_analysis.R file reads in the following text files as data tables:
- 'features.txt': List of all features.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Having read the text files as data tables an aggregate data frame, agg_df, is created which combines both train and test data.
Next all the variables that present mean or std numbers are extracted, such that a subset data frame can be created with just these columns and "subject_no" and "activity". The activities are then redefined using their names using the activity_labels.txt file. Descriptive column names are added from features.txt file. Finally the data frame is melted with variables going down as rows such that the average of each variable can be calculated for every "subject_no", for each "activity". The output is a independent tidy data set with the average of each variable for each activity and each subject, which meets the principles of a tidy set by following the rules below:
- each variable represents one column
- each different observation represents a different row
- there should be one table for each "kind" of variable
- if you have multiple tables, they should include a column in the table that allows them to be linked

