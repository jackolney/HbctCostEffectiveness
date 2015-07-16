###############################
# CareCascadeV2 Python Script #
###############################
   # Multiple Run Version #
   ########################

import sys
import os.path
import time
import logging
import csv

# Arguments to Python #
path = str(sys.argv[1])
altPath = str(sys.argv[2])
# path = r"post_paris\test"
# altPath = r"post_paris/test"

#############
# Log Setup #
#############

logging.basicConfig(filename=r"\\fi--san02\homes\jjo11\cascade\%s\log" % path,
                            filemode='a',
                            format='%(asctime)s,%(msecs)d %(name)s %(levelname)s %(message)s',
                            datefmt='%H:%M:%S',
                            level=logging.DEBUG)

logging.info("Starting Python script.")

###########
# CONTROL #
###########

sizeAdjustment = 15
seqList = ["Seq1","Seq2","Seq3","Seq4"]
runList = ["run1","run2","run3","run4","run5","run6","run7","run8","run9","run10"]
outputFolderList = ["Baseline", "NaiveHbct", "Hbct_2016", "Hbct_2017", "Hbct_2018", "Hbct_2019", "Hbct_2020", "Hbct_2021", "Hbct_2022", "Hbct_2023", "Hbct_2024", "Hbct_2025", "Hbct_2026", "Hbct_2027", "Hbct_2028", "Hbct_2029", "Hbct_2030", "Hbct_2031", "Hbct_2032", "Hbct_2033", "Hbct_2034", "Hbct_2035"]

##############
# WHERE AM I #
##############

# Work out which sequence I should be on.
theSequence = 0

for j in range(0,len(seqList)):
    for i in range(0,len(runList)):
        for x in range(0,len(outputFolderList)):
            if os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\%s\%s\output\%s\currentWorkspace.RData" % (path, seqList[j], runList[i], outputFolderList[x])):
                theSequence = j + 1

logging.info("The Sequence = %s" % theSequence)

##################
# SEQUENCE SETUP #
##################

for x in range(0,len(seqList)):
    if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\%s" % (path, seqList[x])):
        os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\%s" % (path, seqList[x]))

# seqList[0] needs to go before all runList[x]

#print r"\\fi--san02\homes\jjo11\cascade\%s\%s\%s" % (testPath, seqList[0], runList[0])

for i in range(0,len(runList)):
    if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\%s\%s" % (path, seqList[theSequence], runList[i])):
        os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\%s\%s" % (path, seqList[theSequence], runList[i]))
runPath = [None] * len(runList)
runAltPath = [None] * len(runList)
for i in range(0,len(runList)):
    runPath[i] = "%s\%s\%s" % (path, seqList[theSequence], runList[i])
    runAltPath[i] = "%s/%s/%s" % (altPath, seqList[theSequence], runList[i])

#################
# Creation Loop #
#################

