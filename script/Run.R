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

# 90-90-90
Baseline$s909090[2] / Baseline$s909090[1]
Baseline$s909090[3] / Baseline$s909090[2]
Baseline$s909090[4] / Baseline$s909090[3]

# 95-95-95
Baseline$s959595[2] / Baseline$s959595[1]
Baseline$s959595[3] / Baseline$s959595[2]
Baseline$s959595[4] / Baseline$s959595[3]