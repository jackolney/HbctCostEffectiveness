###############################
# CareCascadeV2 Python Script #
###############################
   # Multiple Run Version #
   ########################

import sys
import os.path
import time
import logging

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

###############
# Repeat Runs #
###############

runList = ["run1","run2","run3","run4","run5","run6","run7","run8","run9","run10"]

for x in range(0,len(runList)):
	if not os.path.exists(r"\\fi--san02\homes\jjo11\cascade\%s\%s" % (path, runList[x])):
		os.makedirs(r"\\fi--san02\homes\jjo11\cascade\%s\%s" % (path, runList[x]))

runPath = [None] * len(runList)
runAltPath = [None] * len(runList)

for i in range(0,len(runList)):
	runPath[i] = "%s\%s" % (path,runList[i])
	runAltPath[i] = "%s/%s" % (altPath,runList[i])

#################
# Creation Loop #
#################

for i in range(0,len(runList)):
	####################
	# Output directory #
	####################
	outputPath 	= r"\\fi--san02\homes\jjo11\cascade\%s\output" % runPath[i]
	if not os.path.exists(outputPath):
		os.makedirs(outputPath)
	outputFolderList = ["Baseline","Hbct_1","Hbct_2","Vct_1","Vct_2","HbctPocCd4_1","HbctPocCd4_2","Linkage_1","Linkage_2","VctPocCd4","PreOutreach_1","PreOutreach_2","ImprovedCare_1","ImprovedCare_2","PocCd4","ArtOutreach_1","ArtOutreach_2","Adherence_1","Adherence_2","ImmediateArt","UniversalTestAndTreat_1","UniversalTestAndTreat_2"]
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
	cHbct 					= [0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	cVct 					= [0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	cHbctPocCd4 			= [0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	cLinkage				= [0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0]
	cVctPocCd4 				= [0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0]
	cPreOutreach 			= [0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0]
	cImprovedCare 			= [0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0]
	cPocCd4 				= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
	cArtOutreach			= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0]
	cAdherence 				= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0]
	cImmediateArt 			= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0]
	cUniversalTestAndTreat 	= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2]
	logging.info("Starting run.R script creation. (%s)" % runList[i])
	for x in range(0,len(outputFolderList)):
		file = open(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\scenario\%s\run.R" % (runPath[i], outputFolderList[x]),"w")
		file.write("Cascade <- function() {\n")
		file.write("	startTime <- proc.time()\n")
		file.write(r"	dyn.load('\\\\fi--san02/homes/jjo11/cascade/%s/main.dll')" % altPath + "\n")
		file.write("	result <- .Call('CallCascade',\n")
		file.write("	%s,  	# Pop;\n" % 10)
		file.write("	%s,  	# Hbct;\n" % cHbct[x])
		file.write("	%s,  	# Vct;\n" % cVct[x])
		file.write("	%s,  	# HbctPocCd4;\n" % cHbctPocCd4[x])
		file.write("	%s,  	# Linkage;\n" % cLinkage[x])
		file.write("	%s,  	# VctPocCd4;\n" % cVctPocCd4[x])
		file.write("	%s,  	# PreOutreach;\n" % cPreOutreach[x])
		file.write("	%s,  	# ImprovedCare;\n" % cImprovedCare[x])
		file.write("	%s,	  	# PocCd4;\n" % cPocCd4[x])
		file.write("	%s,  	# ArtOutreach;\n" % cArtOutreach[x])
		file.write("	%s,   	# Adherence;\n" % cAdherence[x])
		file.write("	%s,  	# ImmediateArt;\n" % cImmediateArt[x])
		file.write("	%s,  	# UniversalTestAndTreat;\n" % cUniversalTestAndTreat[x])
		file.write("	0 		# CalibrationSwitch;\n")
		file.write("	)\n")
		file.write("	endTime <- proc.time() - startTime\n")
		file.write("	print(endTime)\n")
		file.write("	flush.console()\n")
		file.write("	return(result)\n")
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
		file = open(r"\\fi--san02\homes\jjo11\cascade\%s\scripts\go\go_%s.R" % (runPath[i], outputFolderList[x]),"w")
		file.write(r"setwd('\\\\fi--san02/homes/jjo11/cascade/%s/')" % runAltPath[i] + "\n")
		file.write("source('./scripts/scenario/%s/run.R')\n" % outputFolderList[x])
		file.write("%s <- Cascade()\n" % outputFolderList[x])
		file.write("save.image(file='./output/%s/currentWorkspace.RData')\n" % outputFolderList[x])	
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
			os.system(r"job submit /scheduler:fi--didemrchnb.dide.local /jobtemplate:12Core /rerunnable:true /jobname:%s%s \\fi--san02\homes\jjo11\cascade\%s\sim\sim_%s.bat" % (runList[i],outputFolderList[x],runPath[i], outputFolderList[x]))

logging.info("Python script complete.")