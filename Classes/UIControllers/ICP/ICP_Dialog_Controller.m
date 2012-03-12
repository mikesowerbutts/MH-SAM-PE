    //
//  ICP_Dialog_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 02/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "ICP_Dialog_Controller.h"
#import "BlueSheetDataModel.h"
#import "WSListPickerController.h"

@implementation ICP_Dialog_Controller
@synthesize icc_description, icc_rating, icc_description_Controller, icc_rating_Controller, criteria;
-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:(NSString *)theID{
	[super initWithXIBAndIDDontShow:theNibName mainView:theDispView ID:theID];
	return self;
}
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID{
	[super setupDialog:theDataObjID ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	if(theDataObjID != nil){
		BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
		BSCriteria *criTemp = [[bluesheetDataModel getCriterias] getObjectByID:theDataObjID];
		self.criteria = [[criTemp copyObject] autorelease];
	}
	else
		self.criteria = [[[BSCriteria alloc] initWithXML:nil ID:ID] autorelease];
	if(criteria != nil){
		if(self.icc_description_Controller == nil)
			self.icc_description_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:icc_description value:[WSUtils URLDecode:criteria.iccDesc]] autorelease];
		else
			self.icc_description_Controller.value = criteria.iccDesc;
		self.icc_description.textView.editable = NO;
		
		if(self.icc_rating_Controller == nil){
			self.icc_rating_Controller = [[WSListPickerController alloc] initWithFieldListDataAndValue:icc_rating listData:[bluesheetDataModel idealCustomerCriteriaDropList] value:criteria.value multiSelect:NO];
		}
		else
			self.icc_rating_Controller.value = criteria.value;
	}
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
		BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
        criteria.value = [icc_rating_Controller.selectedPairs.items count] > 0 ? [icc_rating_Controller.selectedPairs.items objectAtIndex:0] : [[WSKVPair alloc] initWithKeyValue:@"" aValue:@""];
        
		[[[WSDataModelManager instance] getByID:ID] updateObjectList:[bluesheetDataModel getCriterias] updatedObject:criteria notificationType:@"ICP"];
	}
	[super isClosing:mode];
	return YES;
}

- (void)dealloc {
    [super dealloc];
	[icc_description release];
	[icc_rating release];
	[icc_description_Controller release];
	[icc_rating_Controller release];
	[criteria release];
}
@end
