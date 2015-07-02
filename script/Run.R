#Test Script for CareCascade
setwd("/Users/jack/git/HbctCostEffectiveness")

system("date")
popSize = 1000
dyn.load("./main.so")

Baseline <- .Call("CallCascade",popSize, 
                0, #s_NaiveHbct,
                0, #s_HbctNcd,
                0, #s_HbctNcdPreArtRetention,
                0, #s_HbctNcdRetention,
                0, #s_HbctNcdRetentionAdherence,
                0, #s_HbctFrequency,
                0, #s_Vct,
                0, #s_HbctPocCd4,
                0, #s_Linkage,
                0, #s_PreOutreach,
                0, #s_ImprovedCare,
                0, #s_PocCd4,
                0, #s_VctPocCd4,
                0, #s_ArtOutreach,
                0, #s_ImmediateArt,
                0, #s_UniversalTestAndTreat,
                0, #s_Adherence,
                0 #s_Calibration
                )
