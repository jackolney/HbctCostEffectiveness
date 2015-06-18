GenerateBaselineFigures <- function(result,directory,sizeAdjustment) {

graphics.off()
quartz.options(w=15/2,h=12/2)
library(RColorBrewer)
p <- brewer.pal(9,"Set1")

####################
#Hiv Prevalence
# Unaids_HivPrev <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_HivPrevalence_Kenya.csv",header=TRUE)
Unaids_HivPrev <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_HivPrevalence_Kenya_2013.csv",header=TRUE)

par(family="Avenir Next Bold")
plot(seq(0,59,1),result$sHIV_15to49[1:60] / result$sPOP_15to49[1:60],
	type='l',
	col=p[2],
	lwd=4,
	ylim=c(0,0.12),
	main='HIV Prevalence',
	xlab='Year',
	ylab='Prevalence',
	xaxt='n')
lines(seq(20,43,1),Unaids_HivPrev$prev,
	lwd=4,
	lty=3,
	col=p[1])
lines(seq(0,59,1),result$sHIV_15to49[1:60] / result$sPOP_15to49[1:60],
	lwd=4,
	col=p[2])
axis(1,seq(0,60,5),seq(1970,2030,5))
legend("topright",c("UNAIDS 15-49yr","CareCascade 15-49yr"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrev_Unaids.pdf")),type='pdf')

####################
#PlwhivOnArt
Unaids_PlwhivOnArt <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_PlwhivOnArt_Kenya.csv",header=TRUE)

par(family="Avenir Next Bold")
plot(seq(0,59,1),result$sART_15to49[1:60] / result$sHIV_15to49[1:60],
	type='l',
	col=p[2],
	lwd=4,
	ylim=c(0,if(max((result$sART_15to49 / result$sHIV_15to49)[34:60]) < 0.4) {0.4} else {max((result$sART_15to49 / result$sHIV_15to49)[34:60])}),
	main='Proportion of PLHIV on ART',
	xlab='Year',
	ylab='Proportion',
	xaxt='n')
lines(seq(34,42,1),Unaids_PlwhivOnArt$propPlwhivOnArt,
	lwd=4,
	lty=3,
	col=p[1])
lines(seq(0,59,1),result$sART_15to49[1:60] / result$sHIV_15to49[1:60],
	lwd=4,
	col=p[2])
axis(1,seq(0,60,5),seq(1970,2030,5))
legend("topleft",c("UNAIDS","CareCascade"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/PlwhivOnArt_Unaids.pdf")),type='pdf')


par(family="Avenir Next Bold")
plot(seq(0,59,1),result$sART_15to49[1:60] / result$sHIV_15to49[1:60],
	type='l',
	col=p[2],
	lwd=4,
	ylim=c(0,if(max((result$sART_15to49 / result$sHIV_15to49)[34:60]) < 0.4) {0.4} else {max((result$sART_15to49 / result$sHIV_15to49)[34:60])}),
	xlim=c(30,59),
	main='Proportion of PLHIV on ART',
	xlab='Year',
	ylab='Proportion',
	xaxt='n')
lines(seq(34,42,1),Unaids_PlwhivOnArt$propPlwhivOnArt,
	lwd=4,
	lty=3,
	col=p[1])
lines(seq(0,59,1),result$sART_15to49[1:60] / result$sHIV_15to49[1:60],
	lwd=4,
	col=p[2])
axis(1,seq(0,60,5),seq(1970,2030,5))
legend("topleft",c("UNAIDS","CareCascade"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/PlwhivOnArt_Unaids_Short.pdf")),type='pdf')

####################
#Proportion of AIDS-related deaths in general population
Unaids_AidsDeaths <- read.csv("/Users/jack/git/CareCascade/estimates/UNAIDS_AidsRelatedDeaths.csv",header=TRUE)

par(family="Avenir Next Bold")
plot(seq(1,59,1),(result$sAidsDeath_15plus / result$sPOP_15plus)[1:59],
	type='l',
	col=p[2],
	lwd=4,
	ylim=c(0,0.01),
	xlim=c(0,60),
	main='Proportion of AIDS-related deaths in population',
	xlab='Year',
	ylab='Proportion',
	xaxt='n')
lines(seq(20,43,1),Unaids_AidsDeaths$proportion,
	lwd=4,
	lty=3,
	col=p[1])
lines(seq(1,59,1),(result$sAidsDeath_15plus / result$sPOP_15plus)[1:59],
	lwd=4,
	col=p[2])
axis(1,seq(0,60,5),seq(1970,2030,5))
legend("topright",c("UNAIDS","CareCascade"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/AidsDeath_Unaids.pdf")),type='pdf')

####################
#KAIS 2007 - HIV prevalence by Age and Sex. (National)
Kais2007_PrevByAgeSex <- read.csv("/Users/jack/git/CareCascade/estimates/Kais2007_PrevByAgeSex.csv",header=TRUE)

graphics.off()
quartz.options(w=10,h=12/2)

######
#MALE#
######
result
par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2007 / result$sPOP_AgeSex_2007)[11:20],
	type='b',
	lwd=4,
	main="HIV prevalence among men 15-64 years old",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.2))
lines(Kais2007_PrevByAgeSex$male,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)
axis(1,seq(1,10,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-54",
		"55-59",
		"60-64"),
	cex.axis=1.2)
axis(2,seq(0,0.2,0.02),seq(0,20,2),las=1,cex.axis=1.2)
legend("topleft",
	c("Model 2007 - Males","KAIS 2007 - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrevMale_Kais2007.pdf")),type='pdf')

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2007 / result$sPOP_AgeSex_2007)[1:10],
	type='b',
	lwd=4,
	main="HIV prevalence among women 15-64 years old",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.2,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.20))
lines(Kais2007_PrevByAgeSex$female,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)
axis(1,seq(1,10,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-54",
		"55-59",
		"60-64"),
	cex.axis=1.2)
axis(2,seq(0,0.20,0.02),seq(0,20,2),las=1,cex.axis=1.2)
legend("topleft",
	c("Model 2007 - Females","KAIS 2007 - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrevFemale_Kais2007.pdf")),type='pdf')

####################
#KAIS 2012 - HIV prevalence by Age and Sex. (National)
Kais2012_PrevByAgeSex <- read.csv("/Users/jack/git/CareCascade/estimates/Kais2012_PrevByAgeSex.csv",header=TRUE)

(result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8]
(result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16]

######
#MALE#
######

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16],
	type='b',
	lwd=4,
	main="HIV prevalence among Men in Kenya Nationally in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.20),
	)

