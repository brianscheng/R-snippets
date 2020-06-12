#Eventfinder - quantify duration of events

salinity$new.time<-mapply(julian, x=as.POSIXct(salinity$rdate),origin=as.POSIXct("1900-01-01",tz="GMT"))

threshold<-5

index <- which(salinity2$Sal<=threshold) #index of all salinity values less than threshold.
l <- length(index) 
index2<-which((index[2:l]- index[1:l-1])>1) #holds the end new.time of each event
l2 <- length(index2)

eventDurations.5psu<- salinity$new.time[index[index2[1]]] - salinity$new.time[index[1]] #index has indices of elements from orginal dataframe, index2 has indices of the elements of index (which are the endpoints of each event)
for (i in 2:l2)
{
  eventDurations.5psu[i]<- salinity$new.time[index[index2[i]]] - salinity$new.time[index[index2[i-1]+1]] #this has the length of new.time for each event
} 
eventDurations.5psu[l2+1] <- salinity$new.time[index[index2[l2]]] - salinity$new.time[index[index2[l2-1]+1]] #this is the last event (because it can't find all of them)