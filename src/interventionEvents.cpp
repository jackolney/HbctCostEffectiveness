//
//  interventionEvents.cpp
//  priorityQ
//
//  Created by Jack Olney on 03/11/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include "toolbox.h"
#include "interventionEvents.h"
#include "interventionUpdate.h"
#include "update.h"
#include "impact.h"
#include "cost.h"
#include "rng.h"
#include "cascadeEvents.h"
#include "cascadeUpdate.h"

using namespace std;

extern Rng * theRng;

/////////////////////
/////////////////////

SeedHct::SeedHct(person * const thePerson, const double Time, const bool poc) :
event(Time),
pPerson(thePerson),
pointOfCare(poc)
{
	if(Time >= thePerson->GetNatDeathDate()) { Cancel(); }
}

SeedHct::~SeedHct()
{}

bool SeedHct::CheckValid()
{
	if(!pPerson->GetEverArt())
		return pPerson->Alive();
	else
		return false;
}

void SeedHct::Execute()
{
	ScheduleHctHivTest(pPerson,GetTime(),pointOfCare);
}

/////////////////////
/////////////////////

SeedPerpetualHct::SeedPerpetualHct(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{
	if(Time >= thePerson->GetNatDeathDate()) { Cancel(); }
}

SeedPerpetualHct::~SeedPerpetualHct()
{}

bool SeedPerpetualHct::CheckValid()
{
	if(!pPerson->GetEverArt())
		return pPerson->Alive();
	else
		return false;
}

void SeedPerpetualHct::Execute()
{
	SchedulePerpetualHctHivTest(pPerson,GetTime());
}

/////////////////////
/////////////////////

HctHivTest::HctHivTest(person * const thePerson, const double Time, const bool poc) :
event(Time),
pPerson(thePerson),
pointOfCare(poc)
{
	thePerson->SetHctHivTestDate(Time);
	if(Time >= thePerson->GetNatDeathDate()) { Cancel(); }
}

HctHivTest::~HctHivTest()
{}

bool HctHivTest::CheckValid()
{
	if(pPerson->GetHctHivTestDate() == GetTime()) //&& !pPerson->GetEverArt()
		return pPerson->Alive();
	else
		return false;
}

void HctHivTest::Execute()
{
	UpdateDaly(pPerson,GetTime());
	ChargeHctVisit(pPerson);
	if(pPerson->GetSeroStatus()) {
		// Testing
		pPerson->SetDiagnosedState(true,1,GetTime());
		if(pointOfCare)
			new HctPocCd4Test(pPerson,GetTime());
		else if(HctLinkage(pPerson,GetTime()))
			ScheduleInitialCd4TestAfterHct(pPerson,GetTime());
		SchedulePictHivTest(pPerson,GetTime());

		pPerson->SetHctRetentionTrigger(true);
		
		// InCare	
		if(pPerson->GetInCareState()) {
			// If scheduled to dropout of PreArt care, cancel it.
			if(pPerson->GetPreArtDropoutDate() > 0) {
				pPerson->SetPreArtDropoutDate(0);
				ScheduleVctHivTest(pPerson,GetTime());
				SchedulePictHivTest(pPerson,GetTime());
			}
		}
		
		
		// Allow hctRetentionTrigger to reduce the probability of loss by 50% across PreART care.
		// If function specific. Functions that it will act upon:
			// ReceiveCd4TestResult();
			// AttendCd4TestResult();
			// SecondaryCd4Test();

		// ART
		pPerson->SetArtAdherenceState(0.975);
		// If ArtDropoutDate set, then cancel it.
		// ScheduleArtDropout (now uses hctRetentionTrigger to reduce times... by a bit. %?)


	}
}

/////////////////////
/////////////////////

HctPocCd4Test::HctPocCd4Test(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{
	if(Time >= thePerson->GetNatDeathDate()) { Cancel(); }
}

HctPocCd4Test::~HctPocCd4Test()
{}

bool HctPocCd4Test::CheckValid()
{
	return pPerson->Alive();
}

void HctPocCd4Test::Execute()
{
	UpdateDaly(pPerson,GetTime());
	ChargePocCd4Test(pPerson);
	pPerson->SetEverCd4TestState(true);
	pPerson->SetEverCd4TestResultState(true);
	if(pPerson->GetEligible())
		ScheduleArtInitiation(pPerson,GetTime());
	else if(HctLinkage(pPerson,GetTime()))
		ScheduleInitialCd4TestAfterHct(pPerson,GetTime());
	SchedulePictHivTest(pPerson,GetTime());
}

/////////////////////
/////////////////////

PreArtOutreach::PreArtOutreach(person * const thePerson, const double Time, const double theProb) :
event(Time),
pPerson(thePerson),
probReturn(theProb)
{
	if(Time >= thePerson->GetNatDeathDate()) { Cancel(); }
}

PreArtOutreach::~PreArtOutreach()
{}

bool PreArtOutreach::CheckValid()
{
	if(pPerson->GetDiagnosedState() && !pPerson->GetInCareState())
		return pPerson->Alive();
	else
		return false;
}

void PreArtOutreach::Execute()
{
	ChargePreArtOutreach(pPerson);
	if(theRng->Sample(probReturn))
		new Cd4Test(pPerson,GetTime());
}

/////////////////////
/////////////////////

VctPocCd4Test::VctPocCd4Test(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{
	if(Time >= thePerson->GetNatDeathDate()) { Cancel(); }
}

VctPocCd4Test::~VctPocCd4Test()
{}

bool VctPocCd4Test::CheckValid()
{
	return pPerson->Alive();
}

void VctPocCd4Test::Execute()
{
	UpdateDaly(pPerson,GetTime());
	ChargePreArtClinicVisit(pPerson);
	pPerson->SetEverCd4TestState(true);
	pPerson->SetEverCd4TestResultState(true);
	pPerson->SetInCareState(true,GetTime());
	if(immediateArtFlag)
		ScheduleImmediateArt(pPerson,GetTime());
	else if(pPerson->GetCurrentWho() > 2 || theRng->Sample(0.05)) {
		ChargePocCd4Test(pPerson);
		FastTrackArt(pPerson,GetTime());
	} else if(pPerson->GetEligible()) {
		ChargePocCd4Test(pPerson);
		ScheduleArtInitiation(pPerson,GetTime());
	} else {
		ChargePocCd4Test(pPerson);
		if(SecondaryCd4Test(pPerson,GetTime()))
			SchedulePreArtCd4Test(pPerson,GetTime());
	}
	SchedulePictHivTest(pPerson,GetTime());
}

/////////////////////
/////////////////////

PocCd4Test::PocCd4Test(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{
	if(Time >= thePerson->GetNatDeathDate()) { Cancel(); }
}

PocCd4Test::~PocCd4Test()
{}

bool PocCd4Test::CheckValid()
{
	return pPerson->Alive();
	
}

void PocCd4Test::Execute() // Update.
{
	UpdateDaly(pPerson,GetTime());
	ChargePreArtClinicVisit(pPerson);
	pPerson->SetEverCd4TestState(true);
	pPerson->SetEverCd4TestResultState(true);
	pPerson->SetInCareState(true,GetTime());
	if(immediateArtFlag)
		ScheduleImmediateArt(pPerson,GetTime());
	else if(pPerson->GetCurrentWho() > 2 || theRng->Sample(0.05)) {
		ChargePocCd4Test(pPerson);
		FastTrackArt(pPerson,GetTime());
	} else if(pPerson->GetEligible()) {
		ChargePocCd4Test(pPerson);
		ScheduleArtInitiation(pPerson,GetTime());
	} else {
		ChargePocCd4Test(pPerson);
		if(SecondaryCd4Test(pPerson,GetTime()))
			SchedulePreArtCd4Test(pPerson,GetTime());
	}
	SchedulePictHivTest(pPerson,GetTime());
}

/////////////////////
/////////////////////

ArtOutreach::ArtOutreach(person * const thePerson, const double Time, const double theProb) :
event(Time),
pPerson(thePerson),
probReturn(theProb)
{
	if(Time >= thePerson->GetNatDeathDate()) { Cancel(); }	
}

ArtOutreach::~ArtOutreach()
{}

bool ArtOutreach::CheckValid()
{
	if(pPerson->GetEverArt() && !pPerson->GetArtInitiationState())
		return pPerson->Alive();
	else
		return false;
}

void ArtOutreach::Execute()
{
	ChargeArtOutreach(pPerson);
	if(pPerson->GetArtCount() < 2 && theRng->Sample(probReturn)) {
		UpdateDaly(pPerson,GetTime());
		pPerson->SetArtInitiationState(true,GetTime());
		ScheduleCd4Update(pPerson,GetTime());
		ScheduleWhoUpdate(pPerson,GetTime());
		ScheduleArtDropout(pPerson,GetTime());
		pPerson->UpdateInfectiousnessArray();
	}
}

/////////////////////
/////////////////////