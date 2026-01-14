####brackets####
numbers<-30:1
numbers[5] #subsets the 5th value from numbers vector 

numbers[c(5,11,3)] #extracts three different values 
numbers[-3] #includes all values except for 28 because 28 is in 3rd position
numbers[-(1:20)] #includes all values except the numbers in the first 20 positions
numbers[-1:20] #won't work because you can't mix positive&negative indices

numbers[3]<-42 #changes value in 3rd position to 42 
numbers
numbers[c(4,6)]<-c(99,23) #changes values of multiple indices
numbers
indices<-c(5,11,3) #stores values in positions 5,11,3 into vector indices
numbers[indices] #displays values in indices vector
goal.pred<-(1:6) #create vector with 6 indices  
goal.pred[c(1:6)]<-c(12,4,4,6,9,3) #insert numbers into indices 
goal.pred
goal.rang<-(1:6)
goal.rang[c(1:6)]<-c(5,3,2,2,12,9)
goal.rang

which(goal.pred>5) #displays which games had more than 5 goals
goal.pred[2] == goal.rang[2] #did the preds and rangers tie in game 2? no
goal.pred[4] > goal.rang[4] #did preds score more than rangers in game4? yes
goal.pred5<-which(goal.pred >5) #new vector stores games where count>5
pred.win<-goal.pred > goal.rang #pred.win stores all indices where 
                        #goal.pred value is greater than goal.rang value
which(pred.win) #which games did preds win? 1,2,3,4
goal.pred[pred.win] #displays count instead of indice
sum(pred.win) #total numbers of times preds on? 4

####data####
data(iris) #load data
str(iris) #check struture-shows the data points for each variable
          #5 variables, 150 observations
View(iris) #displays data as spreadsheet
iris[1,3] #extracts from first row of third column 
iris[100,5] #extracts from 100 row, 5th column 
subset.iris15<-iris[1:15,1:5] #data set containing first 15 samples
subset.iris15<-iris[1:15,] #simplification of line 41, R understands to include all rows
View(subset.iris15)

names<- c("Sarah", "Fred", "Carol", "Bert", "Tommy", "Milly", "Lilly", "Billy", "Wes")
grep("illy", names) #use grep to search by pattern & displays indice 
names[grep("illy", names)] #displays which names fit the pattern rather than displaying indice
sort(names) #sort names in alphabetical order 
sort(names, decreasing = TRUE) #sort names in reverse order 

####reading and writing data####
getwd() #displays working directory
list.files() #lists files in directory
cg<-read.csv("commongarden.csv", header=TRUE) #read data into data frame named cg



write.csv("cg_output", "commongarden.csv") #save cg data frame as csv file

####basic statistics####
View(cg)
cg$weight #displays weight column 
mean(cg$larval_period) #average of wood frog larvalperiod = 83.67942

svl.regression.model<-lm(svl ~ femur, data=cg) #perform linear model with cg data and store as object
summary(svl.regression.model) #produce summary of results of model

t.test(cg$weight[cg$pop == "Cheaha"], cg$weight[cg$pop == "East"]) #t-test asses significance of sample means 

min(cg$larval_period) #lowest range value for larval period days
max(cg$larval_period) #highest range value for larval period days

wlp.regression.model<-lm(weight ~ larval_period, data=cg)
summary(wlp.regression.model) #frogs with higher weight/shorter larval period are correlated

cheaha_subset<-subset(cg, pop=="Cheaha", select = larval_period:svl)
View(cheaha_subset) #displays only 3 columns in regards to cheaha population

####basic plotting####
x<-1:30
y<-rnorm(30, mean = x) #rnorm refers to normal distribution
y2<-rnorm(30, mean = x, sd= sqrt(x))
plot(y~x, main = "First plot", xlab="x axis label", ylab="y axis label") #create scatter plot and set titles

hist(y) #plot a histogram

data(islands)






