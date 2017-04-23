# Getting and Cleaning Data Course Project
This is a repo for the getting and cleaning data course project.  The script, called run_analysis.R, work as follows:

1.) Loads the data sets into R.  It assumes that the data is in the working directory /UCI HAR Dataset/.  If not, please edit in the script. It will then set all the colume names and combine them into one working dataset.

2.) Chops the dataset down to ID, Mean, and STDEV columns only.

3.) Adds activity labels to the dataset so it's friendlier than an ID.

4.) This step is supposed to label the columns with descriptive names, but we already did that in column 1.

5.) Create a finalized dataset and output it to tidy.txt
