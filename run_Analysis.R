library(plyr)
library(dplyr)

# 1. Setting the correct working directory
setwd('./UCI HAR Dataset')
features <- read.table('features.txt')
labels <- read.table('activity_labels.txt')

# 2-1. Combining features and labels for the training dataset
x_train <- read.table('./train/X_train.txt')
names(x_train) <- features[['V2']]
y_train <- read.table('./train/y_train.txt', col.names='label')
sub_train <- read.table('./train/subject_train.txt', col.names='id')

index <- function(df){df$index <- row.names(df);df}

train <- join_all(list(index(x_train), index(y_train), index(sub_train)))

# 2-2. Combining features and labels for the test dataset
x_test <- read.table('./test/X_test.txt')
names(x_test) <- features[['V2']]
y_test <- read.table('./test/y_test.txt', col.names='label')
sub_test <- read.table('./test/subject_test.txt', col.names='id')
test <- join_all(list(index(x_test), index(y_test), index(sub_test)))

# 3. Selecting the columns (mean, std) & assigning factor levels to the label
train_test <- rbind(train, test)
vars <- names(train_test)
Xs <- c(grep('mean',vars,value=TRUE), grep('std',vars,value=TRUE))

data <- train_test[,c('id','label',Xs)]
data$label <- as.factor(data$label)
levels(data$label) <- labels$V2

Xs <- sub("\\(\\)", "", Xs)
Xs <- gsub("-", "_", Xs)
names(data) <- c('id','label',Xs)

# 4. Creating an independent summary dataset by activity and subject
sum <- aggregate(data[,Xs], list(data$label,data$id),mean)
sorted_sum <- sum %>% dplyr::rename(activity=Group.1, id=Group.2) %>% arrange(activity,id)
write.table(sorted_sum, file="Assignment4.txt", row.names=FALSE)

setwd("../")