lines(Kais2012_PrevByAgeSex$confLower.1,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confHigher.1,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines(Kais2012_PrevByAgeSex$men,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)

lines((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16],
	type='b',
	col=p[1],
	cex=2,
	lty=1,
	lwd=4)

axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.20,0.02),seq(0,20,2),las=1,cex.axis=1.5)
legend("topleft",
	c("Model 2012 - Males","KAIS 2012 - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrevMale_Kais2012.pdf")),type='pdf')

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8],
	type='b',
	lwd=4,
	main="HIV prevalence among Women in Kenya Nationally in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.20),
	)

lines(Kais2012_PrevByAgeSex$women,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confLower.2,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confHigher.2,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8],
	type='b',
	col=p[1],
	cex=2,
	lty=1,
	lwd=4)

axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.20,0.02),seq(0,20,2),las=1,cex.axis=1.5)
legend("topleft",
	c("Model 2012 - Females","KAIS 2012 - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrevFemale_Kais2012.pdf")),type='pdf')

#################
#NYANZA PROVINCE#
#################

######
#MALE#
######

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16],
	type='b',
	lwd=4,
	main="HIV prevalence among Men in Nyanza Province in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.5),
	)

lines(Kais2012_PrevByAgeSex$men.1,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confLower.4,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confHigher.4,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16],
	type='b',
	col=p[1],
	cex=2,
	lty=1,
	lwd=4)

axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.5,0.05),seq(0,50,5),las=1,cex.axis=1.5)
legend("topleft",
	c("Model 2012 - Males","KAIS 2012 Nyanza - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrevMale_Nyanza_Kais2012.pdf")),type='pdf')

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8],
	type='b',
	lwd=4,
	main="HIV prevalence among Women in Nyanza Province in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.5),
	)

lines(Kais2012_PrevByAgeSex$women.1,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confLower.5,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confHigher.5,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8],
	type='b',
	col=p[1],
	cex=2,
	lty=1,
	lwd=4)

axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.5,0.05),seq(0,50,5),las=1,cex.axis=1.5)
legend("topleft",
	c("Model 2012 - Females","KAIS 2012 Nyanza - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrevFemale_Nyanza_Kais2012.pdf")),type='pdf')

##################
#WESTERN PROVINCE#
##################

######
#MALE#
######

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16],
	type='b',
	lwd=4,
	main="HIV prevalence among Men in Western Province in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.3),
	)

lines(Kais2012_PrevByAgeSex$men.2,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confLower.7,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confHigher.7,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[9:16],
	type='b',
	col=p[1],
	cex=2,
	lty=1,
	lwd=4)

axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.3,0.05),seq(0,30,5),las=1,cex.axis=1.5)
legend("topleft",
	c("Model 2012 - Males","KAIS 2012 Western - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrevMale_Western_Kais2012.pdf")),type='pdf')

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8],
	type='b',
	lwd=4,
	main="HIV prevalence among Women in Western Province in 2012",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.3),
	)

lines(Kais2012_PrevByAgeSex$women.2,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confLower.8,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines(Kais2012_PrevByAgeSex$confHigher.8,
	type='l',
	col=p[2],
	cex=2,
	lty=3,
	lwd=4)

lines((result$sHIV_AgeSex_2012 / result$sPOP_AgeSex_2012)[1:8],
	type='b',
	col=p[1],
	cex=2,
	lty=1,
	lwd=4)

axis(1,seq(1,8,1),
	c("15-19",
		"20-24",
		"25-29",
		"30-34",
		"35-39",
		"40-44",
		"45-49",
		"50-64"),
	cex.axis=1.5)
axis(2,seq(0,0.3,0.05),seq(0,30,5),las=1,cex.axis=1.5)
legend("topleft",
	c("Model 2012 - Females","KAIS 2012 Western - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrevFemale_Western_Kais2012.pdf")),type='pdf')

####################
#CD4 distribution over time

Cd4DistributionTotal <- matrix(0,8,66)
Cd4DistributionTotal[1,] <- result$sCD4_200 - result$sCD4_200_Art
Cd4DistributionTotal[2,] <- result$sCD4_200_Art
Cd4DistributionTotal[3,] <- result$sCD4_200350 - result$sCD4_200350_Art
Cd4DistributionTotal[4,] <- result$sCD4_200350_Art
Cd4DistributionTotal[5,] <- result$sCD4_350500 - result$sCD4_350500_Art
Cd4DistributionTotal[6,] <- result$sCD4_350500_Art
Cd4DistributionTotal[7,] <- result$sCD4_500 - result$sCD4_500_Art
Cd4DistributionTotal[8,] <- result$sCD4_500_Art

Cd4DistributionProp <- matrix(0,8,66)
Cd4DistributionProp[1,] <- (result$sCD4_200 - result$sCD4_200_Art) / colSums(Cd4DistributionTotal)
Cd4DistributionProp[2,] <- result$sCD4_200_Art / colSums(Cd4DistributionTotal)
Cd4DistributionProp[3,] <- (result$sCD4_200350 - result$sCD4_200350_Art) / colSums(Cd4DistributionTotal)
Cd4DistributionProp[4,] <- result$sCD4_200350_Art / colSums(Cd4DistributionTotal)
Cd4DistributionProp[5,] <- (result$sCD4_350500 - result$sCD4_350500_Art) / colSums(Cd4DistributionTotal)
Cd4DistributionProp[6,] <- result$sCD4_350500_Art / colSums(Cd4DistributionTotal)
Cd4DistributionProp[7,] <- (result$sCD4_500 - result$sCD4_500_Art) / colSums(Cd4DistributionTotal)
Cd4DistributionProp[8,] <- result$sCD4_500_Art / colSums(Cd4DistributionTotal)

require(RColorBrewer)
m <- brewer.pal(11,"RdYlGn")

par(family="Avenir Next Bold")
barplot(Cd4DistributionProp,
	space=0,
	border=1,
	col=c(m[1],m[11],m[2],m[10],m[3],m[9],m[4],m[8]),
	xlab="Year",
	main="CD4 distribution among HIV-positive individuals over time",
	ylab="Proportion",
	yaxt='n',
	xlim=c(6,65))
axis(1,seq(5.5,65.5,5),seq(1975,2036,5))
axis(2,seq(0,1,0.1),las=1)
quartz.save(gsub(" ","",paste(directory,"/Cd4Distribution.pdf")),type='pdf')

####################
#WHO distribution over time

WHODistributionTotal <- matrix(0,8,66)
WHODistributionTotal[1,] <- result$sWHO_4 - result$sWHO_4_Art
WHODistributionTotal[2,] <- result$sWHO_4_Art
WHODistributionTotal[3,] <- result$sWHO_3 - result$sWHO_3_Art
WHODistributionTotal[4,] <- result$sWHO_3_Art
WHODistributionTotal[5,] <- result$sWHO_2 - result$sWHO_2_Art
WHODistributionTotal[6,] <- result$sWHO_2_Art
WHODistributionTotal[7,] <- result$sWHO_1 - result$sWHO_1_Art
WHODistributionTotal[8,] <- result$sWHO_1_Art

