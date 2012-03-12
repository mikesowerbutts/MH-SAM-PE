    //
//  BuyingInfluences_Covered_Dialog_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 20/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BuyingInfluences_Covered_Dialog_Controller.h"
#import "BlueSheetDataModel.h"
#import "WSListPickerController.h"
@implementation BuyingInfluences_Covered_Dialog_Controller
@synthesize description, rating, description_Controller, rating_Controller, influence;
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID{
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	if(theDataObjID != nil){
		BSInfluence *infTemp = [[bluesheetDataModel getInfluences] getObjectByID:theDataObjID];
		self.influence = [[infTemp copyObject] autorelease];//Leak
	}
	else{
		self.influence = [[[BSInfluence alloc] init:theID] autorelease];//Leak
	}
	if(influence != nil){
		if(self.description_Controller == nil)
			self.description_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:description value:influence.coverDescription] autorelease];
		else
			self.description_Controller.value = influence.coverDescription;
		if(self.rating_Controller == nil)
			self.rating_Controller = [[[WSListPickerController alloc] initWithFieldListDataAndValue:rating listData:[bluesheetDataModel howWellIsBaseCovered] value:influence.cover multiSelect:NO] autorelease];
		else
			self.rating_Controller.value = influence.cover;
	}
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
		influence.cover = [rating_Controller.selectedPairs.items count] > 0 ? [rating_Controller.selectedPairs.items objectAtIndex:0] : [[WSKVPair alloc] initWithKeyValue:@"" aValue:@""];
		influence.coverDescription = description.textView.text;
		BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
		[bluesheetDataModel updateObjectList:[bluesheetDataModel getInfluences] updatedObject:influence notificationType:@"Influence"];
	}
	[super isClosing:mode];
	return YES;
}
- (void)dealloc {
    [super dealloc];
	[description release];
	[rating release];
	[description_Controller release];
	[rating_Controller release];
	[influence release];
}
@end
