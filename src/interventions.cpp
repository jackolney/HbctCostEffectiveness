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
extern int const * p_HbctFrequency;
extern int const * p_Calibration;

/////////////////////
/////////////////////

void SeedInterventions(person * const thePerson)
{
	if(*p_NaiveHbct || *p_HbctNcd || *p_HbctNcdPreArtRetention || *p_HbctNcdRetention || *p_HbctNcdRetentionAdherence || *p_HbctFrequency || *p_Calibration) {
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
					new SeedHct(pPerson,14610 + (i * 1461),false,false,false,false);
	}

	/////////////////////
	/* HbctNcd */

	if(*p_HbctNcd) {

		// Every 4 years
		if(*p_HbctNcd == 1)
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 14610 + (i * 1461))
					new SeedHct(pPerson,14610 + (i * 1461),false,false,false,false);

		pPerson->SetHctNcdCostTrigger(true);
	}

	/////////////////////
	/* HbctNcdPreArtRetention */

	if(*p_HbctNcdPreArtRetention) {

		// Every 4 years
		if(*p_HbctNcdPreArtRetention == 1)
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 14610 + (i * 1461))
					new SeedHct(pPerson,14610 + (i * 1461),false,true,false,false);

		pPerson->SetHctNcdCostTrigger(true);
	}

	/////////////////////
	/* HbctNcdRetention */

	if(*p_HbctNcdRetention) {

		// Every 4 years
		if(*p_HbctNcdRetention == 1)
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 14610 + (i * 1461))
					new SeedHct(pPerson,14610 + (i * 1461),false,true,true,false);

		pPerson->SetHctNcdCostTrigger(true);
	}

	/////////////////////
	/* HbctNcdRetentionAdherence */

	if(*p_HbctNcdRetentionAdherence) {

		// Every 4 years
		if(*p_HbctNcdRetentionAdherence == 1)
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 14610 + (i * 1461))
					new SeedHct(pPerson,14610 + (i * 1461),false,true,true,true);

		pPerson->SetHctNcdCostTrigger(true);
	}

	/////////////////////
	/* HbctFrequency */

	if(*p_HbctFrequency) {
		// Every year
		if(*p_HbctFrequency == 1)
			for(size_t i=0;i<20;i++)
				if(GetTime() <= 14610 + (i * 365.25))
					new SeedHct(pPerson,14610 + (i * 365.25),false,true,true,true);

		// Every 2 years
		if(*p_HbctFrequency == 2)
			for(size_t i=0;i<10;i++)
				if(GetTime() <= 14610 + (i * 730.5))
					new SeedHct(pPerson,14610 + (i * 730.5),false,true,true,true);

		// Every 3 years
		if(*p_HbctFrequency == 3)
			for(size_t i=0;i<7;i++)
				if(GetTime() <= 14610 + (i * 1095.75))
					new SeedHct(pPerson,14610 + (i * 1095.75),false,true,true,true);

		// Every 4 years
		if(*p_HbctFrequency == 4)
			for(size_t i=0;i<5;i++)
				if(GetTime() <= 14610 + (i * 1461))
					new SeedHct(pPerson,14610 + (i * 1461),false,true,true,true);

		// Every 5 years
		if(*p_HbctFrequency == 5)
			for(size_t i=0;i<4;i++)
				if(GetTime() <= 14610 + (i * 1826.25))
					new SeedHct(pPerson,14610 + (i * 1826.25),false,true,true,true);

		// Every 6 years
		if(*p_HbctFrequency == 6)
			for(size_t i=0;i<4;i++)
				if(GetTime() <= 14610 + (i * 2191.5))
					new SeedHct(pPerson,14610 + (i * 2191.5),false,true,true,true);

		// Every 7 years
		if(*p_HbctFrequency == 7)
			for(size_t i=0;i<3;i++)
				if(GetTime() <= 14610 + (i * 2556.75))
					new SeedHct(pPerson,14610 + (i * 2556.75),false,true,true,true);

		// Every 8 years
		if(*p_HbctFrequency == 8)
			for(size_t i=0;i<3;i++)
				if(GetTime() <= 14610 + (i * 2922))
					new SeedHct(pPerson,14610 + (i * 2922),false,true,true,true);

		// Every 10 years
		if(*p_HbctFrequency == 10)
			for(size_t i=0;i<2;i++)
				if(GetTime() <= 14610 + (i * 3652.5))
					new SeedHct(pPerson,14610 + (i * 3652.5),false,true,true,true);

		// 2010
		if(*p_HbctFrequency == 11) {
			const double HbctTime[1] = {0};
			for(size_t i=0;i<1;i++)
				if(GetTime() <= 14610 + HbctTime[i])
					new SeedHct(pPerson,14610 + HbctTime[i],false,true,true,true);
		}

		// 2010, 2011
		if(*p_HbctFrequency == 12) {
			const double HbctTime[2] = {0,365.25};
			for(size_t i=0;i<2;i++)
				if(GetTime() <= 14610 + HbctTime[i])
					new SeedHct(pPerson,14610 + HbctTime[i],false,true,true,true);
		}

		// 2010, 2011, 2014
		if(*p_HbctFrequency == 13) {
			const double HbctTime[3] = {0,365.25,1461};
			for(size_t i=0;i<3;i++)
				if(GetTime() <= 14610 + HbctTime[i])
					new SeedHct(pPerson,14610 + HbctTime[i],false,true,true,true);
		}

		// 2010, 2011, 2014, 2020
		if(*p_HbctFrequency == 14) {
			const double HbctTime[4] = {0,365.25,1461,3652.5};
			for(size_t i=0;i<4;i++)
				if(GetTime() <= 14610 + HbctTime[i])
					new SeedHct(pPerson,14610 + HbctTime[i],false,true,true,true);
		}

		pPerson->SetHctNcdCostTrigger(true);
	}

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
