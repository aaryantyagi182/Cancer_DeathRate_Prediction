library(party)
library(caTools)
library(modelr)
getwd()


##Reading CSV file.
data <- read.csv("~/Big_data-R/cancer_reg.csv")
data[1, ]
str(data)
##Number of rows and columns in data
ncol(data)
nrow(data)

##Get summary of the data.
summary(data)

#Percentage of Null values in each column..
sapply(data, function(x) sum(is.na(x)))/3047

#Removing insignificant columns
df<-subset(data,select = -c(Geography,PctSomeCol18_24))

#Imputation of Missing Value
df[is.na(df)]<-0
sapply(df, function(x) sum(is.na(x)))/3047
##Correlation Analysis
data<-as.matrix(df)
s=cor(data)
s[2,1:30]
library(corrplot)
corrplot(s, type = "upper", order = "hclust", tl.col = "black")

##Visualisations
df1<-df[sample(nrow(df),1000), ]
library(ggplot2)
##Univariate Analysis
#Income

sp<-ggplot(df1)+geom_histogram(aes(x=medIncome),binwidth=1840,color='black',fill="yellow")+
  geom_vline(aes(xintercept=mean(medIncome)),color="blue", linetype="dashed", size=1)+xlab("Income")
sp

##Left skewed..

#popEst2015
qp<-ggplot(df1)+geom_histogram(aes(x=popEst2015),binwidth=181598,color='black',fill="yellow")+
  geom_vline(aes(xintercept=mean(popEst2015)),color="blue", linetype="dashed", size=1)+xlab("Population")
qp

#Bivariate Analysis
q<-ggplot(df1,aes(x=avgAnnCount,y=avgDeathsPerYear,color="red"))+geom_point()
q

sp<-ggplot(df1,aes(x=popEst2015,y=avgDeathsPerYear,color="green"))+geom_point()
sp

qr<-ggplot(df1,aes(x=PctBachDeg25_Over,y=avgDeathsPerYear,color="red"))+geom_point()
qr
t<-ggplot(df1,aes(x=PctAsian,y=avgDeathsPerYear,color="green"))+geom_point()
t

library(ggpubr)
figure <- ggarrange(q,sp,qr,t,ncol = 2, nrow = 2)
figure

##Preprocessing
library(jmotif)
df<-znorm(df)
bin1 = (max(df$medIncome)-min(df$medIncome))/56
bin1
bin2 = (max(df$popEst2015)-min(df$popEst2015))/56
bin2
sp<-ggplot(df)+geom_histogram(aes(x=medIncome),binwidth=bin1,color='black',fill="yellow")+
  geom_vline(aes(xintercept=mean(medIncome)),color="blue", linetype="dashed", size=1)+xlab("Income")
sp
qp<-ggplot(df)+geom_histogram(aes(x=popEst2015),binwidth=bin2,color='black',fill="yellow")+
  geom_vline(aes(xintercept=mean(popEst2015)),color="blue", linetype="dashed", size=1)+xlab("Population")
qp
library(GGally)
ggpairs(data=df, columns=1:2)
##Split in train_test
set.seed(1237)
sample_data = sample.split(df, SplitRatio = 0.7) 
sample_data

train_data <- subset(df, sample_data == TRUE) 
test_data <- subset(df, sample_data == FALSE) 
#############Multivariate Linear Regression#########################
####################################################################

model <- lm(avgDeathsPerYear~avgAnnCount+popEst2015+PctAsian+PctBachDeg25_Over+PctHS25_Over+medIncome, train_data)
result <-  predict(model,test_data)
mape <- ((sum(result - test_data$avgDeathsPerYear)^2)/nrow(test_data))
mape <- sqrt(mape)
mape
rss <- sum(( test_data$avgDeathsPerYear - result) ^ 2)  ## residual sum of squares
tss <- sum((test_data$avgDeathsPerYear - mean(test_data$avgDeathsPerYear)) ^ 2)  ## total sum of squares
rsq <- 1 - rss/tss
rsq
#############################################################
s2<-ggplot(test_data,aes(x=avgDeathsPerYear)) +geom_line(aes(y=avgDeathsPerYear),color="red")+geom_line(aes(y=result),color="green")
s2
q<-ggplot(test_data,aes(x=popEst2015)) +geom_line(aes(y=avgDeathsPerYear),color="red")+geom_line(aes(y=result),color="green")
q
r<-ggplot(test_data,aes(x=result)) +geom_point(aes(y=avgDeathsPerYear),color="red")+geom_line(aes(y=result),color="green")
r
