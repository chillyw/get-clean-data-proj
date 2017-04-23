####################
# Getting and Cleaning Data Course Project
# Chris Wilson
# 04/23/2017
####################

#### Part 1: Let's get a clean, tidy dataset

## First, read in the test files to a table

subjectTest = read.table('./UCI HAR Dataset/test/subject_test.txt')
xTest = read.table('./UCI HAR Dataset/test/X_test.txt')
yTest = read.table('./UCI HAR Dataset/test/Y_test.txt')

## Next, read in the train data files

subjectTrain = read.table('./UCI HAR Dataset/train/subject_train.txt')
xTrain = read.table('./UCI HAR Dataset/train/X_train.txt')
yTrain = read.table('./UCI HAR Dataset/train/Y_train.txt')

## Finally, load the data from the other files

activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')
featuresInfo = read.table('./UCI HAR Dataset/features_info.txt')
features = read.table('./UCI HAR Dataset/features.txt')

## Now that we've got all the data loaded, let's make some more friendly column names

colnames(activityLabels) = c("actID","actLabel")
colnames(subjectTrain) = "subID"
colnames(xTrain) = features[,2]
colnames(yTrain) = "actID"
colnames(subjectTest) = "subID"
colnames(xTest) = features[,2]
colnames(yTest) = "actID"

## Next up is creating a couple nice and tidy data sets

trainData = cbind(subjectTrain,yTrain,xTrain)
testData = cbind(subjectTest,yTest,xTest)

## Finally, let's merge those bad boys into one big set
combData = rbind(trainData,testData)

#### Part 2:  Get the mean & stddev for each measurement

# First, let's get the columns that have ID, mean, std in their name.
cols <- colnames(combData)
colFilter <- c(grep("ID$",cols),grep("-(mean|std)\\(\\)*",cols))


# Next, let's filter combData based on those columns
combData<-combData[,colFilter]

## 3. Use descripitive activity names in the data set

# Let's merge activityLabels into the data set
combData = merge(combData,activityLabels,by="actID",all.y=FALSE)

# Now get rid of the actID column
combData = combData[,colnames(combData) != 'actID']

## 4. Label the Data with Descriptive Variable Names

# This was already done when we merged the dataset above

## 5. Create a final, summarized dataset
library(reshape2)
meltData <- melt(combData,id = c("subID","actLabel"))
finalData <- dcast(meltData,subID + actLabel ~ variable, mean)

## Now, let's end by outputting this bad boy!
write.table(finalData,"tidy.txt",row.names=FALSE)
