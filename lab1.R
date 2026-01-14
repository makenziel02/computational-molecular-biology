####using R as a calculator#### 
2*8 
sqrt(9)
5>3

(5>3) & (7>5)
3 %in% 1:5  #is 3 in the sequence 1-5?
c (1,2,3)  #concatenates/combines values into a list

####assign values to variables####
x<-5 #assigns the value of 5 to the variable x
x #prints out the value of x which is 5

x*2 #uses variable x to perform operation

x<-7 #reassigns to value of x to 7
x*2

ls() #lists the variables 
rm(x) #removes the variable x

####R data types####
x<-"data" #stores the word data inside of x
x
typeof(x) #details what type of vector x is
length(x) # defines the length of x

y<-1:5 # creates a sequence and assigns the sequence to y
y 

typeof(y)

x<-as.numeric(5)
z<-as.numeric(y)

i = "hi"
i<-as.character(i) # using casting to change data type
i

####structures####
vector() #used to create an empty vector

vector("character", length =5)
vector("logical", length =5) #logical vector of 5 elements 

x<-c(1,2,3) # creates vector by directly specifying contents
x

as.integer() #explicitly creates an integer 

z<-c("Sally", "Sue", "Sam") #adding elements to a vector
z

z<-c(z, "Steve") #adds an element on to existing list
z

series<-1:10 #assigns a sequence to variable series 
series
seq(1:10) #outputs sequence on to the screen 

seq(1,10, by=0.1) #series in 0.1 increments 

x<-(1:20) #assigns sequence to x
x

x[3] #accessing a value in the vector by specifying
x[21] #searching for a number not in vector gives output NA
x[1:2]

y<-seq(2,12, by=2) #assigns series to y
y[3] # extracts number in 3rd position
y[2:4] # extracts number in 2,3,4 positions
length(y) #the length of y is 6
max(y) #maximum value in series
min(y) #minimum value in series
prod(y) #multiples every value in series
mean(y) #finds average of series 

z<-seq(2,100, by=2) #sequence of all even numbers between 2 and 100
sum(z) 
sum(z) == 51*50 #is the sum equal to the product? yes.

####Matrix####
A<-matrix(nrow=2, ncol=2) #creates 2 by 2 matrix
A
dim(A) #dimensions of matrix

A<-matrix(c(1,2,3,4), 2,2) #inputs values into matrix 
A

A<-matrix(c(1,2,3,4), 2,2, byrow=TRUE) #inputs data into rows then columns 
nrow(A) #amount of rows
ncol(A) #amount of columns

x<-1:3
y<-10:12
cbind(x,y) #binds columns 
rbind(x,y) #binds rows 

Z<-matrix(1:9, 3,3)
Z
Z[1,] #access first row
Z[,2] #access second column


####Lists####
mylist<-list(Names = c("a","b","c","d"), Values=c(1,2,3))
mylist
mylist[[1]] #access element in a list
mylist[[2]]

####Data frames####
dat<-data.frame(id= letters[1:10], x= 1:10, y=11:20) #creates data frame with 
                                    #each column having a different data type 
dat


head(dat) #displays first 6 lines
tail(dat) #displays last 6 lines
dim(dat) #displays dimensions
nrow(dat) #displays number of rows
ncol(dat) #displays number of columns
str(dat) # name,type, and preview of data frame
colnames(dat) #names for data frames 


data(trees) #read in data
View(trees) #view data
str(trees) #see the structure of data frame

ncol(trees) #displays number of columns
nrow(trees) #displays number of rows
head(trees,4) #prints first 4 lines
trees$Girth #select a column
trees$Height[1:5] #first 5 elements of height column
trees[1:3,] #select rows 1,2,3

trees<-rbind(trees,c(13.25, 76, 30.17)) #add a row
trees<-combined<-cbind(trees,trees) #combine columns 
colnames(trees)<-c("girth", "height", "volume") #change column names 
                                                #from upper to lowercase
View(trees)

mean(trees$height) #mean of the height column
mean(trees$girth) #mean of the girth column



