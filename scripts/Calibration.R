Calibrate <- function() {
	# Calibration Script for CareCascade
	setwd("/Users/jack/git/CareCascade")
	source("./rScript/BaselineFigures.R")

	rm(list=ls())
	system("date")
	popSize = 100
	dyn.load("./source/main.so")
	Calibration <- .Call("CallCascade",popSize, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
	Calibration

	########################
	# CALIBRATION FUNCTION #
	########################

	require(beepr)
	results <- matrix(0,84,3)
	colnames(results) <- c("ONE","TWO","THREE")
	rownames(results) <- c("C1_HCT", "C1_VCT", "C1_PICT", "L2.1_HCT_m500", "L2.1_HCT_350500", "L2.1_HCT_200350", "L2.1_HCT_l200", "L2.1_VCT_m500", "L2.1_VCT_350500", "L2.1_VCT_200350", "L2.1_VCT_l200", "L2.1_PICT_m500", "L2.1_PICT_350500", "L2.1_PICT_200350", "L2.1_PICT_l200", "R3_HCT", "R3_VCT", "R3_PICT", "R8_HCT", "R8_VCT", "R8_PICT", "ART1_HCT_m500", "ART1_HCT_350500", "ART1_HCT_200350", "ART1_HCT_l200", "ART1_VCT_m500", "ART1_VCT_350500", "ART1_VCT_200350", "ART1_VCT_l200", "ART1_PICT_m500", "ART1_PICT_350500", "ART1_PICT_200350", "ART1_PICT_l200", "ART1_ALL_m500", "ART1_ALL_350500", "ART1_ALL_200350", "ART1_ALL_l200", "ART2_HCT", "ART2_VCT", "ART2_PICT", "ART4", "ART5_HCT", "ART5_VCT", "ART5_PITC", "ART6_HCT", "ART9_HCT", "ART9_VCT", "ART9_PITC", "ART10_ALL", "ART11_HCT", "ART11_VCT", "ART11_PITC", "ART12_ALL", "ART13_HCT", "ART13_VCT", "ART13_PICT", "ART14_HCT", "ART14_VCT", "ART14_PICT", "PLWHIV_2010", "PLWHIV_2010_VCT", "PLWHIV_2010_PICT", "%onART", "nonART,", "diag_count", "ART14_ALL", "ART5_ALL", "ART9_ALL", "ART11_ALL", "ART13_ALL","ArtRoute_Hct","ArtRoute_Vct","ArtRoute_Pict","In2014","Mid2010","T12_ArtAtEnrollment", "T12_NotArtAtEnrollment", "T12_Reinitiating", "T3_ArtAtEnrollment_Recent", "T3_ArtAtEnrollment_NotRecent", "T3_Retained", "T3_LostReturnNotEligible", "T3_LostReturnEligible", "T3_Reinitiating")
	results

	##################################################
	#C1 - Proportion of individuals that ever enter care

	#Time points
	if(sum(Calibration$sC1) == 0) {beep(9); print("ERROR!")}
	#HCT
	results[1,1] <- Calibration$sC1[1] / sum(Calibration$sC1[1:3])
	results[1,2] <- Calibration$sC1[4] / sum(Calibration$sC1[4:6])
	results[1,3] <- Calibration$sC1[7] / sum(Calibration$sC1[7:9])

	#VCT
	results[2,1] <- Calibration$sC1[2] / sum(Calibration$sC1[1:3])
	results[2,2] <- Calibration$sC1[5] / sum(Calibration$sC1[4:6])
	results[2,3] <- Calibration$sC1[8] / sum(Calibration$sC1[7:9])

	#PICT
	results[3,1] <- Calibration$sC1[3] / sum(Calibration$sC1[1:3])
	results[3,2] <- Calibration$sC1[6] / sum(Calibration$sC1[4:6])
	results[3,3] <- Calibration$sC1[9] / sum(Calibration$sC1[7:9])

	#Use FIRST_test_route (not the ART variable). Where I wonder? EVERYWHERE!

	##################################################
	#L2.1 - Mean CD4 count at first CD4 measurement
	#HCT
	#Time point ONE
	results[4,1] <- Calibration$sL21[1] / sum(Calibration$sL21[1:4])
	results[5,1] <- Calibration$sL21[2] / sum(Calibration$sL21[1:4])
	results[6,1] <- Calibration$sL21[3] / sum(Calibration$sL21[1:4])
	results[7,1] <- Calibration$sL21[4] / sum(Calibration$sL21[1:4])
	#Time point TWO
	results[4,2] <- Calibration$sL21[13] / sum(Calibration$sL21[13:16])
	results[5,2] <- Calibration$sL21[14] / sum(Calibration$sL21[13:16])
	results[6,2] <- Calibration$sL21[15] / sum(Calibration$sL21[13:16])
	results[7,2] <- Calibration$sL21[16] / sum(Calibration$sL21[13:16])
	#Time point THREE
	results[4,3] <- Calibration$sL21[25] / sum(Calibration$sL21[25:28])
	results[5,3] <- Calibration$sL21[26] / sum(Calibration$sL21[25:28])
	results[6,3] <- Calibration$sL21[27] / sum(Calibration$sL21[25:28])
	results[7,3] <- Calibration$sL21[28] / sum(Calibration$sL21[25:28])

	####
	#VCT
	#Time point ONE
	results[8,1] <- Calibration$sL21[5] / sum(Calibration$sL21[5:8])
	results[9,1] <- Calibration$sL21[6] / sum(Calibration$sL21[5:8])
	results[10,1] <- Calibration$sL21[7] / sum(Calibration$sL21[5:8])
	results[11,1] <- Calibration$sL21[8] / sum(Calibration$sL21[5:8])
	#Time point TWO
	results[8,2] <- Calibration$sL21[17] / sum(Calibration$sL21[17:20])
	results[9,2] <- Calibration$sL21[18] / sum(Calibration$sL21[17:20])
	results[10,2] <- Calibration$sL21[19] / sum(Calibration$sL21[17:20])
	results[11,2] <- Calibration$sL21[20] / sum(Calibration$sL21[17:20])
	#Time point THREE
	results[8,3] <- Calibration$sL21[29] / sum(Calibration$sL21[29:32])
	results[9,3] <- Calibration$sL21[30] / sum(Calibration$sL21[29:32])
	results[10,3] <- Calibration$sL21[31] / sum(Calibration$sL21[29:32])
	results[11,3] <- Calibration$sL21[32] / sum(Calibration$sL21[29:32])

	####
	#PICT
	#Time point ONE
	results[12,1] <- Calibration$sL21[9] / sum(Calibration$sL21[9:12])
	results[13,1] <- Calibration$sL21[10] / sum(Calibration$sL21[9:12])
	results[14,1] <- Calibration$sL21[11] / sum(Calibration$sL21[9:12])
	results[15,1] <- Calibration$sL21[12] / sum(Calibration$sL21[9:12])
	#Time point TWO
	results[12,2] <- Calibration$sL21[21] / sum(Calibration$sL21[21:24])
	results[13,2] <- Calibration$sL21[22] / sum(Calibration$sL21[21:24])
	results[14,2] <- Calibration$sL21[23] / sum(Calibration$sL21[21:24])
	results[15,] <- Calibration$sL21[24] / sum(Calibration$sL21[21:24])
	#Time point THREE
	results[12,3] <- Calibration$sL21[33] / sum(Calibration$sL21[33:36])
	results[13,3] <- Calibration$sL21[34] / sum(Calibration$sL21[33:36])
	results[14,3] <- Calibration$sL21[35] / sum(Calibration$sL21[33:36])
	results[15,3] <- Calibration$sL21[36] / sum(Calibration$sL21[33:36])

	##################################################
	#R3 - Mean number of secondary CD4 appointment prior to becoming eligible for ART
	#HCT
	results[16,1] <- Calibration$sR3[1] / Calibration$sR3_Counter[1]
	results[16,2] <- Calibration$sR3[4] / Calibration$sR3_Counter[4]
	results[16,3] <- Calibration$sR3[7] / Calibration$sR3_Counter[7]

	#VCT
	results[17,1] <- Calibration$sR3[2] / Calibration$sR3_Counter[2]
	results[17,2] <- Calibration$sR3[5] / Calibration$sR3_Counter[5]
	results[17,3] <- Calibration$sR3[8] / Calibration$sR3_Counter[8]

	#PITC
	results[18,1] <- Calibration$sR3[3] / Calibration$sR3_Counter[3]
	results[18,2] <- Calibration$sR3[6] / Calibration$sR3_Counter[6]
	results[18,3] <- Calibration$sR3[9] / Calibration$sR3_Counter[9]

	#################################################
	#R8 - Mean CD4 count when receiving secondary CD4 results
	#Values calculated in C (roughly medians)
	#CD4 <200 = 1 = 100
	#CD4 200-350 = 2 = 275
	#CD4 350-500 = 3 = 425
	#CD4 >500 = 4 = 750

	#HCT
	results[19,1] <- Calibration$sR8[1] / Calibration$sR8_Counter[1]
	results[19,2] <- Calibration$sR8[4] / Calibration$sR8_Counter[4]
	results[19,3] <- Calibration$sR8[7] / Calibration$sR8_Counter[7]

	#VCT
	results[20,1] <- Calibration$sR8[2] / Calibration$sR8_Counter[2]
	results[20,2] <- Calibration$sR8[5] / Calibration$sR8_Counter[5]
	results[20,3] <- Calibration$sR8[8] / Calibration$sR8_Counter[8]

	#PICT
	results[21,1] <- Calibration$sR8[3] / Calibration$sR8_Counter[3]
	results[21,2] <- Calibration$sR8[6] / Calibration$sR8_Counter[6]
	results[21,3] <- Calibration$sR8[9] / Calibration$sR8_Counter[9]

	##################################################
	#ART1 - Mean CD4 count at ART initiation
	#I don't think this should be "everHbct" etc. but rather FIRST route into care.
	#ArtStuff
	Calibration$sART1

	#HBCT
	#Time point ONE
	results[22,1] <- Calibration$sART1[1] / sum(Calibration$sART1[1:4])
	results[23,1] <- Calibration$sART1[2] / sum(Calibration$sART1[1:4])
	results[24,1] <- Calibration$sART1[3] / sum(Calibration$sART1[1:4])
	results[25,1] <- Calibration$sART1[4] / sum(Calibration$sART1[1:4])

	#Time point TWO
	results[22,2] <- Calibration$sART1[17] / sum(Calibration$sART1[17:20])
	results[23,2] <- Calibration$sART1[18] / sum(Calibration$sART1[17:20])
	results[24,2] <- Calibration$sART1[19] / sum(Calibration$sART1[17:20])
	results[25,2] <- Calibration$sART1[20] / sum(Calibration$sART1[17:20])

	#Time point THREE
	results[22,3] <- Calibration$sART1[33] / sum(Calibration$sART1[33:36])
	results[23,3] <- Calibration$sART1[34] / sum(Calibration$sART1[33:36])
	results[24,3] <- Calibration$sART1[35] / sum(Calibration$sART1[33:36])
	results[25,3] <- Calibration$sART1[36] / sum(Calibration$sART1[33:36])

	#VCT
	#Time point ONE
	results[26,1] <- Calibration$sART1[5] / sum(Calibration$sART1[5:8])
	results[27,1] <- Calibration$sART1[6] / sum(Calibration$sART1[5:8])
	results[28,1] <- Calibration$sART1[7] / sum(Calibration$sART1[5:8])
	results[29,1] <- Calibration$sART1[8] / sum(Calibration$sART1[5:8])

	#Time point TWO
	results[26,2] <- Calibration$sART1[21] / sum(Calibration$sART1[21:24])
	results[27,2] <- Calibration$sART1[22] / sum(Calibration$sART1[21:24])
	results[28,2] <- Calibration$sART1[23] / sum(Calibration$sART1[21:24])
	results[29,2] <- Calibration$sART1[24] / sum(Calibration$sART1[21:24])

	#Time point THREE
	results[26,3] <- Calibration$sART1[37] / sum(Calibration$sART1[37:40])
	results[27,3] <- Calibration$sART1[38] / sum(Calibration$sART1[37:40])
	results[28,3] <- Calibration$sART1[39] / sum(Calibration$sART1[37:40])
	results[29,3] <- Calibration$sART1[40] / sum(Calibration$sART1[37:40])

	#PICT
	#Time point ONE
	results[30,1] <- Calibration$sART1[9] / sum(Calibration$sART1[9:12])
	results[31,1] <- Calibration$sART1[10] / sum(Calibration$sART1[9:12])
	results[32,1] <- Calibration$sART1[11] / sum(Calibration$sART1[9:12])
	results[33,1] <- Calibration$sART1[12] / sum(Calibration$sART1[9:12])

	#Time point TWO
	results[30,2] <- Calibration$sART1[25] / sum(Calibration$sART1[25:28])
	results[31,2] <- Calibration$sART1[26] / sum(Calibration$sART1[25:28])
	results[32,2] <- Calibration$sART1[27] / sum(Calibration$sART1[25:28])
	results[33,2] <- Calibration$sART1[28] / sum(Calibration$sART1[25:28])

	#Time point THREE
	results[30,3] <- Calibration$sART1[41] / sum(Calibration$sART1[41:44])
	results[31,3] <- Calibration$sART1[42] / sum(Calibration$sART1[41:44])
	results[32,3] <- Calibration$sART1[43] / sum(Calibration$sART1[41:44])
	results[33,3] <- Calibration$sART1[44] / sum(Calibration$sART1[41:44])

	#####
	#ART1 - ALL
	#T1
	results[34,1] <- Calibration$sART1[13] / sum(Calibration$sART1[13:16])
	results[35,1] <- Calibration$sART1[14] / sum(Calibration$sART1[13:16])
	results[36,1] <- Calibration$sART1[15] / sum(Calibration$sART1[13:16])
	results[37,1] <- Calibration$sART1[16] / sum(Calibration$sART1[13:16])

	#T2
	results[34,2] <- Calibration$sART1[29] / sum(Calibration$sART1[29:32])
	results[35,2] <- Calibration$sART1[30] / sum(Calibration$sART1[29:32])
	results[36,2] <- Calibration$sART1[31] / sum(Calibration$sART1[29:32])
	results[37,2] <- Calibration$sART1[32] / sum(Calibration$sART1[29:32])

	#T3
	results[34,3] <- Calibration$sART1[45] / sum(Calibration$sART1[45:48])
	results[35,3] <- Calibration$sART1[46] / sum(Calibration$sART1[45:48])
	results[36,3] <- Calibration$sART1[47] / sum(Calibration$sART1[45:48])
	results[37,3] <- Calibration$sART1[48] / sum(Calibration$sART1[45:48])

	##################################################
	#ART2 - Proportion of individuals initiating ART with CD4 <200.
	#Needs stratification by VCT / HCT
	#HCT
	results[38,1] <- Calibration$sART1[4] / sum(Calibration$sART1[1:4])
	results[38,2] <- Calibration$sART1[20] / sum(Calibration$sART1[17:20])
	results[38,3] <- Calibration$sART1[36] / sum(Calibration$sART1[33:36])

	#VCT
	results[39,1] <- Calibration$sART1[8] / sum(Calibration$sART1[5:8])
	results[39,2] <- Calibration$sART1[24] / sum(Calibration$sART1[21:24])
	results[39,3] <- Calibration$sART1[40] / sum(Calibration$sART1[37:40])

	#PICT
	results[40,1] <- Calibration$sART1[12] / sum(Calibration$sART1[9:12])
	results[40,2] <- Calibration$sART1[28] / sum(Calibration$sART1[25:28])
	results[40,3] <- Calibration$sART1[44] / sum(Calibration$sART1[41:44])

	##################################################
	#ART4 - Mean number of pre-ART visits prior to ART initiation
	Calibration$sART4
	#ALL
	results[41,1] <- Calibration$sART4[1] / sum(Calibration$sART1[13:16])
	results[41,2] <- Calibration$sART4[2] / sum(Calibration$sART1[29:32])
	results[41,3] <- Calibration$sART4[3] / sum(Calibration$sART1[45:48])

	##################################################
	#ART5 - Proportion of patients initiating ART after diagnosis and successful retention in care until becoming eligible for treatment (i.e. no gap in care)
	Calibration$sART5
	#HCT
	results[42,1] <- Calibration$sART5[1] / sum(Calibration$sART1[1:4])
	results[42,2] <- Calibration$sART5[4] / sum(Calibration$sART1[17:20])
	results[42,3] <- Calibration$sART5[7] / sum(Calibration$sART1[33:36])

	#VCT
	results[43,1] <- Calibration$sART5[2] / sum(Calibration$sART1[5:8])
	results[43,2] <- Calibration$sART5[5] / sum(Calibration$sART1[21:24])
	results[43,3] <- Calibration$sART5[8] / sum(Calibration$sART1[37:40])

	#PITC
	results[44,1] <- Calibration$sART5[3] / sum(Calibration$sART1[9:12])
	results[44,2] <- Calibration$sART5[6] / sum(Calibration$sART1[25:28])
	results[44,3] <- Calibration$sART5[9] / sum(Calibration$sART1[41:44])

	##################################################
	#ART6 - mean time for ppl successfully reatained (HCT only)
	Calibration$sART6;
	Calibration$sART6_Counter;
	#HCT
	results[45,1] <- Calibration$sART6[1] / Calibration$sART6_Counter[1]
	results[45,2] <- Calibration$sART6[2] / Calibration$sART6_Counter[2]
	results[45,3] <- Calibration$sART6[3] / Calibration$sART6_Counter[3]

	##################################################
	#ART9 - Proportion of patients initiating ART after diagnosis, who were subsequently lost from pre-ART care (ie. HAD AT LEAST ONE CD4 CELL COUNT) but returning prior to becoming eligible for treatment
	Calibration$sART9;
	#HCT
	results[46,1] <- Calibration$sART9[1] / sum(Calibration$sART1[1:4]) 
	results[46,2] <- Calibration$sART9[4] / sum(Calibration$sART1[17:20]) 
	results[46,3] <- Calibration$sART9[7] / sum(Calibration$sART1[33:36]) 

	#VCT
	results[47,1] <- Calibration$sART9[2] / sum(Calibration$sART1[5:8]) 
	results[47,2] <- Calibration$sART9[5] / sum(Calibration$sART1[21:24]) 
	results[47,3] <- Calibration$sART9[8] / sum(Calibration$sART1[37:40]) 

	#PICT
	results[48,1] <- Calibration$sART9[3] / sum(Calibration$sART1[9:12]) 
	results[48,2] <- Calibration$sART9[6] / sum(Calibration$sART1[25:28]) 
	results[48,3] <- Calibration$sART9[9] / sum(Calibration$sART1[41:44]) 

	##################################################
	#ART10 - Mean time for ppl lost but return before eligible.
	Calibration$sART10;
	Calibration$sART10_Counter;
	#ALL (assumed)
	results[49,1] <- Calibration$sART10[1] / Calibration$sART10_Counter[1]
	results[49,2] <- Calibration$sART10[2] / Calibration$sART10_Counter[2]
	results[49,3] <- Calibration$sART10[3] / Calibration$sART10_Counter[3]

	##################################################
	#ART11 - Proportion of patients initiating ART after diagnosis, subsequent loss from pre-ART care and returning when already eligible for treatment
	Calibration$sART11;
	#HCT
	results[50,1] <- Calibration$sART11[1] / sum(Calibration$sART1[1:4])
	results[50,2] <- Calibration$sART11[4] / sum(Calibration$sART1[17:20])
	results[50,3] <- Calibration$sART11[7] / sum(Calibration$sART1[33:36])
	#VCT
	results[51,1] <- Calibration$sART11[2] / sum(Calibration$sART1[5:8])
	results[51,2] <- Calibration$sART11[5] / sum(Calibration$sART1[21:24])
	results[51,3] <- Calibration$sART11[8] / sum(Calibration$sART1[37:40])

	#PICT
	results[52,1] <- Calibration$sART11[3] / sum(Calibration$sART1[9:12])
	results[52,2] <- Calibration$sART11[6] / sum(Calibration$sART1[25:28])
	results[52,3] <- Calibration$sART11[9] / sum(Calibration$sART1[41:44])

	##################################################
	#ART12 - Mean time for ppl lost but returned when eligible
	Calibration$sART12;
	Calibration$sART12_Counter;

	results[53,1] <- Calibration$sART12[1] / Calibration$sART12_Counter[1]
	results[53,2] <- Calibration$sART12[2] / Calibration$sART12_Counter[2]
	results[53,3] <- Calibration$sART12[3] / Calibration$sART12_Counter[3]

	##################################################
	#ART13 - Proportion of patients initating ART who had previously been on ART
	Calibration$sART13;

	# THESE VALUES ARE ZERO CURRENTLY AS NOBODY IS COMING BACK ONTO ART #

	#HCT
	results[54,1] <- Calibration$sART13[1] / sum(Calibration$sART1[1:4]) 
	results[54,2] <- Calibration$sART13[4] / sum(Calibration$sART1[17:20]) 
	results[54,3] <- Calibration$sART13[7] / sum(Calibration$sART1[33:36]) 

	#VCT
	results[55,1] <- Calibration$sART13[2] / sum(Calibration$sART1[5:8]) 
	results[55,2] <- Calibration$sART13[5] / sum(Calibration$sART1[21:24]) 
	results[55,3] <- Calibration$sART13[8] / sum(Calibration$sART1[37:40]) 

	#PICT
	results[56,1] <- Calibration$sART13[3] / sum(Calibration$sART1[9:12]) 
	results[56,2] <- Calibration$sART13[6] / sum(Calibration$sART1[25:28]) 
	results[56,3] <- Calibration$sART13[9] / sum(Calibration$sART1[41:44]) 

	##################################################
	#ART14 - Proportion of patients initating who prior to that day had no experience of care
	Calibration$sART14
	#HCT
	results[57,1] <- Calibration$sART14[1] / sum(Calibration$sART1[1:4]) 
	results[57,2] <- Calibration$sART14[4] / sum(Calibration$sART1[17:20]) 
	results[57,3] <- Calibration$sART14[7] / sum(Calibration$sART1[33:36]) 

	#VCT
	results[58,1] <- Calibration$sART14[2] / sum(Calibration$sART1[5:8]) 
	results[58,2] <- Calibration$sART14[5] / sum(Calibration$sART1[21:24]) 
	results[58,3] <- Calibration$sART14[8] / sum(Calibration$sART1[37:40]) 

	#PICT
	results[59,1] <- Calibration$sART14[3] / sum(Calibration$sART1[9:12]) 
	results[59,2] <- Calibration$sART14[6] / sum(Calibration$sART1[25:28]) 
	results[59,3] <- Calibration$sART14[9] / sum(Calibration$sART1[41:44]) 

	##################################################
	##################################################
	# Pre2010
	Calibration$sPre2010
	Calibration$sHivArray[1]

	#PLWHIV_2010_diag / PLWHIV_2010
	results[60,2] <- Calibration$sPre2010[1] / Calibration$sHivArray[1]

	#PLWHIV_2010_diag_vct / PLWHIV_2010_diag
	results[61,2] <- Calibration$sPre2010[2] / Calibration$sPre2010[1]

	#PLWHIV_2010_diag_pict / PLWHIV_2010_diag
	results[62,2] <- Calibration$sPre2010[3] / Calibration$sPre2010[1]

	#####
	#Percentage on ART
	(Calibration$sArtArray[1] / 3) / (Calibration$sHivArray[1] / 3)
	(Calibration$sArtArray[2] / 1) / (Calibration$sHivArray[2] / 1)
	(Calibration$sArtArray[3] / 3.5) / (Calibration$sHivArray[3] / 3.5)

	Calibration$sArtArray[1] / Calibration$sDiagArray[1]
	Calibration$sArtArray[2] / Calibration$sDiagArray[2]
	Calibration$sArtArray[3] / Calibration$sDiagArray[3]

	# % of diagnosed individuals on ART
	results[63,1] <- Calibration$sArtArray[1] / Calibration$sDiagArray[1]
	results[63,2] <- Calibration$sArtArray[2] / Calibration$sDiagArray[2]
	results[63,3] <- Calibration$sArtArray[3] / Calibration$sDiagArray[3]

	#perhaps a bit crude at the moment but will do.
	(Calibration$sArtArray[1] / Calibration$sHivArray[1]) / 3
	(Calibration$sArtArray[2] / Calibration$sHivArray[2]) / 1
	(Calibration$sArtArray[3] / Calibration$sHivArray[3]) / 3.5

	#New ART initiators...
	results[64,1] <- Calibration$sArtArray[1] / 3
	results[64,2] <- Calibration$sArtArray[2] / 1
	results[64,3] <- Calibration$sArtArray[3] / 3.5

	results[65,1] <- NaN
	results[65,2] <- NaN
	results[65,3] <- NaN

	#########################
	#########################
	#########################

	#Previous health care experience of those initiating ART (big table in "FinalDataRequest" document.)
	Calibration$sART14
	#######
	# ALL #
	#######
	#ART14
	results[66,1] <- sum(Calibration$sART14[1:3]) / sum(Calibration$sART1[13:16])
	results[66,2] <- sum(Calibration$sART14[4:6]) / sum(Calibration$sART1[29:32])
	results[66,3] <- sum(Calibration$sART14[7:9]) / sum(Calibration$sART1[45:48])

	#ART5
	results[67,1] <- sum(Calibration$sART5[1:3]) / sum(Calibration$sART1[13:16])
	results[67,2] <- sum(Calibration$sART5[4:6]) / sum(Calibration$sART1[29:32])
	results[67,3] <- sum(Calibration$sART5[7:9]) / sum(Calibration$sART1[45:48])

	#ART9
	results[68,1] <- sum(Calibration$sART9[1:3]) / sum(Calibration$sART1[13:16])
	results[68,2] <- sum(Calibration$sART9[4:6]) / sum(Calibration$sART1[29:32])
	results[68,3] <- sum(Calibration$sART9[7:9]) / sum(Calibration$sART1[45:48])

	#ART11
	results[69,1] <- sum(Calibration$sART11[1:3]) / sum(Calibration$sART1[13:16])
	results[69,2] <- sum(Calibration$sART11[4:6]) / sum(Calibration$sART1[29:32])
	results[69,3] <- sum(Calibration$sART11[7:9]) / sum(Calibration$sART1[45:48])

	#ART13
	results[70,1] <- sum(Calibration$sART13[1:3]) / sum(Calibration$sART1[13:16])
	results[70,2] <- sum(Calibration$sART13[4:6]) / sum(Calibration$sART1[29:32])
	results[70,3] <- sum(Calibration$sART13[7:9]) / sum(Calibration$sART1[45:48])

	# CHECKSUM #
	colSums(results[66:70,])
	# CHECKSUM #

	##################################################
	# PROPORTION ENTERING ART BY ROUTE OF ENTRY #
	ONE <- sum(Calibration$sART1[13:16])
	TWO <- sum(Calibration$sART1[29:32])
	THREE <- sum(Calibration$sART1[45:48])

	# HCT
	results[71,1] <- sum(Calibration$sART1[1:4]) / ONE
	results[71,2] <- sum(Calibration$sART1[17:20]) / TWO
	results[71,3] <- sum(Calibration$sART1[33:36]) / THREE

	# VCT
	results[72,1] <- sum(Calibration$sART1[5:8]) / ONE
	results[72,2] <- sum(Calibration$sART1[21:24]) / TWO
	results[72,3] <- sum(Calibration$sART1[37:40]) / THREE

	# PICT
	results[73,1] <- sum(Calibration$sART1[9:12]) / ONE
	results[73,2] <- sum(Calibration$sART1[25:28]) / TWO
	results[73,3] <- sum(Calibration$sART1[41:44]) / THREE

	#######
	# In 2014, 91% of people in care were on ART.
	results[74,3] <- Calibration$sIn2014[2] / Calibration$sIn2014[1]

	#######
	# Mid 2010, 34% of people were on ART.
	results[75,2] <- Calibration$sMid2010[2] / Calibration$sMid2010[1]

	### PIE CHARTS ###

	# SafetyCheck
	sum(Calibration$sPie_1) / ONE
	sum(Calibration$sPie_2) / TWO
	sum(Calibration$sPie_3) / THREE

	results[76,1] <- Calibration$sPie_1[1] / ONE
	results[77,1] <- Calibration$sPie_1[2] / ONE
	results[78,1] <- Calibration$sPie_1[3] / ONE

	results[76,2] <- Calibration$sPie_2[1] / TWO
	results[77,2] <- Calibration$sPie_2[2] / TWO
	results[78,2] <- Calibration$sPie_2[3] / TWO

	results[79,3] <- Calibration$sPie_3[1] / THREE
	results[80,3] <- Calibration$sPie_3[2] / THREE
	results[81,3] <- Calibration$sPie_3[3] / THREE
	results[82,3] <- Calibration$sPie_3[4] / THREE
	results[83,3] <- Calibration$sPie_3[5] / THREE
	results[84,3] <- Calibration$sPie_3[6] / THREE

	results
	result_output <- formatC(results,digits=4,format="f")
	result_output
	date()
	write.table(results,file="calibrationResults.csv",sep=',')

}

Calibrate()