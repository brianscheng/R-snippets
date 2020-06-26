#brief vignette on rfishbase
#original author: Woody Laui
#Concept: test Bergmann's rule, which states that populations of fish within a certain clade closer to the poles will be larger in mass than their equatorial counter parts.
#Compiling Mean Distributions, Maximum Lengths, and Maximum Weights of Different Species from Fishbase


#load rfishbase
library(rfishbase)

#Let's just query for some common species using common names
Tuna<-common_to_sci("Tuna") #this sets Tuna as a set of scientific names under the common name 'Tuna'
Grouper<-common_to_sci("Grouper")
Snapper<-common_to_sci("Snapper")

#This sets extentNS as a table of the Northern Latitude and the Southern Latitude numbers as a range. They will be positive values.
extentNS<-c("NorthernLatitude", "NorthernLatitudeNS", "SouthernLatitude", "SouthernLatitudeNS")

#BSC START FROM HERE
#Query the distribution of each set of species (hence the [1:24]) 
distr_T<-distribution(Tuna[1:24], fields = extentNS)
distr_G<-distribution(Grouper[1:81], field=extentNS)
distr_S<-distribution(Snapper[1:79], field=extentNS)

#Using their species reference number as the common variable, find the max weight for each of the species
TW<-species(Tuna,fields=c("SpeciesRefNO", "Weight"))
GW<-species(Grouper, fields=c("SpeciesRefNO", "Weight"))
SW<-species(Snapper, fields=c("SpeciesRefNO", "Weight"))

#Again, using their species reference number as the common variable, find the max length for each of the species 
TL<-species(Tuna, fields=c("SpeciesRefNO", "Length"))
GL<-species(Grouper, fields=c("SpeciesRefNO", "Length"))
SL<-species(Snapper, fields=c("SpeciesRefNO", "Length"))

#Now, merge the last three tables with the respective max weight tables
TLW<-(merge(TL, TW))
GLW<-(merge(GL, GW))
SLW<-(merge(SL, SW))

#Now merge EVERYTHING
T3<-(merge(TLW, distr_T))
G3<-(merge(GLW, distr_G))
S3<-(merge(SLW, distr_S))

#Now we'll just look at the data for Tuna, as things get slightly tedious here. 
#This first line says that in a new column of table T3 called NValue: for all values in the column NorthernLatitude, any value that is positive is left alone, whereas any value that is of southern latitude (ie in the NorthernLatitude column, but is a value in the southern hemisphere), multiply by -1
T3$NValue<-ifelse(T3$NorthernLatitudeNS=="N", T3$NorthernLatitude, T3$NorthernLatitude*-1)
#This line does the opposite for the values in SouthernLatitude, in a new column called SValue in table T3. Therefore, any value that is of the southern hemisphere is multiplied by -1, the values of the northern hemisphere are left alone.
T3$SValue<-ifelse(T3$SouthernLatitudeNS=="S", T3$SouthernLatitude*-1, T3$SouthernLatitude*1)

#This command will create a new column in the table T3 called centre, which gives the average of the latitude, or the centre of the species' range
#HOWEVER, it only finds the mean of all the different distributions within a species. Meaning, that it isn't the actual average latitude, but merely the average latitudes of the different populations
T3$Centre<-(T3$NValue+T3$SValue)/2

#Now that we have those commands, we can proceed to do the same for the other species under the two other common names.
G3$NValue<-ifelse(G3$NorthernLatitudeNS=="N", G3$NorthernLatitude, G3$NorthernLatitude*-1)
G3$SValue<-ifelse(G3$SouthernLatitudeNS=="S", G3$SouthernLatitude*-1, G3$SouthernLatitude*1)
G3$Centre<-(G3$NValue+G3$SValue)/2

S3$NValue<-ifelse(S3$NorthernLatitudeNS=="N", S3$NorthernLatitude, S3$NorthernLatitude*-1)
S3$SValue<-ifelse(S3$SouthernLatitudeNS=="S", S3$SouthernLatitude*-1, S3$SouthernLatitude*1)
S3$Centre<-(S3$NValue+S3$SValue)/2

#Hooray!! BUT! Now we need to sort this data in the right data frames
#For the species under Tuna, let's create a dataframe with the species names, and the mean latitude (ie, centre of range)
#This command finds the mean lat of each species
TLatmean<-tapply(T3$Centre, T3$sciname, mean)
#Create the data frame with the generated table
T4<-data.frame(TLatmean)
#This creates a new column of scientific names associated with the correct rows 
T4$sciname<-row.names(T4)

#Now let's merge that with the lenght and weight
T4lw<-merge(T4, TLW)
#PLOT
T4WLat<-plot(T4lw$Weight~T4lw$TLatmean)
T4LLat<-plot(T4lw$Length~T4lw$TLatmean)
#YAAAAAY!!!!! now go do it for the other two groups
GLatmean<-tapply(G3$Centre, G3$sciname, mean)
G4<-data.frame(GLatmean)
G4$sciname<-row.names(G4)
G4lw<-merge(G4, GLW)
G4WLat<-plot(G4lw$Weight~G4lw$GLatmean)
G4LLat<-plot(G4lw$Length~G4lw$GLatmean)

SLatmean<-tapply(S3$Centre, S3$sciname, mean)
S4<-data.frame(SLatmean)
S4$sciname<-row.names(S4)
S4lw<-merge(S4, SLW)
S4WLat<-plot(S4lw$Weight~S4lw$SLatmean)
S4LLat<-plot(S4lw$Length~S4lw$SLatmean)

#Sooo... this doesn't really contribute much towards discussing Bergmann's rule. But we can always use this code to extract the same data for all the species provided by Fishbase. Go fetch!


