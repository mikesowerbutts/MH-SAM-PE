    //
//  BuyingInfluences_Involved_Dialog_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 06/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BuyingInfluences_Involved_Dialog_Controller.h"
#import "BSInfluence.h"
#import "WSTextViewController.h"
#import "BlueSheetDataModel.h"
#import "WSContact.h"

@implementation BuyingInfluences_Involved_Dialog_Controller
@synthesize nameField, rolesField, degreeField, modeField, nameField_Controller, rolesField_Controller, degreeField_Controller, modeField_Controller, influence;
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID{
	[super setupDialog:theDataObjID ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	if(theDataObjID != nil){
		BSInfluence *infTemp = (BSInfluence *)[[bluesheetDataModel getInfluences] getObjectByID:theDataObjID];
		self.influence = [[infTemp copyObject] autorelease];//Leak
	}
	else
		self.influence = [[[BSInfluence alloc] initWithXML:nil ID:theID] autorelease];//Leak
	if(influence != nil){
		WSContact *con = (WSContact *)[[[[WSDataModelManager instance] getByID:ID] getContacts] getContactByID:influence.contactID];
		WSKVPair *conKVPair = [[WSKVPair alloc] initWithKeyValue:con != nil ? con.ID : @"" aValue:con != nil ? con.contactName : @""];
		if(self.nameField_Controller == nil)
			self.nameField_Controller = [[[WSContactListPickerController alloc] 
								initWithFieldListDataAndValue:nameField 
								listData:[[[[[WSDataModelManager instance] getByID:ID] getContacts] GetExternalContacts] GetKVPairList] 
								value:conKVPair
								multiSelect:NO contactType:@"E"] autorelease];//Leak
		else 
			self.nameField_Controller.value = conKVPair;
		[conKVPair release];//Leak
		if(self.rolesField_Controller == nil)
			self.rolesField_Controller = [[[WSListPickerController alloc] initWithFieldListDataAndValueList:rolesField listData:[bluesheetDataModel getInfluenceRole] valueList:influence.roles multiSelect:YES] autorelease];//Leak
		else
			self.rolesField_Controller.valueList = influence.roles;
		if(self.degreeField_Controller == nil)
			self.degreeField_Controller = [[[WSListPickerController alloc] initWithFieldListDataAndValue:degreeField listData:[bluesheetDataModel getInfluenceDegree] value:influence.degree multiSelect:NO] autorelease];
		else
			self.degreeField_Controller.value = influence.degree;
		if(self.modeField_Controller == nil) 
			self.modeField_Controller = [[[WSListPickerController alloc] initWithFieldListDataAndValue:modeField listData:[bluesheetDataModel getInfluenceMode]  value:influence.mode multiSelect:NO] autorelease];
		else
			self.modeField_Controller.value = influence.mode;
	}
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
		BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
		[influence setTheContactID:[nameField_Controller.selectedPairs.items count] > 0 ? [[nameField_Controller.selectedPairs.items objectAtIndex:0] key] : @""];
		influence.roles = [rolesField_Controller.selectedPairs.items count] > 0 ? rolesField_Controller.selectedPairs : influence.roles;
		influence.degree = [degreeField_Controller.selectedPairs.items count] > 0 ? [degreeField_Controller.selectedPairs.items objectAtIndex:0] : influence.degree;
		influence.mode = [modeField_Controller.selectedPairs.items count] > 0 ? [modeField_Controller.selectedPairs.items objectAtIndex:0] : influence.mode;
		[bluesheetDataModel updateObjectList:[bluesheetDataModel getInfluences] updatedObject:influence notificationType:@"Influence"];
	}
	[super isClosing:mode];
	return YES;
}
- (void)dealloc {
    [nameField_Controller release];
	[rolesField_Controller release];
	[degreeField_Controller release];
	[modeField_Controller release];
	[nameField release];
	[rolesField release];
	[degreeField release];
	[modeField release];
	[influence release];
    [super dealloc];
}

@end