if theSequence == 0:
    for i in range(0,len(runList)):
        ####################
        # Output directory #
        ####################
        outputPath  = r"\\fi--san02\homes\jjo11\cascade\%s\output" % runPath[i]
        if not os.path.exists(outputPath):
            os.makedirs(outputPath)
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\output\%s" % (runPath[i], outputFolderList[x])):
                os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\output\%s" % (runPath[i], outputFolderList[x]))
        logging.info("Output directories created. (%s)" % runList[i])
        ###########
        # Rscript #
        ###########
        scriptPath = r"\\fi--san02\homes\jjo11\cascade\%s\scripts" % runPath[i]
        if not os.path.exists(scriptPath):
            os.makedirs(scriptPath)
        if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario" % runPath[i]):
            os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario" % runPath[i])
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario\%s" % (runPath[i], outputFolderList[x])):
                os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario\%s" % (runPath[i], outputFolderList[x]))
        logging.info("Script folder tree populated. (%s)" % runList[i])
        ###################
        # Scenario arrays #
        ###################
        cNaiveHbct                  = [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctNcd                    = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctNcdPreArtRetention     = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctNcdRetention           = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctNcdRetentionAdherence  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbct_2016                  = [0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        cHbct_2017                  = [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbct_2018                  = [0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbct_2019                  = [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbct_2020                  = [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbct_2021                  = [0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbct_2022                  = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbct_2023                  = [0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbct_2024                  = [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0]
        cHbct_2025                  = [0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0]
        cHbct_2026                  = [0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0]
        cHbct_2027                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0]
        cHbct_2028                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
        cHbct_2029                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]
        cHbct_2030                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0]
        cHbct_2031                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0]
        cHbct_2032                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0]
        cHbct_2033                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0]
        cHbct_2034                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0]
        cHbct_2035                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
        cVct                        = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctPocCd4                 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cLinkage                    = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cPreOutreach                = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cImprovedCare               = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cPocCd4                     = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cVctPocCd4                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cArtOutreach                = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cImmediateArt               = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cUniversalTestAndTreat      = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cAdherence                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        logging.info("Starting run.R script creation. (%s)" % runList[i])
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario\%s\run.R" % (runPath[i], outputFolderList[x])):
                file = open(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario\%s\run.R" % (runPath[i], outputFolderList[x]),"w")
                file.write("Cascade <- function() {\n")
                file.write("    startTime <- proc.time()\n")
                file.write(r"    dyn.load('\\\\fi--san02/homes/jjo11/cascade/%s/main.dll')" % altPath + "\n")
                file.write("    result <- .Call('CallCascade',\n")
                file.write("    %s,     # Pop;\n" % sizeAdjustment)
                file.write("    %s,     # NaiveHbct;\n" % cNaiveHbct[x])
                file.write("    %s,     # HbctNcd;\n" % cHbctNcd[x])
                file.write("    %s,     # HbctNcdPreArtRetention;\n" % cHbctNcdPreArtRetention[x])
                file.write("    %s,     # HbctNcdRetention;\n" % cHbctNcdRetention[x])
                file.write("    %s,     # HbctNcdRetentionAdherence;\n" % cHbctNcdRetentionAdherence[x])
                file.write("    %s,     # Hbct_2016;\n" % cHbct_2016[x])
                file.write("    %s,     # Hbct_2017;\n" % cHbct_2017[x])
                file.write("    %s,     # Hbct_2018;\n" % cHbct_2018[x])
                file.write("    %s,     # Hbct_2019;\n" % cHbct_2019[x])
                file.write("    %s,     # Hbct_2020;\n" % cHbct_2020[x])
                file.write("    %s,     # Hbct_2021;\n" % cHbct_2021[x])
                file.write("    %s,     # Hbct_2022;\n" % cHbct_2022[x])
                file.write("    %s,     # Hbct_2023;\n" % cHbct_2023[x])
                file.write("    %s,     # Hbct_2024;\n" % cHbct_2024[x])
                file.write("    %s,     # Hbct_2025;\n" % cHbct_2025[x])
                file.write("    %s,     # Hbct_2026;\n" % cHbct_2026[x])
                file.write("    %s,     # Hbct_2027;\n" % cHbct_2027[x])
                file.write("    %s,     # Hbct_2028;\n" % cHbct_2028[x])
                file.write("    %s,     # Hbct_2029;\n" % cHbct_2029[x])
                file.write("    %s,     # Hbct_2030;\n" % cHbct_2030[x])
                file.write("    %s,     # Hbct_2031;\n" % cHbct_2031[x])
                file.write("    %s,     # Hbct_2032;\n" % cHbct_2032[x])
                file.write("    %s,     # Hbct_2033;\n" % cHbct_2033[x])
                file.write("    %s,     # Hbct_2034;\n" % cHbct_2034[x])
                file.write("    %s,     # Hbct_2035;\n" % cHbct_2035[x])
                file.write("    %s,     # Vct;\n" % cVct[x])
                file.write("    %s,     # HbctPocCd4;\n" % cHbctPocCd4[x])
                file.write("    %s,     # Linkage;\n" % cLinkage[x])
                file.write("    %s,     # PreOutreach;\n" % cPreOutreach[x])
                file.write("    %s,     # ImprovedCare;\n" % cImprovedCare[x])
                file.write("    %s,     # PocCd4;\n" % cPocCd4[x])
                file.write("    %s,     # VctPocCd4;\n" % cVctPocCd4[x])
                file.write("    %s,     # ArtOutreach;\n" % cArtOutreach[x])
                file.write("    %s,     # ImmediateArt;\n" % cImmediateArt[x])
                file.write("    %s,     # UniversalTestAndTreat;\n" % cUniversalTestAndTreat[x])
                file.write("    %s,     # Adherence;\n" % cAdherence[x])
                file.write("    0       # CalibrationSwitch;\n")
                file.write("    )\n")
                file.write("    endTime <- proc.time() - startTime\n")
                file.write("    print(endTime)\n")
                file.write("    flush.console()\n")
                file.write("    return(result)\n")
                file.write("}\n")
                file.close()
        logging.info("Completed run.R script creation. (%s)" % runList[i])
        ####################
        # Rscript creation #
        ####################
        logging.info("Building simulation control scripts in R. (%s)" % runList[i])
        goPath = r"\\fi--san02\homes\jjo11\cascade\%s\scripts\go" % runPath[i]
        if not os.path.exists(goPath):
            os.makedirs(goPath)
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\go\go_%s.R" % (runPath[i], outputFolderList[x])):
                file = open(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\go\go_%s.R" % (runPath[i], outputFolderList[x]),"w")
                file.write(r"setwd('\\\\fi--san02/homes/jjo11/cascade/%s/')" % runAltPath[i] + "\n")
                file.write("source('./scripts/scenario/%s/run.R')\n" % outputFolderList[x])
                file.write("%s <- Cascade()\n" % outputFolderList[x])
                file.write("save.image(file='./output/%s/currentWorkspace.RData')\n\n" % outputFolderList[x])
                file.write("### AutomationTestScript ###\n")
                file.write("rm(list=ls())\n")
                file.write(r"setwd('\\\\fi--san02/homes/jjo11/cascade/%s/%s/')" % (altPath, seqList[theSequence]) + "\n\n")
                file.write("# IFTTT Notification Setup\n")
                file.write("list.of.packages <- c('bitops','httr','RCurl')\n")
                file.write(r"new.packages <- list.of.packages[!(list.of.packages %in% installed.packages(lib.loc='\\\\fi--san02/homes/jjo11/library/')[,'Package'])]" + "\n")
                file.write(r"if(length(new.packages)) install.packages(new.packages,repos='http://cran.ma.imperial.ac.uk',lib='\\\\fi--san02/homes/jjo11/library/')" + "\n")
                file.write(r"require(bitops,lib.loc='\\\\fi--san02/homes/jjo11/library/')" + "\n")
                file.write(r"require(RCurl,lib.loc='\\\\fi--san02/homes/jjo11/library/')" + "\n")
                file.write(r"require(httr,lib.loc='\\\\fi--san02/homes/jjo11/library/')" + "\n")
                file.write("myEvent <- 'cluster'\n")
                file.write("myKey <- 'yrE109QSpk7g52OgdOzf0'\n")
                file.write("makerUrl <- paste('https://maker.ifttt.com/trigger', myEvent, 'with/key', myKey, sep='/')\n\n")
                file.write("run <- c('run1','run2','run3','run4','run5','run6','run7','run8','run9','run10')\n")
                file.write("interventions <- c('Baseline','NaiveHbct','Hbct_2016', 'Hbct_2017', 'Hbct_2018', 'Hbct_2019', 'Hbct_2020', 'Hbct_2021', 'Hbct_2022', 'Hbct_2023', 'Hbct_2024', 'Hbct_2025', 'Hbct_2026', 'Hbct_2027', 'Hbct_2028', 'Hbct_2029', 'Hbct_2030', 'Hbct_2031', 'Hbct_2032', 'Hbct_2033', 'Hbct_2034', 'Hbct_2035')\n\n")
                file.write("for(i in 1:length(run)) {\n")
                file.write("\tfor(j in 1:length(interventions)) {\n")
                file.write("\t\tif(!file.exists(gsub(' ','',paste(run[i],'/output/',interventions[j],'/currentWorkspace.RData')))) {\n")
                file.write("\t\t\tstop(paste('File',gsub(' ','',paste(run[i],'/output/',interventions[j],'/currentWorkspace.RData')),'does not exist.'))\n")
                file.write("\t\t}\n")
                file.write("\t}\n")
                file.write("}\n\n")
                file.write("# lock-file\n")
                file.write("if(!file.exists('lock-file')) {\n")
                file.write("\tdir.create('lock-file')\n")
                file.write("} else {\n")
                file.write("\tstop('File locked.')\n")
                file.write("}\n\n")
                file.write("if(file.exists(gsub(' ','',paste('./',run[1],'/output/',interventions[1],'/currentWorkspace.RData'))))\n")
                file.write("\tload(gsub(' ','',paste('./',run[1],'/output/',interventions[1],'/currentWorkspace.RData'))) else stop('File (run1:baseline) does not exist.')\n\n")
                file.write("# Loop through all interventions and runs and dynamically average them #\n")
                file.write("for(i in 1:length(interventions)) {\n")
                file.write("\tprint(interventions[i])\n")
                file.write("\t# Create vector of names\n")
                file.write("\toutputNames <- c()\n")
                file.write("\tfor(m in 1:length(Baseline))\n")
                file.write("\t\toutputNames[m] <- names(Baseline)[m]\n")
                file.write("\t# Create list\n")
                file.write("\toutput <- sapply(outputNames,function(x) NULL)\n")
                file.write("\tfor(n in 1:length(output))\n")
                file.write("\t\toutput[[n]] <- vector('double',length(Baseline[[n]]))\n")
                file.write("\ttheLength = 0\n")
                file.write("\tfor(j in 1:length(run)) {\n")
                file.write("\t\tif(file.exists(gsub(' ','',paste('./',run[j],'/output/',interventions[i],'/currentWorkspace.RData')))) {\n")
                file.write("\t\t\tload(gsub(' ','',paste('./',run[j],'/output/',interventions[i],'/currentWorkspace.RData')))\n")
                file.write("\t\t\tprint(run[j])\n")
                file.write("\t\t\ttheLength <- theLength + 1\n")
                file.write("\t\t\tfor(k in 1:length(Baseline)) {\n")
                file.write("\t\t\t\toutput[[k]] <- output[[k]] + get(interventions[i])[[k]]\n")
                file.write("\t\t\t}\n")
                file.write("\t\t}\n")
                file.write("\t}\n")
                file.write("\tprint(paste('theLength =',theLength))\n")
                file.write("\tfor(l in 1:length(Baseline)) {\n")
                file.write("\t\toutput[[l]] <- output[[l]] / theLength\n")
                file.write("\t}\n")
                file.write("\tassign(interventions[i],output)\n")
                file.write("}\n")
                file.write("print('\tComplete!')\n\n")
                file.write("sizeAdjustment = %s" % sizeAdjustment + "\n\n")
                file.write("totalDALYs <- matrix(0,20,1)\n")
                file.write("totalDALYs[1,] <- (sum(Baseline$sDALY) - sum(Hbct_2016$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[2,] <- (sum(Baseline$sDALY) - sum(Hbct_2017$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[3,] <- (sum(Baseline$sDALY) - sum(Hbct_2018$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[4,] <- (sum(Baseline$sDALY) - sum(Hbct_2019$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[5,] <- (sum(Baseline$sDALY) - sum(Hbct_2020$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[6,] <- (sum(Baseline$sDALY) - sum(Hbct_2021$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[7,] <- (sum(Baseline$sDALY) - sum(Hbct_2022$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[8,] <- (sum(Baseline$sDALY) - sum(Hbct_2023$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[9,] <- (sum(Baseline$sDALY) - sum(Hbct_2024$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[10,] <- (sum(Baseline$sDALY) - sum(Hbct_2025$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[11,] <- (sum(Baseline$sDALY) - sum(Hbct_2026$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[12,] <- (sum(Baseline$sDALY) - sum(Hbct_2027$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[13,] <- (sum(Baseline$sDALY) - sum(Hbct_2028$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[14,] <- (sum(Baseline$sDALY) - sum(Hbct_2029$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[15,] <- (sum(Baseline$sDALY) - sum(Hbct_2030$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[16,] <- (sum(Baseline$sDALY) - sum(Hbct_2031$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[17,] <- (sum(Baseline$sDALY) - sum(Hbct_2032$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[18,] <- (sum(Baseline$sDALY) - sum(Hbct_2033$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[19,] <- (sum(Baseline$sDALY) - sum(Hbct_2034$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[20,] <- (sum(Baseline$sDALY) - sum(Hbct_2035$sDALY)) * sizeAdjustment\n\n")
                file.write("# Find index of max(totalDALYs)\n")
                file.write("i = 1\n")
                file.write("while(totalDALYs[i,] != max(totalDALYs)) i <- i + 1\n\n")
                file.write(r"SeqResultPath <- gsub(' ','',paste('\\\\fi--san02/homes/jjo11/cascade/%s/','SequenceResults.csv'))" % altPath + "\n\n")
                file.write("if(file.exists(SeqResultPath)) {\n")
                file.write("\tArgsForModel <- read.csv(SeqResultPath)\n")
                file.write("\tArgsForModel$Args[i] = 1\n")
                file.write("\twrite.csv(ArgsForModel,file=SeqResultPath,row.names=FALSE)\n")
                file.write("} else {\n")
                file.write("\tYears <- seq(2016,2035,1)\n")
                file.write("\tArgs <- c(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)\n")
                file.write("\tArgsForModel <- data.frame(Years,Args)\n")
                file.write("\tArgsForModel$Args[i] = 1\n")
                file.write("\twrite.csv(ArgsForModel,file=SeqResultPath,row.names=FALSE)\n")
                file.write("}\n\n")
                file.write("write.csv(ArgsForModel,file='SequenceResults.csv',row.names=FALSE)\n\n")
                file.write("# Submit a new job to the cluster\n\n")
                file.write("JobLocation <- scan(what='character',allowEscapes=FALSE)\n")
                file.write(r"'\\fi--san02\homes\jjo11\cascade\%s\control.bat'" % path + "\n\n")
                file.write("system(paste('job submit /scheduler:fi--didemrchnb.dide.local /jobtemplate:GeneralNodes /numcores:1 /rerunnable:true /jobname:Sequence%s', JobLocation))" % (theSequence + 1) + "\n\n")
                file.write("httr::POST(makerUrl, body=list(value1='%s', value2='sequence %s finished.'))\n\n" % (altPath, theSequence + 1))
                file.write("print('Done.')")
                file.close()
        logging.info("Finished building simulation control scripts in R. (%s)" % runList[i])
        #####################
        # Bat file creation #
        #####################
        logging.info("Building batch files. (%s)" % runList[i])
        simPath = r"\\fi--san02\homes\jjo11\cascade\%s\sim" % runPath[i]
        if not os.path.exists(simPath):
            os.makedirs(simPath)
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\sim\sim_%s.bat" % (runPath[i], outputFolderList[x])):
                file = open(r"\\fi--san02\homes\jjo11\cascade\%s\sim\sim_%s.bat" % (runPath[i], outputFolderList[x]),"w")
                file.write("call setR64_3_0_1.bat\n")
                file.write(r"net use \\fi--san02\homes\jjo11\cascade\%s\ " % runPath[i] + "\n")
                file.write(r"set R_LIBS=\\fi--san02\homes\jjo11\cascade\%s\ " % runPath[i] + "\n")
                file.write(r"set R_LIBS_USER=\\fi--san02\homes\jjo11\cascade\%s\ " % runPath[i] + "\n")
                file.write(r"R CMD BATCH \\fi--san02\homes\jjo11\cascade\%s\scripts\go\go_%s.R" % (runPath[i], outputFolderList[x]))
                file.close()
        logging.info("Finished building batch files. (%s)" % runList[i])
    ########################################################################
    ##################
    # Job Submission #
    ##################
    for i in range(0,len(runList)):
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\output\%s\currentWorkspace.RData" % (runPath[i], outputFolderList[x])):
                logging.info("Launching %s, %s" % (runList[i],outputFolderList[x]))
                os.system(r"job submit /scheduler:fi--didemrchnb.dide.local /jobtemplate:16Core /numcores:4 /rerunnable:true /jobname:%s%s \\fi--san02\homes\jjo11\cascade\%s\sim\sim_%s.bat" % (runList[i], outputFolderList[x], runPath[i], outputFolderList[x]))
else:
    #############################
    # OPEN SEQUENCE RESULTS CSV #
    #############################
    logging.info("Starting Sequence %s" % theSequence)
    with open(r"\\fi--san02/homes/jjo11/cascade/%s/%s" % (altPath, "SequenceResults.csv"),"r") as theCsv:
        reader = csv.reader(theCsv)
        ArgsList = list(reader)
    for x in range(0,len(ArgsList)):
        logging.info("%s %s" % (ArgsList[x][0],ArgsList[x][1]))
    #############################################
    # WRITE NEW SEQUENCE OF BATS, RSCRIPTS etc. #
    #############################################
    for x in range(0,len(runList)):
        if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\%s\%s" % (path, seqList[theSequence], runList[x])):
            os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\%s\%s" % (path, seqList[theSequence], runList[x]))
    runPath = [None] * len(runList)
    runAltPath = [None] * len(runList)
    for i in range(0,len(runList)):
        runPath[i] = "%s\%s\%s" % (path, seqList[theSequence], runList[i])
        runAltPath[i] = "%s/%s/%s" % (altPath, seqList[theSequence], runList[i])
    #################
    # Creation Loop #
    #################
    for i in range(0,len(runList)):
        ####################
        # Output directory #
        ####################
        outputPath  = r"\\fi--san02\homes\jjo11\cascade\%s\output" % runPath[i]
        if not os.path.exists(outputPath):
            os.makedirs(outputPath)
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\output\%s" % (runPath[i], outputFolderList[x])):
                os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\output\%s" % (runPath[i], outputFolderList[x]))
        logging.info("Output directories created. (%s)" % runList[i])
        ###########
        # Rscript #
        ###########
        scriptPath = r"\\fi--san02\homes\jjo11\cascade\%s\scripts" % runPath[i]
        if not os.path.exists(scriptPath):
            os.makedirs(scriptPath)
        if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario" % runPath[i]):
            os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario" % runPath[i])
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario\%s" % (runPath[i], outputFolderList[x])):
                os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario\%s" % (runPath[i], outputFolderList[x]))
        logging.info("Script folder tree populated. (%s)" % runList[i])
        ###################
        # Scenario arrays #
        ###################
        cNaiveHbct                  = [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctNcd                    = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctNcdPreArtRetention     = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctNcdRetention           = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctNcdRetentionAdherence  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[1][1]) is 1:
            cHbct_2016 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2016 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[2][1]) is 1:
            cHbct_2017 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2017 = [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[3][1]) is 1:
            cHbct_2018 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2018 = [0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[4][1]) is 1:
            cHbct_2019 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2019 = [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[5][1]) is 1:
            cHbct_2020 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2020 = [0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[6][1]) is 1:
            cHbct_2021 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2021 = [0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[7][1]) is 1:
            cHbct_2022 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2022 = [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[8][1]) is 1:
            cHbct_2023 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2023 = [0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[9][1]) is 1:
            cHbct_2024 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2024 = [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[10][1]) is 1:
            cHbct_2025 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2025 = [0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[11][1]) is 1:
            cHbct_2026 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2026 = [0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0]
        if int(ArgsList[12][1]) is 1:
            cHbct_2027 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2027 = [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0]
        if int(ArgsList[13][1]) is 1:
            cHbct_2028 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2028 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
        if int(ArgsList[14][1]) is 1:
            cHbct_2029 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2029 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]
        if int(ArgsList[15][1]) is 1:
            cHbct_2030 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2030 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0]
        if int(ArgsList[16][1]) is 1:
            cHbct_2031 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2031 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0]
        if int(ArgsList[17][1]) is 1:
            cHbct_2032 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2032 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0]
        if int(ArgsList[18][1]) is 1:
            cHbct_2033 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2033 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0]
        if int(ArgsList[19][1]) is 1:
            cHbct_2034 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2034 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0]
        if int(ArgsList[20][1]) is 1:
            cHbct_2035 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        else:
            cHbct_2035 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
        cVct                        = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cHbctPocCd4                 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cLinkage                    = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cPreOutreach                = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cImprovedCare               = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cPocCd4                     = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cVctPocCd4                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cArtOutreach                = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cImmediateArt               = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cUniversalTestAndTreat      = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        cAdherence                  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        logging.info("Starting run.R script creation. (%s)" % runList[i])
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario\%s\run.R" % (runPath[i], outputFolderList[x])):
                file = open(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario\%s\run.R" % (runPath[i], outputFolderList[x]),"w")
                file.write("Cascade <- function() {\n")
                file.write("    startTime <- proc.time()\n")
                file.write(r"   dyn.load('\\\\fi--san02/homes/jjo11/cascade/%s/main.dll')" % altPath + "\n")
                file.write("    result <- .Call('CallCascade',\n")
                file.write("    %s,     # Pop;\n" % sizeAdjustment)
                file.write("    %s,     # NaiveHbct;\n" % cNaiveHbct[x])
                file.write("    %s,     # HbctNcd;\n" % cHbctNcd[x])
                file.write("    %s,     # HbctNcdPreArtRetention;\n" % cHbctNcdPreArtRetention[x])
                file.write("    %s,     # HbctNcdRetention;\n" % cHbctNcdRetention[x])
                file.write("    %s,     # HbctNcdRetentionAdherence;\n" % cHbctNcdRetentionAdherence[x])
                file.write("    %s,     # Hbct_2016;\n" % cHbct_2016[x])
                file.write("    %s,     # Hbct_2017;\n" % cHbct_2017[x])
                file.write("    %s,     # Hbct_2018;\n" % cHbct_2018[x])
                file.write("    %s,     # Hbct_2019;\n" % cHbct_2019[x])
                file.write("    %s,     # Hbct_2020;\n" % cHbct_2020[x])
                file.write("    %s,     # Hbct_2021;\n" % cHbct_2021[x])
                file.write("    %s,     # Hbct_2022;\n" % cHbct_2022[x])
                file.write("    %s,     # Hbct_2023;\n" % cHbct_2023[x])
                file.write("    %s,     # Hbct_2024;\n" % cHbct_2024[x])
                file.write("    %s,     # Hbct_2025;\n" % cHbct_2025[x])
                file.write("    %s,     # Hbct_2026;\n" % cHbct_2026[x])
                file.write("    %s,     # Hbct_2027;\n" % cHbct_2027[x])
                file.write("    %s,     # Hbct_2028;\n" % cHbct_2028[x])
                file.write("    %s,     # Hbct_2029;\n" % cHbct_2029[x])
                file.write("    %s,     # Hbct_2030;\n" % cHbct_2030[x])
                file.write("    %s,     # Hbct_2031;\n" % cHbct_2031[x])
                file.write("    %s,     # Hbct_2032;\n" % cHbct_2032[x])
                file.write("    %s,     # Hbct_2033;\n" % cHbct_2033[x])
                file.write("    %s,     # Hbct_2034;\n" % cHbct_2034[x])
                file.write("    %s,     # Hbct_2035;\n" % cHbct_2035[x])
                file.write("    %s,     # Vct;\n" % cVct[x])
                file.write("    %s,     # HbctPocCd4;\n" % cHbctPocCd4[x])
                file.write("    %s,     # Linkage;\n" % cLinkage[x])
                file.write("    %s,     # PreOutreach;\n" % cPreOutreach[x])
                file.write("    %s,     # ImprovedCare;\n" % cImprovedCare[x])
                file.write("    %s,     # PocCd4;\n" % cPocCd4[x])
                file.write("    %s,     # VctPocCd4;\n" % cVctPocCd4[x])
                file.write("    %s,     # ArtOutreach;\n" % cArtOutreach[x])
                file.write("    %s,     # ImmediateArt;\n" % cImmediateArt[x])
                file.write("    %s,     # UniversalTestAndTreat;\n" % cUniversalTestAndTreat[x])
                file.write("    %s,     # Adherence;\n" % cAdherence[x])
                file.write("    0       # CalibrationSwitch;\n")
                file.write("    )\n")
                file.write("    endTime <- proc.time() - startTime\n")
                file.write("    print(endTime)\n")
                file.write("    flush.console()\n")
                file.write("    return(result)\n")
                file.write("}\n")
                file.close()
        logging.info("Completed run.R script creation. (%s)" % runList[i])
        ####################
        # Rscript creation #
        ####################
        logging.info("Building simulation control scripts in R. (%s)" % runList[i])
        goPath = r"\\fi--san02\homes\jjo11\cascade\%s\scripts\go" % runPath[i]
        if not os.path.exists(goPath):
            os.makedirs(goPath)
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\go\go_%s.R" % (runPath[i], outputFolderList[x])):
                file = open(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\go\go_%s.R" % (runPath[i], outputFolderList[x]),"w")
                file.write(r"setwd('\\\\fi--san02/homes/jjo11/cascade/%s/')" % runAltPath[i] + "\n")
                file.write("source('./scripts/scenario/%s/run.R')\n" % outputFolderList[x])
                file.write("%s <- Cascade()\n" % outputFolderList[x])
                file.write("save.image(file='./output/%s/currentWorkspace.RData')\n\n" % outputFolderList[x])
                file.write("# AutomationTestScript\n")
                file.write("rm(list=ls())\n")
                file.write(r"setwd('\\\\fi--san02/homes/jjo11/cascade/%s/%s/')" % (altPath, seqList[theSequence]) + "\n\n")
                file.write("# IFTTT Notification Setup\n")
                file.write("list.of.packages <- c('bitops','httr','RCurl')\n")
                file.write(r"new.packages <- list.of.packages[!(list.of.packages %in% installed.packages(lib.loc='\\\\fi--san02/homes/jjo11/library/')[,'Package'])]" + "\n")
                file.write(r"if(length(new.packages)) install.packages(new.packages,repos='http://cran.ma.imperial.ac.uk',lib='\\\\fi--san02/homes/jjo11/library/')" + "\n")
                file.write(r"require(bitops,lib.loc='\\\\fi--san02/homes/jjo11/library/')" + "\n")
                file.write(r"require(RCurl,lib.loc='\\\\fi--san02/homes/jjo11/library/')" + "\n")
                file.write(r"require(httr,lib.loc='\\\\fi--san02/homes/jjo11/library/')" + "\n")
                file.write("myEvent <- 'cluster'\n")
                file.write("myKey <- 'yrE109QSpk7g52OgdOzf0'\n")
                file.write("makerUrl <- paste('https://maker.ifttt.com/trigger', myEvent, 'with/key', myKey, sep='/')\n\n")
                file.write("run <- c('run1','run2','run3','run4','run5','run6','run7','run8','run9','run10')\n")
                file.write("interventions <- c('Baseline','NaiveHbct','Hbct_2016', 'Hbct_2017', 'Hbct_2018', 'Hbct_2019', 'Hbct_2020', 'Hbct_2021', 'Hbct_2022', 'Hbct_2023', 'Hbct_2024', 'Hbct_2025', 'Hbct_2026', 'Hbct_2027', 'Hbct_2028', 'Hbct_2029', 'Hbct_2030', 'Hbct_2031', 'Hbct_2032', 'Hbct_2033', 'Hbct_2034', 'Hbct_2035')\n\n")
                file.write("for(i in 1:length(run)) {\n")
                file.write("\tfor(j in 1:length(interventions)) {\n")
                file.write("\t\tif(!file.exists(gsub(' ','',paste(run[i],'/output/',interventions[j],'/currentWorkspace.RData')))) {\n")
                file.write("\t\t\tstop(paste('File',gsub(' ','',paste(run[i],'/output/',interventions[j],'/currentWorkspace.RData')),'does not exist.'))\n")
                file.write("\t\t}\n")
                file.write("\t}\n")
                file.write("}\n\n")
                file.write("# lock-file\n")
                file.write("if(!file.exists('lock-file')) {\n")
                file.write("\tdir.create('lock-file')\n")
                file.write("} else {\n")
                file.write("\tstop('File locked.')\n")
                file.write("}\n\n")
                file.write("if(file.exists(gsub(' ','',paste('./',run[1],'/output/',interventions[1],'/currentWorkspace.RData'))))\n")
                file.write("\tload(gsub(' ','',paste('./',run[1],'/output/',interventions[1],'/currentWorkspace.RData'))) else stop('File (run1:baseline) does not exist.')\n\n")
                file.write("# Loop through all interventions and runs and dynamically average them #\n")
                file.write("for(i in 1:length(interventions)) {\n")
                file.write("\tprint(interventions[i])\n")
                file.write("\t# Create vector of names\n")
                file.write("\toutputNames <- c()\n")
                file.write("\tfor(m in 1:length(Baseline))\n")
                file.write("\t\toutputNames[m] <- names(Baseline)[m]\n")
                file.write("\t# Create list\n")
                file.write("\toutput <- sapply(outputNames,function(x) NULL)\n")
                file.write("\tfor(n in 1:length(output))\n")
                file.write("\t\toutput[[n]] <- vector('double',length(Baseline[[n]]))\n")
                file.write("\ttheLength = 0\n")
                file.write("\tfor(j in 1:length(run)) {\n")
                file.write("\t\tif(file.exists(gsub(' ','',paste('./',run[j],'/output/',interventions[i],'/currentWorkspace.RData')))) {\n")
                file.write("\t\t\tload(gsub(' ','',paste('./',run[j],'/output/',interventions[i],'/currentWorkspace.RData')))\n")
                file.write("\t\t\tprint(run[j])\n")
                file.write("\t\t\ttheLength <- theLength + 1\n")
                file.write("\t\t\tfor(k in 1:length(Baseline)) {\n")
                file.write("\t\t\t\toutput[[k]] <- output[[k]] + get(interventions[i])[[k]]\n")
                file.write("\t\t\t}\n")
                file.write("\t\t}\n")
                file.write("\t}\n")
                file.write("\tprint(paste('theLength =',theLength))\n")
                file.write("\tfor(l in 1:length(Baseline)) {\n")
                file.write("\t\toutput[[l]] <- output[[l]] / theLength\n")
                file.write("\t}\n")
                file.write("\tassign(interventions[i],output)\n")
                file.write("}\n")
                file.write("print('\tComplete!')\n\n")
                file.write("sizeAdjustment = %s" % sizeAdjustment + "\n\n")
                file.write("totalDALYs <- matrix(0,20,1)\n")
                file.write("totalDALYs[1,] <- (sum(Baseline$sDALY) - sum(Hbct_2016$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[2,] <- (sum(Baseline$sDALY) - sum(Hbct_2017$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[3,] <- (sum(Baseline$sDALY) - sum(Hbct_2018$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[4,] <- (sum(Baseline$sDALY) - sum(Hbct_2019$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[5,] <- (sum(Baseline$sDALY) - sum(Hbct_2020$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[6,] <- (sum(Baseline$sDALY) - sum(Hbct_2021$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[7,] <- (sum(Baseline$sDALY) - sum(Hbct_2022$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[8,] <- (sum(Baseline$sDALY) - sum(Hbct_2023$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[9,] <- (sum(Baseline$sDALY) - sum(Hbct_2024$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[10,] <- (sum(Baseline$sDALY) - sum(Hbct_2025$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[11,] <- (sum(Baseline$sDALY) - sum(Hbct_2026$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[12,] <- (sum(Baseline$sDALY) - sum(Hbct_2027$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[13,] <- (sum(Baseline$sDALY) - sum(Hbct_2028$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[14,] <- (sum(Baseline$sDALY) - sum(Hbct_2029$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[15,] <- (sum(Baseline$sDALY) - sum(Hbct_2030$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[16,] <- (sum(Baseline$sDALY) - sum(Hbct_2031$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[17,] <- (sum(Baseline$sDALY) - sum(Hbct_2032$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[18,] <- (sum(Baseline$sDALY) - sum(Hbct_2033$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[19,] <- (sum(Baseline$sDALY) - sum(Hbct_2034$sDALY)) * sizeAdjustment\n")
                file.write("totalDALYs[20,] <- (sum(Baseline$sDALY) - sum(Hbct_2035$sDALY)) * sizeAdjustment\n\n")
                file.write("# Find index of max(totalDALYs)\n")
                file.write("i = 1\n")
                file.write("while(totalDALYs[i,] != max(totalDALYs)) i <- i + 1\n\n")
                file.write(r"SeqResultPath <- gsub(' ','',paste('\\\\fi--san02/homes/jjo11/cascade/%s/','SequenceResults.csv'))" % altPath + "\n\n")
                file.write("if(file.exists(SeqResultPath)) {\n")
                file.write("\tArgsForModel <- read.csv(SeqResultPath)\n")
                file.write("\tArgsForModel$Args[i] = 1\n")
                file.write("\twrite.csv(ArgsForModel,file=SeqResultPath,row.names=FALSE)\n")
                file.write("} else {\n")
                file.write("\tYears <- seq(2016,2035,1)\n")
                file.write("\tArgs <- c(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)\n")
                file.write("\tArgsForModel <- data.frame(Years,Args)\n")
                file.write("\tArgsForModel$Args[i] = 1\n")
                file.write("\twrite.csv(ArgsForModel,file=SeqResultPath,row.names=FALSE)\n")
                file.write("}\n\n")
                file.write("write.csv(ArgsForModel,file='SequenceResults.csv',row.names=FALSE)\n\n")
                file.write("# Submit a new job to the cluster\n\n")
                file.write("JobLocation <- scan(what='character',allowEscapes=FALSE)\n")
                file.write(r"'\\fi--san02\homes\jjo11\cascade\%s\control.bat'" % path + "\n\n")
                file.write("system(paste('job submit /scheduler:fi--didemrchnb.dide.local /jobtemplate:GeneralNodes /numcores:1 /rerunnable:true /jobname:Sequence%s', JobLocation))" % (theSequence + 1) + "\n\n")
                file.write("httr::POST(makerUrl, body=list(value1='%s', value2='sequence %s finished.'))\n\n" % (altPath, theSequence + 1))
                file.write("print('Done.')")
                file.close()
        logging.info("Finished building simulation control scripts in R. (%s)" % runList[i])
        #####################
        # Bat file creation #
        #####################
        logging.info("Building batch files. (%s)" % runList[i])
        simPath = r"\\fi--san02\homes\jjo11\cascade\%s\sim" % runPath[i]
        if not os.path.exists(simPath):
            os.makedirs(simPath)
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\sim\sim_%s.bat" % (runPath[i], outputFolderList[x])):
                file = open(r"\\fi--san02\homes\jjo11\cascade\%s\sim\sim_%s.bat" % (runPath[i], outputFolderList[x]),"w")
                file.write("call setR64_3_0_1.bat\n")
                file.write(r"net use \\fi--san02\homes\jjo11\cascade\%s\ " % runPath[i] + "\n")
                file.write(r"set R_LIBS=\\fi--san02\homes\jjo11\cascade\%s\ " % runPath[i] + "\n")
                file.write(r"set R_LIBS_USER=\\fi--san02\homes\jjo11\cascade\%s\ " % runPath[i] + "\n")
                file.write(r"R CMD BATCH \\fi--san02\homes\jjo11\cascade\%s\scripts\go\go_%s.R" % (runPath[i], outputFolderList[x]))
                file.close()
        logging.info("Finished building batch files. (%s)" % runList[i])
    ########################################################################
    ##################
    # Job Submission #
    ##################
    for i in range(0,len(runList)):
        for x in range(0,len(outputFolderList)):
            if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\output\%s\currentWorkspace.RData" % (runPath[i], outputFolderList[x])):
                logging.info("Launching %s, %s" % (runList[i],outputFolderList[x]))
                os.system(r"job submit /scheduler:fi--didemrchnb.dide.local /jobtemplate:16Core /numcores:4 /rerunnable:true /jobname:%s%s \\fi--san02\homes\jjo11\cascade\%s\sim\sim_%s.bat" % (runList[i], outputFolderList[x], runPath[i], outputFolderList[x]))

#######
# END #
#######

logging.info("Python script end.")