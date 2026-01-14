#load packages
library(adegenet)
library(hierfstat)
library(pegas)

####using accessors####

#load data
data(nancycats)
View(nancycats)
nancycats[10:18, loc="fca8"]@tab #access information using accessors 
nInd(nancycats) #returns amount of individuals in the set - 237
nLoc(nancycats) #returns amount of loci - 9
nPop(nancycats) #returns amount of populations - 17

####using summaries####

summary(nancycats) #returns a summary of info about the data set

total<-summary(nancycats) #save summary as an object
names(total) #displays the names in the summary
#create a barplot 
barplot(total$loc.n.all, ylab = "Number of alleles",
        main="Number of alleles per locus")
####manipulating the data#####

data(microbov) #load data
microbov.pop<-genind2genpop(microbov) #create genpop object from genind
microbov.pop # 15 populations and 30 loci

popNames(microbov.pop) #displays population names 
microbov3<-microbov.pop[1:3,] #subset data
nAll(microbov3) #check loci names
subsetloci<-microbov3[,loc=c(1,3)] #subset by locus
subsetloci #range = 9-12
#sort by loci names
locNames(microbov3)
hel5<-microbov3[,loc='HEL5'] #look for one locus
hel5 #number of alleles per locus = 11

####measuring and testing population structure & HWE ####

wc(nancycats) #wc provides f stats
cats.hwt<-hw.test(nancycats, B=0) #test for hwe
cats.hwt #3 loci deviate from hwe

#### PCA on genind objects ####
sum(is.na(microbov$tab)) #find missing data - 6325 missing data sites
X<-scaleGen(microbov, NA.method="mean") #replace missing data using scaleGen
class(X)

#create list containing three important values
pcal <-dudi.pca(X, cent=FALSE, scale=FALSE, scannf = FALSE, nf=3) 
barplot(pcal$eig[1:50],main="PCA eigenvalues", col=heat.colors(50)) #create barplot

#create colorplot by plotting the pca
colorplot(pcal$li, pcal$li, transp=TRUE, cex=3, xlab="PC 1", ylab = "PC 2")
title("PCA of microbov dataset\naxes 1-2")
abline(v=0,h=0,col="grey", lty=2)

#look at PC1 and PC3
colorplot(pcal$li[c(1,3)], pcal$li, transp=TRUE, cex=3, xlab="PC 1", ylab = "PC 3")
title("PCA of microbov dataset\naxes 1-3")
abline(v=0,h=0,col="grey", lty=2)

