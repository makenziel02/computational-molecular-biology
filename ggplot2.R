#load library
library(tidyverse)
popsize<- read_tsv("pop_size.csv")
ndvi<- read_tsv("ndvi.csv")
seaice<- read_tsv("sea_ice.csv")
snow<- read_tsv("snow.csv")

#convert to tidy form
seaice <- seaice %>% gather(Month, Cover, 3:14)

#building a plot
ggplot(data = popsize) + #sets the data that will be used
    aes(x= Year, y=Pop_Size, colour = Herd) + #sets x and y axis as well as color of points w herd
    geom_point() + #geom specifies the type of graph/plot
    geom_line()

#creates a histogram using ndvi may data
ggplot(data = ndvi) +
    aes(x=NDVI_May) +
    geom_histogram()

#defining aes in a plot can be done in three separate ways
ggplot(data=ndvi) + 
      aes(x=NDVI_May) +
      geom_histogram()
ggplot(data = ndvi, aes(x=NDVI_May))+
      geom_histogram()
ggplot(data=ndvi)+
      geom_histogram(aes(x=NDVI_May))

#produces a density plot
ggplot(data=ndvi) +
    aes(x=NDVI_May) +
    geom_density()

#create a box plot
p1<-ggplot(data=ndvi) + aes(x=Herd, y= NDVI_May) #store graph into variable
p1 + geom_boxplot() #apply geometrics/plot type to variable containing graph
p1 + geom_violin()
p1 + geom_boxplot() + aes(fill=Herd) #color boxes using function fill

#make a bar plot for population wah & plot monthly measures
ggplot(data = seaice %>% filter(Herd == "WAH")) + 
      aes(x=Year) +
      geom_bar()
#make height of bars represent value in a column
ggplot(data = seaice %>% 
      filter(Herd == "WAH", Year == 1990)) + 
      aes(x=Month, y=Cover) +
      geom_col()
#order month labels in chronological order rather than alphabetical
seaice$Month <- factor(seaice$Month, month.abb)
ggplot(data=seaice %>% 
        filter(Herd=="WAH", Year==1990)) +
        aes(x=Month, y=Cover) +
        geom_col()

#create a scatter plot to show relationship between two continuous variables
p1 <- ggplot(data=popsize %>%
              filter(Herd=="WAH")) +
              aes(x=Year, y=Pop_Size) +
              geom_point()
show(p1) #display graph
p1+geom_smooth() #display a line to show plotted points
p1 + geom_smooth(method="lm") #use a linear model
#use a polynomial regression
p1 + geom_smooth(method = "lm",
                 formula= y ~ poly(x,3), se= FALSE) #se=false says dont plot standard error
#calculate summary stats and errors for herds GRH and PCH
stats <- popsize %>% filter(Herd %in% c("GRH", "PCH")) %>%
          group_by(Herd) %>%
          summarise(
                meanPopSize = mean(Pop_Size),
                SD = sd(Pop_Size),
                N =  n(),
                SEM = SD/sqrt(N),
                CI = SEM * qt(0.975, N-1))
#plot mean population size as a bar plot
ggplot(data = stats) +
        aes(x=Herd, y=meanPopSize) +
        geom_col()
#set up aesthetic mapping for confidence intervals 
limits <- aes(ymax=stats$meanPopSize + stats$CI,
              ymin=stats$meanPopSize - stats$CI)
#plot including confidence intervals
ggplot(data=stats) +
        aes(x=Herd, y= meanPopSize) +
        geom_col() +
        geom_errorbar(limits, width = .3)

#boxplot with colors showing population size of each herd
p1<- ggplot(data=popsize,
            aes(x=Herd, y=Pop_Size, fill = Herd)) +
            geom_boxplot()
show(p1)

#change colors from default
p1+scale_fill_brewer(palette =  "Set3")
#palette based on hue
p1+scale_fill_hue()
#set values and rename legend
p1+scale_fill_manual(values = rainbow(11), 
                     name = "aaa")

#set size and color of points
p1 <- ggplot(data=seaice %>% filter(Herd == "BEV")) + 
              aes(x=Year, y=Month, colour = Cover,
                  size = Cover) +
                  geom_point()
show(p1)

#change colors by setting
p1 + scale_colour_gradient(high= "white", low="red")


#graph shows how sea ice dynamics have changed through the years
ggplot(data = seaice %>% 
        filter(Herd %in% c("WAH" , "BAT"),
               Year %in% c(1980,1990,2000,2010))) +
               aes(x=Month, y=Cover) +
               geom_col() +
               facet_grid(Year~Herd) #x and y axis same for each graph

#fits several panels  
ggplot(data=seaice %>% filter(Year==2010)) +
        aes(x=Month, y=Cover) +
        geom_col() +
        facet_wrap(~Herd)
#allows for ranges to change between panels
ggplot(data=seaice %>% filter(Year==2010)) +
    aes(x=Month, y=Cover) +
    geom_col() +
    facet_wrap(~Herd, scales = "free")

#change labels of graph
p1<- ggplot(data=popsize) +
            aes(x=Year, y=Pop_Size) +
            geom_point()
p1 + xlab("Year")
p1 + ylab("Population Size")
p1 + ggtitle("Population Dynamics")


p1 <- ggplot(data=popsize) +
      aes(x=Herd, y=Pop_Size, fill=Herd) +
      geom_boxplot()
show(p1)
#move position of legend on a graph
p1 + theme(legend.position = "bottom")
p1 + theme(legend.position = "top")
#remove legend
p1 + theme(legend.position = "none")

#use guide function to change title and features of legend
p1<-ggplot(data=popsize) +
    aes(x=Year, y=Pop_Size, colour=Herd, 
                alpha = sqrt(Pop_Size)) +
    geom_point()
show(p1)
p1 + guides(colour=guide_legend(nrow=4,
                                title="herd"),
                    alpha = guide_legend(direction="horizontal", 
                                         title = "al"))
#suppress only one legend 
p1 + guides(colour="none")
#create a plot
p1<- ggplot(data=snow %>% 
              filter(Herd=="CAH"),
            aes(y=Week_snowmelt, x=Perc_snowccover)) +
            geom_point()
p1+theme_bw() #black and white background
show(p1)
p1+theme_linedraw() #line draw
show(p1)
p1+theme_minimal() #minimalist theme
show(p1)

#themes that mimic popular publications
install.packages("ggthemes")
library(ggthemes)
show(p1 + theme_fivethirtyeight())

#set color to be red for all points by setting value outside the aesthetics
p1<-ggplot(data = popsize) + 
    aes(x=Year, y=Pop_Size) +
    geom_point(colour="red")
show(p1)

#function ggsave used to save plots
ggsave(filename = "/Users/makenzielanier/Desktop/R Lab Files (tidyverse)/test.pdf",
       plot=p1, width=3, height=4)








####intermezzo 9.5####
#plot perc_snowcover vs week_snowmelt
ggplot(data=snow) +
        aes(x=Perc_snowcover, y= Week_snowmelt) +
        geom_col()


####intermezzo 9.6####
#produce a histogram for each herd showing ground snow melting
ggplot(data=snow %>% 
         filter(Herd)) +
         aes(x=Herd, y=Week_snowmelt) +
         geom_histogram()+
         facet_grid(Herd~Week_snowmelt)

ggplot(data=snow %>%
        filter(Week_snowmelt)) +
        aes(x=Year, y=Herd) +
        geom_tile()
      








