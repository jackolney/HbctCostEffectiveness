//
//  interventionUpdate.cpp
//  priorityQ
//
//  Created by Jack Olney on 03/11/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include "interventionUpdate.h"
#include "interventionEvents.h"
#include "cascadeUpdate.h"
#include "cascadeEvents.h"
#include "rng.h"
#include "toolbox.h"

extern Rng * theRng;

using namespace std;

////////////////////
////////////////////

void ScheduleHctHivTest(person * const thePerson, const double theTime, const bool poc, const bool PreArtRetention, const bool ArtRetention, const bool Adherence)
{
	if(thePerson->GetBirthDay() != 0 && theTime >= 16801.5 && theTime < 24106.5) {
		const double diagDay = theRng->SampleExpDist(hctHivTestTime);
		if(diagDay <= 365.25)
			new HctHivTest(thePerson,theTime + diagDay,poc,PreArtRetention,ArtRetention,Adherence);
	}
}

////////////////////
////////////////////

void SchedulePerpetualHctHivTest(person * const thePerson, const double theTime)
{
	if(thePerson->GetBirthDay() != 0 && theTime >= 16801.5 && theTime < 24106.5)
		new HctHivTest(thePerson,theTime + (unif_rand() * 365.25),false,false,false,false);
}

////////////////////
////////////////////

bool HctLinkage(person * const thePerson, const double theTime)
{
	if(thePerson->GetDiagnosisCount() > 1) {
		if(theRng->Sample(hctProbLinkPreviouslyDiagnosed))
			return true;
		else
			return false;
	} else {
		if(theRng->Sample(hctProbLink))
			return true;
		else
			return false;
	}
}

////////////////////
////////////////////

void ScheduleImmediateArt(person * const thePerson, const double theTime)
{
	new ArtInitiation(thePerson,theTime);
}

////////////////////
////////////////////
