# Cancer_DeathRate_Prediction
Our objective for the project was to predict average deaths per year using the cancer dataset
imported from data.world.
SUMMARY OF THE DATASET
Our dataset had 3047 rows with 32 columns. The variables summary is mentioned below:
KEY:
Columns:
avgAnnCount: Mean number of reported cases of cancer diagnosed annually(a)
avgDeathsPerYear: Mean number of reported mortalities due to cancer(a)
incidenceRate: Mean per capita (100,000) cancer diagnoses(a)
medianIncome: Median income per county (b)
popEst2015: Population of county (b)
povertyPercent: Percent of populace in poverty (b)
studyPerCap: Per capita number of cancer-related clinical trials per county (a)
MedianAge: Median age of county residents (b)
MedianAgeMale: Median age of male county residents (b)
MedianAgeFemale: Median age of female county residents (b)
Geography: County name (b)
AvgHouseholdSize: Mean household size of county (b)
PercentMarried: Percent of county residents who are married (b)
PctNoHS18_24: Percent of county residents ages 18-24 highest education attained: less than
high school (b)
PctHS18_24: Percent of county residents ages 18-24 highest education attained: high school
diploma (b)
PctSomeCol18_24: Percent of county residents ages 18-24 highest education attained: some
college (b)
PctBachDeg18_24: Percent of county residents ages 18-24 highest education attained:
bachelor's degree (b)
PctHS25_Over: Percent of county residents ages 25 and over highest education attained: high
school diploma (b)
PctBachDeg25_Over: Percent of county residents ages 25 and over highest education attained:
bachelor's degree (b)
PctEmployed16_Over: Percent of county residents ages 16 and over employed (b)
PctUnemployed16_Over: Percent of county residents ages 16 and over unemployed (b)
PctPrivateCoverage: Percent of county residents with private health coverage (b)
PctPrivateCoverageAlone: Percent of county residents with private health coverage alone (no
public assistance) (b)
PctEmpPrivCoverage: Percent of county residents with employee-provided private health
coverage (b)
PctPublicCoverage: Percent of county residents with government-provided health coverage (b)
PctPubliceCoverageAlone: Percent of county residents with government-provided health
coverage alone (b)
PctWhite: Percent of county residents who identify as White (b)
PctBlack: Percent of county residents who identify as Black (b)
PctAsian: Percent of county residents who identify as Asian (b)
PctOtherRace: Percent of county residents who identify in a category which is not White,
Black, or Asian (b)
PctMarriedHouseholds: Percent of married households (b)
BirthRate: Number of live births relative to number of women in county (b)
DESIGN METHODOLOGY
As a team we processed the data in the following stages:
1) Gaining some domain knowledge and understanding different variables through the
summary feature provided by R.
2) Treating Missing data
We had three columns namely PctSomeCol18_24, PctEmployed16_Over and
PctPrivateCoverageAlone with 74.9% ,4% and 19% of missing data respectively.
We thereby dropped the column PctSomeCol18_24 and replaced the missing values in
the other two columns with 0.
3) Correlation Analysis.
According to our hypothesis 35 was quite a number for the target variable and hence we
decided to proceed with correlation analysis and ruled out too strongly or too weakly
correlated features( with the target and between the dependent variables themselves)
and simplified our model to highlight it’s root causes.
Variables chosen using the correlation analysis:
avgAnnCount
popEst2015
PctAsian
PctBachDeg25_Over
PctHS25_Over
medIncome
4) Univariate and Bivariate Analysis.
We studied the distribution of the variables and checked them for any outliers and
skewness in univariate analysis.
In bivariate analysis we visualised the target variable with other dependent variables so
as to rule out any case of any non linear relations between variables.
In bivariate and univariate analysis we have log transformed the income and
popEstd2015 variables in order to rule out skewness and the effect of outliers in these
columns.
5) Preprocessing and division of the dataset.
In univariate analysis we found the factors Income and Population to be positively
skewed thus we applied the log transformation to tackle the same.
After preprocessing we divided the dataset in 70:30(train:test) ratio to train the model
and test it on unseen data to get a clear idea about our model’s accuracy.
6) Predictive Modelling.
We used linear regression with avgDeathsPerYear as the independent variable and
avgAnnCount,popEst2015,PctAsian,PctBachDeg25_Over,PctHS25_Over and
medIncome as the dependent variables.
