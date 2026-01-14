####reading data using tidyverse####
install.packages("tidyverse") #download tidyverse package 
library(tidyverse)

popsize <- read_tsv("pop_size.csv") #read in data and convert to tab separated
popsize #displays a few lines of the tibble (aka data frame)

head(popsize, 3) #print first three lines using head function
tail(popsize, 3) #prints last three lines using tail function

View(popsize) #displays data in a spreadsheet
glimpse(popsize) #same as summary function
dim(popsize) #displays dimensions
ncol(popsize) #number of columns
nrow(popsize) #number of rows

####selecting and manipulating data####
ndvi <- read_tsv("ndvi.csv") #read in data
head(ndvi) #display first 6 lines of tibble

select(ndvi, Herd, NDVI_May) #extracts herd and ndvi_may columns using select
select(ndvi, Herd:NDVI_May) #";" includes all columns between herd and ndvi_may
select(ndvi, -Herd, -Year) #"-" excludes columns 
select(ndvi, -(Year:NDVI_May)) #excludes all columns between year and ndvi_may
select(ndvi, matches("NDV")) #includes all columns that start with ndv

filter(popsize, Herd == "WAH") #filter extracts certain rows
filter(popsize, Year>=1970, Year<=1980) #extracts rows with years 1970-1980
filter(popsize, Year %in% c(1970,1980,1990)) #extract specific, nonconsecutive years

slice(popsize, 20:30) #everything between rows 20 and 30
top_n(popsize, 10, Pop_Size) #top ten rows when ordered by pop_size
top_n(popsize, 15, desc(Pop_Size)) #take 15 rows with smallest pop_size
sample_n(popsize, 5) #take 5 random rows
sample_frac(popsize, 0.02) #2% of the rows at random

unique(popsize[order(popsize$Herd), 1]) #nested base R code - all unique herds alphabetically

select(popsize, Herd) #extract herd column
distinct(select(popsize, Herd)) #remove repeated values from herd column using distinct
arrange(distinct(select(popsize, Herd)), Herd) #sort the data using arrange 

popsize %>% select(Herd) %>% distinct() %>% arrange(Herd) # use %>% as a pipeline

#split pipelines over several lines ; assign output to vector "herds"
herds <- popsize %>% 
                select(Herd) %>% 
                distinct() %>% 
                arrange(Herd) 
####intermezzo 9.1####
popsize %>% select(Year) %>% unique() %>% arrange(Year) #extract unique years in popsize and order
ndvi %>% select(NDVI_May) %>% max() #row in ndvi with largest ndvi_may

popsize %>% rename(h = Herd) #rename column 

#add a new column and use other columns to form new column - mutate function
ndvi %>% mutate(meanNDVI = (NDVI_May + NDVI_June_August) / 2) %>% head(4)
#only displays new column - transmute function
ndvi %>% transmute(meanNDVI = (NDVI_May + NDVI_June_August) / 2) %>% head(4)

####counting and computing statistics####

#summarise is used to create summaries of the data
ndvi %>% summarise(mean_May = mean(NDVI_May)) #compute mean for whole data set
#compute several statistics at once 
ndvi %>% summarise(mean_May = mean(NDVI_May), 
                   sd_May = sd(NDVI_May),
                   median_May = median(NDVI_May))
#summmaries of computations for each group 
popsize %>% group_by(Herd) %>%
            summarise(avgPS = mean(Pop_Size),
            minPS = min(Pop_Size),
            maxPS = max(Pop_Size)) %>%
            arrange(Herd)
#count the number of rows belonging to each group using tally function
popsize %>% group_by(Herd) %>% tally() %>% arrange(Herd)
#this same operation can be carried out using function n, counts rows
popsize %>% group_by(Herd) %>%
            summarise(tot = n()) %>% 
            arrange(Herd)

#calculates z score for population size of each herd in each year 
popsize %>% 
        group_by(Herd) %>% 
        mutate(zscore = (Pop_Size - mean(Pop_Size)) / sd(Pop_Size))

#the same thing can be done with scale function
popsize %>% 
        group_by(Herd) %>%
        mutate(zscore = scale(Pop_Size))

####intermezzo 9.2#### 
#compute average Pop_Size for each Herd in popsize 
popsize %>% 
        group_by(Herd) %>%
        transmute(mean(Pop_Size)) %>%
        unique()
        
#identify herd with the largest standard deviation for ndvi_may
ndvi %>% 
    group_by(Herd) %>%
    summarise(sd = sd(NDVI_May)) %>%
    top_n() %>% 
    select(Herd)

####data wrangling####
seaice <- read_tsv("sea_ice.csv") #read in data
head(seaice) #display first lines

seaice %>% gather(Month, Cover, 3:14) #organize data in 4 rows
seaice<- seaice %>% gather(Month, Cover, 3:14) #override previous tibble 

head(popsize, 3) #current organization of data
#create tibble with years as columns & pop size below
popsize %>% 
  filter(Year > 1979, Year < 1985) %>% 
  spread(Year, Pop_Size, fill = "")

#combine two tibbles 
combined <- inner_join(popsize, ndvi)
head(combined, 4)
#display dimensions of each to display the combination of data frames
dim(popsize) 
dim(ndvi)
dim(combined)

#compute correlation between pop_size & ndvi_may
cor(combined %>% select(Pop_Size, NDVI_May))



####intermezzo 9.3####
#compute average sea-ice cover for each month and herd, by averaging over the years
seaice %>%
  group_by(Herd, Month) %>%
  summarise(average = mean(Cover))


####intermezzo 9.4####
#produce a tibble containing the average population size&sea-ice cover
avg_Perc_seaicecover <- inner_join(popsize, seaice)

avg_Perc_seaicecover %>% 
  group_by(Herd, Year) %>%
  summarise(aver_popsize = mean(Pop_Size), 
            aver_cover = mean(Cover))

#provides a tibble with 17 rows that are present in popsize but not avg_Perc_seaicecover
anti_join(popsize, avg_Perc_seaicecover) 











        
        