WHODistributionProp <- matrix(0,8,66)
WHODistributionProp[1,] <- (result$sWHO_4 - result$sWHO_4_Art) / colSums(WHODistributionTotal)
WHODistributionProp[2,] <- result$sWHO_4_Art / colSums(WHODistributionTotal)
WHODistributionProp[3,] <- (result$sWHO_3 - result$sWHO_3_Art) / colSums(WHODistributionTotal)
WHODistributionProp[4,] <- result$sWHO_3_Art / colSums(WHODistributionTotal)
WHODistributionProp[5,] <- (result$sWHO_2 - result$sWHO_2_Art) / colSums(WHODistributionTotal)
WHODistributionProp[6,] <- result$sWHO_2_Art / colSums(WHODistributionTotal)
WHODistributionProp[7,] <- (result$sWHO_1 - result$sWHO_1_Art) / colSums(WHODistributionTotal)
WHODistributionProp[8,] <- result$sWHO_1_Art / colSums(WHODistributionTotal)

require(RColorBrewer)
m <- brewer.pal(11,"RdYlGn")

par(family="Avenir Next Bold")
barplot(WHODistributionProp,
	space=0,
	border=1,
	col=c(m[1],m[11],m[2],m[10],m[3],m[9],m[4],m[8]),
	xlab="Year",
	main="WHO distribution among HIV-positive individuals over time",
	ylab="Proportion",
	yaxt='n',
	xlim=c(6,65))
axis(1,seq(5.5,65.5,5),seq(1975,2036,5))
axis(2,seq(0,1,0.1),las=1)
quartz.save(gsub(" ","",paste(directory,"/WHODistribution.pdf")),type='pdf')

####################
#Cd4 distrubition among people not on ART in 2007
Kais2007_Cd4 <- read.csv("/Users/jack/git/CareCascade/estimates/Kais2007_Cd4.csv",header=TRUE)

Model_Cd4_1 <- result$sPOP_NoArtCd4_2007[1] / sum(result$sPOP_NoArtCd4_2007)
Model_Cd4_2 <- result$sPOP_NoArtCd4_2007[2] / sum(result$sPOP_NoArtCd4_2007)
Model_Cd4_3 <- result$sPOP_NoArtCd4_2007[3] / sum(result$sPOP_NoArtCd4_2007)
Model_Cd4_4 <- result$sPOP_NoArtCd4_2007[4] / sum(result$sPOP_NoArtCd4_2007)
Model_Cd4 <- c(Model_Cd4_1,Model_Cd4_2,Model_Cd4_3,Model_Cd4_4)

Cd4_Bar <- matrix(0,4,2)
Cd4_Bar[,1] <- Model_Cd4
Cd4_Bar[,2] <- Kais2007_Cd4[1:4,2]

par(family="Avenir Next Bold")
barplot(Cd4_Bar,
	border=NA,
	width=c(1,1),
	main="CD4 distribution among individuals not on ART in 2007",
	yaxt='n',
	ylab="Proportion",
	cex.main=1.5,
	cex.lab=1.2,
	ylim=c(0,1),
	col=m)
axis(2,seq(0,1,0.1),las=1,cex.axis=1.2)
mtext("Model 2007",1,at=0.7,1,cex=1.5)
mtext("KAIS 2007",1,at=1.9,1,cex=1.5)
quartz.save(gsub(" ","",paste(directory,"/Cd4Distribution_Kais2007.pdf")),type='pdf')

####################
#AMPATH Prevalence in 2014
Ampath2014 <- read.csv("/Users/jack/git/CareCascade/estimates/Ampath2014_PrevByAgeSex.csv",header=TRUE)

graphics.off()
quartz.options(w=15/2,h=12/2)

######
#MALE#
######

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2014 / result$sPOP_AgeSex_2014)[6:10],
	type='b',
	lwd=4,
	main="HIV prevalence among Men on 22/05/2014",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.30))
lines(Ampath2014$male,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)
axis(1,seq(1,5,1),
	c("0-14",
		"14-21",
		"21-29",
		"29-46",
		">46"),
	cex.axis=1.5)
