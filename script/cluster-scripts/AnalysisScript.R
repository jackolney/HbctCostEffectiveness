# Notification Stuff
SendNotification <- function(ThePath, TheSequence) {
	# IFTTT Notification Setup
	list.of.packages <- c('httr','bitops','RCurl','digest','devtools','jsonlite','data.table','ggplot2','labeling','slackr')
	new.packages <- list.of.packages[!(list.of.packages %in% installed.packages(lib.loc='\\\\fi--san02/homes/jjo11/library/')[,'Package'])]
	if(length(new.packages)) install.packages(new.packages,repos='http://cran.ma.imperial.ac.uk',lib='\\\\fi--san02/homes/jjo11/library/')
	require(httr,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	require(bitops,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	require(RCurl,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	require(digest,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	# require(devtools,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	require(jsonlite,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	require(data.table,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	require(ggplot2,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	require(labeling,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	require(slackr,lib.loc='\\\\fi--san02/homes/jjo11/library/')
	slackrSetup(channel = '#slackr', username = 'MRC Cluster', api_token = 'xoxp-15444906276-15444906292-17727215943-e72c66b33b')
	slackr("Simulation complete.")
}

# Check for existence of all files
AllFilesExist <- function(TheRun, TheIntervention) {
	for(i in 1:length(TheRun)) {
		for(j in 1:length(TheIntervention)) {
			if(!file.exists(gsub(' ','',paste(TheRun[i],'/output/',TheIntervention[j],'/currentWorkspace.RData')))) {
				stop(paste('File',gsub(' ','',paste(TheRun[i],'/output/',TheIntervention[j],'/currentWorkspace.RData')),'does not exist.'))
			}
		}
	}
}

# Check for lock-file
LockFileCheck <- function() {
	if(!file.exists('lock-file')) {
		dir.create('lock-file')
	} else {
		stop('File locked.')
	}
}

AnalyseResults <- function(TheSize, ThePath, TheRun, TheIntervention) {

	if(file.exists(gsub(' ','',paste('./',TheRun[1],'/output/',TheIntervention[1],'/currentWorkspace.RData'))))
		load(gsub(' ','',paste('./',TheRun[1],'/output/',TheIntervention[1],'/currentWorkspace.RData'))) else stop('File (run1:baseline) does not exist.')

	# Loop through all interventions and runs and dynamically average them #
	for(i in 1:length(TheIntervention)) {
		print(TheIntervention[i])
		# Create vector of names
		outputNames <- c()
		for(m in 1:length(Baseline))
			outputNames[m] <- names(Baseline)[m]
		# Create list
		output <- sapply(outputNames,function(x) NULL)
		for(n in 1:length(output))
			output[[n]] <- vector('double',length(Baseline[[n]]))
		theLength = 0
		for(j in 1:length(TheRun)) {
			if(file.exists(gsub(' ','',paste('./',TheRun[j],'/output/',TheIntervention[i],'/currentWorkspace.RData')))) {
				load(gsub(' ','',paste('./',TheRun[j],'/output/',TheIntervention[i],'/currentWorkspace.RData')))
				print(TheRun[j])
				theLength <- theLength + 1
				for(k in 1:length(Baseline)) {
					output[[k]] <- output[[k]] + get(TheIntervention[i])[[k]]
				}
			}
		}
		print(paste('theLength =',theLength))
		for(l in 1:length(Baseline)) {
			output[[l]] <- output[[l]] / theLength
		}
			assign(TheIntervention[i],output)
	}
	print('Complete!')

	totalDALYs <- matrix(0,20,1)
	totalDALYs[1,] <- (sum(Baseline$sDALY) - sum(Hbct_2016$sDALY)) * TheSize
	totalDALYs[2,] <- (sum(Baseline$sDALY) - sum(Hbct_2017$sDALY)) * TheSize
	totalDALYs[3,] <- (sum(Baseline$sDALY) - sum(Hbct_2018$sDALY)) * TheSize
	totalDALYs[4,] <- (sum(Baseline$sDALY) - sum(Hbct_2019$sDALY)) * TheSize
	totalDALYs[5,] <- (sum(Baseline$sDALY) - sum(Hbct_2020$sDALY)) * TheSize
	totalDALYs[6,] <- (sum(Baseline$sDALY) - sum(Hbct_2021$sDALY)) * TheSize
	totalDALYs[7,] <- (sum(Baseline$sDALY) - sum(Hbct_2022$sDALY)) * TheSize
	totalDALYs[8,] <- (sum(Baseline$sDALY) - sum(Hbct_2023$sDALY)) * TheSize
	totalDALYs[9,] <- (sum(Baseline$sDALY) - sum(Hbct_2024$sDALY)) * TheSize
	totalDALYs[10,] <- (sum(Baseline$sDALY) - sum(Hbct_2025$sDALY)) * TheSize
	totalDALYs[11,] <- (sum(Baseline$sDALY) - sum(Hbct_2026$sDALY)) * TheSize
	totalDALYs[12,] <- (sum(Baseline$sDALY) - sum(Hbct_2027$sDALY)) * TheSize
	totalDALYs[13,] <- (sum(Baseline$sDALY) - sum(Hbct_2028$sDALY)) * TheSize
	totalDALYs[14,] <- (sum(Baseline$sDALY) - sum(Hbct_2029$sDALY)) * TheSize
	totalDALYs[15,] <- (sum(Baseline$sDALY) - sum(Hbct_2030$sDALY)) * TheSize
	totalDALYs[16,] <- (sum(Baseline$sDALY) - sum(Hbct_2031$sDALY)) * TheSize
	totalDALYs[17,] <- (sum(Baseline$sDALY) - sum(Hbct_2032$sDALY)) * TheSize
	totalDALYs[18,] <- (sum(Baseline$sDALY) - sum(Hbct_2033$sDALY)) * TheSize
	totalDALYs[19,] <- (sum(Baseline$sDALY) - sum(Hbct_2034$sDALY)) * TheSize
	totalDALYs[20,] <- (sum(Baseline$sDALY) - sum(Hbct_2035$sDALY)) * TheSize

	# Find index of max(totalDALYs)
	i <- 1
	while(totalDALYs[i,] != max(totalDALYs)) {
		i <- i + 1
	}

	SeqResultPath <- paste(ThePath,'SequenceResults.csv',sep='')

	if(file.exists(SeqResultPath)) {
		ArgsForModel <- read.csv(SeqResultPath)
		ArgsForModel$Args[i] = 1
		write.csv(ArgsForModel,file=SeqResultPath,row.names=FALSE)
	} else {
		Years <- seq(2016,2035,1)
		Args <- c(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
		ArgsForModel <- data.frame(Years,Args)
		ArgsForModel$Args[i] = 1
		write.csv(ArgsForModel,file=SeqResultPath,row.names=FALSE)
	}

	write.csv(ArgsForModel,file='SequenceResults.csv',row.names=FALSE)
}

