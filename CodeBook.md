# CodeBook
Author: Stephen Streufert

Project: Coursera - Getting and Cleaning Data, Project

Date: Saturday, March 21, 2015 

# Project Description
The source data is described thusly: 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

See full description at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Using the data as described above, I was asked to clean up the data and calculate the mean of particular measurements for the 30 subjects (volunteers), based on each of the six activities performed. See the Transformations section below for details of the tasks performed.

# Data 
## Inputs
The source data may be downloaded from: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

Note that the source data are split into 2 groups: a training group (70% of the data) and a test group (30% of the data). This splitting was performed for data mining purposes to "train" a model" and then to "test" it. For purposes of this project, the data were recombined.

8 files from the sources data were combined to generate the final output:

|    File	|	Description	|	Members	|
|	------------	|	------------	|	------------	|
|	/features.txt	|	List of all features	|	561 observations of 2 variables	|
|	/activity_labels.txt	|	Links the class labels with their activity name	|	6 observations of 2 variables	|
|	/test/y_test.txt	|	Test labels	|	2947 observations of 1 variable	|
|	/train/y_train.txt	|	Training labels	|	7352 observations of 1 variable	|
|	/test/subject_test.txt	|	Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.	|	2947 observations of 1 variable	|
|	/train/subject_train.txt	|	Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.	|	7352 observations of 1 variable	|
|	/test/X_test.txt	|	Test set	|	2947 observations of 561 variables	|
|	/train/X_train.txt	|	Training set	|	7352 observations of 561 variables	|


## Transformations 
Once the 8 source files were loaded, the general transformations went as follows,

1. Combine the test and training labels (activity IDs), 10,299 rows and 1 column
2. Combine the test and training subject lists, 10,299 rows and 1 column
3. Combine the test and training data sets, 10,299 rows and 561 columns
4. Add the subject and labels to the combined data set; this resulted in a master data set of 10,299 rows and 563 columns
5. Replace the labels (activity IDs) with the actual activity names from the activity labels
6. Select the 66 measurements out of the original 561; leaving 68 columns in the master data set
7. Finally, group by subject and activity and provide the mean measurement values; 180 rows and 68 columns

Detailed steps are contained in the README.md


## Outputs
The final output consists of a single tidy data set, "tidy_data.txt"" which contains 180 rows with 68 columns. There are 30 subjects and each performed 6 activities, so 180 rows. The remaining 66 columns in each row represent the mean of particular measurements collected for that subject/activity. 

Recall that the original data sets included 561 measurements. The project instructions stated we were to "[Extract] only the measurements on the mean and standard deviation for each measurement". I took this to mean I should only include features containing either "mean()" or "std()". 

Information about tidy data sets is available here: http://vita.had.co.nz/papers/tidy-data.pdf

### Record Identifiers
The first two columns of each row identify the test subject and the activity performed when the measurements were collected.

* Subject - numeric value between 1-30, which represents each of the 30 volunteers in the experiment.
* Activity - one of six possible activities performed in the experiment.
    * WALKING
    * WALKING_UPSTAIRS
    * WALKING_DOWNSTAIRS
    * SITTING
    * STANDING
    * LAYING

### Variables
The 66 variables follow a specific naming convention and dots (.) are used as separators for each section:

* Signal type (t or f)
    * t denotes time domain signals which were captured at a constant rate of 50 Hz
    * f denotes frequency domain signals
* The type of measure. for additional details, see the "feature_info.txt" file which may be downloaded from http://archive.ics.uci.edu/ml/machine-learning-databases/00240/
* mean or std - whether the measurement is the arithmetic mean or the standard deviation
* X, Y, or Z - indicates if the measurement was related to the X-, Y-, or Z-axis 

