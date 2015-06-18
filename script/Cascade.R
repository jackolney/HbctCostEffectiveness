Cascade <- function(Pop,Hbct,Vct,HbctPocCd4,Linkage,VctPocCd4,PreOutreach,ImprovedCare,PocCd4,ArtOutreach,Adherence,ImmediateArt,UniversalTestAndTreat) {
	startTime <- proc.time()	
	result <- .Call("CallCascade",
		Pop,  					# Pop;
		Hbct,  					# Hbct; 
		Vct,  					# Vct; 
		HbctPocCd4,  			# HbctPocCd4; 
		Linkage,  				# Linkage;
		VctPocCd4,  			# VctPocCd4; 					      
		PreOutreach,  			# PreOutreach; 
		ImprovedCare,  			# ImprovedCare; 
		PocCd4,	  				# PocCd4; 
		ArtOutreach,  			# ArtOutreach;
		Adherence,   			# Adherence;					      
		ImmediateArt,  			# ImmediateArt; 
		UniversalTestAndTreat  	# UniversalTestAndTreat; 
	)
	endTime <- proc.time() - startTime
	print(endTime)
	flush.console()
	return(result)
}