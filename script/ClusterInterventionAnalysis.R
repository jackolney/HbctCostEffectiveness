#Test Script for CareCascade
rm(list=ls())
setwd("/Volumes/jjo11/cascade/CareCascadeV2/November/24th/Sweep/")

load("./output/Baseline/currentWorkspace.RData")
Baseline <- result
load("./output/Hbct_1/currentWorkspace.RData")
Hbct_1 <- result
load("./output/Hbct_2/currentWorkspace.RData")
Hbct_2  <- result
load("./output/Vct_1/currentWorkspace.RData")
Vct_1 <- result
load("./output/Vct_2/currentWorkspace.RData")
Vct_2  <- result
load("./output/HbctPocCd4_1/currentWorkspace.RData")
HbctPocCd4_1 <- result
load("./output/HbctPocCd4_2/currentWorkspace.RData")
HbctPocCd4_2  <- result
load("./output/Linkage_1/currentWorkspace.RData")
Linkage_1 <- result
load("./output/Linkage_2/currentWorkspace.RData")
Linkage_2 <- result
load("./output/VctPocCd4/currentWorkspace.RData")
VctPocCd4 <- result
load("./output/PreOutreach_1/currentWorkspace.RData")
PreOutreach_1 <- result
load("./output/PreOutreach_2/currentWorkspace.RData")
PreOutreach_2  <- result
load("./output/ImprovedCare_1/currentWorkspace.RData")
ImprovedCare_1 <- result
load("./output/ImprovedCare_2/currentWorkspace.RData")
ImprovedCare_2  <- result
load("./output/PocCd4/currentWorkspace.RData")
PocCd4  <- result
load("./output/ArtOutreach_1/currentWorkspace.RData")
ArtOutreach_1 <- result
load("./output/ArtOutreach_2/currentWorkspace.RData")
ArtOutreach_2 <- result
load("./output/Adherence_1/currentWorkspace.RData")
Adherence_1 <- result
load("./output/Adherence_2/currentWorkspace.RData")
Adherence_2 <- result
load("./output/ImmediateArt/currentWorkspace.RData")
ImmediateArt <- result
load("./output/UniversalTestAndTreat_1/currentWorkspace.RData")
UniversalTestAndTreat_1 <- result
load("./output/UniversalTestAndTreat_2/currentWorkspace.RData")
UniversalTestAndTreat_2 <- result

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
		ylim=c(0,5e+05),
		ylab="DALY's averted",
		yaxt='n')
	axis(2,at=seq(0,5e+05,1e+05),labels=format(seq(0,5e+05,1e+05),big.mark=","),las=3,cex.axis=1)
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

quartz.save("/Users/jack/git/CareCascade/interventionFigures/impact.pdf",type='pdf')

######################
# COST IMPACT FIGURE #
######################
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

bCOST <- sum(Baseline$sCOST)

resultCOST <- matrix(0,2,12)
resultCOST[1,1] <- sum(Hbct_1$sCOST) - bDALY
resultCOST[2,1] <- sum(Hbct_2$sCOST) - bDALY
resultCOST[1,2] <- sum(Vct_1$sCOST) - bDALY
resultCOST[2,2] <- sum(Vct_2$sCOST) - bDALY
resultCOST[1,3] <- sum(HbctPocCd4_1$sCOST) - bDALY
resultCOST[2,3] <- sum(HbctPocCd4_2$sCOST) - bDALY
resultCOST[1,4] <- sum(Linkage_1$sCOST) - bDALY
resultCOST[2,4] <- sum(Linkage_2$sCOST) - bDALY
resultCOST[1,5] <- sum(VctPocCd4$sCOST) - bDALY
resultCOST[1,6] <- sum(PreOutreach_1$sCOST) - bDALY
resultCOST[2,6] <- sum(PreOutreach_2$sCOST) - bDALY
resultCOST[1,7] <- sum(ImprovedCare_1$sCOST) - bDALY
resultCOST[2,7] <- sum(ImprovedCare_2$sCOST) - bDALY
resultCOST[1,8] <- sum(PocCd4$sCOST) - bDALY
resultCOST[1,9] <- sum(ArtOutreach_1$sCOST) - bDALY
resultCOST[2,9] <- sum(ArtOutreach_2$sCOST) - bDALY
resultCOST[1,10] <- sum(Adherence_1$sCOST) - bDALY
resultCOST[2,10] <- sum(Adherence_2$sCOST) - bDALY
resultCOST[1,11] <- sum(ImmediateArt$sCOST) - bDALY
resultCOST[1,12] <- sum(UniversalTestAndTreat_1$sCOST) - bDALY
resultCOST[2,12] <- sum(UniversalTestAndTreat_2$sCOST) - bDALY

par(family="Avenir Next Bold")
plot(resultDALY[1,1],resultCOST[1,1],
	pch=19,
	cex=1.5,
	cex.main=1.5,
	cex.lab=1.2,
	cex.axis=1.2,
	col=plot_col[1],
	xlim=c(0,5e+05),
	main="DALY's averted against additional cost of interventions acting on HIV care between 2010 and 2030",
	xlab="DALY's averted",
	ylab="Additional cost (2013 USD)",
	ylim=c(0,7e+9))
# abline(h=0,lwd=1.5)
# abline(v=0,lwd=1.5)

points(resultDALY[2,1],resultCOST[2,1],col=plot_col[1],pch=17,cex=1.5)

