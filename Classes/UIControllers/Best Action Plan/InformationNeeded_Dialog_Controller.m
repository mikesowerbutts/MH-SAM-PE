//
//  InformationNeeded_Dialog_Controller.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 11/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "InformationNeeded_Dialog_Controller.h"
#import "BlueSheetDataModel.h"

@implementation InformationNeeded_Dialog_Controller
@synthesize action, infoNeeded, infoNeeded_Controller, source, source_Controller, assignedTo, assignedTo_Controller, whenAssignedTo, whenAssignedTo_Controller, contact, contact_Controller, whenContact, whenContact_Controller, status, status_Controller, crmActivity, crmActivityController;
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID{
	[super setupDialog:theDataObjID ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	if(theDataObjID != nil){
		BSBestInfo *strTemp = (BSBestInfo *)[bluesheetDataModel.bestInfosList getObjectByID:theDataObjID];
		self.action = [[strTemp copy] autorelease];
	}
	else
		self.action = [[[BSBestInfo alloc] init:theID] autorelease];
	NSString *infoNeededStr = @"";
	NSString *sourceStr = @"";
	WSKVPair *assignedToKVP = [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
	WSDate *whenAssignedToDate = [[[WSDate alloc] initWithString:@"" ID:self.ID] autorelease];
	WSKVPair *contactKVP = [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
	WSDate *whenContactDate = [[[WSDate alloc] initWithString:@"" ID:self.ID] autorelease];
	WSKVPair *statusKVP = [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
    NSString *crmActivityStr = @"false";
	if(action != nil){
		[infoNeededStr release];
		infoNeededStr = action.what;
		[sourceStr release];
		sourceStr = action.sourceDescription;
		
		WSContact *whoCon = (WSContact *)[[[[WSDataModelManager instance] getByID:ID] getContacts] getContactByID:action.whoID];
		assignedToKVP = [[[WSKVPair alloc] initWithKeyValue:whoCon != nil ? whoCon.ID : @"" aValue:whoCon != nil ? whoCon.contactName : @""] autorelease];
		
		whenAssignedToDate = [[action.when copy] autorelease];
		
		WSContact *conCon = (WSContact *)[[[[WSDataModelManager instance] getByID:ID] getContacts] getContactByID:action.ownerID];
		contactKVP = [[[WSKVPair alloc] initWithKeyValue:conCon != nil ? conCon.ID : @"" aValue:conCon != nil ? conCon.contactName : @""] autorelease];
        
		whenContactDate = [[action.completed copy] autorelease];
		
		statusKVP = action.status;
        crmActivityStr = [action.check stringValue];
	}
	if(self.infoNeeded_Controller == nil)
		self.infoNeeded_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:infoNeeded value:infoNeededStr] autorelease];
	else
		self.infoNeeded_Controller.value = infoNeededStr;
	if(self.source_Controller == nil)
		self.source_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:source value:sourceStr] autorelease];
	else
		self.source_Controller.value = sourceStr;
	if(self.assignedTo_Controller == nil)
		self.assignedTo_Controller = [[[WSContactListPickerController alloc] initWithFieldListDataAndValue:assignedTo listData:[[[bluesheetDataModel getContacts] GetInternalContacts] GetKVPairList] value:assignedToKVP multiSelect:NO contactType:@"I"] autorelease];
	else
		self.assignedTo_Controller.value = assignedToKVP;
	if(self.whenAssignedTo_Controller == nil)
		self.whenAssignedTo_Controller = [[[WSDateFieldController alloc] initWithFieldAndDate:whenAssignedTo currentDate:[whenAssignedToDate getXMLFormattedDate]] autorelease];
	else
		self.whenAssignedTo_Controller.date = whenAssignedToDate;
	if(self.contact_Controller == nil)
		self.contact_Controller = [[[WSContactListPickerController alloc] initWithFieldListDataAndValue:contact listData:[[[bluesheetDataModel getContacts] GetExternalContacts] GetKVPairList] value:contactKVP multiSelect:NO contactType:@"E"] autorelease];
	else
		self.contact_Controller.value = contactKVP;
	if(self.whenContact_Controller == nil)
		self.whenContact_Controller = [[[WSDateFieldController alloc] initWithFieldAndDate:whenContact currentDate:[whenContactDate getXMLFormattedDate]] autorelease];
	else
		self.whenContact_Controller.date = whenContactDate;
	if(self.status_Controller == nil)
		self.status_Controller = [[[WSListPickerController alloc] initWithFieldListDataAndValue:status listData:[bluesheetDataModel actionStatus] value:statusKVP multiSelect:NO] autorelease];
	else
		self.status_Controller.value = statusKVP;
    if(self.crmActivityController == nil){
        self.crmActivityController = [[[WSToggleButtonController alloc] initWithButton:self.crmActivity ID:ID] autorelease];
    }
    [self.crmActivityController setChecked:crmActivityStr];
    
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
        BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
        if([[crmActivityController getStringValue] isEqualToString:@"true"])
            action.ID = [NSString stringWithFormat:@"NEWTASK%@", action.ID];
		action.what = infoNeeded.textView.text;
		action.sourceDescription = source.textView.text;
		action.whoID = [assignedTo_Controller.selectedPairs.items count] > 0 ? [[assignedTo_Controller.selectedPairs.items objectAtIndex:0] key] : action.whoID;
		action.when = whenAssignedTo_Controller.date;
        //[contact_Controller.selectedPairs describe];
		action.ownerID = [contact_Controller.selectedPairs.items count] > 0 ? [[contact_Controller.selectedPairs.items objectAtIndex:0] key] : action.ownerID;
		action.completed = whenContact_Controller.date;
		action.status = ([status_Controller.selectedPairs.items count] > 0 ? [status_Controller.selectedPairs.items objectAtIndex:0] : [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease]);
        action.check = [[WSBoolean alloc] initWithString:[NSString stringWithFormat:@"%i", self.crmActivityController.state]];
		[bluesheetDataModel updateObjectList:bluesheetDataModel.bestInfosList updatedObject:action notificationType:@"BestInfo"];
        if([[crmActivityController getStringValue] isEqualToString:@"false"] && [action.ID rangeOfString:@"NEWTASK"].location != NSNotFound){
            action.ID = [action.ID stringByReplacingOccurrencesOfString:@"NEWTASK" withString:@""];
            [bluesheetDataModel updateObjectList:bluesheetDataModel.bestInfosList updatedObject:action notificationType:@"BestInfo"];
        }
	}
	[super isClosing:mode];
	return YES;
}
-(void)dealloc{
	[super dealloc];
	[action release];
	[infoNeeded release];
	[infoNeeded_Controller release];
	[source release];
	[source_Controller release];
	[assignedTo release];
	[assignedTo_Controller release];
	[whenAssignedTo release];
	[whenAssignedTo_Controller release];
	[contact release];
	[contact_Controller release];
	[whenContact release];
	[whenContact_Controller release];
	[status release];
	[status_Controller release];
}
@end
