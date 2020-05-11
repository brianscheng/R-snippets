#vignette rnoaa buoy function

library(rnoaa) ; library(ggplot2)
#buoys command pulls straight from NDBC, may require ncdf package
res<-buoys(dataset="stdmet")
res #list of buoy data (standard meteorological) that is available
#datasets available: adcp, adcp2, cwind, dart, mmbcur, ocean, pwind, stdmet, swden, wlevel
#see package details for full description of data types

mbb<-buoy(dataset='stdmet', buoyid = 46258)
#buoy is the primary function for pulling ndbc data
#46258 is Mission Bay West Buoy
#if no year specified, first year is pulled, in this case 2016
#oddly, doesn't seem like you can pull multiple years

mbb.2016<-buoy(dataset='stdmet', buoyid = 46258, year = 2016)
mbb.2017<-buoy(dataset='stdmet', buoyid = 46258, year = 2017)
mbb.2018<-buoy(dataset='stdmet', buoyid = 46258, year = 2018)
mbb.2019<-buoy(dataset='stdmet', buoyid = 46258, year = 2019)

#above are "large buoy" elements, 1st element has metadata, 2nd element is the data itself
mbb.2016

#now lets just extract the data itself
mbb.2016.df<-mbb.2016$data
mbb.2017.df<-mbb.2017$data
mbb.2018.df<-mbb.2018$data
mbb.2019.df<-mbb.2019$data

mbb.all.df<-rbind(mbb.2016.df, mbb.2017.df, mbb.2018.df, mbb.2019.df)
str(mbb.all.df)
plot(mbb.all.df$sea_surface_temperature)#looks reasonable

mbb.all.df$rtime<-as.POSIXct(x=mbb.all.df$time, format="%Y-%m-%d")
#convert time to POSIXlt format, note that I cut off the time
is.POSIXct <- function(x) inherits(x, "POSIXct") #write a function to check that it is
is.POSIXct(mbb.all.df$rtime) #check

my.ylab = expression(paste("SST"," (",degree,"C)"))

plot1<-ggplot(mbb.all.df,aes(x=rtime,y=sea_surface_temperature))+geom_point()+ylab(my.ylab)+
  xlab("Date (year-month)")+theme_bw()+
  theme(axis.title.y=element_text(size=18,vjust=1),axis.text=element_text(size=16),
        axis.title.x=element_text(size=18,vjust=-0.1), 
        panel.border = element_rect(size=.8, colour = "black"))
#scale_x_datetime(date_breaks = "1 year")
plot1
