#Test Script for CareCascade
setwd("/Users/jack/git/CareCascade")
source("./rScript/BaselineFigures.R")

system("date")
popSize = 1000
dyn.load("./source/main.so")

Baseline2 <- .Call("CallCascade",popSize, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Baseline2

Baseline <- .Call("CallCascade",popSize, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Baseline

system("date")
popSize = 100
dyn.load("./source/main.so")

ImmArt <- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)
ImmArt

names(Baseline)

plot(Baseline$sAidsDeath,type='b',lwd=2)
lines(ImmArt$sAidsDeath,col="red",lwd=2,type='b')

sum(ImmArt$sDALY)

ImmArt$sDALY_OffArt / ImmArt$sDALY
ImmArt$sDALY_OnArt / ImmArt$sDALY
plot(ImmArt$sDALY_LYL / ImmArt$sDALY,type='b',lwd=2,ylim=c(0,1))

# DALYs comparison

(sum(Baseline$sDALY) - sum(ImmArt$sDALY)) / sum(Baseline$sDALY)

plot(ImmArt$sDALY)

# Deaths

(sum(Baseline$sCARE) - sum(ImmArt$sCARE)) / sum(Baseline$sCARE)

sum(Baseline$sCARE)
sum(Baseline$sAidsDeath[41:60])

plot(Baseline$sAidsDeath[41:60] - ImmArt$sAidsDeath[41:60],type='b',lwd=2)

sum(ImmArt$sCARE)

(sum(Baseline$sDALY) - sum(ImmArt$sDALY)) / sum(Baseline$sDALY)

totalDALY <- sum(Baseline$sDALY)

sum(Baseline$sDALY_OffArt)
sum(Baseline$sDALY_OnArt)
sum(Baseline$sDALY_LYL)

sum(Baseline$sDALY_OffArt) + sum(Baseline$sDALY_OnArt) + sum(Baseline$sDALY_LYL)


theDALY <- c(sum(Baseline$sDALY_OnArt),sum(Baseline$sDALY_OffArt),sum(Baseline$sDALY_LYL))

Out <- c(theDALY[1] / totalDALY,theDALY[2] / totalDALY,theDALY[3] / totalDALY)

require(RColorBrewer)
Color <- brewer.pal(9,"Set1")

barplot(as.matrix(Out),col=Color)


plot(Baseline$sDALY,type='l',lwd=2)
lines(ImmArt$sDALY,type='l',lwd=2,col="red")

(sum(Baseline$sDALY) - sum(ImmArt$sDALY)) / sum(Baseline$sDALY)
(sum(Baseline$sCARE) - sum(ImmArt$sCARE)) / sum(Baseline$sCARE)


sum(ImmArt$sDALY)


sum(Baseline$sDALY_OffArt)
sum(Baseline$sDALY_OnArt)
sum(Baseline$sDALY_LYL)

plot(Baseline$sINCIDENCE,type='l',lwd=2)
lines(Baseline2$sINCIDENCE,type='l',lwd=2,col="red")