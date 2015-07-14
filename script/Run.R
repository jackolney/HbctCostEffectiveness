#Test Script for CareCascade
setwd("/Users/jack/git/HbctCostEffectiveness")

system("date")
popSize = 1000
dyn.load("./main.so")

Baseline <- .Call("CallCascade",popSize, 
                0, # s_NaiveHbct,
                0, # s_HbctNcd,
                0, # s_HbctNcdPreArtRetention,
                0, # s_HbctNcdRetention,
                0, # s_HbctNcdRetentionAdherence,
                0, # s_Hbct_2016,
                0, # s_Hbct_2017,
                0, # s_Hbct_2018,
                0, # s_Hbct_2019,
                0, # s_Hbct_2020,
                0, # s_Hbct_2021,
                0, # s_Hbct_2022,
                0, # s_Hbct_2023,
                0, # s_Hbct_2024,
                0, # s_Hbct_2025,
                0, # s_Hbct_2026,
                0, # s_Hbct_2027,
                0, # s_Hbct_2028,
                0, # s_Hbct_2029,
                0, # s_Hbct_2030,
                0, # s_Hbct_2031,
                0, # s_Hbct_2032,
                0, # s_Hbct_2033,
                0, # s_Hbct_2034,
                0, # s_Hbct_2035,
                0, # s_Vct,
                0, # s_HbctPocCd4,
                0, # s_Linkage,
                0, # s_PreOutreach,
                0, # s_ImprovedCare,
                0, # s_PocCd4,
                0, # s_VctPocCd4,
                0, # s_ArtOutreach,
                0, # s_ImmediateArt,
                0, # s_UniversalTestAndTreat,
                0, # s_Adherence,
                0 # s_Calibration
                )

# 90-90-90
Baseline$s909090[2] / Baseline$s909090[1]
Baseline$s909090[3] / Baseline$s909090[2]
Baseline$s909090[4] / Baseline$s909090[3]

# 95-95-95
Baseline$s959595[2] / Baseline$s959595[1]
Baseline$s959595[3] / Baseline$s959595[2]
Baseline$s959595[4] / Baseline$s959595[3]

names(Baseline)

plot(Baseline$sDALY,type='b',lwd=2)
plot(Baseline$sCOST,type='b',lwd=2)

Baseline$sDALY
length(Baseline$sDALY)

Baseline$sCOST
length(Baseline$sCOST)

plot(Baseline$sHIV_15to49 / Baseline$sPOP_15to49,type='b',lwd=2)
plot(Baseline$sINCIDENCE,lwd=2,type='b')
Baseline