points(resultDALY[1,2],resultCOST[1,2],col=plot_col[2],pch=19,cex=1.5)
points(resultDALY[2,2],resultCOST[2,2],col=plot_col[2],pch=17,cex=1.5)

points(resultDALY[1,3],resultCOST[1,3],col=plot_col[3],pch=19,cex=1.5)
points(resultDALY[2,3],resultCOST[2,3],col=plot_col[3],pch=17,cex=1.5)

points(resultDALY[1,4],resultCOST[1,4],col=plot_col[4],pch=19,cex=1.5)
points(resultDALY[2,4],resultCOST[2,4],col=plot_col[4],pch=17,cex=1.5)

points(resultDALY[1,5],resultCOST[1,5],col=plot_col[5],pch=19,cex=1.5)

points(resultDALY[1,6],resultCOST[1,6],col=plot_col[6],pch=19,cex=1.5)
points(resultDALY[2,6],resultCOST[2,6],col=plot_col[6],pch=17,cex=1.5)

points(resultDALY[1,7],resultCOST[1,7],col=plot_col[7],pch=19,cex=1.5)
points(resultDALY[2,7],resultCOST[2,7],col=plot_col[7],pch=19,cex=1.5)

points(resultDALY[1,8],resultCOST[1,8],col=plot_col[8],pch=19,cex=1.5)

points(resultDALY[1,9],resultCOST[1,9],col=plot_col[9],pch=19,cex=1.5)
points(resultDALY[2,9],resultCOST[2,9],col=plot_col[9],pch=17,cex=1.5)

points(resultDALY[1,10],resultCOST[1,10],col=plot_col[10],pch=19,cex=1.5)
points(resultDALY[2,10],resultCOST[2,10],col=plot_col[10],pch=17,cex=1.5)

points(resultDALY[1,11],resultCOST[1,11],col=plot_col[11],pch=19,cex=1.5)

points(resultDALY[1,12],resultCOST[1,12],col=plot_col[12],pch=19,cex=1.5)
points(resultDALY[2,12],resultCOST[2,12],col=plot_col[12],pch=17,cex=1.5)

legend("topright",
	c("HBCT",
		"VCT",
		"HBCT POC CD4",
		"Linkage",
		"Pre-ART Outreach",
		"Improved Care",
		"VCT POC CD4",
		"POC CD4",
		"On-ART Outreach",
		"Adherence",
		"Immediate ART",
		"UTT"),
	fill=plot_col,
	border=NA,
	box.lty=0,
	cex=1.2)

legend(c(0,7e+9),
	c("Maximum Impact",
		"Realistic Impact"),
	pch=c(19,17),
	col=c(1),
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save("/Users/jack/git/CareCascade/interventionFigures/costImpact.pdf",type='pdf')

###########
# BIG PIE #
###########

library(RColorBrewer)
m <- brewer.pal(9,"Spectral")
p <- brewer.pal(9,"Set1")
graphics.off()
quartz.options(w=20,h=12)
system("mkdir ./interventionFigures/pie")

Interventions <- c("Baseline", "Hbct_1", "Hbct_2", "Vct_1", "Vct_2", "HbctPocCd4_1", "HbctPocCd4_2", "Linkage_1", "Linkage_2", "VctPocCd4", "PreOutreach_1", "PreOutreach_2", "ImprovedCare_1", "ImprovedCare_2", "PocCd4", "ArtOutreach_1", "ArtOutreach_2", "Adherence_1", "Adherence_2", "ImmediateArt", "UniversalTestAndTreat_1", "UniversalTestAndTreat_2")

for(i in 1:length(Interventions)) {
	print(Interventions[i])
	par(family="Avenir Next Bold")
	pie(get(Interventions[i])$sCARE,
		main=Interventions[i],
		labels=c("Never tested",
			"Tested but never\n initiated ART",
			"Initiated ART but\n died following late initiation (<200)",
			"Initiated ART but\n died off ART",
			"Initiatied ART but\n not late (>200)"),
		col=c(m[1:5]),
		border=NA,
		cex=2)
	quartz.save(gsub(" ","",paste("/Users/jack/git/CareCascade/interventionFigures/pie/",Interventions[i],".pdf")),type='pdf')

	par(family="Avenir Next Bold")
	pie(get(Interventions[i])$sCLINIC,
		main="The View from the Clinic\n (At ART initiation between 2010 and 2030)",
		labels=c("Successful retention in pre-ART care",
			"Initiated ART at entry to care",
			"Lost from pre-ART care\n but returned prior to becoming eligible",
			"Lost from pre-ART\n and returned when eligible"),
		col=c(p[3],m[3],m[2],m[1]),
		border=NA,
		cex=2)
	quartz.save(gsub(" ","",paste("/Users/jack/git/CareCascade/interventionFigures/pie/",Interventions[i],"_Clinic.pdf")),type='pdf')

}

################
# TOTAL DEATHS #
################
setwd("/Users/jack/git/CareCascade/")

# Create some directories.
for(i in 1:length(Interventions)) {
	system(paste("mkdir",gsub(" ","",paste("./interventionFigures/",Interventions[i]))))
}

# Fill them up...
source("./rScript/BaselineFigures.R")
for(i in 1:length(Interventions)) {
	print(Interventions[i])
	directory <- gsub(" ","",paste("/Users/jack/git/CareCascade/interventionFigures/",Interventions[i]))
	GenerateBaselineFigures(get(Interventions[i]),directory)
}