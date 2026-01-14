v<-seq(1:10)
v[7]
seq(4,10,by=0.5)
wf <- c(12,4,4,6,9,3)
gf <- c(5,3,2,2,12,9)

matrix(data=wf, gf, byrow=FALSE)

clutch_total <- matrix(wf, gf)
clutch_total
sum(clutch_total)
which(wf>gf)
min(wf)
max(wf)
which(wf>4)
as.numeric(clutch_total)



data(iris)
iris10 <- head(iris, 10)
iris10


write.csv(iris10, "iris10.csv")
str(iris10)
View(iris10)
iris10$Petal.Length[1]


iris25 <- head(iris, 25)


iris30<-subset(head(iris, 25), select = c(1,3,5))
View(iris30)


iris_25 <- subset(iris, 25 , select=c(1,3,5))
View(iris_25)



irisverse <- iris %>% filter(Species=="setosa")
str(irisverse)
irisverse %>% summarise(mean(Petal.Length))
  
  
  
  

View(irisverse)

library(tidyverse)
surveys <- read_csv("surveys.csv")
View(surveys)
dim(surveys)

subset <- surveys %>% select(plot_id, species_id, hindfoot_length)
View(subset)

surveys %>% select(-record_id, -species_id)
surveys %>% filter(year==1995)

surveys %>% filter(hindfoot_length>25) %>% select(species_id, sex, hindfoot_length)
  
surveys %>% mutate(weight.kg = weight/1000) %>% print(n=1000)

surveys %>% group_by(sex) %>% summarise(mean(hindfoot_length))



scatter.smooth(x = iris$Petal.Length, y = iris$Sepal.Length, xlab="petal length", ylab= "sepal length")
hist(iris$Petal.Length, xlab="petal length", ylab= "frequency", main= "")
  

View()
