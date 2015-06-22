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

		// All control and changes to the system are driven by the HCT event.

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