|    Variable	|	Definition	|
|	--------------------------------	|	--------------------------------	|
|	t.BodyAcc.mean.X	|	mean of the time-based measure of the body accelerometer along the X-axis	|
|	t.BodyAcc.mean.Y	|	mean of the time-based measure of the body accelerometer along the Y-axis	|
|	t.BodyAcc.mean.Z	|	mean of the time-based measure of the body accelerometer along the Z-axis	|
|	t.BodyAcc.std.X	|	standard deviation of the time-based measure of the body accelerometer along the X-axis	|
|	t.BodyAcc.std.Y	|	standard deviation of the time-based measure of the body accelerometer along the Y-axis	|
|	t.BodyAcc.std.Z	|	standard deviation of the time-based measure of the body accelerometer along the Z-axis	|
|	t.GravityAcc.mean.X	|	mean of the time-based measure of the gravity accelerometer along the X-axis	|
|	t.GravityAcc.mean.Y	|	mean of the time-based measure of the gravity accelerometer along the Y-axis	|
|	t.GravityAcc.mean.Z	|	mean of the time-based measure of the gravity accelerometer along the Z-axis	|
|	t.GravityAcc.std.X	|	standard deviation of the time-based measure of the gravity accelerometer along the X-axis	|
|	t.GravityAcc.std.Y	|	standard deviation of the time-based measure of the gravity accelerometer along the Y-axis	|
|	t.GravityAcc.std.Z	|	standard deviation of the time-based measure of the gravity accelerometer along the Z-axis	|
|	t.BodyAccJerk.mean.X	|	mean of the time-based measure of the body accelerometer jerk signals along the X-axis	|
|	t.BodyAccJerk.mean.Y	|	mean of the time-based measure of the body accelerometer jerk signals along the Y-axis	|
|	t.BodyAccJerk.mean.Z	|	mean of the time-based measure of the body accelerometer jerk signals along the Z-axis	|
|	t.BodyAccJerk.std.X	|	standard deviation of the time-based measure of the body accelerometer jerk signals along the X-axis	|
|	t.BodyAccJerk.std.Y	|	standard deviation of the time-based measure of the body accelerometer jerk signals along the Y-axis	|
|	t.BodyAccJerk.std.Z	|	standard deviation of the time-based measure of the body accelerometer jerk signals along the Z-axis	|
|	t.BodyGyro.mean.X	|	mean of the time-based measure of the body gyroscope along the X-axis	|
|	t.BodyGyro.mean.Y	|	mean of the time-based measure of the body gyroscope along the Y-axis	|
|	t.BodyGyro.mean.Z	|	mean of the time-based measure of the body gyroscope along the Z-axis	|
|	t.BodyGyro.std.X	|	standard deviation of the time-based measure of the body gyroscope along the X-axis	|
|	t.BodyGyro.std.Y	|	standard deviation of the time-based measure of the body gyroscope along the Y-axis	|
|	t.BodyGyro.std.Z	|	standard deviation of the time-based measure of the body gyroscope along the Z-axis	|
|	t.BodyGyroJerk.mean.X	|	mean of the time-based measure of the body gyroscope jerk signals along the X-axis	|
|	t.BodyGyroJerk.mean.Y	|	mean of the time-based measure of the body gyroscope jerk signals along the Y-axis	|
|	t.BodyGyroJerk.mean.Z	|	mean of the time-based measure of the body gyroscope jerk signals along the Z-axis	|
|	t.BodyGyroJerk.std.X	|	standard deviation of the time-based measure of the body gyroscope jerk signals along the X-axis	|
|	t.BodyGyroJerk.std.Y	|	standard deviation of the time-based measure of the body gyroscope jerk signals along the Y-axis	|
|	t.BodyGyroJerk.std.Z	|	standard deviation of the time-based measure of the body gyroscope jerk signals along the Z-axis	|
|	t.BodyAccMag.mean	|	mean of the time-based measure of the body accelerometer magnitude  	|
|	t.BodyAccMag.std	|	standard deviation of the time-based measure of the body accelerometer magnitude  	|
|	t.GravityAccMag.mean	|	mean of the time-based measure of the gravity accelerometer magnitude  	|
|	t.GravityAccMag.std	|	standard deviation of the time-based measure of the gravity accelerometer magnitude  	|
|	t.BodyAccJerkMag.mean	|	mean of the time-based measure of the body gyroscope jerk magnitude   	|
|	t.BodyAccJerkMag.std	|	standard deviation of the time-based measure of the body gyroscope jerk magnitude   	|
|	t.BodyGyroMag.mean	|	mean of the time-based measure of the body gyroscope magnitude  	|
|	t.BodyGyroMag.std	|	standard deviation of the time-based measure of the body gyroscope magnitude  	|
|	t.BodyGyroJerkMag.mean	|	mean of the time-based measure of the body gyroscope jerk magnitude   	|
|	t.BodyGyroJerkMag.std	|	standard deviation of the time-based measure of the body gyroscope jerk magnitude   	|
|	f.BodyAcc.mean.X	|	mean of the frequency-based measure of the body accelerometer along the X-axis	|
|	f.BodyAcc.mean.Y	|	mean of the frequency-based measure of the body accelerometer along the Y-axis	|
|	f.BodyAcc.mean.Z	|	mean of the frequency-based measure of the body accelerometer along the Z-axis	|
|	f.BodyAcc.std.X	|	standard deviation of the frequency-based measure of the body accelerometer along the X-axis	|
|	f.BodyAcc.std.Y	|	standard deviation of the frequency-based measure of the body accelerometer along the Y-axis	|
|	f.BodyAcc.std.Z	|	standard deviation of the frequency-based measure of the body accelerometer along the Z-axis	|
|	f.BodyAccJerk.mean.X	|	mean of the frequency-based measure of the body accelerometer jerk signals along the X-axis	|
|	f.BodyAccJerk.mean.Y	|	mean of the frequency-based measure of the body accelerometer jerk signals along the Y-axis	|
|	f.BodyAccJerk.mean.Z	|	mean of the frequency-based measure of the body accelerometer jerk signals along the Z-axis	|
|	f.BodyAccJerk.std.X	|	standard deviation of the frequency-based measure of the body accelerometer jerk signals along the X-axis	|
|	f.BodyAccJerk.std.Y	|	standard deviation of the frequency-based measure of the body accelerometer jerk signals along the Y-axis	|
|	f.BodyAccJerk.std.Z	|	standard deviation of the frequency-based measure of the body accelerometer jerk signals along the Z-axis	|
|	f.BodyGyro.mean.X	|	mean of the frequency-based measure of the body gyroscope along the X-axis	|
|	f.BodyGyro.mean.Y	|	mean of the frequency-based measure of the body gyroscope along the Y-axis	|
|	f.BodyGyro.mean.Z	|	mean of the frequency-based measure of the body gyroscope along the Z-axis	|
|	f.BodyGyro.std.X	|	standard deviation of the frequency-based measure of the body gyroscope along the X-axis	|
|	f.BodyGyro.std.Y	|	standard deviation of the frequency-based measure of the body gyroscope along the Y-axis	|
|	f.BodyGyro.std.Z	|	standard deviation of the frequency-based measure of the body gyroscope along the Z-axis	|
|	f.BodyAccMag.mean	|	mean of the frequency-based measure of the body accelerometer magnitude  	|
|	f.BodyAccMag.std	|	standard deviation of the frequency-based measure of the body accelerometer magnitude  	|
|	f.BodyBodyAccJerkMag.mean	|	mean of the frequency-based measure of the body accelerometer jerk magnitude   	|
|	f.BodyBodyAccJerkMag.std	|	standard deviation of the frequency-based measure of the body accelerometer jerk magnitude   	|
|	f.BodyBodyGyroMag.mean	|	mean of the frequency-based measure of the body gyroscope magnitude   	|
|	f.BodyBodyGyroMag.std	|	standard deviation of the frequency-based measure of the body gyroscope magnitude   	|
|	f.BodyBodyGyroJerkMag.mean	|	mean of the frequency-based measure of the body gyroscope jerk magnitude   	|
|	f.BodyBodyGyroJerkMag.std	|	standard deviation of the frequency-based measure of the body gyroscope jerk magnitude   	|

