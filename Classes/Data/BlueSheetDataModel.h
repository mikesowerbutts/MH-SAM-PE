//
//  BlueSheetDataModel.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataModel.h"
#import "WSDataObjectList.h"
#import "WSContactList.h"
#import "WSActionList.h"
#import "BSInfluenceList.h"
#import "BSCriteriaList.h"
#import "BSRedFlagList.h"
#import "BSStrengthList.h"
#import "BSBestInfoList.h"
#import "BSDragObjectList.h"
#import "WSKVPairList.h"
#import "WSDate.h"
#import "WSCurrency.h"
#import "WSBoolean.h"

@class MHFlagButtonController;
@class BlueSheetViewController;


@interface BlueSheetDataModel : WSDataModel {
	BlueSheetViewController *vc;
	WSKVPair *ACP;
	WSDate *date;
	NSString *salesPerson;
	NSString *accountName;
	WSCurrency *currentVolume;
	WSCurrency *potentialVolume;
	NSString *product;
	WSCurrency *revenue;
	WSDate *closeDate;
	WSKVPair *compType;
	NSString *competitors;
	WSKVPair *myPosition;
	WSKVPair *placeInSalesFunnel;
	WSKVPair *timingForPriorities;
	
	WSActionList *actionsList;
	BSCriteriaList *criteriasList;
	BSInfluenceList *influencesList;
	BSRedFlagList *redFlagsList;
	BSStrengthList *strengthsList;
	BSBestInfoList *bestInfosList;
	BSDragObjectList *flagsList;
	WSKVPairList *currencyOptions;
	WSKVPairList *actionStatus;
	WSKVPairList *actionType;
	WSKVPairList *influenceRole;
	WSKVPairList *influenceDegree;
	WSKVPairList *influenceMode;
	WSKVPairList *position;
	WSKVPairList *funnel;
	WSKVPairList *timings;
	WSKVPairList *howWellIsBaseCovered;
	WSKVPairList *competitionTypes;
	WSKVPairList *idealCustomerCriteria;
	WSKVPairList *idealCustomerCriteriaDropList;
	MHFlagButtonController *currFlagController;
    WSBoolean *readOnly;
    WSBoolean *manager;
}
@property(nonatomic, retain)MHFlagButtonController *currFlagController;
@property(nonatomic, assign)BlueSheetViewController *vc;
@property(nonatomic, retain)WSKVPair *ACP;
@property(nonatomic, retain)WSDate *date;
@property(nonatomic, retain)NSString *salesPerson;
@property(nonatomic, retain)NSString *accountName;
@property(nonatomic, retain)WSCurrency *currentVolume;
@property(nonatomic, retain)WSCurrency *potentialVolume;
@property(nonatomic, retain)NSString *product;
@property(nonatomic, retain)WSCurrency *revenue;
@property(nonatomic, retain)WSDate *closeDate;
@property(nonatomic, retain)WSKVPair *compType;
@property(nonatomic, retain)NSString *competitors;
@property(nonatomic, retain)WSKVPair *myPosition;
@property(nonatomic, retain)WSKVPair *placeInSalesFunnel;
@property(nonatomic, retain)WSKVPair *timingForPriorities;

@property(nonatomic, retain)WSActionList *actionsList;
@property(nonatomic, retain)BSCriteriaList *criteriasList;
@property(nonatomic, retain)BSInfluenceList *influencesList;
@property(nonatomic, retain)BSRedFlagList *redFlagsList;
@property(nonatomic, retain)BSStrengthList *strengthsList;
@property(nonatomic, retain)BSBestInfoList *bestInfosList;
@property(nonatomic, retain)BSDragObjectList *flagsList;

@property(nonatomic, retain)WSKVPairList *currencyOptions;
@property(nonatomic, retain)WSKVPairList *actionStatus;
@property(nonatomic, retain)WSKVPairList *actionType;
@property(nonatomic, retain)WSKVPairList *influenceRole;
@property(nonatomic, retain)WSKVPairList *influenceDegree;
@property(nonatomic, retain)WSKVPairList *influenceMode;
@property(nonatomic, retain)WSKVPairList *position;
@property(nonatomic, retain)WSKVPairList *funnel;
@property(nonatomic, retain)WSKVPairList *timings;
@property(nonatomic, retain)WSKVPairList *howWellIsBaseCovered;
@property(nonatomic, retain)WSKVPairList *competitionTypes;
@property(nonatomic, retain)WSKVPairList *idealCustomerCriteria;
@property(nonatomic, retain)WSKVPairList *idealCustomerCriteriaDropList;
@property(nonatomic, retain)WSBoolean *readOnly;
@property(nonatomic, retain)WSBoolean *manager;

-(id)init:(NSString *)filename ID:(NSString *)theID;

-(WSContactList *)getContacts;
-(WSActionList *)getActions;
-(BSInfluenceList *)getInfluences;
-(BSCriteriaList *)getCriterias;
-(BSRedFlagList *)getRedFlags;
-(BSStrengthList *)getStrengths;
-(BSBestInfoList *)getBestInfos;
-(BSDragObjectList *)getFlags;

-(WSKVPairList *)getCurrencyOptions;
-(WSKVPairList *)getActionStatus;
-(WSKVPairList *)getActionType;
-(WSKVPairList *)getInfluenceRole;
-(WSKVPairList *)getInfluenceDegree;
-(WSKVPairList *)getInfluenceMode;
-(WSKVPairList *)getPosition;
-(WSKVPairList *)getFunnel;
-(WSKVPairList *)getTimings;
-(WSKVPairList *)getHowWellIsBaseCovered;
-(WSKVPairList *)getCompetitionType;
-(WSKVPairList *)getIdealCustomerCriteria;
-(void)saveData;
-(void)saveData:(bool)dontNotify;
@end
