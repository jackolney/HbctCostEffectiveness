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
extern int const * p_HbctNcdPreArtRetention;
extern int const * p_HbctNcdRetention;
extern int const * p_HbctNcdRetentionAdherence;
extern int const * p_Hbct_2016;
extern int const * p_Hbct_2017;
extern int const * p_Hbct_2018;
extern int const * p_Hbct_2019;
extern int const * p_Hbct_2020;
extern int const * p_Hbct_2021;
extern int const * p_Hbct_2022;
extern int const * p_Hbct_2023;
extern int const * p_Hbct_2024;
extern int const * p_Hbct_2025;
extern int const * p_Hbct_2026;
extern int const * p_Hbct_2027;
extern int const * p_Hbct_2028;
extern int const * p_Hbct_2029;
extern int const * p_Hbct_2030;
extern int const * p_Hbct_2031;
extern int const * p_Hbct_2032;
extern int const * p_Hbct_2033;
extern int const * p_Hbct_2034;
extern int const * p_Hbct_2035;
extern int const * p_Vct;
extern int const * p_HbctPocCd4;
extern int const * p_Linkage;
extern int const * p_PreOutreach;
extern int const * p_ImprovedCare;
extern int const * p_PocCd4;
extern int const * p_VctPocCd4;
extern int const * p_ArtOutreach;
extern int const * p_ImmediateArt;
extern int const * p_UniversalTestAndTreat;
extern int const * p_Adherence;
extern int const * p_Calibration;

/////////////////////
/////////////////////

