#binomial data can be organized as 'binomial counts' of 'x trials' or as bernoulli counts (1 and 0)
#if a binomial glmm exhibits overdispersion one solution is to model the data as bernoulli counts
#this code expands your dataframe from binomial counts to bernoulli counts
#code adapted from Warton and Hui 2011 Ecology, Ecological Archives E092-001-S1

#first, construct dataframe with structure of binomial counts
n = 10                          #number of trials 
alive = sample (1:10, size = 5) #pick 5 random integers from 1 to 10, this is the 'alive' column
dead = n-alive                  #create 'dead' column
data<-data.frame(n, alive, dead)#create dataframe
data

dataset<-data #first clone your dataframe and call it 'dataset' so you don't have to rename stuff
#my columns were originally called "alive" and "dead", change these column names so they are standardized at "success" and "failure"
names(dataset)[names(dataset)=="alive"]<-c("success") #rename the dataframe columns
names(dataset)[names(dataset)=="dead"]<-c("failure")
dataset.expanded = dataset[0,]
for (i in 1:length(dataset$success))
{
  if(dataset$success[i]>0)
  {
    dataset.add.succ = dataset[rep(i,dataset$success[i]),]
    dataset.add.succ$success=1
    dataset.add.succ$failure=0
    dataset.expanded=rbind(dataset.expanded, dataset.add.succ)
  }
  if(dataset$failure[i]>0)
  {
    dataset.add.fail = dataset[rep(i,dataset$failure[i]),]
    dataset.add.fail$success=0
    dataset.add.fail$failure=1
    dataset.expanded=rbind(dataset.expanded, dataset.add.fail)
  }
}
