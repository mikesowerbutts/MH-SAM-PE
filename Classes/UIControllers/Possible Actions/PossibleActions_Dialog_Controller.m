    //
//  PossibleActions_Dialog.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 21/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "PossibleActions_Dialog_Controller.h"
#import "BlueSheetDataModel.h"
#import "WSBoolean.h"

@implementation PossibleActions_Dialog_Controller
@synthesize description, description_Controller, contact, contact_Controller, when, when_Controller, assignedTo, assignedTo_Controller, completed, completed_Controller, status, status_Controller, type, type_Controller, bestAction, bestAction_Controller, action;
-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:(NSString *)theID{
	[super initWithXIBAndIDDontShow:theNibName mainView:theDispView ID:theID];
	return self;
}
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID{
	[super setupDialog:theDataObjID ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	[self.bestAction_Controller.stateImages addObject:@""];
	if(theDataObjID != nil){
		WSAction *actTemp = (WSAction *)[[bluesheetDataModel getActions] getObjectByID:theDataObjID];
		self.action = [[[WSAction alloc] initWithWSAction:actTemp] autorelease];//[[actTemp copy] autorelease];
	}
	else
		self.action = [[[WSAction alloc] initWithXML:nil ID:ID] autorelease];
	if(action != nil){
		
		self.description_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:description value:action.what] autorelease];
		
		WSContact *whoCon = (WSContact *)[[[[WSDataModelManager instance] getByID:ID] getContacts] getContactByID:action.whoID];
		WSKVPair *whoConKVPair = [[[WSKVPair alloc] initWithKeyValue:whoCon != nil ? whoCon.ID : @"" aValue:whoCon != nil ? whoCon.contactName : @""] autorelease];
        
		if(self.contact_Controller == nil)
			self.contact_Controller = [[[WSContactListPickerController alloc] 
							  initWithFieldListDataAndValue:contact 
							  listData:[[[[[WSDataModelManager instance] getByID:ID] getContacts] GetExternalContacts] GetKVPairList] 
							  value:whoConKVPair
							  multiSelect:NO contactType:@"E"] autorelease];
		else
			self.contact_Controller.value = whoConKVPair;
		if(self.when_Controller == nil)
			self.when_Controller = [[[WSDateFieldController alloc] initWithFieldAndDate:when currentDate:[action.when getXMLFormattedDate]] autorelease];
		else
			self.when_Controller.date = action.when;
		
		WSContact *ownerCon = (WSContact *)[[[[WSDataModelManager instance] getByID:ID] getContacts] getContactByID:action.ownerID];
		WSKVPair *ownerConKVPair = [[[WSKVPair alloc] initWithKeyValue:ownerCon != nil ? ownerCon.ID : @"" aValue:ownerCon != nil ? ownerCon.contactName : @""] autorelease];
		if(self.assignedTo_Controller == nil)
			self.assignedTo_Controller = [[[WSContactListPickerController alloc] 
							  initWithFieldListDataAndValue:assignedTo 
							  listData:[[[[[WSDataModelManager instance] getByID:ID] getContacts] GetInternalContacts] GetKVPairList]
							  value:ownerConKVPair
							  multiSelect:NO contactType:@"I"] autorelease];
		else
			self.assignedTo_Controller.value = ownerConKVPair;
		if(self.completed_Controller == nil)
			self.completed_Controller = [[[WSDateFieldController alloc] initWithFieldAndDate:completed currentDate:[action.completed getXMLFormattedDate]] autorelease];
		else
			self.completed_Controller.date = action.completed;
		
		if(self.status_Controller == nil)
			self.status_Controller = [[[WSListPickerController alloc] initWithFieldListDataAndValue:status listData:[bluesheetDataModel actionStatus] value:action.status multiSelect:NO] autorelease];
		else
			self.status_Controller.value = action.status;
		
		if(self.type_Controller == nil)
			self.type_Controller = [[[WSListPickerController alloc] initWithFieldListDataAndValue:type listData:[bluesheetDataModel actionType]  value:action.type multiSelect:NO] autorelease]; 
		else
			self.type_Controller.value = action.type;
		
		if(self.bestAction_Controller == nil)
			self.bestAction_Controller = [[[WSToggleButtonController alloc] initWithButton:bestAction ID:ID] autorelease];
		[bestAction_Controller setupState:[[action.check numberValue] intValue]]; 
	}
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
		BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
		action.what = description.textView.text;
		action.whoID = [contact_Controller.selectedPairs.items count] > 0 ? [[contact_Controller.selectedPairs.items objectAtIndex:0] key] : @"";
		action.when = when_Controller.date;
		action.completed = when_Controller.date;
		action.ownerID = [assignedTo_Controller.selectedPairs.items count] > 0 ? [[assignedTo_Controller.selectedPairs.items objectAtIndex:0] key] : @"";
		action.status = ([status_Controller.selectedPairs.items count] > 0) ? [status_Controller.selectedPairs.items objectAtIndex:0] : [[WSKVPair alloc] initWithKeyValue:@"" aValue:@""];
		action.type = [type_Controller.selectedPairs.items count] > 0 ? [type_Controller.selectedPairs.items objectAtIndex:0] : [[WSKVPair alloc] initWithKeyValue:@"" aValue:@""];
		action.check = [[[WSBoolean alloc] initWithString:[NSString stringWithFormat:@"%i", bestAction_Controller.state]] autorelease];
        NSLog(@"state: %i", bestAction_Controller.state);
		[[[WSDataModelManager instance] getByID:ID] updateObjectList:[bluesheetDataModel getActions] updatedObject:action notificationType:@"Action"];
	}
	[super isClosing:mode];
	return YES;
}
- (void)dealloc {
    [super dealloc];
	[description release];
	[description_Controller release];
	[contact release];
	[contact_Controller release];
	[when release];
	[when_Controller release];
	[assignedTo release];
	[assignedTo_Controller release];
	[completed release];
	[completed_Controller release];
	[status release];
	[status_Controller release];
	[type release];
	[type_Controller release];
	[bestAction release];
	[bestAction_Controller release];
	[action release];
}


@end
