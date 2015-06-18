#Test Script for CareCascade
rm(list=ls())
setwd("/Volumes/jjo11/cascade/CareCascadeV2/December/8th/Normal")
system("mkdir ./plots")

# Load up results.
run <- c("run1","run2","run3","run4","run5","run6","run7","run8","run9","run10")
interventions <- c("Baseline", "Hbct_1", "Hbct_2", "Vct_1", "Vct_2", "HbctPocCd4_1", "HbctPocCd4_2", "Linkage_1", "Linkage_2", "VctPocCd4", "PreOutreach_1", "PreOutreach_2", "ImprovedCare_1", "ImprovedCare_2", "PocCd4", "ArtOutreach_1", "ArtOutreach_2", "Adherence_1", "Adherence_2", "ImmediateArt", "UniversalTestAndTreat_1", "UniversalTestAndTreat_2")

# Baseline load to get the size of the output array needed
if(file.exists(gsub(" ","",paste("./",run[1],"/output/",interventions[1],"/currentWorkspace.RData"))))
	load(gsub(" ","",paste("./",run[1],"/output/",interventions[1],"/currentWorkspace.RData"))) else stop("File (run1:baseline) does not exist.")

# Loop through all interventions and runs and dynamically average them #
for(i in 1:length(interventions)) {
	cat(paste("",interventions[i], "\n"))
	# Create vector of names
	outputNames <- c()
	for(m in 1:length(Baseline))
		outputNames[m] <- names(Baseline)[m]
	# Create list
	output <- sapply(outputNames,function(x) NULL)
	for(n in 1:length(output))
		output[[n]] <- vector('double',length(Baseline[[n]]))
	theLength = 0
	for(j in 1:length(run)) {
		if(file.exists(gsub(" ","",paste("./",run[j],"/output/",interventions[i],"/currentWorkspace.RData")))) {
			load(gsub(" ","",paste("./",run[j],"/output/",interventions[i],"/currentWorkspace.RData")))
			cat(paste("\t",run[j], "\n"))
			theLength <- theLength + 1
			for(k in 1:length(get(interventions[i]))) {
				cat(paste("\t\tRow",k, "\n"))
				output[[k]] <- output[[k]] + get(interventions[i])[[k]]
			}
		}
	}
	cat(paste("\t\t\ttheLength =",theLength, "\n"))
	for(l in 1:length(get(interventions[i]))) {
		cat(paste("\t\t\t\tOutputRow",l, "\n"))
		output[[l]] <- output[[l]] / theLength
	}
	assign(interventions[i],output)
}
print("\tComplete!")

##################
# sizeAdjustment #
sizeAdjustment = 10
##################

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
plotCol <- c(R[7],R[5],O[6],p[6],O[3],G[7],p[7],G[3],B[7],B[5],d[10],d[9])