void SeedInterventions(person * const thePerson)
{
	if(*p_NaiveHbct || *p_HbctNcd || *p_HbctNcdPreArtRetention || *p_HbctNcdRetention || *p_HbctNcdRetentionAdherence || *p_Hbct_2016 || *p_Hbct_2017 || *p_Hbct_2018 || *p_Hbct_2019 || *p_Hbct_2020 || *p_Hbct_2021 || *p_Hbct_2022 || *p_Hbct_2023 || *p_Hbct_2024 || *p_Hbct_2025 || *p_Hbct_2026 || *p_Hbct_2027 || *p_Hbct_2028 || *p_Hbct_2029 || *p_Hbct_2030 || *p_Hbct_2031 || *p_Hbct_2032 || *p_Hbct_2033 || *p_Hbct_2034 || *p_Hbct_2035 || *p_Vct || *p_HbctPocCd4 || *p_Linkage || *p_PreOutreach || *p_ImprovedCare || *p_PocCd4 || *p_VctPocCd4 || *p_ArtOutreach || *p_ImmediateArt || *p_UniversalTestAndTreat || *p_Adherence || *p_Calibration) {
		if(thePerson->GetBirthDay() < 16801.5)
			new Interventions(thePerson,16801.5);
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
				if(GetTime() <= 16801.5 + (i * 1461))
					new SeedHct(pPerson,16801.5 + (i * 1461),false,false,false,false);
	}

	/////////////////////
	/* HbctNcd */

	if(*p_HbctNcd) {

		// Every 4 years
		if(*p_HbctNcd == 1)
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 16801.5 + (i * 1461))
					new SeedHct(pPerson,16801.5 + (i * 1461),false,false,false,false);

		pPerson->SetHctNcdCostTrigger(true);
	}

	/////////////////////
	/* HbctNcdPreArtRetention */

	if(*p_HbctNcdPreArtRetention) {

		// Every 4 years
		if(*p_HbctNcdPreArtRetention == 1)
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 16801.5 + (i * 1461))
					new SeedHct(pPerson,16801.5 + (i * 1461),false,true,false,false);

		pPerson->SetHctNcdCostTrigger(true);
	}

	/////////////////////
	/* HbctNcdRetention */

	if(*p_HbctNcdRetention) {

		// Every 4 years
		if(*p_HbctNcdRetention == 1)
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 16801.5 + (i * 1461))
					new SeedHct(pPerson,16801.5 + (i * 1461),false,true,true,false);

		pPerson->SetHctNcdCostTrigger(true);
	}

	/////////////////////
	/* HbctNcdRetentionAdherence */

	if(*p_HbctNcdRetentionAdherence) {

		// Every 4 years
		if(*p_HbctNcdRetentionAdherence == 1)
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 16801.5 + (i * 1461))
					new SeedHct(pPerson,16801.5 + (i * 1461),false,true,true,true);

		pPerson->SetHctNcdCostTrigger(true);
	}

	/////////////////////
	/* HbctFrequency */
	/* Simulations run from 2016 all the way through to 2035 */


	// 2016
	if(*p_Hbct_2016 == 1) {
		if(GetTime() <= 16801.5)
			new SeedHct(pPerson,16801.5,false,false,false,false);
	}

	// 2017
	if(*p_Hbct_2017 == 1) {
		if(GetTime() <= 16801.5 + (1 * 365.25))
			new SeedHct(pPerson,16801.5 + (1 * 365.25),false,false,false,false);
	}
	
	// 2018
	if(*p_Hbct_2018 == 1) {
		if(GetTime() <= 16801.5 + (2 * 365.25))
			new SeedHct(pPerson,16801.5 + (2 * 365.25),false,false,false,false);
	}
	
	// 2019
	if(*p_Hbct_2019 == 1) {
		if(GetTime() <= 16801.5 + (3 * 365.25))
			new SeedHct(pPerson,16801.5 + (3 * 365.25),false,false,false,false);
	}

	// 2020
	if(*p_Hbct_2020 == 1) {
		if(GetTime() <= 16801.5 + (4 * 365.25))
			new SeedHct(pPerson,16801.5 + (4 * 365.25),false,false,false,false);
	}

	// 2021
	if(*p_Hbct_2021 == 1) {
		if(GetTime() <= 16801.5 + (5 * 365.25))
			new SeedHct(pPerson,16801.5 + (5 * 365.25),false,false,false,false);
	}

	// 2022
	if(*p_Hbct_2022 == 1) {
		if(GetTime() <= 16801.5 + (6 * 365.25))
			new SeedHct(pPerson,16801.5 + (6 * 365.25),false,false,false,false);
	}
	
	// 2023
	if(*p_Hbct_2023 == 1) {
		if(GetTime() <= 16801.5 + (7 * 365.25))
			new SeedHct(pPerson,16801.5 + (7 * 365.25),false,false,false,false);
	}
	
	// 2024
	if(*p_Hbct_2024 == 1) {
		if(GetTime() <= 16801.5 + (8 * 365.25))
			new SeedHct(pPerson,16801.5 + (8 * 365.25),false,false,false,false);
	}
	
	// 2025
	if(*p_Hbct_2025 == 1) {
		if(GetTime() <= 16801.5 + (9 * 365.25))
			new SeedHct(pPerson,16801.5 + (9 * 365.25),false,false,false,false);
	}
	
	// 2026
	if(*p_Hbct_2026 == 1) {
		if(GetTime() <= 16801.5 + (10 * 365.25))
			new SeedHct(pPerson,16801.5 + (10 * 365.25),false,false,false,false);
	}
	
	// 2027
	if(*p_Hbct_2027 == 1) {
		if(GetTime() <= 16801.5 + (11 * 365.25))
			new SeedHct(pPerson,16801.5 + (11 * 365.25),false,false,false,false);
	}
	
	// 2028
	if(*p_Hbct_2028 == 1) {
		if(GetTime() <= 16801.5 + (12 * 365.25))
			new SeedHct(pPerson,16801.5 + (12 * 365.25),false,false,false,false);
	}
	
	// 2029
	if(*p_Hbct_2029 == 1) {
		if(GetTime() <= 16801.5 + (13 * 365.25))
			new SeedHct(pPerson,16801.5 + (13 * 365.25),false,false,false,false);
	}
	
	// 2030
	if(*p_Hbct_2030 == 1) {
		if(GetTime() <= 16801.5 + (14 * 365.25))
			new SeedHct(pPerson,16801.5 + (14 * 365.25),false,false,false,false);
	}
	
	// 2031
	if(*p_Hbct_2031 == 1) {
		if(GetTime() <= 16801.5 + (15 * 365.25))
			new SeedHct(pPerson,16801.5 + (15 * 365.25),false,false,false,false);
	}
	
	// 2032
	if(*p_Hbct_2032 == 1) {
		if(GetTime() <= 16801.5 + (16 * 365.25))
			new SeedHct(pPerson,16801.5 + (16 * 365.25),false,false,false,false);
	}
	
	// 2033
	if(*p_Hbct_2033 == 1) {
		if(GetTime() <= 16801.5 + (17 * 365.25))
			new SeedHct(pPerson,16801.5 + (17 * 365.25),false,false,false,false);
	}
	
	// 2034
	if(*p_Hbct_2034 == 1) {
		if(GetTime() <= 16801.5 + (18 * 365.25))
			new SeedHct(pPerson,16801.5 + (18 * 365.25),false,false,false,false);
	}
	
	// 2035
	if(*p_Hbct_2035 == 1) {
		if(GetTime() <= 16801.5 + (19 * 365.25))
			new SeedHct(pPerson,16801.5 + (19 * 365.25),false,false,false,false);
	}

	/////////////////////
	/* Vct */
	
	if(*p_Vct) {
		if(*p_Vct == 1)
			vctHivTestTime = vctHivTestTimeOriginal * 0.5;
		else
			vctHivTestTime = vctHivTestTimeOriginal * (1/1.25);
		D(cout << "VctHivTest Intervention. vctHivTestTime = " << vctHivTestTime << endl);
		ScheduleVctHivTest(pPerson,GetTime());
	}
	
	/////////////////////
	/* HbctPocCd4 */
	
	if(*p_HbctPocCd4) {
		D(cout << "HbctPocCd4 Intervention." << endl);
		for(size_t i=0;i<5;i++)
			if(GetTime() <= 16801.5 + (i * 1461))
				new SeedHct(pPerson,16801.5 + (i * 1461),true,false,false,false);
		
		if(*p_HbctPocCd4 == 1) {
			hctProbLink = 1;
			hctProbLinkPreviouslyDiagnosed = 1;
		} else {
			hctProbLink = ((1-hctProbLinkOriginal) * 0.5) + hctProbLinkOriginal;
			hctProbLinkPreviouslyDiagnosed = ((1-hctProbLinkPreviouslyDiagnosedOriginal) * 0.5) + hctProbLinkPreviouslyDiagnosedOriginal;
		}
	}
	
	/////////////////////
	/* Linkage */
	
	if(*p_Linkage) {
		D(cout << "Linkage intervention." << endl);
		if(*p_Linkage == 1) {
			hctProbLink = 1;
			hctProbLinkPreviouslyDiagnosed = 1;
			vctProbLink = 1;
			pictProbLink = 1;
		} else {
			hctProbLink = ((1-hctProbLinkOriginal) * 0.5) + hctProbLinkOriginal;
			hctProbLinkPreviouslyDiagnosed = ((1-hctProbLinkPreviouslyDiagnosedOriginal) * 0.5) + hctProbLinkPreviouslyDiagnosedOriginal;
			vctProbLink = ((1-vctProbLinkOriginal) * 0.5) + vctProbLinkOriginal;
			pictProbLink = ((1-pictProbLinkOriginal) * 0.5) + pictProbLinkOriginal;
		}
	}
	
	/////////////////////
	/* PreOutreach */
	
	if(*p_PreOutreach) {
		double k = 0;
		if(*p_PreOutreach == 1) { k = 1; } else { k = 0.2; }
		
		for(size_t i=0;i<20;i++)
			if(GetTime() <= 16984.125 + (i * 365.25))
				new PreArtOutreach(pPerson,16984.125 + (i * 365.25),k);
	}
	
	/////////////////////
	/* ImprovedCare */
	
	if(*p_ImprovedCare) {
		D(cout << "ImprovedCare intervention." << endl);
		if(*p_ImprovedCare == 1) {
			cd4ResultProbAttend = 1;
			hctShortTermRetention = 1;
			hctLongTermRetention = 1;
			vctShortTermRetention = 1;
			vctLongTermRetention = 1;
			pictShortTermRetention = 1;
			pictLongTermRetention = 1;
			hctProbSecondaryCd4Test = 1;
			vctProbSecondaryCd4Test = 1;
			pictProbSecondaryCd4Test = 1;
		} else {
			cd4ResultProbAttend = 0.9743416;
			hctShortTermRetention = 0.9743416;
			hctLongTermRetention = 0.9743416;
			vctShortTermRetention = 0.9743416;
			vctLongTermRetention = 0.9743416;
			pictShortTermRetention = 0.9743416;
			pictLongTermRetention = 0.9743416;
			hctProbSecondaryCd4Test = 0.875;
			vctProbSecondaryCd4Test = 0.875;
			pictProbSecondaryCd4Test = 0.875;
		}
	}
	
	/////////////////////
	/* PocCd4 */
	
	if(*p_PocCd4)
		pocFlag = true;
	
	/////////////////////
	/* VctPocCd4 */
	
	if(*p_VctPocCd4) {
		vctPocFlag = true;
		ScheduleVctHivTest(pPerson,GetTime());
	}
	
	/////////////////////
	/* ArtOutreach */
	
	if(*p_ArtOutreach) {
		double k = 0;
		if(*p_ArtOutreach == 1) { k = 1; } else { k = 0.4; }
		
		for(size_t i=0;i<20;i++)
			if(GetTime() <= 16984.125 + (i * 365.25))
				new ArtOutreach(pPerson,16984.125 + (i * 365.25),k);
	}
	
	/////////////////////
	/* ImmediateArt */
	
	if(*p_ImmediateArt) {
		D(cout << "ImmediateArt intervention." << endl);
		immediateArtFlag = true;
		UpdateTreatmentGuidelines(pPerson,4,1);
	}
	
	/////////////////////
	/* UniversalTestAndTreat */
	
	if(*p_UniversalTestAndTreat) {
		D(cout << "UniversalTestAndTreat intervention." << endl);
		immediateArtFlag = true;
		UpdateTreatmentGuidelines(pPerson,4,1);
		
		for(size_t i=0;i<5;i++)
			if(GetTime() <= 16801.5 + (i * 1461))
				new SeedHct(pPerson,16801.5 + (i * 1461),false,false,false,false);
		
		if(*p_UniversalTestAndTreat == 1) {
			hctProbLink = 1;
			hctProbLinkPreviouslyDiagnosed = 1;
		}
	}
	
	/////////////////////
	/* Adherence */
	
	if(*p_Adherence) {
		D(cout << "Adherence intervention." << endl);
		adherenceFlag = true;
		if(*p_Adherence == 1)
			pPerson->SetArtAdherenceState(1);
		else
			pPerson->SetArtAdherenceState(0.975);
	}

	/////////////////////
	/* Calibration */

	if(*p_Calibration) {
		for(size_t i=0;i<20;i++)
			if(GetTime() <= 16801.5 + (i * 365.25))
				new SeedPerpetualHct(pPerson, 16801.5 + (i * 365.25));
	}

	/////////////////////

}

/////////////////////
/////////////////////
