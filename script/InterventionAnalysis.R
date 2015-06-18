#Test Script for CareCascade
rm(list=ls())
setwd("/Users/jack/git/CareCascade")

Interventions <-
c("Baseline",
"Hbct_1",
"Hbct_2",
"Vct_1",
"Vct_2",
"HbctPocCd4_1",
"HbctPocCd4_2",
"Linkage_1",
"Linkage_2",
"VctPocCd4",
"PreOutreach_1",
"PreOutreach_2",
"ImprovedCare_1",
"ImprovedCare_2",
"PocCd4",
"ArtOutreach_1",
"ArtOutreach_2",
"Adherence_1",
"Adherence_2",
"ImmediateArt",
"UniversalTestAndTreat_1",
"UniversalTestAndTreat_2")

cHbct 					<- c(0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
cVct 					<- c(0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
cHbctPocCd4 			<- c(0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
cLinkage				<- c(0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0)
cVctPocCd4 				<- c(0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0)
cPreOutreach 			<- c(0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0)
cImprovedCare 			<- c(0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0)
cPocCd4 				<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0)
cArtOutreach			<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0)
cAdherence 				<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0)
cImmediateArt 			<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0)
cUniversalTestAndTreat 	<- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2)

GlobalPopSize = 100

#Intervention Loop
for(i in 1:length(Interventions)) {
	startTime <- proc.time()
	system("date")
	print(Interventions[i])
	flush.console()
	dyn.load("./source/main.so")
	result <- .Call("CallCascade",GlobalPopSize, 				# Pop;
						      	  cHbct[i],  					# Hbct;
						      	  cVct[i],  					# Vct;
						      	  cHbctPocCd4[i],  				# HbctPocCd4;
						      	  cLinkage[i],  				# Linkage;
						      	  cVctPocCd4[i],  				# VctPocCd4;
						      	  cPreOutreach[i],  			# PreOutreach;
						      	  cImprovedCare[i],  			# ImprovedCare;
						      	  cPocCd4[i],  					# PocCd4;
						      	  cArtOutreach[i],  			# ArtOutreach;
						      	  cAdherence[i],  				# Adherence;
						      	  cImmediateArt[i],  			# ImmediateArt;
						      	  cUniversalTestAndTreat[i]   	# UniversalTestAndTreat;
	)
	assign(Interventions[i],result)
	print(proc.time() - startTime)
	flush.console()
}

save.image(file="currentWorkspace.RData")


########################

baseline <- Cascade(10,0,0,0,0,0,0,0,0,0,0,0,0)
art <- Cascade(10,0,0,0,0,0,0,0,0,1,0,0,0)

Unaids_PlwhivOnArt <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_PlwhivOnArt_Kenya.csv",header=TRUE)
graphics.off()
quartz.options(h=10,w=10)
library(RColorBrewer)
p <- brewer.pal(9,"Set1")

plot(seq(0,59,1),baseline$sART_15to49 / baseline$sHIV_15to49,
	type='l',
	col=p[2],
	lwd=2,
	ylim=c(0,0.5),
	main='Proportion of PLWHIV on ART',
	xlab='Year',
	ylab='Proportion',
	xaxt='n')
lines(seq(0,59,1),art$sART_15to49 / art$sHIV_15to49,
	lwd=2,
	lty=3,
	col=p[3])
lines(seq(34,42,1),Unaids_PlwhivOnArt$propPlwhivOnArt,
	lwd=2,
	lty=3,
	col=p[1])