resultDALY <- matrix(0,2,12)
resultDALY[1,1] <- (sum(Baseline$sDALY) - sum(Hbct_1$sDALY)) * sizeAdjustment
resultDALY[2,1] <- (sum(Baseline$sDALY) - sum(Hbct_2$sDALY)) * sizeAdjustment
resultDALY[1,2] <- (sum(Baseline$sDALY) - sum(Vct_1$sDALY)) * sizeAdjustment
resultDALY[2,2] <- (sum(Baseline$sDALY) - sum(Vct_2$sDALY)) * sizeAdjustment
resultDALY[1,3] <- (sum(Baseline$sDALY) - sum(HbctPocCd4_1$sDALY)) * sizeAdjustment
resultDALY[2,3] <- (sum(Baseline$sDALY) - sum(HbctPocCd4_2$sDALY)) * sizeAdjustment
resultDALY[1,4] <- (sum(Baseline$sDALY) - sum(Linkage_1$sDALY)) * sizeAdjustment
resultDALY[2,4] <- (sum(Baseline$sDALY) - sum(Linkage_2$sDALY)) * sizeAdjustment
resultDALY[1,5] <- (sum(Baseline$sDALY) - sum(VctPocCd4$sDALY)) * sizeAdjustment
resultDALY[1,6] <- (sum(Baseline$sDALY) - sum(PreOutreach_1$sDALY)) * sizeAdjustment
resultDALY[2,6] <- (sum(Baseline$sDALY) - sum(PreOutreach_2$sDALY)) * sizeAdjustment
resultDALY[1,7] <- (sum(Baseline$sDALY) - sum(ImprovedCare_1$sDALY)) * sizeAdjustment
resultDALY[2,7] <- (sum(Baseline$sDALY) - sum(ImprovedCare_2$sDALY)) * sizeAdjustment
resultDALY[1,8] <- (sum(Baseline$sDALY) - sum(PocCd4$sDALY)) * sizeAdjustment
resultDALY[1,9] <- (sum(Baseline$sDALY) - sum(ArtOutreach_1$sDALY)) * sizeAdjustment
resultDALY[2,9] <- (sum(Baseline$sDALY) - sum(ArtOutreach_2$sDALY)) * sizeAdjustment
resultDALY[1,10] <- (sum(Baseline$sDALY) - sum(Adherence_1$sDALY)) * sizeAdjustment
resultDALY[2,10] <- (sum(Baseline$sDALY) - sum(Adherence_2$sDALY)) * sizeAdjustment
resultDALY[1,11] <- (sum(Baseline$sDALY) - sum(ImmediateArt$sDALY)) * sizeAdjustment
resultDALY[1,12] <- (sum(Baseline$sDALY) - sum(UniversalTestAndTreat_1$sDALY)) * sizeAdjustment
resultDALY[2,12] <- (sum(Baseline$sDALY) - sum(UniversalTestAndTreat_2$sDALY)) * sizeAdjustment


par(family="Avenir Next Bold")
	barplot(resultDALY[1,],
		col=plotCol,
		border=NA,
		cex.main=1.5,
		cex.lab=1.2,
		main="DALY's averted between 2010 and 2030",
		ylim=c(0,6e+06),
		ylab="DALY's averted",
		yaxt='n')
	axis(2,at=seq(0,6e+06,1e+06),labels=format(seq(0,6e+06,1e+06),big.mark=",",scientific=FALSE),las=3,cex.axis=1)
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

quartz.save("./plots/impact.pdf",type='pdf')

############################
# PROPORTION OF DALYS PLOT #
############################