axis(2,seq(0,0.3,0.05),seq(0,30,5),las=1,cex.axis=1.5)
legend("topleft",
	c("Model 22/05/2014 - Males","AMPATH 22/05/2014 - Males"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)

lines(Ampath2014$male,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)
quartz.save(gsub(" ","",paste(directory,"/HivPrevMale_Ampath2014.pdf")),type='pdf')

########
#FEMALE#
########

par(family="Avenir Next Bold")
plot((result$sHIV_AgeSex_2014 / result$sPOP_AgeSex_2014)[1:5],
	type='b',
	lwd=4,
	main="HIV prevalence among Women on 22/05/2014",
	xlab="Age (years)",
	ylab="HIV prevalence (%)",
	xaxt='n',
	cex=2,
	cex.main=1.5,
	cex.lab=1.5,
	yaxt='n',
	col=p[1],
	ylim=c(0,0.3))
lines(Ampath2014$female,
	type='b',
	col=p[2],
	cex=2,
	lty=1,
	lwd=4)

axis(1,seq(1,5,1),
	c("0-14",
		"14-21",
		"21-29",
		"29-46",
		">46"),
	cex.axis=1.5)
axis(2,seq(0,0.3,0.05),seq(0,30,5),las=1,cex.axis=1.5)
legend("topleft",
	c("Model 22/05/2014 - Females","AMPATH 22/05/2014 - Females"),
	fill=p[1:2],
	border=NA,
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/HivPrevFemale_Ampath2014.pdf")),type='pdf')

##################
# COST BREAKDOWN #
##################

costBreakdown <- matrix(0,2,20)
costBreakdown[1,] <- (cumsum(result$sPreArtCOST) / cumsum(result$sPreArtCOST + result$sArtCOST))[1:20]
costBreakdown[2,] <- (cumsum(result$sArtCOST) / cumsum(result$sPreArtCOST + result$sArtCOST))[1:20]

library(RColorBrewer)
m <- brewer.pal(9,"Spectral")

par(family="Avenir Next Bold")
barplot(costBreakdown,
	col=c(m[1],m[3]),
	ylab="Proportion of total cost (2013 USD)",
	main="Cost breakdown between 2010 and 2030 (2013 USD)",
	yaxt='n')
year = 2009
i = 1
for(i in 1:20) {
mtext(paste(year + i),1,at=0.5 + (1.2 * i-1),1,cex=1)
}
axis(2,seq(0,1,0.1),las=2)
legend("top",
	c("Pre-ART Cost","ART Cost"),
	fill=c(m[1],m[3]),
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/CostBreakdown.pdf")),type='pdf')

hivCostBreakdown <- matrix(0,2,20)
hivCostBreakdown[1,] <- (cumsum(result$sPreArtCOST_Hiv) / cumsum(result$sPreArtCOST_Hiv + result$sArtCOST_Hiv))[1:20]
hivCostBreakdown[2,] <- (cumsum(result$sArtCOST_Hiv) / cumsum(result$sPreArtCOST_Hiv + result$sArtCOST_Hiv))[1:20]

library(RColorBrewer)
m <- brewer.pal(9,"Spectral")

par(family="Avenir Next Bold")
barplot(hivCostBreakdown,
	col=c(m[1],m[3]),
	ylab="Proportion of total cost (2013 USD)",
	main="Cost breakdown between 2010 and 2030 among HIV-positive individuals (2013 USD)",
	yaxt='n')
year = 2009
i = 1
for(i in 1:20) {
mtext(paste(year + i),1,at=0.5 + (1.2 * i-1),1,cex=1)
}
axis(2,seq(0,1,0.1),las=2)
legend("top",
	c("Pre-ART Cost","ART Cost"),
	fill=c(m[1],m[3]),
	box.lty=0,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/hivCostBreakdown.pdf")),type='pdf')

#############
# INCIDENCE #
#############

SpectrumIncidence <- read.csv("/Users/jack/git/CareCascade/estimates/SpectrumIncidence.csv",header=TRUE)
# SpectrumIncidenceLong <- read.csv("/Users/jack/git/CareCascade/estimates/SpectrumIncidenceLong.csv",header=TRUE)

par(family="Avenir Next Bold")
plot((result$sINCIDENCE * sizeAdjustment)[2:60],
	type='l',
	lwd=4,
	col=p[2],
	xaxt='n',
	yaxt='n',
	ylab='Incident Cases',
	xlab='Year',
	main="Incidence",
	ylim=c(0,3e+05),
	xlim=c(0,60))
axis(1,seq(0,60,5),seq(1970,2030,5))
axis(2,seq(0,3e+05,1e+05),las=3)
lines(SpectrumIncidence$SpectrumIncidence,
	col=p[1:2],
	lwd=4)
legend("topright",
	c("Spectrum Incidence","Model Incidence"),
	fill=p[1:2],
	box.lty=0,
	border=NA,
	cex=1.2)
quartz.save(gsub(" ","",paste(directory,"/Incidence.pdf")),type='pdf')

}