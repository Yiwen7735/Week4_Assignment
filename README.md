# Week4\_Assignment

## `run_analysis.R` explanation

The `run_analysis.R` script contains many comments to explain how it works - for extra details, please
see the script.

The script assumes that the Samsung data is contained within a `UCI HAR Dataset` subdirectory of the R
working directory. It begins by reading the feature names from the `features.txt` file and the activity
names from `activity_labels.txt`. 

Following this, the training and testing data files (`train/*.txt` and `test/*.txt`) are read and
merged to give training and testing data frames. These data frames are then combined and the mean and
standard deviation variables selected from the full feature set. The activity label is converted to
a factor type using the names from `activity_labels.txt` to make them informative to the reader.

Since the variable names are not standard R names, they are modified to remove unusual characters such
as brackets and hyphens.

With this merged data frame, the mean of each variable for each combination of subject and activity
is calculated and the results are sorted by activity and subject ID.

Finally the resulting averaged data frame is written to a text file.

## Variables

For details of the variables used in this data set, please see the `CodeBook.md` file, and the associated
file `features.txt`.
