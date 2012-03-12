//
//  BuyingInfluences_Dialog_Controller.m
//  MH SAM PE
//
//  Created by Toby Widdowson on 06/03/2012.
//  Copyright (c) 2012 White Springs Ltd. All rights reserved.
//

#import "BuyingInfluences_Dialog_Controller.h"
#import "BlueSheetDataModel.h"
#import "WSListPickerController.h"
@implementation BuyingInfluences_Dialog_Controller
@synthesize resultHeader, coveredHeader, nameField, rolesField, degreeField, modeField, nameField_Controller, rolesField_Controller, degreeField_Controller, modeField_Controller, influence, saveAndNewBtn, saveAndNewBtn_Controller, coveredDescription, coveredRating, coveredDescription_Controller, coveredRating_Controller, resultDescription, resultDescription_Controller;
-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:(NSString *)theID{
    [super initWithXIBAndIDDontShow:theNibName mainView:theDispView ID:theID];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactChanged:) name:@"PickerFieldChanged" object:nil];
    return self;
}
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID{
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	if(theDataObjID != nil){
		BSInfluence *infTemp = [[bluesheetDataModel getInfluences] getObjectByID:theDataObjID];
		self.influence = [[infTemp copyObject] autorelease];//Leak
	}
	else
		self.influence = [[[BSInfluence alloc] init:theID] autorelease];//Leak
	if(influence != nil){
        //Involved
        WSContact *con = (WSContact *)[[[[WSDataModelManager instance] getByID:ID] getContacts] getContactByID:influence.contactID];
        WSKVPair *conKVPair = [[WSKVPair alloc] initWithKeyValue:con != nil ? con.ID : @"" aValue:con != nil ? con.contactName : @""];
        
        [self setLabels:con];
        
        if(self.nameField_Controller == nil)
            self.nameField_Controller = [[[WSContactListPickerController alloc] 
                                          initWithFieldListDataAndValue:nameField 
                                          listData:[[[[[WSDataModelManager instance] getByID:ID] getContacts] GetExternalContacts] GetKVPairList] 
                                          value:conKVPair
                                          multiSelect:NO contactType:@"E"] autorelease];
        else 
            self.nameField_Controller.value = conKVPair;
        [conKVPair release];
        if(self.rolesField_Controller == nil)
            self.rolesField_Controller = [[[WSListPickerController alloc] initWithFieldListDataAndValueList:rolesField listData:[bluesheetDataModel getInfluenceRole] valueList:influence.roles multiSelect:YES] autorelease];
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
        
        //Result
        if(self.resultDescription_Controller == nil)
			self.resultDescription_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:resultDescription value:influence.resultDescription] autorelease];
		else
			self.resultDescription_Controller.value = influence.resultDescription;
        
        //Covered
		if(self.coveredDescription_Controller == nil)
			self.coveredDescription_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:coveredDescription value:influence.coverDescription] autorelease];
		else
			self.coveredDescription_Controller.value = influence.coverDescription;
		if(self.coveredRating_Controller == nil)
			self.coveredRating_Controller = [[[WSListPickerController alloc] initWithFieldListDataAndValue:coveredRating listData:[bluesheetDataModel howWellIsBaseCovered] value:influence.cover multiSelect:NO] autorelease];
		else
			self.coveredRating_Controller.value = influence.cover;
	}
    if(self.saveAndNewBtn_Controller == nil){
        [saveAndNewBtn initNormalWithImages];
        [self.saveAndNewBtn.label setValue:@"Save & New"];
        saveAndNewBtn.label.borders = @"";
        self.saveAndNewBtn_Controller = [[WSButtonController alloc] initWithButton:self.saveAndNewBtn ID:ID];
    }
    if(theDataObjID == nil)
        [self enableControls:false];
}
-(void)setLabels:(WSContact *)con{
    NSString *conName = con != nil ? con.contactName : @"Unknown Contact";
    [self.resultHeader setValue:[NSString stringWithFormat:@"Key Win Result for %@", conName]];
    [self.coveredHeader setValue:[NSString stringWithFormat:@"How Well Is Base Covered for %@", conName]];
    self.coveredHeader.borders = @"";
    self.resultHeader.borders = @"";
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"])
        [self saveInfluence];
	[super isClosing:mode];
	return YES;
}
-(void)saveInfluence{
    BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
    //Involved
    [influence setTheContactID:[nameField_Controller.selectedPairs.items count] > 0 ? [[nameField_Controller.selectedPairs.items objectAtIndex:0] key] : @""];
    influence.roles = [rolesField_Controller.selectedPairs.items count] > 0 ? rolesField_Controller.selectedPairs : influence.roles;
    influence.degree = [degreeField_Controller.selectedPairs.items count] > 0 ? [degreeField_Controller.selectedPairs.items objectAtIndex:0] : influence.degree;
    influence.mode = [modeField_Controller.selectedPairs.items count] > 0 ? [modeField_Controller.selectedPairs.items objectAtIndex:0] : influence.mode;
    
    //Result
    influence.resultDescription = resultDescription.textView.text;
    
    //Covered
    influence.cover = [coveredRating_Controller.selectedPairs.items count] > 0 ? [coveredRating_Controller.selectedPairs.items objectAtIndex:0] : [[WSKVPair alloc] initWithKeyValue:@"" aValue:@""];
    influence.coverDescription = coveredDescription.textView.text;
    //Update
    [bluesheetDataModel updateObjectList:[bluesheetDataModel getInfluences] updatedObject:influence notificationType:@"Influence"];
}
-(void)otherBtnTouched:(WSButtonController *)btnController{
	if(btnController == self.saveAndNewBtn_Controller){
        [self saveInfluence];
        [self setupDialog:nil ID:ID];
        [self enableControls:false];
    }
}
-(void)contactChanged:(NSNotification *)notification{
    if([notification object] == self.nameField_Controller){
        BlueSheetDataModel *dm = (BlueSheetDataModel*)[[WSDataModelManager instance] getByID:ID];
        WSContact *con = [dm.getContacts getContactByID:[self.nameField_Controller.value key]];
        [self setLabels:con];
        [self enableControls:con != nil ? true : false];
    }
}
-(void)enableControls:(BOOL)enabled{
    self.rolesField.enabled = enabled;
    self.degreeField.enabled = enabled;
    self.modeField.enabled = enabled;
    self.resultDescription.enabled = enabled;
    self.coveredDescription.enabled = enabled;
    self.coveredRating.enabled = enabled;
    self.okBtn.enabled = enabled;
    self.saveAndNewBtn.enabled = enabled;
}
- (void)dealloc {
    [super dealloc];
	[coveredDescription release];
	[coveredRating release];
	[coveredDescription_Controller release];
	[coveredRating_Controller release];
    [nameField_Controller release];
	[rolesField_Controller release];
	[degreeField_Controller release];
	[modeField_Controller release];
	[nameField release];
	[rolesField release];
	[degreeField release];
	[modeField release];    
    [resultDescription release];
	[resultDescription_Controller release];
	[influence release];
}
@end