axis(1,seq(0,60,5),seq(1970,2030,5))
legend("topright",c("UNAIDS","CareCascade"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)

plot(seq(0,59,1),Baseline$sART_15to49 / Baseline$sHIV_15to49,
	type='l',
	col=p[2],
	lwd=2,
	ylim=c(0,0.5),
	main='Proportion of PLWHIV on ART',
	xlab='Year',
	ylab='Proportion',
	xaxt='n')
lines(seq(0,59,1),ArtOutreach_1$sART_15to49 / ArtOutreach_1$sHIV_15to49,
	lwd=2,
	col=p[3])
lines(seq(34,42,1),Unaids_PlwhivOnArt$propPlwhivOnArt,
	lwd=2,
	lty=3,
	col=p[1])
axis(1,seq(0,60,5),seq(1970,2030,5))
legend("topright",c("UNAIDS","CareCascade"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)


abline(v=33)


get(Interventions[1])

# get(Interventions[1])
save.image(file="currentWorkspace.RData")

load("currentWorkspace.RData")

########################

#####################
# PLOTS AND FIGURES #
#####################

graphics.off()
quartz.options(w=18,h=12)
library(RColorBrewer)
p <- brewer.pal(12,"Set3")
d <- brewer.pal(12,"Paired")
R <-brewer.pal(9,"Reds")
O <- brewer.pal(9,"Oranges")
G <-brewer.pal(9,"Greens")
B <-brewer.pal(9,"Blues")
plot_col <- c(R[7],R[5],O[6],p[6],O[3],G[7],p[7],G[3],B[7],B[5],d[10],d[9])

bDALY <- sum(Baseline$sDALY)

resultDALY <- matrix(0,2,12)
resultDALY[1,1] <- bDALY - sum(Hbct_1$sDALY)
resultDALY[2,1] <- bDALY - sum(Hbct_2$sDALY)
resultDALY[1,2] <- bDALY - sum(Vct_1$sDALY)
resultDALY[2,2] <- bDALY - sum(Vct_2$sDALY)
resultDALY[1,3] <- bDALY - sum(HbctPocCd4_1$sDALY)
resultDALY[2,3] <- bDALY - sum(HbctPocCd4_2$sDALY)
resultDALY[1,4] <- bDALY - sum(Linkage_1$sDALY)
resultDALY[2,4] <- bDALY - sum(Linkage_2$sDALY)
resultDALY[1,5] <- bDALY - sum(VctPocCd4$sDALY)
resultDALY[1,6] <- bDALY - sum(PreOutreach_1$sDALY)
resultDALY[2,6] <- bDALY - sum(PreOutreach_2$sDALY)
resultDALY[1,7] <- bDALY - sum(ImprovedCare_1$sDALY)
resultDALY[2,7] <- bDALY - sum(ImprovedCare_2$sDALY)
resultDALY[1,8] <- bDALY - sum(PocCd4$sDALY)
resultDALY[1,9] <- bDALY - sum(ArtOutreach_1$sDALY)
resultDALY[2,9] <- bDALY - sum(ArtOutreach_2$sDALY)
resultDALY[1,10] <- bDALY - sum(Adherence_1$sDALY)
resultDALY[2,10] <- bDALY - sum(Adherence_2$sDALY)
resultDALY[1,11] <- bDALY - sum(ImmediateArt$sDALY)
resultDALY[1,12] <- bDALY - sum(UniversalTestAndTreat_1$sDALY)
resultDALY[2,12] <- bDALY - sum(UniversalTestAndTreat_2$sDALY)

par(family="Avenir Next Bold")
	barplot(resultDALY[1,],
		col=plot_col,
		border=NA,
		cex.main=1.5,
		cex.lab=1.2,
		main="DALY's averted between 2010 and 2030",
		ylim=c(0,5e+04),
		ylab="DALY's averted",
		yaxt='n')
	axis(2,at=seq(0,5e+04,1e+04),labels=format(seq(0,5e+04,1e+04),big.mark=","),las=3,cex.axis=1)
	mtext("HBCT",1,								at=0.7,1,cex=1)
	mtext("VCT",1,								at=1.9,1,cex=1)
	mtext("HBCT\n POC CD4",1,					at=3.1,1.5,cex=1)
	mtext("Linkage",1,							at=4.3,1,cex=1)
	mtext("VCT\nPOC CD4",1,						at=5.5,1.5,cex=1)
	mtext("Pre-ART\n Outreach",1,				at=6.7,1.5,cex=1)
	mtext("Improved\n Care",1,					at=7.9,1.5,cex=1)
	mtext("POC CD4",1,							at=9.1,1,cex=1)
	mtext("ART\n Outreach",1,					at=10.3,1.5,cex=1)
	mtext("Adherence",1,						at=11.5,1.5,cex=1)
	mtext("Immediate\n ART",1,					at=12.7,1.5,cex=1)
	mtext("UTT",1,								at=13.9,1.5,cex=1)

	barplot(resultDALY[2,],
		yaxt='n',
		border=NA,
		add=TRUE,
		col=c(1,1,1,1,0,1,1,0,1,1,0,1),
		density=30)

legend("topleft",
	c("Maximum Impact","Realistic Impact"),
	fill=1,
	density=c(100,30),
	cex=1.5,
	border=NA,
	box.lty=0)

abline(v=2.5,lty=3,lwd=1.5)
abline(v=6.1,lty=3,lwd=1.5)
abline(v=9.7,lty=3,lwd=1.5)
abline(v=12.1,lty=3,lwd=1.5)

quartz.save("./interventionFigures/impact.pdf",type='pdf')

##################
# CARE PIE CHART #
##################

graphics.off()
quartz.options(w=20,h=12)
library(RColorBrewer)
m <- brewer.pal(9,"Spectral")

par(mfrow=c(1,3),family="Avenir Next Bold")
pie(Baseline$sCARE,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)

pie(Adherence_2$sCARE,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)

pie(Adherence_1$sCARE,
	labels=c("Never tested",
		"Tested but never\n initiated ART",
		"Initiated ART but\n died following late initiation (<200)",
		"Initiated ART but\n died off ART",
		"Initiatied ART but\n not late (>200)"),
	col=c(m[1:5]),
	border=NA,
	cex=2)

##################
# INVESTIGATIONS #
##################

source("./rScript/BaselineFigures.R")
GenerateBaselineFigures(Baseline)
GenerateBaselineFigures(ArtOutreach_1)
GenerateBaselineFigures(Adherence_1)
Adherence_1$sART_15to49
abline(v=37)

art$


#########
# NOTES #
#########

# 1) There is no ImmediateArt_2 intervention - IDIOT.
# 2) Maybe I should actually look at the order of interventions...

