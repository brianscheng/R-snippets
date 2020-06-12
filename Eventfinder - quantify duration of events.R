#Eventfinder - quantify duration and number of events
#shout out to Dale Trockel for developing this solution

#create reproducible data
t    = seq(0,20,0.1)             #create time variable
y    = sin(t)                    #create sine wave variable
data = data.frame(t,y)           #stitch objects into dataframe
plot(data=data, y~t, type = "l") #plot to build intuition
abline(h=-0.5)                   #imagine we want to know how many events are below this 
                                 #threshold and for how long, here there are 3

#parameters (things to change depending on desired outcome)
threshold = -0.5                            #set threshold value
index<-which(data$y <= threshold)           #index of all values less than threshold

#general solution
l <- length(index)                          #calculate length
index2<-which((index[2:l]- index[1:l-1])>1) #holds the end time of each event
l2 <- length(index2)                        #calculate length of end points

eventDurations<- data$t[index[index2[1]]] - data$t[index[1]] 
#index has indices of elements from orginal dataframe
#index2 has indices of the elements of index (which are the endpoints of each event)

for (i in 2:l2)
{
  eventDurations[i]<- data$t[index[index2[i]]] - data$t[index[index2[i-1]+1]] #this has the length of time for each event
} 
eventDurations[l2+1] <- data$t[index[index2[l2]]] - data$t[index[index2[l2-1]+1]] #this is the last event (because it can't find all of them)

#results
eventDurations         #prints vector of event lengths, here they are length = 2
length(eventDurations) #number of events
