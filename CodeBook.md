##Code Book for Getting and Cleaning Data Course Project##

The `run_analisys.R` script uses the following files from the original download (filenames are relative to the **"UCI HAR Dataset"** directory):

- `activity_labels.txt` containing activity ids and labels;
- `features.txt` containing feature ids and labels;
- `train/subject`_train.txt containing subject id per training observation;
- `train/X_train.txt` containing features list per training observation;
- `train/y_train.txt` containing activity id per training observation;
- `test/subject_test.txt` containing subject id per test observation;
- `test/X_test.txt` containing features list per test observation;
- `test/y_test.txt` containing activity id per test observation;

The `run_analysis.R` script contains comments for understanding what it is doing. X_test and X_train tables each has 561 columns. Assumptions I made to select the subset of columns from these tables are the column names end with **mean()** or **std()**. That gives me 66 columns. Gross summary of steps are below.
`Note:` Please install packages `reshape2` and `dplyr` in case if you don't have installed.
- load training, testing, subject, features and activity_labels files into R.
- select the subset of columns contining mean() and std() values.
- combine subjects and features to corresponding test and training data subsets
- combine test and tarining datasets into one dataset,
- converting the above dataset into long form
- grouping and summerizing to find the means by subject, activity and measurement.
- export result to `tidyData.txt`

columns in the `tidyData.txt` file
- Subject - the numerical subject ID
- Activity - name of the Activity
- Measurement - label of the measurement
- MeanValue - average value of the measurement group by Subject and Activity

A quick calculation of number of observation is the resuslt set is:

- number of subjects are 30
- number of activities are 6
- number of measurements are 66
- there fore 30 x 6 X 66 = 11880 observations should be in the `tidyData.txt` file.
