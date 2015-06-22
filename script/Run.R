#Test Script for CareCascade
setwd("/Users/jack/git/HbctCostEffectiveness")

system("date")
popSize = 1000
dyn.load("./src/main.so")

Baseline <- .Call("CallCascade",popSize, 0, 0, 0, 0, 0)
Baseline

system("date")
popSize = 100
dyn.load("./src/main.so")

Hbct <- .Call("CallCascade",popSize, 1, 0, 0, 0, 0)
Hbct
