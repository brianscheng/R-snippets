#examples of special characters in ggplot2 or base r plotting

library(ggplot2)

qplot(1,1) + labs (x = expression(pi))

qplot(1,1) + labs (x = expression(infinity))

qplot(1,1) + labs (x = expression(beta))

qplot(1,1) + labs (x = expression("NO"[3]^-{}))

qplot(1,1) + labs (x = expression(paste("Temperature"," (",degree,"C)")))

qplot(1,1) + labs (x = expression(paste(delta,"C"[13]^14)))


                  
                  