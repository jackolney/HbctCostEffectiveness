//
//  interventions.cpp
//  priorityQ
//
//  Created by Jack Olney on 31/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include "macro.h"
#include "interventions.h"
#include "interventionUpdate.h"
#include "interventionEvents.h"
#include "cascadeEvents.h"
#include "cascadeUpdate.h"
#include "toolbox.h"

using namespace std;

/* Intervention Pointers */
extern int const * p_NaiveHbct; 
extern int const * p_HbctNcd; 
extern int const * p_HbctNcdRetention; 
extern int const * p_HbctFrequency; 
extern int const * p_Calibration;

/////////////////////
/////////////////////

void SeedInterventions(person * const thePerson)
{
	if(*p_NaiveHbct || *p_HbctNcd || *p_HbctNcdRetention || *p_HbctFrequency || *p_Calibration) {
		if(thePerson->GetBirthDay() < 14610)
			new Interventions(thePerson,14610);
		else
			new Interventions(thePerson,thePerson->GetBirthDay());
	}
}

/////////////////////
/////////////////////

Interventions::Interventions(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{
	D(cout << "Interventions scheduled for " << Time << " (year = " << Time / 365.25 << ")" << endl);
	if(Time >= thePerson->GetNatDeathDate()) { Cancel(); }	
}

Interventions::~Interventions()
{}

bool Interventions::CheckValid()
{
	return pPerson->Alive();
}

void Interventions::Execute()
{
	
	/////////////////////
	/////////////////////
	/* NaiveHbct */
	
	if(*p_NaiveHbct) {
		// Intervention Frequency //
		// Every 4 years
		if(*p_NaiveHbct == 1) 
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 14610 + (i * 1461))
					new SeedHct(pPerson,14610 + (i * 1461),false);

		hctProbLink = 1;
		hctProbLinkPreviouslyDiagnosed = 1;
	}

	/////////////////////
	/* HbctNcd */

	if(*p_HbctNcd) {

		// Every 4 years
		if(*p_HbctNcd == 1) 
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 14610 + (i * 1461))
					new SeedHct(pPerson,14610 + (i * 1461),false);

		pPerson->SetHctNcdCostTrigger(true);

		hctProbLink = 1;
		hctProbLinkPreviouslyDiagnosed = 1;
	}
	
	/////////////////////
	/* HbctNcdRetention */

	if(*p_HbctNcdRetention) {

		// Every 4 years
		if(*p_HbctNcdRetention == 1) 
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 14610 + (i * 1461))
					new SeedHct(pPerson,14610 + (i * 1461),false);

		// Trigger for retention behaviour ... how?

		// Things to impact:
				// - Pre-ART retention
					// Alter retention rate calculation... include a factor on ALL people... make it 1 in these people?
				// - ART retention
					// reset retention? Almost need retention rates to be calculated off of something else?
				// - ART Adherence

		pPerson->SetHctNcdCostTrigger(true);
		
		hctProbLink = 1;
		hctProbLinkPreviouslyDiagnosed = 1;
	}


	/////////////////////
	/////////////////////
	/////////////////////
	/////////////////////
	/////////////////////
	/* NaiveHbct */
	
	// if(*p_Hbct) {
	// 	// Every year
	// 	if(*p_Hbct == 1) 
	// 		for(size_t i=0;i<20;i++)
	// 			if(GetTime() <= 14610 + (i * 365.25))
	// 				new SeedHct(pPerson,14610 + (i * 365.25),false);

	// 	// Every 2 years
	// 	if(*p_Hbct == 2) 
	// 		for(size_t i=0;i<10;i++)
	// 			if(GetTime() <= 14610 + (i * 730.5))
	// 				new SeedHct(pPerson,14610 + (i * 730.5),false);

	// 	// Every 3 years
	// 	if(*p_Hbct == 3) 
	// 		for(size_t i=0;i<7;i++)
	// 			if(GetTime() <= 14610 + (i * 1095.75))
	// 				new SeedHct(pPerson,14610 + (i * 1095.75),false);

	// 	// Every 4 years
	// 	if(*p_Hbct == 4) 
	// 		for(size_t i=0;i<5;i++)
	// 			if(GetTime() <= 14610 + (i * 1461))
	// 				new SeedHct(pPerson,14610 + (i * 1461),false);

	// 	// Every 5 years
	// 	if(*p_Hbct == 5) 
	// 		for(size_t i=0;i<4;i++)
	// 			if(GetTime() <= 14610 + (i * 1826.25))
	// 				new SeedHct(pPerson,14610 + (i * 1826.25),false);

	// 	// Every 6 years
	// 	if(*p_Hbct == 6) 
	// 		for(size_t i=0;i<4;i++)
	// 			if(GetTime() <= 14610 + (i * 2191.5))
	// 				new SeedHct(pPerson,14610 + (i * 2191.5),false);

	// 	// Every 7 years
	// 	if(*p_Hbct == 7) 
	// 		for(size_t i=0;i<3;i++)
	// 			if(GetTime() <= 14610 + (i * 2556.75))
	// 				new SeedHct(pPerson,14610 + (i * 2556.75),false);

	// 	// Every 8 years
	// 	if(*p_Hbct == 8) 
	// 		for(size_t i=0;i<3;i++)
	// 			if(GetTime() <= 14610 + (i * 2922))
	// 				new SeedHct(pPerson,14610 + (i * 2922),false);

	// 	// Every 10 years
	// 	if(*p_Hbct == 10) 
	// 		for(size_t i=0;i<2;i++)
	// 			if(GetTime() <= 14610 + (i * 3652.5))
	// 				new SeedHct(pPerson,14610 + (i * 3652.5),false);

	// 	hctProbLink = 1;
	// 	hctProbLinkPreviouslyDiagnosed = 1;
	// }

	// /* Vct */
	
	// if(*p_Vct) {
	// 	if(*p_Vct == 1)
	// 		vctHivTestTime = vctHivTestTimeOriginal * 0.5;
	// 	else
	// 		vctHivTestTime = vctHivTestTimeOriginal * (1/1.25);
	// 	D(cout << "VctHivTest Intervention. vctHivTestTime = " << vctHivTestTime << endl);
	// 	ScheduleVctHivTest(pPerson,GetTime());
	// }
	
	// /////////////////////
	// /* HbctPocCd4 */
	
	// if(*p_HbctPocCd4) {
	// 	D(cout << "HbctPocCd4 Intervention." << endl);
	// 	for(size_t i=0;i<5;i++)
	// 		if(GetTime() <= 14610 + (i * 1461))
	// 			new SeedHct(pPerson,14610 + (i * 1461),true);
		
	// 	if(*p_HbctPocCd4 == 1) {
	// 		hctProbLink = 1;
	// 		hctProbLinkPreviouslyDiagnosed = 1;
	// 	} else {
	// 		hctProbLink = ((1-hctProbLinkOriginal) * 0.5) + hctProbLinkOriginal;
	// 		hctProbLinkPreviouslyDiagnosed = ((1-hctProbLinkPreviouslyDiagnosedOriginal) * 0.5) + hctProbLinkPreviouslyDiagnosedOriginal;
	// 	}
	// }
	
	// /////////////////////
	// /* Linkage */
	
	// if(*p_Linkage) {
	// 	D(cout << "Linkage intervention." << endl);
	// 	if(*p_Linkage == 1) {
	// 		hctProbLink = 1;
	// 		hctProbLinkPreviouslyDiagnosed = 1;
	// 		vctProbLink = 1;
	// 		pictProbLink = 1;
	// 	} else {
	// 		hctProbLink = ((1-hctProbLinkOriginal) * 0.5) + hctProbLinkOriginal;
	// 		hctProbLinkPreviouslyDiagnosed = ((1-hctProbLinkPreviouslyDiagnosedOriginal) * 0.5) + hctProbLinkPreviouslyDiagnosedOriginal;
	// 		vctProbLink = ((1-vctProbLinkOriginal) * 0.5) + vctProbLinkOriginal;
	// 		pictProbLink = ((1-pictProbLinkOriginal) * 0.5) + pictProbLinkOriginal;
	// 	}
	// }
	
	// /////////////////////
	// /* PreOutreach */
	
	// if(*p_PreOutreach) {
	// 	double k = 0;
	// 	if(*p_PreOutreach == 1) { k = 1; } else { k = 0.2; }
		
	// 	for(size_t i=0;i<20;i++)
	// 		if(GetTime() <= 14792.625 + (i * 365.25))
	// 			new PreArtOutreach(pPerson,14792.625 + (i * 365.25),k);
	// }
	
	// /////////////////////
	// /* ImprovedCare */
	
	// if(*p_ImprovedCare) {
	// 	D(cout << "ImprovedCare intervention." << endl);
	// 	if(*p_ImprovedCare == 1) {
	// 		cd4ResultProbAttend = 1;
	// 		hctShortTermRetention = 1;
	// 		hctLongTermRetention = 1;
	// 		vctShortTermRetention = 1;
	// 		vctLongTermRetention = 1;
	// 		pictShortTermRetention = 1;
	// 		pictLongTermRetention = 1;
	// 		hctProbSecondaryCd4Test = 1;
	// 		vctProbSecondaryCd4Test = 1;
	// 		pictProbSecondaryCd4Test = 1;
	// 	} else {
	// 		cd4ResultProbAttend = 0.9743416;
	// 		hctShortTermRetention = 0.9743416;
	// 		hctLongTermRetention = 0.9743416;
	// 		vctShortTermRetention = 0.9743416;
	// 		vctLongTermRetention = 0.9743416;
	// 		pictShortTermRetention = 0.9743416;
	// 		pictLongTermRetention = 0.9743416;
	// 		hctProbSecondaryCd4Test = 0.875;
	// 		vctProbSecondaryCd4Test = 0.875;
	// 		pictProbSecondaryCd4Test = 0.875;
	// 	}
	// }
	
	// /////////////////////
	// /* PocCd4 */
	
	// if(*p_PocCd4)
	// 	pocFlag = true;
	
	// /////////////////////
	// /* VctPocCd4 */
	
	// if(*p_VctPocCd4) {
	// 	vctPocFlag = true;
	// 	ScheduleVctHivTest(pPerson,GetTime());
	// }
	
	// /////////////////////
	// /* ArtOutreach */
	
	// if(*p_ArtOutreach) {
	// 	double k = 0;
	// 	if(*p_ArtOutreach == 1) { k = 1; } else { k = 0.4; }
		
	// 	for(size_t i=0;i<20;i++)
	// 		if(GetTime() <= 14792.625 + (i * 365.25))
	// 			new ArtOutreach(pPerson,14792.625 + (i * 365.25),k);
	// }
	
	// /////////////////////
	// /* ImmediateArt */
	
	// if(*p_ImmediateArt) {
	// 	D(cout << "ImmediateArt intervention." << endl);
	// 	immediateArtFlag = true;
	// 	UpdateTreatmentGuidelines(pPerson,4,1);
	// }
	
	// /////////////////////
	// /* UniversalTestAndTreat */
	
	// if(*p_UniversalTestAndTreat) {
	// 	D(cout << "UniversalTestAndTreat intervention." << endl);
	// 	immediateArtFlag = true;
	// 	UpdateTreatmentGuidelines(pPerson,4,1);
		
	// 	for(size_t i=0;i<5;i++)
	// 		if(GetTime() <= 14610 + (i * 1461))
	// 			new SeedHct(pPerson,14610 + (i * 1461),false);
		
	// 	if(*p_UniversalTestAndTreat == 1) {
	// 		hctProbLink = 1;
	// 		hctProbLinkPreviouslyDiagnosed = 1;
	// 	}
	// }
	
	// /////////////////////
	// /* Adherence */
	
	// if(*p_Adherence) {
	// 	D(cout << "Adherence intervention." << endl);
	// 	adherenceFlag = true;
	// 	if(*p_Adherence == 1)
	// 		pPerson->SetArtAdherenceState(1);
	// 	else
	// 		pPerson->SetArtAdherenceState(0.975);
	// }
	
	/////////////////////
	/* Calibration */
	
	if(*p_Calibration) {
		for(size_t i=0;i<20;i++)
			if(GetTime() <= 14610 + (i * 365.25))
				new SeedPerpetualHct(pPerson, 14610 + (i * 365.25));
	}
	
	/////////////////////
	
}

/////////////////////
/////////////////////
