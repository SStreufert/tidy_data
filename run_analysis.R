# Instructions: You should create one R script called run_analysis.R that does the following. 
# 0.1 load packages
library(data.table)
library("dplyr", lib.loc="~/R/win-library/3.1")

# 0.2 Define function to load file into a data table and (optionally) specify column names
load_file <- function(file_path, col_names){
    basedir <- "./UCI HAR Dataset"
    full_path <- paste(basedir,file_path, sep = "")
    table_name <- read.table(full_path, col.names=col_names)
    return(table_name)
}


# 0.3 make sure data exists in working dir, if not, download it, if still can't get it, fail
if (!file.exists("./getdata-projectfiles-UCI HAR Dataset.zip")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile="./getdata-projectfiles-UCI HAR Dataset.zip")
    # save timestamp of download event 
    date_downloaded <- date()
}
unzip("./getdata-projectfiles-UCI HAR Dataset.zip")


# 0.4 read list of feature names
features_data <- load_file("/features.txt")


# 0.5 read activity label lookup table
activity_labels <- load_file("/activity_labels.txt", c("activity_id","activity"))


# 0.6 read the set of activity label IDs for each record 
test_labels <- load_file("/test/y_test.txt", "activity_id")
train_labels <- load_file("/train/y_train.txt", "activity_id") 


# 0.7 read the set of subject IDs for each record
test_subjects <- load_file("/test/subject_test.txt", "subject")
train_subjects <- load_file("/train/subject_train.txt", "subject")


# 0.8 merge test/train subject data sets and test/train activity_id data sets
merged_labels <- dplyr::bind_rows(test_labels, train_labels)
merged_subjects <- dplyr::bind_rows(test_subjects, train_subjects)


# 0.9 Finally, load both the test and and the train data sets
test_data <- load_file("/test/X_test.txt")
train_data <- load_file("/train/X_train.txt")


# 1. Merge the training and the test sets to create one data set.
# merge test to train data
all_data <- dplyr::bind_rows(test_data, train_data)


# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# rewrite features list to only include mean() and std()
f <- features_data[grep("mean\\(\\)|std\\(\\)",features_data$V2),, drop=FALSE]

# convert to valid column names and remove extra ".."
# so row 271: "fBodyAcc-std()-Z" becomes "fBodyAcc.std...Z" and finally, "fBodyAcc.std.Z"
f$V2 <- sub("\\.\\.","",make.names(f$V2))

# Perform some further name cleanup to add "." before leading "t" or "f"
f$V2 <- sub("^t","t\\.",f$V2)
f$V2 <- sub("^f","f\\.",f$V2)

# x = all_data but with only the columns we care about
x <- all_data[,f$V1, drop=FALSE]


# NOTE: Step 4 is performed now so that existing variables may be named before adding more columns to the data set
# 4. Appropriately label the data set with descriptive variable names. 
names(x) <- f$V2

# 3. Use descriptive activity names to name the activities in the data set
# add merged_labels_and_subjects to x
x <- dplyr::bind_cols(x, merged_labels, merged_subjects)

# lookup the activity (using the ID) and add it to the data set
x <- left_join(x, activity_labels, by="activity_id")

# remove the activity_id column
x$activity_id <- NULL 

# 5. From the data set in step 4, create a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
z <- x %>% dplyr::group_by(subject, activity) %>% dplyr::summarise_each(funs(mean))

# save results to a txt file
write.table(z, file="./tidy_data.txt", row.names=FALSE)
