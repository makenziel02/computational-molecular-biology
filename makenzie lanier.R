#### Makenzie LaNier - Homework ####

#### question 1 ####
getwd() #display working directory 

#read in data 
finch <- read.csv("finches.csv", header=TRUE, sep=",")

str(finch) #check the structure of the data
View(finch) #view in spreadsheet formula

#### question 2 ####

#calculate mean of various variables 
mean(finch$beak.depth) ##9.3924
mean(finch$body.mass) ##16.3534
mean(finch$tarsus.length) ##19.193
mean(finch$wing.length) ##68.5426

#calculate median of various variables
median(finch$beak.depth) ##9.305
median(finch$body.mass) ##16.24
median(finch$tarsus.length) ##19.13
median(finch$wing.length) ##68.19

#calculate sd of various variables 
sd(finch$beak.depth) ##0.9024883
sd(finch$body.mass) ##1.689514
sd(finch$tarsus.length) ##0.8572325
sd(finch$wing.length) ##2.415634

#### question 3 ####

#construct a scatter plot
plot(beak.depth ~ wing.length, data=finch, 
     xlab = "Wing Length", ylab = "Beak Depth")

#### question 4 ####

#test the correlation between beak depth and wing length
cor(finch$beak.depth, finch$wing.length, method = "pearson")
## 0.6444551 the relationship is postive and there is moderate significance

#### question 5 ####

#subset the data into male and female
male <- subset(finch, sex=="male")
female <- subset(finch, sex=="female")

#conduct a t test
t.test(male$beak.depth,female$beak.depth)
## the p value is 0.1047, meaning it is not statistically significant


#### question 6 ####

#conduct at test to see if wing length is significantly different
t.test(male$wing.length, female$wing.length)
## the p value is 0.0002132 meaning that it IS statistically significant

#### question 7 ####

# subset data into survivors and nonsurvivors
survivors <- subset(finch, droughtsurvival == "survivor")
nonsurvivors <- subset(finch, droughtsurvival == "nonsurvivor")

#calculate mean of various variables for survivors
mean(survivors$beak.depth) ##9.6738
mean(survivors$body.mass) ##16.9942
mean(survivors$wing.length) ##69.2966

#calculate median of various variables for survivors
median(survivors$beak.depth) ##9.8
median(survivors$body.mass) ##17.065
median(survivors$wing.length) ##69.46

#calculate sd of various variables for survivors
sd(survivors$beak.depth) ##0.8422392
sd(survivors$body.mass) ##1.757069
sd(survivors$wing.length) ##2.334102

#calculate mean of various variables for nonsurvivors
mean(nonsurvivors$beak.depth) ##9.111
mean(nonsurvivors$body.mass) ##15.7126
mean(nonsurvivors$wing.length) ##67.7886

#calculate median of various variables for nonsurvivors
median(nonsurvivors$beak.depth) ##9.1
median(nonsurvivors$body.mass) ##15.64
median(nonsurvivors$wing.length) ##67.19

#calculate sd of various variables for nonsurvivors
sd(nonsurvivors$beak.depth) ##0.8801258
sd(nonsurvivors$body.mass) ##1.357156
sd(nonsurvivors$wing.length) ##2.276267

#### question 8 ####
 
#create a histogram for beak depth in survivors vs nonsurvivors
hist(survivors$beak.depth) 
## the histogram for survivors displays a normal distribution, 
##meaning that most values are centered around the middle value

hist(nonsurvivors$beak.depth)
## the histogram for nonsurvivors shows the majority of values at 10.5 or less
## there are outliers towards the right of the graph
##nonsurvivors have deeper beaks than survivors


#create a histogram for wing length and drought survival
hist(survivors$wing.length) ##survivors have larger wing lengths
hist(nonsurvivors$wing.length) ##nonsurvivors have shorter wing lengths

#### question 9 ####

#create a model
finch.model <- lm(beak.depth~sex + wing.length + droughtsurvival, data=finch)
#run an anova to test for significant associations
anova(finch.model) 
## sex and wing length had significant p values, meaning that 
## these two characteristics had significant associations with beak depth

#### question 10 ####
## i think that wing length and beak depth were the most 
## important because the survivors had larger wings and deeper beaks 
## the ones with longer wings probably had an easier time flying to water sources
## deep beaks may have helped them drink/store more water because they have a larger 
## amount of space for water storage in their beaks 









