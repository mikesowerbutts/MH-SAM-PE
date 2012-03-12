//
//  BlueSheetDataModel.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BlueSheetDataModel.h"
#import "WSXMLObject.h"
#import "BSInfluenceList.h"
#import "BSRedFlagList.h"
#import "BSStrengthList.h"
#import "BSBestInfoList.h"
#import "BSDragObjectList.h"
#import "BSCriteriaList.h"
#import "WSUtils.h"

#import "WSDateFieldController.h"
#import "WSListPickerController.h"
#import "WSTextViewController.h"
#import "WSTextFieldController.h"
#import "WSNumberFieldController.h"
#import "WSCurrencyFieldController.h"
#import "WSTableViewGroupController.h"
#import "Summary_RedFlags_Controller.h"
#import "Summary_Strengths_Controller.h"
#import "BestActionPlan_Controller.h"
#import "InformationNeeded_Controller.h"
#import "PossibleActions_Controller.h"
#import "WSSlider.h"
#import "BSAdequacyOfCPController.h"
#import "BlueSheetViewController.h"


@implementation BlueSheetDataModel
@synthesize ACP, date, salesPerson, accountName, currentVolume, potentialVolume, product, revenue, closeDate, compType, competitors, myPosition, placeInSalesFunnel, timingForPriorities;
@synthesize actionsList, influencesList, criteriasList, redFlagsList, strengthsList, bestInfosList, flagsList, currFlagController;
@synthesize currencyOptions, actionStatus, actionType, influenceRole, influenceDegree, influenceMode, position, funnel, timings, howWellIsBaseCovered, competitionTypes, idealCustomerCriteria, idealCustomerCriteriaDropList, vc, readOnly, manager;
-(id)initWithXML:(WSXMLObject *)theXML ID:(NSString *)theID{
    @try{
        [super initWithXML:theXML ID:theID];
        self.lastSave = [theXML outerXML];
        self.readOnly = [[[WSBoolean alloc] initWithXML:[self.applicationData Get:@"ReadOnly"]] autorelease];
        self.manager = [[[WSBoolean alloc] initWithXML:[self.applicationData Get:@"Manager"]] autorelease];
        self.transManager = [[[WSTranslationManager alloc] initWithContentNode:[[self.applicationData Get:@"ContentData"] retain]] autorelease];
        //Picklists
        self.currencyOptions = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/CurrencyOptions"]] autorelease];
        [self.currencyOptions removeEmpties];
        self.actionStatus = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/ActionStatus"]] autorelease];
        [self.actionStatus removeEmpties];
        self.actionType = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/ActionType"]] autorelease];
        [self.actionType removeEmpties];
        self.influenceRole = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/InfluenceRole"]] autorelease];
        [self.influenceRole removeEmpties];
        self.influenceDegree = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/InfluenceDegree"]] autorelease];
        [self.influenceDegree removeEmpties];
        self.influenceMode = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/InfluenceMode"]] autorelease];
        [self.influenceMode removeEmpties];
        self.position = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/Position"]] autorelease];
        [self.position removeEmpties];
        self.funnel = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/Funnel"]] autorelease];
        [self.funnel removeEmpties];
        self.timings = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/Timings"]] autorelease];
        [self.timings removeEmpties];
        self.howWellIsBaseCovered = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/HowWellIsBaseCovered"]] autorelease];
        [self.howWellIsBaseCovered removeEmpties];
        self.competitionTypes = [[[WSKVPairList alloc] initWithXMLNode:[self.applicationData Get:@"DropListSettings/CompetitionType"]] autorelease];
        [self.competitionTypes removeEmpties];
        self.idealCustomerCriteriaDropList = [[[WSKVPairList alloc] initWithXMLNode:[[[WSDataModelManager instance] getByID:ID].applicationData Get:@"DropListSettings/IdealCustomerCriteria"]] autorelease];
        [self.idealCustomerCriteriaDropList removeEmpties];
        
        //Data
        self.actionsList = [[[WSActionList alloc] init:[[self.fileData Get:@"Actions"] retain] ID:ID] autorelease];
        actionsList.xmlNodeName = [[[NSString alloc] initWithString:@"Actions"] autorelease];
        
        self.influencesList = [[[BSInfluenceList alloc] init:[self.fileData Get:@"Influences"] ID:ID] autorelease];
        self.influencesList.xmlNodeName = [[[NSString alloc] initWithString:@"Influences"] autorelease];
        
        self.criteriasList = [[[BSCriteriaList alloc] init:[self.fileData Get:@"Criterias"] sourceList:self.idealCustomerCriteriaDropList ID:ID] autorelease];
        self.criteriasList.xmlNodeName = [[[NSString alloc] initWithString:@"Criterias"] autorelease];
        
        self.redFlagsList = [[[BSRedFlagList alloc] init:[self.fileData Get:@"RedFlags"] ID:ID] autorelease];
        self.redFlagsList.xmlNodeName = [[[NSString alloc] initWithString:@"RedFlags"] autorelease];
        
        self.strengthsList = [[[BSStrengthList alloc] init:[self.fileData Get:@"Strengths"] ID:ID] autorelease];
        self.strengthsList.xmlNodeName = [[[NSString alloc] initWithString:@"Strengths"] autorelease];
        
        self.bestInfosList = [[[BSBestInfoList alloc] init:[self.fileData Get:@"BestInfos"] ID:ID] autorelease];
        self.bestInfosList.xmlNodeName = [[[NSString alloc] initWithString:@"BestInfos"] autorelease];
        
        self.flagsList = [[[BSDragObjectList alloc] init:[self.fileData Get:@"Flags"] ID:ID] autorelease];
        self.flagsList.xmlNodeName = [[NSString alloc] initWithString:@"Flags"];
        
        self.ACP = [[[WSKVPair alloc] initWithKeyValue:[WSUtils StringFromNode:[self.fileData Get:@"AdequacyCP"]] aValue:[WSUtils StringFromNode:[self.fileData Get:@"AdequacyDescription"]]] autorelease];

        self.date = [[[WSDate alloc] initWithString:[WSUtils StringFromNode:[self.fileData Get:@"OppDate"]] ID:ID] autorelease];
        self.salesPerson = [[[NSString alloc] initWithString:[WSUtils StringFromNode:[self.fileData Get:@"SalesPerson"]]] autorelease];
        self.accountName = [[[NSString alloc] initWithString:[WSUtils StringFromNode:[self.fileData Get:@"Account"]]] autorelease];
        self.currentVolume = [[[WSCurrency alloc] initWithString:[WSUtils StringFromNode:[self.fileData Get:@"CVolume"]] ID:ID] autorelease];
        self.potentialVolume = [[[WSCurrency alloc] initWithString:[WSUtils StringFromNode:[self.fileData Get:@"PVolume"]] ID:ID] autorelease];
        self.product = [[[NSString alloc] initWithString:[WSUtils StringFromNode:[self.fileData Get:@"Product"]]] autorelease];
        self.revenue = [[[WSCurrency alloc] initWithString:[WSUtils StringFromNode:[self.fileData Get:@"SalesUnits"]] ID:ID] autorelease];
        self.closeDate = [[[WSDate alloc] initWithString:[WSUtils StringFromNode:[self.fileData Get:@"CloseDate"]] ID:ID] autorelease];
        self.compType = [self.competitionTypes getPairByKey:[WSUtils StringFromNode:[self.fileData Get:@"CompetitionType"]]];
        self.competitors = [[[NSString alloc] initWithString:[WSUtils StringFromNode:[self.fileData Get:@"Competition"]]] autorelease];
        self.myPosition = [self.position getPairByKey:[WSUtils StringFromNode:[self.fileData Get:@"MyPosition"]]];
        WSKVPair *plinSF = [self.funnel getPairByKey:[WSUtils StringFromNode:[self.fileData Get:@"SalesFunnel"]]];
        self.placeInSalesFunnel = plinSF != nil ? plinSF : [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
        WSKVPair *tiFPri = [self.timings getPairByKey:[WSUtils StringFromNode:[self.fileData Get:@"TimingsFP"]]];
        self.timingForPriorities = tiFPri != nil ? tiFPri : [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
    }
    @catch (NSException *ex) {
        NSLog(@"Error in BlueSheetDataModel: %@", ex.reason);
    }
	return self;
}
-(WSActionList *)getActions{
	return self.actionsList;
}
-(WSContactList *)getContacts{
	return  self.contactsList;
}
-(BSInfluenceList *)getInfluences{
	return self.influencesList;
}
-(BSCriteriaList *)getCriterias{
	return self.criteriasList;
}
-(BSRedFlagList *)getRedFlags{
	return self.redFlagsList;
}
-(BSStrengthList *)getStrengths{
	return self.strengthsList;
}
-(BSBestInfoList *)getBestInfos{
	return self.bestInfosList;
}
-(BSDragObjectList *)getFlags{
	return self.flagsList;
}
-(WSKVPairList *)getCurrencyOptions{
	return self.currencyOptions;
}
-(WSKVPairList *)getActionStatus{
	return self.actionStatus;
}
-(WSKVPairList *)getActionType{
	return self.actionType;
}
-(WSKVPairList *)getInfluenceRole{
	return self.influenceRole;
}
-(WSKVPairList *)getInfluenceDegree{
	return self.influenceDegree;
}
-(WSKVPairList *)getInfluenceMode{
	return self.influenceMode;
}
-(WSKVPairList *)getPosition{
	return self.position;
}
-(WSKVPairList *)getFunnel{
	return self.funnel;
}
-(WSKVPairList *)getTimings{
	return self.timings;
}
-(WSKVPairList *)getHowWellIsBaseCovered{
	return self.howWellIsBaseCovered;
}
-(WSKVPairList *)getCompetitionType{
	return self.competitionTypes;
}
-(WSKVPairList *)getIdealCustomerCriteria{
	return self.idealCustomerCriteria;
}
-(NSString *)createSaveXML{
	NSMutableString *saveXML = [[[NSMutableString alloc] init] autorelease];
	[saveXML appendString:@"<XML>"];
    [applicationData ReplaceChildNode:@"Contacts" replacementNode:[[[WSXMLObject alloc] init:[contactsList serializeObjects]] autorelease]];
	[saveXML appendString:[applicationData outerXML]];
    WSXMLObject *sheetTypeN = [fileData Get:@"SheetType"];
    if(sheetTypeN == nil){
        sheetTypeN = [[WSXMLObject alloc] init:@"<SheetType>BLUE</SheetType>"];
        [fileData AddChild:sheetTypeN];
    }
	[fileData SetNodeValue:@"AdequacyCP" newValue:[WSUtils URLEncode:self.vc.acp_Controller.sliderLoc.key]];
	[fileData SetNodeValue:@"AdecuacyDescription" newValue:[WSUtils URLEncode:self.vc.acp_Controller.sliderLoc.value]];
	[fileData SetNodeValue:@"OppDate" newValue:[WSUtils URLEncode:[self.vc.oppDets_Date_Controller.date getXMLFormattedDate]]];
	[fileData SetNodeValue:@"SalesPerson" newValue:[WSUtils URLEncode:self.vc.oppDets_SalesPerson.text]];
	[fileData SetNodeValue:@"CVolume" newValue:[WSUtils URLEncode:self.vc.oppDets_CurrentVolume_Controller.currency.rawValue]];
	[fileData SetNodeValue:@"PVolume" newValue:[WSUtils URLEncode:self.vc.oppDets_PotentialVolume_Controller.currency.rawValue]];
	[fileData SetNodeValue:@"Product" newValue:[WSUtils URLEncode:self.vc.oppDets_Product.text]];
	[fileData SetNodeValue:@"SalesUnits" newValue:self.vc.oppDets_Revenue_Controller.currency.rawValue];
	[fileData SetNodeValue:@"CloseDate" newValue:[WSUtils URLEncode:[self.vc.oppDets_CloseDate_Controller.date getXMLFormattedDate]]];
	[fileData SetNodeValue:@"CompetitionType" newValue:[WSUtils URLEncode:self.vc.compSalesFunnel_CompType_Controller.value.key]];
	[fileData SetNodeValue:@"Competition" newValue:[WSUtils URLEncode:self.vc.compSalesFunnel_specComps.textView.text]];
	[fileData SetNodeValue:@"MyPosition" newValue:[WSUtils URLEncode:self.vc.compSalesFunnel_myPosVsComp_Controller.value.key]];
	[fileData SetNodeValue:@"SalesFunnel" newValue:[WSUtils URLEncode:self.vc.compSalesFunnel_plInSalesFun_Controller.value.key]];
	[fileData SetNodeValue:@"TimingsFP" newValue:[WSUtils URLEncode:self.vc.compSalesFunnel_timeForPri_Controller.value.key]];
	[fileData SetNodeValue:@"LastModifiedDate" newValue:[WSDate getWSDateNow]];
	[fileData ReplaceChildNode:@"Actions" replacementNode:[[[WSXMLObject alloc] init:[actionsList serializeObjects]] autorelease]];
	[fileData ReplaceChildNode:@"Influences" replacementNode:[[[WSXMLObject alloc] init:[influencesList serializeObjects]] autorelease]];
	[fileData ReplaceChildNode:@"RedFlags" replacementNode:[[[WSXMLObject alloc] init:[redFlagsList serializeObjects]] autorelease]];
	[fileData ReplaceChildNode:@"Strengths" replacementNode:[[[WSXMLObject alloc] init:[strengthsList serializeObjects]] autorelease]];
	[fileData ReplaceChildNode:@"Criterias" replacementNode:[[[WSXMLObject alloc] init:[criteriasList serializeObjects]] autorelease]];
	[fileData ReplaceChildNode:@"BestInfos" replacementNode:[[[WSXMLObject alloc] init:[bestInfosList serializeObjects]] autorelease]];
	[fileData ReplaceChildNode:@"Flags" replacementNode:[[[WSXMLObject alloc] init:[flagsList serializeObjects]] autorelease]];
	[saveXML appendString:[fileData outerXML]];
	[saveXML appendString:@"</XML>"];
	return saveXML;
}
-(void)saveData{
	NSString *saveXML = [self createSaveXML];
	self.lastSave = [[saveXML copy] autorelease];
	WSKVPair *kvp = [[[WSKVPair alloc] initWithKeyEncodedValue:ID aValue:saveXML] autorelease];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"saveOpportunityBlobXML" object:kvp];
}
-(void)saveData:(bool)dontNotify{
	NSString *saveXML = [self createSaveXML];
	self.lastSave = [[saveXML copy] autorelease];
	WSKVPair *kvp = [[[WSKVPair alloc] initWithKeyEncodedValue:ID aValue:saveXML] autorelease];
    if(!dontNotify)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"saveOpportunityBlobXML" object:kvp];
}
-(void)dealloc{
    [super dealloc];
    [ACP release];
    [date release];
    [salesPerson release];
    [accountName release];
    //[currentVolume release];// Causes crash when running 'normally'
    //[potentialVolume release];// Causes crash when running 'normally'
    [product release];
    //[revenue release];// Causes crash when running 'normally'
    [closeDate release];
    [compType release];
    [competitors release];
    [myPosition release];
    [placeInSalesFunnel release];
    [timingForPriorities release];
    [actionsList release];
    [influencesList release];
    [criteriasList release];
    [redFlagsList release];
    [strengthsList release];
    [bestInfosList release];
    [flagsList release];
    [currFlagController release];
    [currencyOptions release];
    [actionStatus release];
    [actionType release];
    [influenceRole release];
    [influenceDegree release];
    [influenceMode release];
    [position release];
    [funnel release];
    [timings release];
    [howWellIsBaseCovered release];
    [competitionTypes release];
    [idealCustomerCriteria release];
    [idealCustomerCriteriaDropList release];
    [readOnly release];
    [manager release];
    [transManager release];
    [lastSave release];
}
@end