resultPropDALY <- matrix(0,2,12)
resultPropDALY[1,1] <- (sum(Baseline$sDALY) - sum(Hbct_1$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[2,1] <- (sum(Baseline$sDALY) - sum(Hbct_2$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,2] <- (sum(Baseline$sDALY) - sum(Vct_1$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[2,2] <- (sum(Baseline$sDALY) - sum(Vct_2$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,3] <- (sum(Baseline$sDALY) - sum(HbctPocCd4_1$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[2,3] <- (sum(Baseline$sDALY) - sum(HbctPocCd4_2$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,4] <- (sum(Baseline$sDALY) - sum(Linkage_1$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[2,4] <- (sum(Baseline$sDALY) - sum(Linkage_2$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,5] <- (sum(Baseline$sDALY) - sum(VctPocCd4$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,6] <- (sum(Baseline$sDALY) - sum(PreOutreach_1$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[2,6] <- (sum(Baseline$sDALY) - sum(PreOutreach_2$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,7] <- (sum(Baseline$sDALY) - sum(ImprovedCare_1$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[2,7] <- (sum(Baseline$sDALY) - sum(ImprovedCare_2$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,8] <- (sum(Baseline$sDALY) - sum(PocCd4$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,9] <- (sum(Baseline$sDALY) - sum(ArtOutreach_1$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[2,9] <- (sum(Baseline$sDALY) - sum(ArtOutreach_2$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,10] <- (sum(Baseline$sDALY) - sum(Adherence_1$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[2,10] <- (sum(Baseline$sDALY) - sum(Adherence_2$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,11] <- (sum(Baseline$sDALY) - sum(ImmediateArt$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[1,12] <- (sum(Baseline$sDALY) - sum(UniversalTestAndTreat_1$sDALY))  / sum(Baseline$sDALY)
resultPropDALY[2,12] <- (sum(Baseline$sDALY) - sum(UniversalTestAndTreat_2$sDALY))  / sum(Baseline$sDALY)

par(family="Avenir Next Bold")
	barplot(resultPropDALY[1,],
		col=plotCol,
		border=NA,
		cex.main=1.5,
		cex.lab=1.2,
		main="Proportion of DALY's averted between 2010 and 2030",
		ylim=c(0,0.15),
		ylab="Proportion of DALY's averted",
		yaxt='n')
	axis(2,at=seq(0,0.15,0.01),labels=format(seq(0,0.15,0.01),big.mark=","),las=3,cex.axis=1)
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

	barplot(resultPropDALY[2,],
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

quartz.save("./plots/propImpact.pdf",type='pdf')

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
plotCol <- c(R[7],R[5],O[6],p[6],O[3],G[7],p[7],G[3],B[7],B[5],d[10],d[9])

resultCOST <- matrix(0,2,12)
resultCOST[1,1] <- (sum(Hbct_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,1] <- (sum(Hbct_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,2] <- (sum(Vct_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,2] <- (sum(Vct_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,3] <- (sum(HbctPocCd4_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,3] <- (sum(HbctPocCd4_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,4] <- (sum(Linkage_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,4] <- (sum(Linkage_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,5] <- (sum(VctPocCd4$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,6] <- (sum(PreOutreach_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,6] <- (sum(PreOutreach_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,7] <- (sum(ImprovedCare_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,7] <- (sum(ImprovedCare_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,8] <- (sum(PocCd4$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,9] <- (sum(ArtOutreach_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,9] <- (sum(ArtOutreach_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,10] <- (sum(Adherence_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,10] <- (sum(Adherence_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,11] <- (sum(ImmediateArt$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[1,12] <- (sum(UniversalTestAndTreat_1$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment
resultCOST[2,12] <- (sum(UniversalTestAndTreat_2$sCOST) - sum(Baseline$sCOST)) * sizeAdjustment

par(family="Avenir Next Bold")
plot(resultDALY[1,1],resultCOST[1,1],
	pch=19,
	cex=1.5,
	cex.main=1.5,
	cex.lab=1.2,
	cex.axis=1.2,
	col=plotCol[1],
	xlim=c(0,6e+06),
	main="DALY's averted against additional cost of interventions acting on HIV care between 2010 and 2030",
	xlab="DALY's averted",
	ylab="Additional cost (2013 USD)",
	ylim=c(0,5e+9))

points(resultDALY[2,1],resultCOST[2,1],col=plotCol[1],pch=17,cex=1.5)

points(resultDALY[1,2],resultCOST[1,2],col=plotCol[2],pch=19,cex=1.5)
points(resultDALY[2,2],resultCOST[2,2],col=plotCol[2],pch=17,cex=1.5)

points(resultDALY[1,3],resultCOST[1,3],col=plotCol[3],pch=19,cex=1.5)
points(resultDALY[2,3],resultCOST[2,3],col=plotCol[3],pch=17,cex=1.5)

points(resultDALY[1,4],resultCOST[1,4],col=plotCol[4],pch=19,cex=1.5)
points(resultDALY[2,4],resultCOST[2,4],col=plotCol[4],pch=17,cex=1.5)

points(resultDALY[1,5],resultCOST[1,5],col=plotCol[5],pch=19,cex=1.5)

points(resultDALY[1,6],resultCOST[1,6],col=plotCol[6],pch=19,cex=1.5)
points(resultDALY[2,6],resultCOST[2,6],col=plotCol[6],pch=17,cex=1.5)

points(resultDALY[1,7],resultCOST[1,7],col=plotCol[7],pch=19,cex=1.5)
points(resultDALY[2,7],resultCOST[2,7],col=plotCol[7],pch=17,cex=1.5)

points(resultDALY[1,8],resultCOST[1,8],col=plotCol[8],pch=19,cex=1.5)

points(resultDALY[1,9],resultCOST[1,9],col=plotCol[9],pch=19,cex=1.5)
points(resultDALY[2,9],resultCOST[2,9],col=plotCol[9],pch=17,cex=1.5)

points(resultDALY[1,10],resultCOST[1,10],col=plotCol[10],pch=19,cex=1.5)
points(resultDALY[2,10],resultCOST[2,10],col=plotCol[10],pch=17,cex=1.5)

points(resultDALY[1,11],resultCOST[1,11],col=plotCol[11],pch=19,cex=1.5)

points(resultDALY[1,12],resultCOST[1,12],col=plotCol[12],pch=19,cex=1.5)
points(resultDALY[2,12],resultCOST[2,12],col=plotCol[12],pch=17,cex=1.5)

legend("topleft",
	c("HBCT",
		"VCT",
		"HBCT POC CD4",
		"Linkage",
		"VCT POC CD4",
		"Pre-ART Outreach",
		"Improved Care",
		"POC CD4",
		"On-ART Outreach",
		"Adherence",
		"Immediate ART",
		"UTT"),
	fill=plotCol,
	border=NA,
	box.lty=0,
	cex=1.2)

legend("top",
	c("Maximum Impact",
		"Realistic Impact"),
	pch=c(19,17),
	col=c(1),
	border=NA,
	box.lty=0,
	cex=1.2)

quartz.save("./plots/costImpact.pdf",type='pdf')

#############################
# UNADJUSTED COST OVER TIME #
#############################

par(family="Avenir Next Bold")
plot(Baseline$sCOST,
	type='b',
	lwd=2,
	xaxt='n',
	main='Cost over time',
	ylim=c(0,1.5e+08),
	ylab="Cost per year (2013 USD)",
	xlab="Year")
axis(1,seq(0,20,1),seq(2010,2030,1))
lines(Hbct_1$sCOST,col=plotCol[1],type='b',lwd=2)
lines(Hbct_2$sCOST,col=plotCol[1],type='b',lwd=2)
lines(Vct_1$sCOST,col=plotCol[2],type='b',lwd=2)
lines(Vct_2$sCOST,col=plotCol[2],type='b',lwd=2)
lines(HbctPocCd4_1$sCOST,col=plotCol[3],type='b',lwd=2)
lines(HbctPocCd4_2$sCOST,col=plotCol[3],type='b',lwd=2)
lines(Linkage_1$sCOST,col=plotCol[4],type='b',lwd=2)
lines(Linkage_2$sCOST,col=plotCol[4],type='b',lwd=2)
lines(VctPocCd4$sCOST,col=plotCol[5],type='b',lwd=2)
lines(PreOutreach_1$sCOST,col=plotCol[6],type='b',lwd=2)
lines(PreOutreach_2$sCOST,col=plotCol[6],type='b',lwd=2)
lines(ImprovedCare_1$sCOST,col=plotCol[7],type='b',lwd=2)
lines(ImprovedCare_2$sCOST,col=plotCol[7],type='b',lwd=2)
lines(PocCd4$sCOST,col=plotCol[8],type='b',lwd=2)
lines(ArtOutreach_1$sCOST,col=plotCol[9],type='b',lwd=2)
lines(ArtOutreach_2$sCOST,col=plotCol[9],type='b',lwd=2)
lines(Adherence_1$sCOST,col=plotCol[10],type='b',lwd=2)
lines(Adherence_2$sCOST,col=plotCol[10],type='b',lwd=2)
lines(ImmediateArt$sCOST,col=plotCol[11],type='b',lwd=2)
lines(UniversalTestAndTreat_1$sCOST,col=plotCol[12],type='b',lwd=2)
lines(UniversalTestAndTreat_2$sCOST,col=plotCol[12],type='b',lwd=2)

legend("right",
	c("HBCT",
		"VCT",
		"HBCT POC CD4",
		"Linkage",
		"VCT POC CD4",
		"Pre-ART Outreach",
		"Improved Care",
		"POC CD4",
		"On-ART Outreach",
		"Adherence",
		"Immediate ART",
		"UTT"),
	fill=plotCol,
	border=NA,
	box.lty=0,
	cex=1.2)

quartz.save("./plots/cost.pdf",type='pdf')

#############################
# CUMULATIVE COST OVER TIME #
#############################

par(family="Avenir Next Bold")
plot(cumsum(Baseline$sCOST),
	type='b',
	lwd=2,
	xaxt='n',
	main='Cost over time',
	ylim=c(0,1.2e+09),
	ylab="Cost per year (2013 USD)",
	xlab="Year")
axis(1,seq(0,20,1),seq(2010,2030,1))
lines(cumsum(Hbct_1$sCOST),col=plotCol[1],type='b',lwd=2)
lines(cumsum(Hbct_2$sCOST),col=plotCol[1],type='b',lwd=2)
lines(cumsum(Vct_1$sCOST),col=plotCol[2],type='b',lwd=2)
lines(cumsum(Vct_2$sCOST),col=plotCol[2],type='b',lwd=2)
lines(cumsum(HbctPocCd4_1$sCOST),col=plotCol[3],type='b',lwd=2)
lines(cumsum(HbctPocCd4_2$sCOST),col=plotCol[3],type='b',lwd=2)
lines(cumsum(Linkage_1$sCOST),col=plotCol[4],type='b',lwd=2)
lines(cumsum(Linkage_2$sCOST),col=plotCol[4],type='b',lwd=2)
lines(cumsum(VctPocCd4$sCOST),col=plotCol[5],type='b',lwd=2)
lines(cumsum(PreOutreach_1$sCOST),col=plotCol[6],type='b',lwd=2)
lines(cumsum(PreOutreach_2$sCOST),col=plotCol[6],type='b',lwd=2)
lines(cumsum(ImprovedCare_1$sCOST),col=plotCol[7],type='b',lwd=2)
lines(cumsum(ImprovedCare_2$sCOST),col=plotCol[7],type='b',lwd=2)
lines(cumsum(PocCd4$sCOST),col=plotCol[8],type='b',lwd=2)
lines(cumsum(ArtOutreach_1$sCOST),col=plotCol[9],type='b',lwd=2)
lines(cumsum(ArtOutreach_2$sCOST),col=plotCol[9],type='b',lwd=2)
lines(cumsum(Adherence_1$sCOST),col=plotCol[10],type='b',lwd=2)
lines(cumsum(Adherence_2$sCOST),col=plotCol[10],type='b',lwd=2)
lines(cumsum(ImmediateArt$sCOST),col=plotCol[11],type='b',lwd=2)
lines(cumsum(UniversalTestAndTreat_1$sCOST),col=plotCol[12],type='b',lwd=2)
lines(cumsum(UniversalTestAndTreat_2$sCOST),col=plotCol[12],type='b',lwd=2)

legend("topleft",
	c("HBCT",
		"VCT",
		"HBCT POC CD4",
		"Linkage",
		"VCT POC CD4",
		"Pre-ART Outreach",
		"Improved Care",
		"POC CD4",
		"On-ART Outreach",
		"Adherence",
		"Immediate ART",
		"UTT"),
	fill=plotCol,
	border=NA,
	box.lty=0,
	cex=1.2)

quartz.save("./plots/cumulativeCost.pdf",type='pdf')

###########
# BIG PIE #
###########

library(RColorBrewer)
m <- brewer.pal(9,"Spectral")
p <- brewer.pal(9,"Set1")
graphics.off()
quartz.options(w=20,h=12)
system("mkdir ./plots/pie")
system("mkdir ./plots/pie/clinic")

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
	quartz.save(gsub(" ","",paste("./plots/pie/",Interventions[i],".pdf")),type='pdf')

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
	quartz.save(gsub(" ","",paste("./plots/pie/clinic/",Interventions[i],"_Clinic.pdf")),type='pdf')

}

################
# TOTAL DEATHS #
################

# Create some directories.
for(i in 1:length(interventions)) {
	system(paste("mkdir",gsub(" ","",paste("./plots/",interventions[i]))))
}

# Fill them up...
source("/Users/jack/git/CareCascade/rScript/BaselineFigures.R")
for(i in 1:length(interventions)) {
	print(interventions[i])
	directory <- gsub(" ","",paste("./plots/",interventions[i]))
	GenerateBaselineFigures(get(interventions[i]),directory,sizeAdjustment)
}
